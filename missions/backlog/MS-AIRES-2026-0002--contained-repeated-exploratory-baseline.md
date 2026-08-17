---
id: MS-AIRES-2026-0002
title: Contained repeated exploratory baseline
status: proposed
priority: critical
artifact_tier: research-cycle
research_area: agent-evaluation
discipline: [experimental-methods, agent-systems]
created: 2026-08-17
owner_agent: unassigned
depends_on: [MS-AIRES-2026-0001, MS-AIRES-2026-0008]
related_projects: [RFR-002, NX-002]
outputs: [research/packages/RP-AIRES-2026-0002--contained-repeated-exploratory-baseline.md]
---

# Mission

## Objective

Run each validated pilot at least three times with one frozen agent-system
configuration in disposable blind fixtures.

## Why this matters

The repository has no direct agent capability observations, variance estimate,
or complete run-cost record.

## Scope

Included: validated pilots, frozen configuration, random run order, trajectories,
final state, retries, runtime, cost, interventions, and failures. Excluded:
comparative rankings and stable success-rate claims.

## Existing context

`research/frontier/records/RFR-002.md`, NX-002, and Workstream A2 in the
evaluation roadmap.

## Initial hypotheses

Contained repeated runs will produce reconstructable task-level outcomes and
variance useful for the next sample design. Infrastructure or task defects may
instead invalidate the observations.

## Required evidence

Frozen configuration, fixture hashes, run records, action telemetry, final-state
diffs, grader results, cost/intervention logs, and invalid-run reasons.

## Constraints

Only pilots promoted by MS-AIRES-2026-0001 may run. No production credentials,
gold access, or network access unless separately authorized and contained.

## Execution instructions

Predeclare stop rules and run order. Preserve every valid and invalid attempt.

## Deliverables

Immutable run dataset, exploratory variance summary, failure updates, and a
baseline decision.

## Success criteria

At least three valid repetitions per promoted pilot with complete metadata and
reconstructable outcomes.

## Stop conditions

Stop at six valid trials or immediately on containment, telemetry, task, or
grader failure that invalidates further runs.

## Handoff requirements

Provide the natural outcomes needed by MS-AIRES-2026-0003 and the observed
variance needed for later sampling.
