---
id: MS-AIRES-2026-0011
title: Audit versus no-audit decision counterfactual
status: proposed
priority: medium
artifact_tier: full-rep
research_area: evaluation-governance
discipline: [causal-inference, research-methods]
created: 2026-08-17
owner_agent: unassigned
depends_on: [MS-AIRES-2026-0004]
related_projects: [NX-005]
outputs: [research/packages/RP-AIRES-2026-0011--audit-decision-counterfactual.md]
---

# Mission

## Objective

Measure whether independent task audit changes material capability decisions
compared with the frozen unaudited contracts.

## Why this matters

The repository assumes audit prevents false conclusions, but current evidence
shows document improvement rather than a causal decision effect.

## Scope

Included: varied task sample, frozen pre-audit contracts, independent audits,
paired decision reconstruction, changed statuses/conclusions, burden, and error
analysis. Excluded: rewriting pre-audit artifacts after results are known.

## Existing context

NX-005 in `research/analysis/non-human-next-experiments.md` and the audit-first
evaluation decision framework.

## Initial hypotheses

Audit will prevent or materially change at least some false capability
conclusions. No decision changes despite document edits weakens mandatory audit.

## Required evidence

Frozen before/after contracts, independent audit records, paired capability
decisions, adjudication, time/cost, and changed-decision rationale.

## Constraints

Preserve both versions and blind decision reconstruction where possible.

## Execution instructions

Predeclare material decision changes and analyze the paired counterfactual.

## Deliverables

Counterfactual dataset, causal-limitations analysis, and audit-policy decision.

## Success criteria

A defensible estimate of which material conclusions audit changes and at what
cost.

## Stop conditions

Stop if the sample lacks varied tasks or before/after decisions cannot be
reconstructed independently.

## Handoff requirements

Recommend mandatory, risk-triggered, optional, or rejected audit policy with
explicit evidence limits.
