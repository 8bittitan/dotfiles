---
description: Perform a code review on the latest (uncommited/untracked) changes
agent: plan
model: anthropic/claude-opus-5-5
---

Five-axis review of the diff between `HEAD` and the uncommited/untracked changes. User may provide additional context in User Prompt, and any information added 
there MUST be taken into account during review.

Axis:
- **Standards** - does the code conform to this repo's documented coding standards?
- **Performance** - does the code faithfully implement best practices for performance?
- **Review** - does the code follow best practices and reduces tech debt?
- **Accessibility** - does the code follow good accessibility guidelines?
- **Security** - do the changes follow strict security best practices?

All axes run as **parallel sub-agents** so they don't pollute each other's context, then this skill aggregates their findings.

**Only** run the Accessibility agent when dealing with front end or UI related changes. For example, when working in React (or any front end framework), CSS or HTML

## Process

### 1. Pin the fixed point

Whatever the user said is the fixed point — a commit SHA, branch name, tag, `main`, `HEAD~5`, etc. Don't be opinionated; pass it through. If they didn't specify one, ask: "Review against what — a branch, a commit, or `main`?" Don't proceed until you have it.

Capture the diff command once: `git diff <fixed-point>...HEAD` (three-dot, so the comparison is against the merge-base). Also note the list of commits via `git log <fixed-point>..HEAD --oneline`.

### 2. Identify the standards sources

Anything in the repo that documents how code should be written, such as `CODING_STANDARDS.md` or `CONTRIBUTING.md`.

On top of whatever the repo documents, the Standards axis always carries the **smell baseline** below — a fixed set of Fowler code smells (_Refactoring_, ch.3) that applies even when a repo documents nothing. Two rules bind it:

- **The repo overrides.** A documented repo standard always wins; where it endorses something the baseline would flag, suppress the smell.
- **Always a judgement call.** Each smell is a labelled heuristic ("possible Feature Envy"), never a hard violation — and, like any standard here, skip anything tooling already enforces.

Each smell reads *what it is* → *how to fix*; match it against the diff:

- **Mysterious Name** — a function, variable, or type whose name doesn't reveal what it does or holds. → rename it; if no honest name comes, the design's murky.
- **Duplicated Code** — the same logic shape appears in more than one hunk or file in the change. → extract the shared shape, call it from both.
- **Feature Envy** — a method that reaches into another object's data more than its own. → move the method onto the data it envies.
- **Data Clumps** — the same few fields or params keep travelling together (a type wanting to be born). → bundle them into one type, pass that.
- **Primitive Obsession** — a primitive or string standing in for a domain concept that deserves its own type. → give the concept its own small type.
- **Repeated Switches** — the same `switch`/`if`-cascade on the same type recurs across the change. → replace with polymorphism, or one map both sites share.
- **Shotgun Surgery** — one logical change forces scattered edits across many files in the diff. → gather what changes together into one module.
- **Divergent Change** — one file or module is edited for several unrelated reasons. → split so each module changes for one reason.
- **Speculative Generality** — abstraction, parameters, or hooks added for needs the spec doesn't have. → delete it; inline back until a real need shows.
- **Message Chains** — long `a.b().c().d()` navigation the caller shouldn't depend on. → hide the walk behind one method on the first object.
- **Middle Man** — a class or function that mostly just delegates onward. → cut it, call the real target direct.
- **Refused Bequest** — a subclass or implementer that ignores or overrides most of what it inherits. → drop the inheritance, use composition.

### 3. Spawn all sub-agents in parallel

Send a single message with five `Agent` tool calls. Use the `general-purpose` subagent for all, unless a specific agent name is specified below.

**Standards sub-agent**:
Name: `standards` 

Prompt:
- The full diff command and commit list.
- The list of standards-source files you found in step 3, **plus the smell baseline from step 3** pasted in full — the sub-agent has no other access to it.

**Performance sub-agent**:
Name: `performance-reviewer`

Prompt:
- The diff command and commit list.

**Review sub-agent**:
Name: `code-reviewer`

Prompt:
- The diff command and commit list.

**Accessibility sub-agent**:

Name: `accessibility-checker`

Prompt:
- The diff command and commit list.

** Security sub-agent**:

Name: `security-reviewer`

Prompt:
- The diff command and commit list.

### 4. Additional checks

#### Change Sizing

Small, focused changes are easier to review, faster to merge, and safer to deploy. Target these sizes:

```
~100 lines changed   → Good. Reviewable in one sitting.
~300 lines changed   → Acceptable if it's a single logical change.
~1000 lines changed  → Too large. Split it.
```

**Watch file size, not just diff size.** A small diff can still push a file past a healthy boundary — around 1000 *total* lines in a single file (distinct from the ~1000 *changed*-lines threshold above) is a common inspection signal, not a hard cap. When a change materially grows an already-large file, ask whether to extract helpers, subcomponents, or modules *first*, before piling more on. Decompose, then add.

**What counts as "one change":** A single self-contained modification that addresses one thing, includes related tests, and keeps the system functional after submission. One part of a feature — not the whole feature.

**Splitting strategies when a change is too large:**

| Strategy | How | When |
|----------|-----|------|
| **Stack** | Submit a small change, start the next one based on it | Sequential dependencies |
| **By file group** | Separate changes for groups needing different reviewers | Cross-cutting concerns |
| **Horizontal** | Create shared code/stubs first, then consumers | Layered architecture |
| **Vertical** | Break into smaller full-stack slices of the feature | Feature work |

**When large changes are acceptable:** Complete file deletions and automated refactoring where the reviewer only needs to verify intent, not every line.

**Separate refactoring from feature work.** A change that refactors existing code and adds new behavior is two changes — submit them separately. Small cleanups (variable renaming) can be included at reviewer discretion.

### 4. Report

Aggregate the findings from each of the agents and then categorize the findings as such:

Label every comment with its severity so the author knows what's required vs optional:

| Prefix | Meaning | Author Action |
|--------|---------|---------------|
| **Blocker:** | Required change | Must address before creating PR |
| **Critical:** | Blocks PR creation | Security vulnerability, data loss, broken functionality |
| **Nit:** | Minor, optional | Author may ignore — formatting, style preferences |
| **Optional:** / **Consider:** | Suggestion | Worth considering but not required |
| **FYI** | Informational only | No action needed — context for future reference |

This prevents authors from treating all feedback as mandatory and wasting time on optional suggestions.

**Lead with what matters.** Order findings by leverage: correctness and security first, then structural regressions and missed simplifications, then everything else. Don't bury a real issue under cosmetic nits — a few high-conviction comments beat a long list. If you have one structural problem and ten nits, the structural problem *is* the review.

End with:

- A one-line summary: total findings per axis
- A final verdict on if the changes are ready for a Pull Request or not.

## Why five axes

A change can pass one axis and fail the other:

- Code that follows every standard but implements the wrong thing → **Standards pass, Performance fail.**
- Code that does exactly what the issue asked but breaks the project's conventions → **Performance pass, Accessibility fail.**

Reporting them separately stops one axis from masking the other.

== User Prompt ==
$ARGUMENTS
