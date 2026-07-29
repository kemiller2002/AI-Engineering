---
identifier: RP-2026-07-28-EVAL-ARCH
title: AI-ROS Evaluation System Architecture
version: 0.1.0
status: proposed
---

# Evaluation System Architecture

## Architectural Objective

Make every capability claim reconstructable from a frozen system configuration, blind task fixture, observable outcome, calibrated grader, and explicit uncertainty statement.

## Components

1. **Task Registry** — task family, version, construct, risk, provenance, status.
2. **Fixture Builder** — creates disposable initial state without gold leakage.
3. **Agent Runner Adapter** — invokes a named model/harness without embedding task-specific advantages.
4. **Containment Layer** — permissions, network policy, credentials, timeout, checkpoint, kill switch.
5. **Telemetry Recorder** — configuration, actions, final state, runtime, tokens/cost, interventions.
6. **Grader Stack** — deterministic outcomes first; provenance, trajectory, model, and human layers only when justified.
7. **Integrity Auditor** — task/grader probe testing, contamination audit, independent review.
8. **Results Store** — immutable raw run records plus derived summaries.
9. **Decision Layer** — readiness gates and engineering recommendations.

## Information Flow

`task contract → blind fixture → contained runner → outcome/trace → external graders → integrity audit → results → decision`

Gold outcomes and grader internals flow directly to the external graders and must not flow through the agent boundary.

## Canonical Data Contracts

### Task

- stable ID and version;
- construct and task family;
- visible prompt;
- allowed/prohibited actions;
- initial-state hash;
- observable requirements;
- regressions;
- contamination and risk classification;
- grader versions.

### Run

- immutable run ID;
- exact system configuration;
- task/fixture versions;
- timestamps and resource usage;
- interventions;
- final-state hash/diff;
- raw grader records;
- failure IDs;
- scope warnings.

### Decision

- question;
- evidence IDs;
- alternatives;
- selected action;
- uncertainty;
- reversal trigger;
- owner and review date.

## Build-vs-Buy Decisions

- Build the task contracts, fixtures, and repository-specific graders because they encode AI-ROS semantics.
- Keep the runner adapter thin and replaceable; model/harness churn is high.
- Do not build a dashboard, database, distributed scheduler, or knowledge graph until repeated runs make Markdown/JSON and local files inadequate.
- Do not build a universal composite score.

## Evolution Path

### Now

- local versioned fixtures;
- Python standard-library grader;
- Markdown/JSON results;
- manual independent review;
- disposable local copies.

### Next

- blind fixture export;
- JSON run schema;
- runner adapter for one harness;
- automated state capture;
- reviewer-label format;
- CI regression for graders.

### Later, if earned

- isolated container runner;
- encrypted raw trace store;
- scheduled model matrix;
- human-review queue;
- dashboard generated from canonical results;
- organization-wide benchmark governance.

