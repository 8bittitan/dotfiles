---
description: Perform a code review on the latest (uncommited/untracked) changes
agent: plan
---

# Review

Three-axis review of the diff between `HEAD` and the uncommited/untracked changes:

- **Standards** — does the code conform to this repo's documented coding standards?
- **Performance** — does the code faithfully implement best practices for performance?
- **Accessibility** - does the code follow good accessibility guidelines?

All axes run as **parallel sub-agents** so they don't pollute each other's context, then this skill aggregates their findings.

**Only** run the Accessibility agent when dealing with front end or UI related changes. For example, when working in React (or any front end framework), CSS or HTML

## Process

### 1. Pin the fixed point

Whatever the user said is the fixed point — a commit SHA, branch name, tag, `main`, `HEAD~5`, etc. Don't be opinionated; pass it through. If they didn't specify one, ask: "Review against what — a branch, a commit, or `main`?" Don't proceed until you have it.

Capture the diff command once: `git diff <fixed-point>...HEAD` (three-dot, so the comparison is against the merge-base). Also note the list of commits via `git log <fixed-point>..HEAD --oneline`.

### 2. Identify the standards sources

Anything in the repo that documents how code should be written. Common locations:

- `CLAUDE.md`, `AGENTS.md`
- `CONTRIBUTING.md`
- `CONTEXT.md`, `CONTEXT-MAP.md`, per-context `CONTEXT.md` files
- `docs/adr/` (architectural decisions are standards)
- `.editorconfig`, `eslint.config.*`, `biome.json`, `prettier.config.*`, `tsconfig.json` (machine-enforced standards — note them but don't re-check what tooling already checks)
- Any `STYLE.md`, `STANDARDS.md`, `STYLEGUIDE.md`, or similar at the repo root or under `docs/`

Collect the list of files. The **Standards** sub-agent will read them.

### 3. Spawn all sub-agents in parallel

Send a single message with three `Agent` tool calls. Use the `general-purpose` subagent for both.

**Standards sub-agent prompt** — include:

- The full diff command and commit list.
- The list of standards-source files you found in step 3.
- The brief: "Read the standards docs. Then read the diff. Report — per file/hunk where relevant — every place the diff violates a documented standard. Cite the standard (file + the rule). Distinguish hard violations from judgement calls. Skip anything tooling enforces. Under 400 words."

**Performance sub-agent prompt** — include:

- The diff command and commit list.
- The brief: "Read the diff. Explore to find areas of performance improvements for the related code. This could be DB queries, looping, inefficient renders (React), etc. Use your best judgement based on what the codebase looks like. Under 400 words."

**Accessibility sub-agent prompt** — include:

- The diff command and commit list.
- The brief: "Read the diff. Explore to find areas of improvement for accessibility guidelines. This should be based on actual guidelines published and make the features more usable by users that are impaired. Keep to 400 words."

If the spec is missing, skip the Spec sub-agent and note this in the final report.

### 4. Aggregate

Present the two reports under `## Standards`, `## Performance` and `## Accessibility` headings, verbatim or lightly cleaned. Do **not** merge or rerank findings — the three axes are deliberately separate so the user can see them independently.

End with a one-line summary: total findings per axis, and the worst single issue (if any) flagged.

## Why three axes

A change can pass one axis and fail the other:

- Code that follows every standard but implements the wrong thing → **Standards pass, Performance fail.**
- Code that does exactly what the issue asked but breaks the project's conventions → **Performance pass, Accessibility fail.**

Reporting them separately stops one axis from masking the other.
