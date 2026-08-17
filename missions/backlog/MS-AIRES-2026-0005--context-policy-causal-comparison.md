---
id: MS-AIRES-2026-0005
title: Context-policy causal comparison
status: proposed
priority: medium
artifact_tier: full-rep
research_area: context-engineering
discipline: [experimental-methods, context-engineering]
created: 2026-08-17
owner_agent: unassigned
depends_on: [MS-AIRES-2026-0004]
related_projects: [RFR-005]
outputs: [research/packages/RP-AIRES-2026-0005--context-policy-causal-comparison.md]
---

# Mission

## Objective

Compare full-history, recent-window, artifact-first, selective retrieval,
structured-summary, and compiled-context policies on the same audited suite.

## Why this matters

The repository does not know which context policy maximizes verified outcomes
per total cost or how context loss and contamination interact with task horizon.

## Scope

Included: randomized paired runs, stale/conflicting-state injection, reliability,
latency, retries, context volume, recovery, and cost. Excluded: changing models
or harnesses during the comparison.

## Existing context

`research/frontier/records/RFR-005.md` and Roadmap Phase 3.

## Initial hypotheses

Selective or compiled context will preserve reliability at lower total cost than
full history. Context omissions or contamination may reverse that result.

## Required evidence

Frozen suite/configuration, randomization, run records, policy payloads, verified
outcomes, recovery traces, and cost data.

## Constraints

Hold model, harness, task version, and grading fixed. Report task-policy
interactions rather than only aggregate effects.

## Execution instructions

Predeclare policies and paired-run analysis before execution.

## Deliverables

Context-policy decision table, cost/reliability frontier, and failure analysis.

## Success criteria

Repeatable effect estimates sufficient to choose or reject a default context
policy.

## Stop conditions

Stop if task drift, grader drift, or incomplete telemetry breaks causal
comparability.

## Handoff requirements

Record the selected policy, exceptions, and revalidation triggers.
