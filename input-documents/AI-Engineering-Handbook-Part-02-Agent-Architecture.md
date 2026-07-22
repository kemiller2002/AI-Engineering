# AI Engineering Handbook

# Part 2 --- Agent Architecture and Coordination

Version: Draft 0.1

------------------------------------------------------------------------

# 1. Why Multiple Agents?

Different engineering activities benefit from different optimization
goals. Separating planning, implementation, testing, review, and
documentation reduces context pollution and improves accountability.

## Recommended Agent Roles

  Agent           Primary Goal           Outputs
  --------------- ---------------------- ----------------------------
  Coordinator     Orchestrate work       Task assignments, progress
  Planner         Decompose objectives   Task graph
  Researcher      Reduce uncertainty     Evidence reports
  Implementer     Write code             Commits, patches
  Tester          Validate behavior      Test reports
  Reviewer        Critique changes       Review findings
  Documentarian   Preserve knowledge     ADRs, guides

------------------------------------------------------------------------

# 2. Coordinator Responsibilities

The coordinator should:

-   Define objectives
-   Maintain task queue
-   Enforce budgets
-   Detect blockers
-   Route work
-   Collect artifacts
-   Decide when human review is required

It should avoid becoming a bottleneck by delegating specialized work
quickly.

------------------------------------------------------------------------

# 3. Task Contracts

Every task should include:

-   Objective
-   Scope
-   Inputs
-   Required artifacts
-   Constraints
-   Acceptance criteria
-   Budget
-   Expected outputs

This prevents agents from making incompatible assumptions.

------------------------------------------------------------------------

# 4. Communication Through Artifacts

Prefer durable files over conversational summaries.

Examples:

-   ADRs
-   Evidence registry
-   Repository map
-   Test report
-   Review report
-   Change log

Artifacts become the project's long-term memory.

------------------------------------------------------------------------

# 5. Failure Recovery

When an agent fails:

1.  Capture partial work.
2.  Record assumptions.
3.  Record failed hypotheses.
4.  Preserve logs.
5.  Return unfinished work to the queue.

Never discard failed research without documenting why it failed.

------------------------------------------------------------------------

# 6. Metrics

Useful operational metrics include:

-   Tasks completed
-   Acceptance rate
-   Human review frequency
-   Rework rate
-   Tokens per accepted change
-   Mean task duration
-   Retrieval success rate

------------------------------------------------------------------------

# 7. Anti-patterns

Avoid:

-   General-purpose "do everything" agents
-   Hidden assumptions
-   Direct edits without task contracts
-   Long conversational handoffs
-   Missing acceptance criteria

------------------------------------------------------------------------

# Next Part

Part 3 explores engineering workflows for greenfield projects, legacy
modernization, repository organization, CI/CD, and release engineering.
