---
identifier: RP-2026-07-28-EVAL-RESULTS
title: AI-ROS Evaluation Results
version: 0.2.0
status: active
---

# Evaluation Results

## Scope Warning

These are **task-contract and grader-calibration results**, not agent capability results. No AI agent was evaluated.

## Cycle 002 — Task Integrity

| Pilot | Contract complete | Complete probe | Alternative-correct probe | Incomplete probe | Regression/defect probe | Disposition |
|---|---:|---:|---:|---:|---:|---|
| ET-004-P01 | Yes | Accepted | Accepted | Rejected as partial | Rejected as regressive | Provisional; independent review pending |
| ET-014-P01 | Yes | Accepted as task defect | Accepted as task defect | Rejected as persuasive-but-wrong | N/A | Provisional; independent review pending |

Design review exposed two problems before baseline:

1. storing outcomes near fixtures creates severe contamination risk unless blind fixtures are exported;
2. exact-reference prose grading would reject semantically valid alternatives, so the pilot grader accepts a narrow semantic family and keeps human adjudication for novel language.

## Cycle 003 — Deterministic Grader Calibration

Command:

```bash
python3 tools/evaluation/evalctl.py all
```

Observed on 2026-07-28:

- task contracts valid: 2/2;
- declared probe classifications matched: 7/7;
- complete alternatives accepted: 4/4;
- incomplete, regressive, or persuasive-wrong probes rejected/classified: 3/3.
- blind task exports prepared without detected gold/probe files: 2/2.

## What This Supports

- Executable state checks can distinguish several important outcome classes on deliberately constructed examples (EV-E014).
- Alternative-correct probes are practical guards against overly strict reference-patch grading.
- Incomplete and regressive probes are practical guards against low-coverage grading.

## What This Does Not Support

- that the graders generalize to unseen outputs;
- that independent humans agree with the labels;
- that model-based or trajectory graders add value;
- that any agent can complete the tasks;
- that three runs will be enough;
- that this documentation-heavy suite predicts coding-agent performance.

## Failed/Unexecuted Tests

- Independent double review: unavailable.
- Blinded human adjudication: unavailable.
- Prose-only grader false-accept test: not implemented because an uncalibrated prose grader would not provide decision-grade evidence.
- Repeated agent baseline: deliberately blocked until independent review and blind fixture export.

## Reproduction

The evaluator uses the Python standard library. A passing `all` command verifies contract presence and exact calibration against versioned expected labels. Fixture hashes are printed by `validate`.
