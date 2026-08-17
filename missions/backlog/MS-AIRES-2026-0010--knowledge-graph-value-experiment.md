---
id: MS-AIRES-2026-0010
title: Knowledge-graph value experiment
status: proposed
priority: low
artifact_tier: full-rep
research_area: knowledge-platform
discipline: [knowledge-engineering, information-retrieval]
created: 2026-08-17
owner_agent: unassigned
depends_on: [MS-AIRES-2026-0004, MS-AIRES-2026-0009]
related_projects: [RFR-010]
outputs: [research/packages/RP-AIRES-2026-0010--knowledge-graph-value-experiment.md]
---

# Mission

## Objective

Test whether a maintained research graph improves retrieval, handoff accuracy,
duplicate detection, and research selection enough to justify maintenance.

## Why this matters

A graph may compound repository learning or create expensive ontology debt.

## Scope

Included: representative navigation/synthesis tasks, file/search baseline,
minimal graph workflow, correctness, time, missed provenance, duplicates, and
maintenance effort. Excluded: production graph infrastructure before value is
demonstrated.

## Existing context

`research/frontier/records/RFR-010.md` and knowledge-platform architecture.

## Initial hypotheses

Graph assistance will produce replicated material gains on relationship-heavy
tasks exceeding maintenance cost. Search parity falsifies adoption.

## Required evidence

Benchmark tasks, relevance/answer judgments, baseline results, graph results,
maintenance logs, and replication.

## Constraints

Use stable corpus and identifiers; keep the prototype minimal and reversible.

## Execution instructions

Predefine tasks and go/no-go threshold before building the graph slice.

## Deliverables

Minimal prototype, benchmark results, cost-benefit analysis, and go/no-go
decision.

## Success criteria

Replicated material gains that exceed ongoing maintenance cost.

## Stop conditions

Stop when search matches graph performance or ontology instability dominates.

## Handoff requirements

Record adopt/reject scope and delete-or-preserve disposition for the prototype.
