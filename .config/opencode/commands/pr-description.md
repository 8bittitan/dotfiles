---
description: Write a pull request descripton for the supplied pull request
agent: plan
model: anthropic/claude-haiku-5-5
---

Please write a PR description for this PR: $ARGUMENTS.

If the user did not provide a pull request (number or link), ask the user to provide one.

Keep it concise and eplain WHY something was changed, not WHAT the change were.

Add possible user testing scenarios when possible.

If there is already a set template for a pull request, you MUST follow that template.

Refrain from using LLM type syntax and linguistics. Ensure you are writing the description as close to how a human would as possible. For example:

- Do NOT use emdashes
- Use modern technical termonology

Respond to the user with ONLY the markdown based PR description, you are NOT to try and set the description yourself.
