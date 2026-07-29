---
identifier: RP-2026-07-28-EVAL-ROADMAP
title: AI-ROS Evaluation Research and Engineering Roadmap
version: 2.0.0
status: active
---

# Evaluation Research and Engineering Roadmap

## North Star

Optimize **verified useful outcomes per total cost under explicit risk constraints**. Total cost includes compute, retries, latency, human review, incident risk, and recovery—not just tokens.

## Principles

- validate tasks before measuring agents;
- test graders with alternative-correct and incomplete outcomes;
- isolate agents from gold data and production systems;
- preserve separate correctness, safety, defect, cost, and uncertainty measures;
- keep model/harness adapters replaceable;
- promote claims only after independent review and unseen replication;
- build infrastructure only when an observed failure requires it.

## Workstream A — Measurement Foundation

### A0: Constructs and task audit — complete

- [x] evaluation unit, constructs, outcome classes;
- [x] candidate task families;
- [x] failure taxonomy;
- [x] task-integrity audit.

### A1: Pilot contracts and in-sample graders — provisionally complete

- [x] ET-004 bounded edit fixture;
- [x] ET-014 task-defect fixture;
- [x] alternative-correct, incomplete, regressive, and persuasive-wrong probes;
- [x] deterministic calibration;
- [ ] two independent reviews;
- [ ] blinded review-label comparison.

Use `13-independent-review-protocol.md`; preserve original reviews before adjudication.

**Gate:** pilots remain provisional until independent review.

### A2: Blind baseline infrastructure — next

- blind fixture exporter;
- immutable JSON run schema;
- one replaceable harness adapter;
- final-state/diff capture;
- runtime, token/cost, retry, and intervention capture;
- at least three exploratory repeats per pilot.

**Gate:** no comparative ranking; use results to estimate variance and repair tasks.

### A3: Grader external validity

- unseen alternative-correct and incomplete outcomes;
- blinded expert labels;
- false-accept and false-reject estimates;
- model/rubric grader only if deterministic evidence leaves material ambiguity;
- exploit audit for grader shortcuts.

### A4: Representative minimum suite

Add ET-001, ET-003, ET-005, ET-007, ET-011, and ET-012 one at a time. Include at least one code/automation task from future real work before making coding-agent claims.

## Workstream B — Containment and Safety (Parallel, Mandatory)

### B0: Low-risk local containment — current

- [x] synthetic fixtures without secrets;
- [x] no network requirement;
- [x] threat model and trust boundaries;
- [ ] blind fixture export;
- [ ] grader outside agent-write scope.

### B1: Long-horizon controls

- timeout and checkpoint;
- pause/kill control;
- action telemetry;
- rollback/recovery test;
- prompt-injection task;
- confused-deputy and excessive-permission tasks.

### B2: External-tool readiness

Do not enable external writes until identity, scoped authorization, audit, idempotency, and recovery are demonstrated in synthetic systems.

## Workstream C — Context, State, and Memory

Start only after A2 produces a stable baseline:

1. artifact-only state;
2. full conversation/history;
3. recent-window context;
4. structured summary;
5. retrieval-compiled context;
6. stale/conflicting state injection.

Measure verified success, regressions, tokens/cost, recovery, and intervention. Do not assume more context is better.

## Workstream D — Human Review and Economics

- capture review minutes from the first baseline;
- identify which failures humans catch that graders miss;
- compare fixed gates with risk-triggered escalation;
- measure cost per verified outcome;
- estimate reviewer saturation and queue delay;
- test whether additional review changes decisions.

## Workstream E — Orchestration

Do not compare multi-agent systems before a single-agent baseline exists. Then compare:

1. single relay;
2. parallel independent attempts with adjudication;
3. specialist roles;
4. coordinator-worker hierarchy.

Measure duplicated effort, synthesis loss, latency, total verified cost, and failure correlation. Parallelism is valuable only when tasks are sufficiently independent and adjudication cost is lower than the gain.

## Workstream F — Retrieval and Knowledge Platform

- create real repository questions and relevance judgments;
- benchmark lexical search first;
- add vector/hybrid retrieval only where lexical fails;
- test canonical-source selection and freshness;
- add graph-assisted retrieval only if relationship queries show unmet value;
- generate website/search views from canonical evidence rather than creating a second source of truth.

## Workstream G — Model Routing and Operations

- route by task risk, ambiguity, horizon, modality, and privacy;
- evaluate model snapshots, not brand names;
- refresh baselines only for material changes;
- use control charts/regression thresholds before claiming improvement;
- archive invalidated tasks and preserve comparability notes.

## Governance and Teaching

Every cycle must leave:

- an immutable cycle report;
- appended journal entry;
- updated evidence/hypothesis/experiment records;
- explicit negative results;
- a plain-language explanation;
- exact next action and stop condition.

Teach the system as a hierarchy:

1. Is the task valid?
2. Is the run contained?
3. Is the outcome observable?
4. Is the grader calibrated?
5. Is the result repeatable?
6. Does it transfer to the real decision?
7. Is the verified value worth the full cost?

## Dependencies and Critical Path

Critical path:

`independent pilot review → blind fixture/export → exploratory repeated baseline → unseen grader calibration → minimum representative suite → context comparison`

Parallel prerequisites:

`containment + telemetry + human-review protocol + cost accounting`

Orchestration, knowledge graphs, dashboards, and large model matrices are deliberately off the critical path.

## Diminishing-Returns Boundary for the Current Run

Further design now would mostly speculate. The next decision-changing evidence requires:

- independent reviewers;
- actual isolated agent runs;
- captured resource data;
- unseen outputs.

Do not add more architecture until those observations expose a concrete failure or decision.
