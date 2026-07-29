---
identifier: RP-2026-07-23-004
title: AI Research Roadmap
version: 2.0.0
status: active
as_of: 2026-07-28
---

# AI Research Roadmap

## Strategy

Build measurement before complexity, while treating containment as a parallel prerequisite rather than a later phase. Each phase should create evidence that can cancel or reshape later work. Time estimates are agent/research effort, not calendar commitments.

The detailed active plan is `research/evaluation/12-research-and-engineering-roadmap.md`.

## Phase 0 — Task and Grader Integrity (active)

**Objective:** ensure tasks and graders can support a fair inference before measuring agents.

- [x] Define constructs, outcomes, and failure taxonomy.
- [x] Create sixteen candidate task families.
- [x] Instantiate ET-004 and ET-014 pilots.
- [x] Calibrate deterministic grading against seven declared probes.
- [x] Export blind fixtures without gold/probe outcomes.
- [ ] Obtain two independent reviews.
- [ ] Test unseen alternative-correct and incomplete outcomes.

**Exit criteria:** reviewers agree or disagreements are adjudicated; alternative-correct work passes; incomplete work fails; contamination controls are tested.

## Phase 1 — Contained Exploratory Baseline

**Objective:** determine which measures predict correct repository outcomes.

- Freeze one complete agent-system configuration.
- Run only validated pilots in disposable blind fixtures.
- Capture final state, actions, runtime, tokens/cost, retries, and human interventions.
- Repeat at least three times for exploratory variance; choose later sample size from observed variance.
- Repair task and grader defects before expanding.

**Deliverables:** immutable run records, variance estimate, failure analysis, grader revisions.

**Decision gate:** do not rank models or architectures from pilot/debugging runs.

## Parallel Foundation — Containment and Runtime Safety

This work begins before Phase 1 and continues throughout:

- no production credentials;
- network deny-by-default;
- disposable state;
- agent/grader permission separation;
- timeouts, checkpoints, pause/kill, and rollback;
- action telemetry and post-run inspection.

This sequencing change follows current evidence that evaluation environments can create real security incidents and that fixed suites do not anticipate every long-horizon failure.

## Phase 2 — External Validity and Representative Suite

**Objective:** establish that graders work on unseen outcomes and that the task mix supports the intended claims.

- calibrate against blinded expert labels;
- estimate false acceptance/rejection;
- add one task family at a time;
- include recovery, provenance, injection, and cross-file state;
- add genuine code/automation work before coding-agent claims.

**Decision gate:** task-level results and sampling limits must be reported before aggregate claims.

## Phase 3 — Context, State, and Memory

**Objective:** find the lowest-cost policy that preserves reliable completion.

- Compare full history, recent-window, structured summary, retrieval, and artifact-first state.
- Inject stale, conflicting, and missing state.
- Measure error type, recovery, context cost, and human intervention.

**Deliverables:** context policy, memory freshness protocol, state schema, decision framework.

## Phase 4 — Permissions, Security, and Recovery

**Objective:** bound agent action without destroying utility.

- Define read-only, workspace-write, external-write, and destructive tiers.
- Test prompt injection, schema mutation, secret exposure, confused-deputy, and unintended side effects.
- Evaluate checkpointing, rollback, and escalation.

**Deliverables:** threat model, permission matrix, recovery playbook, safety evaluation pack.

## Phase 5 — Human Review, Economics, and Orchestration

**Objective:** identify when parallel agents or human intervention create net value.

- Measure reviewer burden and cost per verified outcome before adding agents.
- Compare single relay, parallel independent, specialist, and coordinator-worker structures only after a stable single-agent baseline.
- Measure duplicated work, synthesis loss, latency, verified cost, and reviewer burden.
- Compare fixed approval gates with risk-triggered escalation.

**Deliverables:** orchestration threshold framework, human-agent operating model, scheduling guidance.

## Phase 6 — Retrieval and Knowledge Platform

**Objective:** validate the minimum knowledge architecture needed for AI-ROS.

- Create repository question/relevance judgments.
- Compare lexical, vector, hybrid, curated context, and graph-assisted retrieval.
- Test freshness, canonical source selection, and provenance.
- Decide whether a knowledge graph earns its maintenance cost.

**Deliverables:** retrieval benchmark, search decision record, knowledge-graph go/no-go.

## Phase 7 — Model Routing and Interface Agents

**Objective:** optimize verified outcomes across fast-changing models and interfaces.

- Route tasks by complexity, risk, modality, and privacy.
- Evaluate browser, desktop, and multimodal work under perturbations.
- Maintain quarterly local/cloud/open/frontier scorecards.

**Deliverables:** routing policy, deployment scorecard, UI-agent risk profile.

## Continuous Research

- Quarterly benchmark validity audit
- Monthly model/harness baseline refresh when material releases occur
- Regression suite on every change to prompts, context policy, permissions, or tools
- Append-only preservation of failed hypotheses and task defects
- Annual reprioritization of the matrix

## Dependency Flow

Critical path:

`task/grader integrity → contained baseline → external validity → representative suite → context/state → human economics → orchestration → retrieval/platform → routing/interfaces`

Parallel prerequisite:

`containment + telemetry + pause/rollback`

## Stop Conditions

Pause or redirect a stream when:

- metrics do not change a decision;
- task ambiguity exceeds agent error;
- model churn invalidates the implementation faster than it can be evaluated;
- coordination cost exceeds measured benefit;
- a simpler artifact or test provides equivalent decision value.

Current diminishing-returns boundary: do not add further architecture until independent review or isolated run evidence changes a decision.
