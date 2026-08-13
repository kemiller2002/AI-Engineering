---
identifier: RP-2026-07-30-NHE-BACKLOG
title: Non-Human Experimental Research Backlog
version: 1.0.0
status: active
confidence: medium-high
---

# Non-Human Experimental Research Backlog

## Priority matrix

Scales are ordinal: 5 is highest information/impact/cost/risk. Priority accounts
for prerequisites and is not a computed universal score.

| Proposed experiment | Information gain | Decision impact | Cost | Obsolescence risk | Priority |
|---|---:|---:|---:|---:|---|
| NX-001 Independent review + frozen unseen grader challenge | 5 | 5 | 2 | 2 | 1 |
| NX-002 Contained repeated baseline on pilots that pass NX-001 | 5 | 5 | 3 | 4 | 2 |
| NX-003 Adversarial gold-separation audit | 4 | 5 | 2 | 2 | 3 |
| NX-004 Independent code/automation task replication | 5 | 4 | 4 | 3 | 4 |
| NX-005 Audit/no-audit decision counterfactual | 3 | 3 | 4 | 3 | 5 |

## NX-001 — Independent review and frozen unseen grader challenge

- **Originating uncertainty:** Are ET-004-P01 and ET-014-P01 fair, and does the
  grader classify outcomes it was not co-designed with?
- **Prior experiments:** EX-E002, EX-E003, EX-E004.
- **Hypothesis:** Two independent reviewers will find the visible contracts
  valid after bounded revisions, and the frozen grader will agree with blinded
  consensus on materially correct/incorrect unseen outcomes.
- **Competing hypothesis:** At least one task is quarantined or the frozen grader
  has decision-material false acceptance/rejection.
- **Independent variables:** task; outcome source (independent mutation versus
  agent-produced later); outcome class.
- **Dependent variables:** reviewer validity label, disagreement, grader/consensus
  match, false-accept/false-reject cases, required revisions.
- **Controls/baseline:** current seven known probes as regression controls; current
  task versions and grader hash frozen.
- **Dataset:** both pilots; minimum six unseen outcomes per pilot with balanced
  intended classes, authored without grader access. This is a coverage target,
  not a power claim.
- **Model selection:** none required for the first mutation set.
- **Randomization/blinding:** reviewers see visible task first, then independently
  label shuffled outcomes; outcome authors do not see grader implementation;
  grader remains frozen.
- **Metrics:** per-case labels, confusion table, disagreement reasons; no aggregate
  promotion if one material false acceptance remains unexplained.
- **Success:** two valid reviews after revisions, known probes still pass, no
  unresolved material false acceptance, and false rejections are bounded or
  routed to adjudication.
- **Falsification:** quarantine label, material hidden requirement, or unexplained
  semantic error by the frozen grader.
- **Expected information gain:** Very high; directly attacks researcher
  circularity and unlocks or blocks agent runs.
- **Estimated cost:** 2 reviewers, one adjudicator if needed, 2–4 engineering
  hours excluding reviewer availability.
- **Risks:** reviewers are not independent; mutation set remains narrow.
- **Stop:** each task is validated, revised and rechecked, or quarantined.
- **Artifacts:** immutable reviews, blinded labels, outcome files, hashes,
  adjudication, updated registry/cycle.

## NX-002 — Contained exploratory baseline

- **Originating uncertainty:** Can one frozen agent system complete validated
  pilots repeatably, safely, and economically?
- **Prior:** EX-E005, unlocked by NX-001 and EX-E007.
- **Hypothesis/competitor:** success/failure patterns are observable and variance
  can guide later sample size / outcomes are dominated by task, grader, or
  infrastructure defects.
- **Variables:** task and repeat number; no model comparison.
- **Outcomes:** verified class, failure IDs, runtime, retries, tokens/cost, human
  interventions, final-state diff, prohibited actions.
- **Controls:** frozen system configuration; blind disposable fixtures; external
  read-only grader; no network or gold access.
- **Runs:** at least three per validated pilot for debugging only. Do not infer a
  stable rate or rank.
- **Randomization:** random run order; record any model stochastic parameters and
  seeds when supported.
- **Success:** reconstructable runs with no containment breach and enough
  variance/failure evidence to specify the next sample plan.
- **Falsification:** telemetry loss, gold exposure, unresolved task defect, or
  containment failure invalidates affected runs.
- **Cost:** moderate; model usage plus engineering.
- **Stop:** six valid trials are captured, or a validity/containment defect blocks
  continuation.

## NX-003 — Adversarial gold-separation audit

Seed disguised filenames, semantic answer fragments, metadata, symlink/path edge
cases, and grader-like content into source fixtures. Compare the current
exporter/detector with an independently specified manifest allowlist. Success
requires only explicitly public files and no planted secret reaching exports.
Any leak falsifies general “blind” status and triggers repair before NX-002.

## NX-004 — Independent code/automation replication

After NX-002, instantiate one naturally occurring code task not descended from
ET-004/014. Use a separate author, fail-to-pass plus pass-to-pass checks, at least
six unseen mutations, and the same review/run protocol. This tests transfer and
breaks the documentation-task lineage.

## NX-005 — Audit/no-audit counterfactual

Across a later varied task sample, freeze initial contracts and record the
capability decision they would produce, then apply independent audit and measure
which decisions/statuses change. Preserve both versions. This is the first
experiment capable of estimating whether mandatory audit prevents material false
conclusions rather than merely improving documents.
