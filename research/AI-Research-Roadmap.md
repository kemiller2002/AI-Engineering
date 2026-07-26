---
identifier: RP-2026-07-23-004
title: AI Research Roadmap
version: 1.0.0
status: active
as_of: 2026-07-23
---

# AI Research Roadmap

## Strategy

Build measurement before complexity. Each phase should create evidence that can cancel or reshape later work. Time estimates are agent/research effort, not calendar commitments.

## Phase 0 — Baseline and Instrumentation (1–2 weeks)

**Objective:** establish a reproducible task suite and full cost/outcome capture.

- Select 12–20 representative repository tasks spanning research, editing, retrieval, validation, and coding.
- Define success, partial success, regressions, prohibited actions, and human-review criteria.
- Record model, harness, prompt, tool permissions, context policy, environment, latency, tokens/cost, retries, and intervention time.
- Run repeated baselines.

**Exit criteria:** another agent can reproduce runs; graders agree sufficiently; broken or ambiguous tasks are removed or repaired.

## Phase 1 — Evaluation and Verification (2–4 weeks)

**Objective:** determine which measures predict correct repository outcomes.

- Compare final-state tests, rubric grading, trace grading, provenance checks, and human review.
- Audit task validity using independent reviewers and adversarial attempts.
- Create failure taxonomy and confidence calibration.
- Test the prediction that rankings change when cost, regressions, and human effort are included.

**Deliverables:** eval specification, task manifest, baseline REP, evaluation harness, grader audit.

**Decision gate:** do not automate further if the suite cannot reliably distinguish complete, partial, unsafe, and persuasive-but-wrong work.

## Phase 2 — Context, State, and Memory (2–4 weeks)

**Objective:** find the lowest-cost policy that preserves reliable completion.

- Compare full history, recent-window, structured summary, retrieval, and artifact-first state.
- Inject stale, conflicting, and missing state.
- Measure error type, recovery, context cost, and human intervention.

**Deliverables:** context policy, memory freshness protocol, state schema, decision framework.

## Phase 3 — Permissions, Security, and Recovery (2–3 weeks)

**Objective:** bound agent action without destroying utility.

- Define read-only, workspace-write, external-write, and destructive tiers.
- Test prompt injection, schema mutation, secret exposure, confused-deputy, and unintended side effects.
- Evaluate checkpointing, rollback, and escalation.

**Deliverables:** threat model, permission matrix, recovery playbook, safety evaluation pack.

## Phase 4 — Orchestration and Human Collaboration (3–5 weeks)

**Objective:** identify when parallel agents or human intervention create net value.

- Compare single relay, parallel independent, specialist, and coordinator-worker structures.
- Measure duplicated work, synthesis loss, latency, verified cost, and reviewer burden.
- Compare fixed approval gates with risk-triggered escalation.

**Deliverables:** orchestration threshold framework, human-agent operating model, scheduling guidance.

## Phase 5 — Retrieval and Knowledge Platform (3–5 weeks)

**Objective:** validate the minimum knowledge architecture needed for AI-ROS.

- Create repository question/relevance judgments.
- Compare lexical, vector, hybrid, curated context, and graph-assisted retrieval.
- Test freshness, canonical source selection, and provenance.
- Decide whether a knowledge graph earns its maintenance cost.

**Deliverables:** retrieval benchmark, search decision record, knowledge-graph go/no-go.

## Phase 6 — Model Routing and Interface Agents (ongoing)

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

`evaluation → context/state → security/recovery → orchestration/human factors → retrieval/knowledge platform → routing/interfaces`

Security threat cases begin in Phase 1 even though the full security program follows context work.

## Stop Conditions

Pause or redirect a stream when:

- metrics do not change a decision;
- task ambiguity exceeds agent error;
- model churn invalidates the implementation faster than it can be evaluated;
- coordination cost exceeds measured benefit;
- a simpler artifact or test provides equivalent decision value.

