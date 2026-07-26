---
identifier: RP-2026-07-23-EVAL-SPEC
title: AI-ROS Agent Evaluation Specification
version: 0.1.0
status: experimental
---

# Evaluation Specification

## Constructs

The suite measures separate constructs; it does not assume one latent “agent quality” score.

| Construct | Operational definition | Evidence |
|---|---|---|
| Completeness | All explicit and reasonably inferable requirements satisfied | Final-state checks + rubric |
| Correctness | Result matches task semantics, not only a reference implementation | Independent outcome checks |
| Regression avoidance | Pre-existing valid behavior and unrelated state remain intact | Pass-to-pass checks + diff |
| Safety | No prohibited action, boundary violation, or secret exposure | State/trace checks |
| Traceability | Material claims and changes link to inspectable evidence | Provenance checks |
| Recoverability | Work can resume after interruption without private context | Continuation test |
| Efficiency | Resources used per verified successful outcome | Runtime, tokens/cost, retries, review minutes |
| Calibration | Agent confidence and escalation correspond to actual uncertainty | Outcome vs confidence/escalation |

## Outcome Classes

- **Complete:** all hard requirements pass; no regression or prohibited action.
- **Partial:** useful progress, but at least one material requirement fails.
- **Regressive:** requested result appears present but valid existing behavior/state is damaged.
- **Unsafe:** any prohibited action or material boundary violation occurs.
- **Persuasive-but-wrong:** report claims completion while observable state fails.
- **Task defect:** prompt, fixture, or grader prevents a fair capability inference.
- **Infrastructure failure:** harness/environment failure independent of task attempt.

Unsafe and task-defect outcomes must never be hidden inside an aggregate score.

## Task Integrity Audit

Before baseline use, two reviewers should independently answer:

1. Is the requested outcome observable?
2. Does the prompt contain every requirement enforced by graders, or is the remainder reasonably inferable from visible repository conventions?
3. Do graders accept multiple semantically correct implementations?
4. Do tests cover every material requirement?
5. Can incomplete work pass?
6. Can correct work fail due to formatting or reference-patch mimicry?
7. Is relevant hidden context required?
8. Is the initial state reproducible?
9. Is contamination likely through current files, Git history, or web access?
10. Does the task measure a project-relevant capability?

Disagreement triggers adjudication. Tasks are **validated**, **revised**, or **quarantined**—never silently retained.

## Grader Stack

Use the smallest stack that covers the task’s failure surface:

1. deterministic final-state checks;
2. pass-to-pass regression checks;
3. provenance/reference checks;
4. trajectory checks only for safety, permissions, or diagnostic questions;
5. blinded human review for semantic completeness and task audit;
6. model grading only after calibration against human-labeled cases.

This ordering challenges HY-D: trajectory grading is not presumed useful for every task. Outcome evidence should remain primary unless the process itself is the construct.

## Run Protocol

- Freeze fixture and grader versions.
- Record the complete system configuration.
- Start from a clean, disposable worktree or fixture copy.
- Prevent access to gold answers unless the experiment studies contamination.
- Run at least three independent trials per stochastic configuration for exploratory results; increase based on observed variance before comparative claims.
- Preserve final diff/state, grader outputs, interventions, errors, and resource measures.
- Audit unanimous failures for possible task or evaluator defects.
- Report per-task results before aggregates.

## Comparison Rules

- Change one major variable at a time when making causal claims.
- Use paired tasks and identical fixtures for system comparisons.
- Report confidence intervals or raw trial counts; avoid decorative precision.
- Do not infer production ROI from pass rate without review cost and failure consequence.
- Treat task families—not individual prompts—as the intended generalization target.

## Minimum Metadata

`run_id`, `task_id`, `fixture_hash`, `date`, `model`, `model_snapshot`, `harness`, `harness_version`, `instructions_hash`, `context_policy`, `tools`, `permissions`, `network_policy`, `seed_or_repeat`, `start_time`, `end_time`, `tokens`, `cost`, `human_interventions`, `human_review_minutes`, `outcome_class`, `grader_versions`, `failure_ids`, `notes`.

## Decision Thresholds for Cycle 002

The two pilot tasks are ready for baseline only if:

- both reviewers classify them as valid or revisions resolve disagreements;
- every hard requirement maps to at least one observable check;
- at least one intentionally incomplete solution fails;
- at least one alternative correct solution passes;
- fixture recreation produces identical hashes.

