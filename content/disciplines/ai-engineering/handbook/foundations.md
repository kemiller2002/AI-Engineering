# AI Engineering Handbook

# Part 1 --- Foundations

Version: Draft 0.1

------------------------------------------------------------------------

# 1. Purpose

This handbook is intended to be a practical engineering reference for
building AI-assisted development and research systems that maximize
useful work while operating within finite token, cost, and human-review
budgets.

The central thesis is simple:

> Tokens are not the scarce resource. **Validated engineering progress**
> is.

The objective is therefore not to minimize tokens at all costs, but to
maximize **validated engineering value per unit of total cost**.

------------------------------------------------------------------------

# 2. Core Principles

## Principle 1 --- Treat conversations as execution environments

A chat session is a workspace, not the project's memory.

Durable knowledge belongs in version-controlled artifacts such as:

-   Architecture Decision Records (ADRs)
-   Task contracts
-   Evidence registries
-   Repository documentation
-   Checkpoints
-   Test results

Agents should reconstruct state from these artifacts rather than replay
months of conversation.

------------------------------------------------------------------------

## Principle 2 --- Externalize knowledge

Every expensive reasoning step should leave behind a reusable artifact.

Examples include:

-   repository maps
-   dependency graphs
-   architectural decisions
-   experiment reports
-   failure analyses
-   implementation notes

The goal is to pay for reasoning once and reuse it many times.

------------------------------------------------------------------------

## Principle 3 --- Optimize the entire system

Token efficiency emerges from:

-   good information architecture
-   effective retrieval
-   task decomposition
-   evaluation
-   review discipline

It is rarely achieved by shortening prompts alone.

------------------------------------------------------------------------

# 3. Engineering Value Equation

Instead of optimizing for cost alone, optimize:

    Engineering Value
    -------------------------------
    Tokens
    + Human review
    + Rework
    + Latency
    + Coordination

Reducing any denominator while preserving quality improves throughput.

------------------------------------------------------------------------

# 4. Context Engineering

Context is a compiled working set, not a historical archive.

A recommended context packet consists of:

1.  Stable organizational policies
2.  Role definition
3.  Task contract
4.  Acceptance criteria
5.  Retrieved authoritative artifacts
6.  Current working state
7.  Available tools
8.  Output schema
9.  Budget and stopping rules

Everything else should be retrieved on demand.

------------------------------------------------------------------------

# 5. Memory Layers

## Working Memory

Current prompt and active reasoning.

## Project Memory

Version-controlled project artifacts.

## Retrieval Layer

Searches project memory for relevant information.

## Organizational Memory

Reusable prompts, coding standards, architectural patterns, and
operating procedures.

------------------------------------------------------------------------

# 6. Architecture Overview

``` text
Human
   |
Coordinator
   |
+-------------+
| Specialists |
+-------------+
   |
Artifacts
   |
Repository
```

Agents communicate primarily through durable artifacts rather than
lengthy conversational summaries.

------------------------------------------------------------------------

# 7. Anti-patterns

Avoid:

-   One permanent conversation
-   Full repository prompts
-   Duplicate research
-   Unlimited retries
-   Agent swarms without ownership
-   Documentation generated from memory instead of accepted artifacts

------------------------------------------------------------------------

# 8. Initial Adoption Checklist

-   [ ] Create task contracts.
-   [ ] Create ADRs.
-   [ ] Store research in an evidence registry.
-   [ ] Add repository maps.
-   [ ] Introduce checkpoints.
-   [ ] Measure tokens by task.
-   [ ] Separate planning, implementation, testing, and review.
-   [ ] Build retrieval before increasing context size.

------------------------------------------------------------------------

# Next Part

Part 2 covers:

-   Agent taxonomy
-   Coordinator design
-   Planner agents
-   Research agents
-   Coding agents
-   Testing agents
-   Reviewer agents
-   Communication contracts
-   Failure recovery
