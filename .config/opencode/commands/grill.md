---
description: Interview the user relentlessly about a plan or design until reaching shared understanding, resolving each branch of the decision tree.
agent: plan
---

User query: $ARGUMENTS

If the user did not provide a query or feature, prompt the user on what they would like the grilling session to be about.

Interview me relentlessly about every aspect of this query until we reach a shared understanding. Walk down each branch of the design tree, resolving dependencies between decisions one-by-one. For each question, provide your recommended answer.

Ask the questions one at a time, be sure to use the harness' version of `AskUserQuestion` when available.

If a question can be answered by exploring the codebase, explore the codebase instead.
