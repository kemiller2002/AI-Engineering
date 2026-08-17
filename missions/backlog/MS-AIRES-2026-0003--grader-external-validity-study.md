---
id: MS-AIRES-2026-0003
title: Grader external-validity study
status: proposed
priority: high
artifact_tier: research-cycle
research_area: agent-evaluation
discipline: [measurement, statistics]
created: 2026-08-17
owner_agent: unassigned
depends_on: [MS-AIRES-2026-0002]
related_projects: [RFR-003, NX-001]
outputs: [research/packages/RP-AIRES-2026-0003--grader-external-validity-study.md]
---

# Mission

## Objective

Compare frozen deterministic and optional layered grader decisions with blinded
expert labels on unseen and naturally produced outcomes.

## Why this matters

All later comparisons depend on knowing the grader's false-accept and
false-reject behavior outside designer-created probes.

## Scope

Included: stratified blinded outcomes, expert reference labels, confusion tables,
disagreement analysis, reviewer burden, and incremental grader value. Excluded:
grader promotion based only on known probes.

## Existing context

`research/frontier/records/RFR-003.md`, NX-001, and evaluation Gate B.

## Initial hypotheses

The frozen grader will agree with expert consensus within declared bounds; an
unexplained material false acceptance falsifies promotion.

## Required evidence

Outcome corpus, blind labels, adjudication, grader hashes and outputs, error
tables, uncertainty statement, and cost measurements.

## Constraints

Outcome authors and labelers must not see grader internals. Preserve task-level
results and avoid unsupported population estimates.

## Execution instructions

Predeclare sampling and adjudication, then run graders without modification.

## Deliverables

Validation dataset, error analysis, and grader promote/revise/quarantine record.

## Success criteria

Declared error bounds and evidence that every additional grader changes enough
decisions to justify its cost.

## Stop conditions

Stop on leakage, invalid blinding, or insufficient independent labels.

## Handoff requirements

Document which grader stack is permitted for MS-AIRES-2026-0004.
