---
id: MS-AIRES-2026-0006
title: Total verified-cost measurement
status: proposed
priority: medium
artifact_tier: research-cycle
research_area: evaluation-economics
discipline: [operations-research, economics]
created: 2026-08-17
owner_agent: unassigned
depends_on: [MS-AIRES-2026-0002, MS-AIRES-2026-0004]
related_projects: [RFR-006]
outputs: [research/packages/RP-AIRES-2026-0006--total-verified-cost-measurement.md]
---

# Mission

## Objective

Operationalize total cost per verified useful outcome across compute, retries,
latency, review, incidents, intervention, and recovery.

## Why this matters

Token cost alone can reverse deployment decisions when human and failure costs
are material.

## Scope

Included: prospective resource accounting, failed-attempt costs, task-level
distributions, and sensitivity analysis. Excluded: universal monetary weights
unsupported by observed use cases.

## Existing context

`research/frontier/records/RFR-006.md` and evaluation Workstream D.

## Initial hypotheses

All-in cost changes at least some system or policy rankings relative to token
cost. The competing result is ranking stability across plausible weights.

## Required evidence

Versioned cost schema, complete run/intervention logs, valuation assumptions,
sensitivity ranges, and reconciliation records.

## Constraints

Separate observations from assigned weights and preserve failed runs.

## Execution instructions

Instrument costs before collecting the target runs and reconcile every run.

## Deliverables

Cost schema, observed dataset, sensitivity report, and decision guidance.

## Success criteria

Every included run reconciles and conclusions remain explicit across plausible
cost weights.

## Stop conditions

Stop if missing telemetry prevents all-in reconciliation.

## Handoff requirements

Provide reusable cost fields and identify the weights that materially change
decisions.
