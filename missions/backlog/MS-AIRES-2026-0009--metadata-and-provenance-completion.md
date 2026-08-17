---
id: MS-AIRES-2026-0009
title: Metadata adoption and provenance-edge validation
status: proposed
priority: high
artifact_tier: research-cycle
research_area: repository-integrity
discipline: [knowledge-management, repository-tooling]
created: 2026-08-17
owner_agent: unassigned
depends_on: []
related_projects: [RFR-009]
outputs: [research/packages/RP-AIRES-2026-0009--metadata-and-provenance-completion.md]
---

# Mission

## Objective

Define bounded canonical metadata adoption, obtain a real supersession-edge
sample, and validate reciprocal and semantic provenance checks.

## Why this matters

RFR-009 tooling exists, but low metadata coverage and no real supersession edge
prevent reliable repository-wide provenance traversal.

## Scope

Included: adoption policy, a bounded current-artifact migration, real edge
sample, heading/bare-path/registry-reference decisions, seeded tests, and
retrieval impact measurement. Excluded: indiscriminate legacy migration.

## Existing context

`research/frontier/records/RFR-009.md` and both RFR-009 investigation records.

## Initial hypotheses

Targeted metadata on current canonical artifacts will improve traversal enough
to justify its maintenance cost. The competing result is negligible retrieval
benefit or excessive migration burden.

## Required evidence

Before/after inventory, policy decision, migrated sample, real supersession
records, seeded defects, validator results, and retrieval/handoff observations.

## Constraints

Preserve legacy IDs and provenance; do not enforce fields before policy approval;
do not invent supersession relationships.

## Execution instructions

Select the smallest decision-relevant artifact class, measure baseline, migrate,
validate, and compare retrieval/handoff behavior.

## Deliverables

Adoption decision, migration map if needed, calibrated checks, updated inventory,
and RFR-009 disposition.

## Success criteria

Zero unexplained canonical reference failures, all seeded defects detected, and
a defensible adopt/limit/reject decision for metadata expansion.

## Stop conditions

Stop if no real provenance edge exists or measured value cannot justify broader
migration.

## Handoff requirements

State whether RFR-009 can close and which artifact classes remain diagnostic.
