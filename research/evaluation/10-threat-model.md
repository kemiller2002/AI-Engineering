---
identifier: RP-2026-07-28-EVAL-THREAT
title: Evaluation System Threat Model
version: 0.1.0
status: provisional
---

# Evaluation System Threat Model

## Assets

- user files and Git history;
- credentials and identity;
- grader integrity and gold outcomes;
- benchmark validity;
- external services;
- raw traces and potentially sensitive data;
- operator time and money.

## Trust Boundaries

1. task author ↔ task fixture;
2. agent ↔ sandbox/tools/network;
3. agent outcome ↔ grader;
4. grader ↔ gold data;
5. runtime ↔ production credentials/services;
6. results ↔ published capability claims.

## Threats and Controls

| Threat | Failure | Minimum control |
|---|---|---|
| Agent reads expected outcomes | TF-006 | Blind fixture export; gold outside agent-readable path |
| Agent edits grader | TF-006/TF-009 | Read-only external grader process |
| Task content injects instructions | AF-007 | Authority separation; adversarial fixture; action telemetry |
| Agent reaches production service | AF-006 | No production credentials; network deny-by-default |
| Agent escapes intended scope | AF-006 | Disposable sandbox; explicit tool permissions; timeout |
| Grader rewards shortcut | TF-003/TF-009 | Negative probes, exploit audit, state recomputation |
| Correct alternative rejected | TF-002 | Alternative-correct probes; semantic adjudication |
| Incomplete solution passes | TF-003 | Mutation/incomplete probes and regression checks |
| Trace exposes secrets | IF-003/security | Redaction policy; synthetic credentials; access controls |
| Long run drifts into harm | AF-006 | Runtime monitor, checkpoints, kill switch, rollback |
| Evaluator overclaims results | TF-008 | Scope statement, per-task results, uncertainty, replication gate |

## Architectural Consequence

Security and evaluation are not serial phases. Containment, gold separation, telemetry, pause, and rollback must exist before adversarial or long-horizon evaluation. Later security research can deepen controls, but it cannot be postponed behind baseline work.

## Residual Risk

Local documentation fixtures are low consequence, but the architecture must not generalize that low risk to networked, cyber, browser, financial, or production-code tasks.

