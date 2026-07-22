# AI Engineering Handbook

# Part 3 --- Engineering Workflows

Version: Draft 0.1

------------------------------------------------------------------------

# Introduction

An AI-assisted engineering workflow should optimize for **validated
progress**, not simply code generation. Every phase should produce
durable artifacts that reduce uncertainty and make future work cheaper.

------------------------------------------------------------------------

# 1. Greenfield Projects

Recommended phases:

1.  Vision and constraints
2.  Research and assumption testing
3.  Architecture Decision Records (ADRs)
4.  Repository scaffolding
5.  Component and API contracts
6.  Incremental implementation
7.  Automated validation
8.  Human review
9.  Documentation updates

## Deliverables

-   Project charter
-   Repository map
-   ADR index
-   Coding standards
-   Initial task backlog

------------------------------------------------------------------------

# 2. Legacy Modernization

Before changing code:

-   Build a dependency map
-   Identify architectural seams
-   Capture current behavior with tests
-   Document risks
-   Prioritize high-value improvements

Avoid "big bang" rewrites unless there is a compelling technical or
business reason.

------------------------------------------------------------------------

# 3. Repository Organization

Suggested layout:

``` text
/docs
  /adr
  /research
  /architecture
/tasks
/prompts
/templates
/src
/tests
/scripts
```

The repository should be understandable through its artifacts, not just
its source code.

------------------------------------------------------------------------

# 4. Context Boundaries

Agents should receive only the information needed for the current task.

Good context contains:

-   Relevant ADRs
-   Acceptance criteria
-   Target files
-   Coding standards
-   Existing tests

Avoid sending entire repositories when only a few files are relevant.

------------------------------------------------------------------------

# 5. Development Loop

``` text
Research
   ↓
Plan
   ↓
Implement
   ↓
Test
   ↓
Review
   ↓
Document
   ↓
Repeat
```

Each stage should leave behind reusable outputs.

------------------------------------------------------------------------

# 6. CI/CD Integration

AI should assist---not replace---quality gates.

Recommended pipeline:

-   Static analysis
-   Unit tests
-   Integration tests
-   Security scanning
-   AI review
-   Human approval
-   Deployment

------------------------------------------------------------------------

# 7. Long-Running Projects

Maintain continuity with:

-   ADRs
-   Decision logs
-   Research registry
-   Evidence registry
-   Repository maps
-   Milestone summaries

These artifacts reduce the need to replay historical conversations.

------------------------------------------------------------------------

# 8. Metrics

Track:

-   Lead time
-   Change failure rate
-   Mean review time
-   Tokens per accepted feature
-   Rework percentage
-   Test coverage
-   Documentation freshness

------------------------------------------------------------------------

# 9. Checklist

-   [ ] Research before implementation
-   [ ] Write ADRs for significant decisions
-   [ ] Keep prompts modular
-   [ ] Preserve failed experiments
-   [ ] Validate before merging
-   [ ] Update documentation after every accepted change

------------------------------------------------------------------------

# Next Part

Part 4 covers research engineering, evidence standards, experiment
tracking, and building long-running autonomous research programs.
