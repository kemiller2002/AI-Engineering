---
id: MS-AIRES-2026-0007
title: Risk-triggered human escalation study
status: proposed
priority: medium
artifact_tier: full-rep
research_area: human-agent-systems
discipline: [human-factors, safety]
created: 2026-08-17
owner_agent: unassigned
depends_on: [MS-AIRES-2026-0004, MS-AIRES-2026-0008]
related_projects: [RFR-007]
outputs: [research/packages/RP-AIRES-2026-0007--risk-triggered-human-escalation-study.md]
---

# Mission

## Objective

Compare fixed approval gates, risk-triggered escalation, and end-only review on
ethically bounded tasks.

## Why this matters

The repository lacks evidence about intervention timing, reviewer burden,
missed-risk rate, autonomy loss, and trust calibration.

## Scope

Included: explicit risk strata, within-task policy comparison, preventions,
false alarms, review time, recovery, and verified outcomes. Excluded: production
external writes.

## Existing context

`research/frontier/records/RFR-007.md`, Roadmap Phase 5, and the threat model.

## Initial hypotheses

Risk-triggered escalation will reduce consequential exposure with lower burden
than fixed gates. Missed risks or unacceptable outcome loss falsify that policy.

## Required evidence

Risk labels, intervention logs, reviewer actions and time, outcomes, false alarms,
missed risks, and recovery records.

## Constraints

Use trained reviewers and synthetic or low-risk tasks with working containment.

## Execution instructions

Predeclare triggers and adjudication, randomize policy where safe, and preserve
all interventions.

## Deliverables

Escalation policy, burden/risk frontier, and failure analysis.

## Success criteria

Lower consequential-risk exposure without unacceptable verified-outcome loss.

## Stop conditions

Stop on containment failure, unsafe exposure, or unreliable risk labels.

## Handoff requirements

Document allowed autonomy tiers, triggers, and unresolved human-factors risks.
