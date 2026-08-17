---
id: MS-AIRES-2026-0008
title: Evaluation containment validation
status: proposed
priority: critical
artifact_tier: research-cycle
research_area: agent-safety
discipline: [security-engineering, resilience]
created: 2026-08-17
owner_agent: unassigned
depends_on: []
related_projects: [RFR-008, NX-003]
outputs: [research/packages/RP-AIRES-2026-0008--evaluation-containment-validation.md]
---

# Mission

## Objective

Test containment, gold separation, monitoring, pause, and rollback controls while
measuring construct distortion.

## Why this matters

Safe baseline execution depends on controls that currently have architectural
support but limited control-effectiveness evidence.

## Scope

Included: benign fault injection, adversarial gold-separation cases, denied
actions, telemetry, pause/kill, rollback, incident response, and task impact.
Excluded: production credentials and uncontrolled adversarial execution.

## Existing context

`research/frontier/records/RFR-008.md`, NX-003, the threat model, and evaluation
Workstream B.

## Initial hypotheses

Critical controls will fail safely and preserve sufficient task validity. Any
secret/gold leak or unrecoverable action falsifies readiness.

## Required evidence

Control matrix, planted-secret manifest, fault scenarios, telemetry, alerts,
rollback proofs, incident records, and distortion measurements.

## Constraints

Use disposable synthetic environments. Start with benign faults before more
adversarial scenarios.

## Execution instructions

Test each control independently, then test composed failure paths.

## Deliverables

Control test suite, gold-separation audit, incident records, and residual-risk
decision.

## Success criteria

All critical controls fail safely with complete evidence, measured recovery, and
acceptable task distortion.

## Stop conditions

Stop immediately on uncontrolled escape, secret exposure, or missing telemetry.

## Handoff requirements

State whether MS-AIRES-2026-0002 is safe to run and list residual controls.
