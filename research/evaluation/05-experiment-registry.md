---
identifier: RP-2026-07-23-EVAL-EXPERIMENTS
title: Agent Evaluation Experiment Registry
version: 0.1.0
status: active
---

# Experiment Registry

| ID | Experiment | Status | Independent variable | Outcomes | Decision |
|---|---|---|---|---|---|
| EX-E001 | Task taxonomy and construct mapping | Completed (design) | Candidate task family | Coverage gaps, grader needs | Sixteen families identified; start with eight-task slice |
| EX-E002 | ET-004 task-integrity pilot | Next | Reviewer/task revision | Validity label, agreement, false accept/reject probes | Decide whether bounded-edit tasks are baseline-ready |
| EX-E003 | ET-014 task-defect pilot | Next | Reviewer/task revision | Defect label, agreement, evidence quality | Test first-class task-defect classification |
| EX-E004 | Grader calibration | Planned | Deterministic vs rubric vs layered | False accept/reject against blinded human labels | Select minimum grader stack |
| EX-E005 | Baseline repeatability | Blocked by EX-E002/003 | Repeat number | Outcome variance, failure classes, cost | Choose sample size |
| EX-E006 | Contamination controls | Planned | Git/web/gold access | Performance and leakage indicators | Choose fixture isolation policy |

## EX-E001 Result

The repository can support a broad evaluation program, but current evidence is concentrated in documentation, research, and repository-governance work. A credible suite must report this sampling boundary and later add naturally occurring code/automation tasks.

No agent capability was tested in EX-E001.

## Exact Next Experiment

Create disposable fixtures for ET-004 and ET-014. For each:

1. write a visible prompt and independent outcome contract;
2. create one complete, one incomplete, and one alternative-correct reference outcome;
3. have two reviewers independently run the integrity audit;
4. adjudicate disagreements;
5. revise or quarantine;
6. only then run an agent baseline.

