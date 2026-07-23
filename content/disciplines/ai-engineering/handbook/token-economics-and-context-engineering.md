# AI Engineering Handbook

# Part 5 --- Token Economics and Context Engineering

Version: Draft 0.1

------------------------------------------------------------------------

# Introduction

Most discussions about AI efficiency focus on reducing token usage. That
is an incomplete optimization target.

The correct objective is to maximize **validated engineering progress
per unit of total cost**, where cost includes tokens, latency, human
review, rework, and coordination.

------------------------------------------------------------------------

# 1. The Economics of Tokens

Treat tokens like any other engineering resource.

Every token should either:

-   reduce uncertainty,
-   increase implementation quality,
-   improve validation,
-   or create a reusable artifact.

Tokens that merely repeat information or recreate prior reasoning have
little long-term value.

------------------------------------------------------------------------

# 2. Engineering Value per Token

A useful mental model:

    Engineering Value
    -------------------------------------
    Prompt Tokens
    + Completion Tokens
    + Human Review Time
    + Rework
    + Latency

Increasing token usage is acceptable if it produces a proportionally
larger increase in validated engineering output.

------------------------------------------------------------------------

# 3. Context Engineering

Prompt engineering optimizes individual prompts.

Context engineering optimizes the **entire information pipeline**.

A context packet should contain:

1.  Stable project rules
2.  Task contract
3.  Relevant architecture decisions
4.  Retrieved source material
5.  Current work state
6.  Acceptance criteria
7.  Available tools
8.  Expected output format
9.  Budget and stopping conditions

Everything else should remain outside the active context until
retrieved.

------------------------------------------------------------------------

# 4. Context Compilation

Instead of replaying conversation history, compile context from durable
artifacts.

Possible inputs include:

-   ADRs
-   Repository maps
-   Task files
-   Coding standards
-   Previous review reports
-   Research summaries

Compiled context is usually smaller, more current, and easier to
validate.

------------------------------------------------------------------------

# 5. Token Amortization

Expensive reasoning becomes inexpensive when reused.

Examples:

-   Architecture diagrams
-   Repository indexes
-   API catalogs
-   Dependency graphs
-   Research summaries
-   Coding conventions

Create these once and reference them repeatedly.

------------------------------------------------------------------------

# 6. Retrieval Strategy

Prefer retrieval over oversized prompts.

Retrieve:

-   only the files required,
-   only the decisions that matter,
-   only the standards applicable to the task.

Precision often beats volume.

------------------------------------------------------------------------

# 7. Context Compression

Compression should preserve meaning rather than simply remove words.

Good compression retains:

-   decisions,
-   constraints,
-   interfaces,
-   acceptance criteria,
-   open risks.

Avoid compressing away critical assumptions.

------------------------------------------------------------------------

# 8. Budgeting Across Agents

Assign token budgets intentionally.

Example:

  Agent             Relative Budget
  --------------- -----------------
  Planner                    Medium
  Researcher                   High
  Implementer                Medium
  Tester                     Medium
  Reviewer                     High
  Documentarian                 Low

Budgets should reflect expected reasoning complexity rather than
organizational hierarchy.

------------------------------------------------------------------------

# 9. Anti-patterns

Avoid:

-   Massive "everything" prompts
-   Constantly restating repository history
-   Copying documentation into every prompt
-   Keeping all reasoning inside chat sessions
-   Ignoring retrieval opportunities

------------------------------------------------------------------------

# 10. Practical Checklist

-   [ ] Build reusable artifacts.
-   [ ] Retrieve before expanding context.
-   [ ] Compile context from project state.
-   [ ] Measure engineering value, not just token counts.
-   [ ] Cache expensive reasoning.
-   [ ] Review token-heavy workflows regularly.

------------------------------------------------------------------------

# Next Part

Part 6 examines the modern AI engineering toolchain, including coding
agents, IDE integrations, local models, MCP servers, and orchestration
patterns.
