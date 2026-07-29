---
identifier: RP-2026-07-23-EVAL-HYPOTHESES
title: Agent Evaluation Hypothesis Registry
version: 0.1.0
status: active
---

# Hypothesis Registry

| ID | Hypothesis | Status | Prior confidence | Evidence | Falsification / reversal condition |
|---|---|---|---:|---|---|
| HY-E001 | A repository-native suite has higher decision relevance than public leaderboard scores for AI-ROS | Active | Medium | EV-E008 | Public scores consistently predict paired AI-ROS outcomes and native tasks add no decision-changing signal |
| HY-E002 | A mandatory task-integrity audit prevents material false capability conclusions | Leading | Medium-high | EV-E001, EV-E002, EV-E004, EV-E009 | Audit labels do not predict grader errors or ranking changes across a sufficiently varied suite |
| HY-E003 | Layered graders reduce false acceptance versus deterministic final-state checks alone | Active | Medium | EV-E003, EV-E006, EV-E007 | Calibrated deterministic checks match expert labels and extra graders add only noise/cost |
| HY-E004 | Task defects are common enough to require a first-class outcome category | Active | Medium | EV-E001 | Pilot and expanded audits find negligible defects with tight uncertainty bounds |
| HY-E005 | Trajectory grading adds value mainly for safety and diagnosis, not routine correctness | New competing hypothesis | Low-medium | EV-E003 plus construct analysis | Trajectory evidence materially improves correctness classification after outcome checks across task classes |
| HY-E006 | Controlled fixtures and restricted access reduce contamination without destroying realism | Active | Medium | EV-E002, EV-E004, EV-E005, EV-E007 | Restriction causes large construct loss or contamination remains unchanged |
| HY-E007 | Three repeats are sufficient for early exploratory task debugging, not stable system ranking | Active | Medium | Statistical caution; no AI-ROS evidence | Observed variance is negligible across tasks or three-run conclusions replicate under larger samples |
| HY-E008 | The current documentation-heavy repository underrepresents production coding-agent work | Leading | High | EV-E008 | Task inventory or future history provides balanced, representative coding workloads |
| HY-E009 | Evaluation containment must be implemented before adversarial or long-horizon baselines | Leading | High | EV-E011, EV-E012 | Equally representative unconstrained runs show no additional risk and containment adds prohibitive construct distortion |
| HY-E010 | Predeployment evaluation must be paired with runtime monitoring, pause, and rollback | Active | Medium-high | EV-E012 | Fixed suites reliably predict material deployment failures across representative changes |
| HY-E011 | Cost per verified successful outcome is more decision-relevant than token cost | Active | Medium-high | EV-E013 | Token cost alone predicts total economic value across representative tasks |

## Assumptions Under Challenge

1. **Native equals valid:** rejected as a default assumption; retained only as a relevance hypothesis.
2. **More graders equals better:** challenged by HY-E005; unnecessary graders can add correlated error and cost.
3. **Three runs are enough:** restricted to task debugging until variance is observed.
4. **A single score aids decisions:** rejected for now because safety, task defects, and cost encode different losses.
5. **Historical tasks are gold-standard tasks:** challenged because human issue context and reference patches may not define implementation-independent requirements.

## Predictions for Cycle 002

- At least one of the first two candidate tasks will need revision after independent integrity review.
- An intentionally incomplete but polished response will pass a prose-only rubric and fail an outcome/state check.
- ET-014 will reveal lower reviewer agreement than ET-004 because task-defect classification requires judgment.

## Cycle 002–003 Updates

- The prediction that at least one pilot would need revision was **partly supported**: both initial designs required explicit contamination isolation and broader alternative-correct acceptance before provisional use.
- The prose-only false-accept prediction remains **untested**; no calibrated prose-only grader was run.
- The reviewer-disagreement prediction remains **untested** because no independent reviewers participated.
- HY-E003 gained limited support from EV-E014: deterministic checks separated supplied complete, partial, regressive, task-defect, and persuasive-but-wrong probes. This does not show that adding model or trajectory graders improves results.
