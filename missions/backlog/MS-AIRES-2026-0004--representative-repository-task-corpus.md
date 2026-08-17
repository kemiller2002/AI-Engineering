---
id: MS-AIRES-2026-0004
title: Representative repository task corpus
status: proposed
priority: high
artifact_tier: full-rep
research_area: agent-evaluation
discipline: [dataset-design, software-maintenance]
created: 2026-08-17
owner_agent: unassigned
depends_on: [MS-AIRES-2026-0003, MS-AIRES-2026-0009]
related_projects: [RFR-004, NX-004]
outputs: [research/packages/RP-AIRES-2026-0004--representative-repository-task-corpus.md]
---

# Mission

## Objective

Build and independently audit a minimum versioned suite spanning real coding,
documentation, recovery, provenance, security, and cross-file work.

## Why this matters

The current documentation-heavy pilots cannot support broad repository-agent or
coding-agent claims.

## Scope

Included: target population, sampling frame, held-out history, audited synthetic
cases, leakage/provenance records, and task-level reporting. Excluded: expanding
the suite before each added family changes a decision.

## Existing context

`research/frontier/records/RFR-004.md`, NX-004, and evaluation Workstream A4.

## Initial hypotheses

A small audited suite can expose materially different failures across task
families. Failure to source genuine coding work falsifies coding-agent scope.

## Required evidence

Sampling report, source provenance, task contracts, independent audits, held-out
fixtures, coverage rationale, and leakage assessment.

## Constraints

Add one family at a time; preserve licensing, privacy, and repository history;
report sampling limits before aggregate metrics.

## Execution instructions

Start with one independently authored code/automation task, then add only
decision-relevant families.

## Deliverables

Versioned corpus, task manifest, audit labels, held-out fixtures, and scope
decision.

## Success criteria

Explicit coverage targets and demonstrated inclusion of genuine coding work.

## Stop conditions

Stop when additional families no longer change the intended claim boundary or
when provenance/leakage cannot be controlled.

## Handoff requirements

Publish the allowed inference scope and stable task versions for downstream
comparisons.
