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
| EX-E002 | ET-004 task-integrity pilot | Provisionally complete | Reviewer/task revision | Validity label, alternative/partial/regressive probes | Contract calibrated; independent review required |
| EX-E003 | ET-014 task-defect pilot | Provisionally complete | Reviewer/task revision | Defect label, alternative/persuasive-wrong probes | Contract calibrated; independent review required |
| EX-E004 | Deterministic probe calibration | Completed in-sample | Probe outcome class | Classification match | 7/7 declared classifications matched; no generalization claim |
| EX-E005 | Baseline repeatability | Blocked by EX-E002/003 | Repeat number | Outcome variance, failure classes, cost | Choose sample size |
| EX-E006 | Contamination controls | Planned | Git/web/gold access | Performance and leakage indicators | Choose fixture isolation policy |
| EX-E007 | Blind fixture export preflight | Completed | Source vs exported fixture | Gold/probe exposure | Current pilots export without expected outcomes or grader code |

## EX-E001 Result

The repository can support a broad evaluation program, but current evidence is concentrated in documentation, research, and repository-governance work. A credible suite must report this sampling boundary and later add naturally occurring code/automation tasks.

No agent capability was tested in EX-E001.

## EX-E002–E004 Results

- Both task contracts contain all required metadata.
- ET-004-P01 accepts two semantically equivalent complete edits and rejects one omitted status change plus one collateral regression.
- ET-014-P01 accepts two defensible defect codes when evidence identifies the same contradiction and rejects a polished but invalid acceptance.
- Calibration matched all seven declared outcome classes.
- Neither pilot is independently reviewed; status is provisional rather than validated.
- No model, agent, harness, stochastic run, token cost, or human-time baseline was measured.

## Exact Next Experiment

After independent integrity review, execute EX-E005:

1. export blind disposable fixtures without probe outcomes or expected labels;
2. freeze the complete system configuration;
3. run each pilot at least three times for exploratory variance;
4. preserve final state, runtime, interventions, and failures;
5. do not rank systems;
6. use variance and failures to choose the next sample size and grader revision.
