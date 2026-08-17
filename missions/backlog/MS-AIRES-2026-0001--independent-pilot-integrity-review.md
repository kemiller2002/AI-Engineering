---
id: MS-AIRES-2026-0001
title: Independent pilot integrity review
status: proposed
priority: critical
artifact_tier: research-cycle
research_area: agent-evaluation
discipline: [measurement, research-methods]
created: 2026-08-17
owner_agent: unassigned
depends_on: []
related_projects: [RFR-001, NX-001]
outputs: [research/packages/RP-AIRES-2026-0001--independent-pilot-integrity-review.md]
---

# Mission

## Objective

Obtain two blinded, independent construct and probe reviews for ET-004-P01 and
ET-014-P01, then validate, revise, or quarantine each pilot.

## Why this matters

Designer calibration cannot establish construct validity. This is the current
gate for all capability baselines.

## Scope

Included: reviewer recruitment, preregistered materials, independent labels,
agreement analysis, post-capture adjudication, immutable dispositions. Excluded:
agent capability runs and model comparisons.

## Existing context

`research/frontier/records/RFR-001.md`,
`research/evaluation/13-independent-review-protocol.md`, and NX-001 in
`research/analysis/non-human-next-experiments.md`.

## Initial hypotheses

Independent reviewers will find both pilots valid after bounded revisions and
will agree on material probe labels. A quarantine or unresolved disagreement
falsifies promotion readiness.

## Required evidence

Original independent reviews, blinded labels, agreement table, adjudication,
task/grader hashes, and final pilot disposition.

## Constraints

Reviewers must not have designed the tasks or graders. Preserve reviews before
discussion and do not simulate independence with repository agents.

## Execution instructions

Follow the independent-review protocol and the frozen unseen-outcome portion of
NX-001. Record revisions without overwriting prior versions.

## Deliverables

Cycle report, immutable review records, agreement analysis, and updated
evaluation registries.

## Success criteria

Two independent reviews per pilot, no concealed disagreement, and an explicit
validate/revise/quarantine decision for each pilot.

## Stop conditions

Stop when both pilots have a defensible disposition or reviewer independence
cannot be obtained.

## Handoff requirements

State which pilots, if any, unlock MS-AIRES-2026-0002 and list every unresolved
validity concern.
