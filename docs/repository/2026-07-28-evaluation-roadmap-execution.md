# Evaluation Roadmap Execution Decision

## Date

2026-07-28

## Decision

Execute the next two evaluation research cycles, adopt the minimum local evaluation architecture, and revise the roadmap so containment is a parallel prerequisite rather than a later serial phase.

## Why

The pilot work demonstrated that task and grader design changes decisions before agent execution. Current external evidence also shows that evaluation protocols can expose shortcuts and, in high-risk settings, real infrastructure. Therefore AI-ROS must validate tasks, isolate gold data, and contain runs before producing capability claims.

## Changes

- Created ET-004-P01 and ET-014-P01 pilot fixtures and probe outcomes.
- Implemented `tools/evaluation/evalctl.py`.
- Added blind fixture export.
- Added results, decision framework, threat model, architecture, roadmap, guide, cycle reports, and handoff.
- Updated canonical state, roadmap, and changelog.

## Validation

```bash
python3 tools/evaluation/evalctl.py all
python3 tools/evaluation/evalctl.py prepare --output <new-disposable-directory>
git diff --check
```

At execution time, both task contracts validated, seven declared classifications matched, and two blind fixtures exported without detected gold/probe files.

## Limits

- no independent human review;
- no AI agent baseline;
- no stochastic variance, token/cost, or human-time data;
- no evidence of grader generalization to unseen outcomes.

## Reversal Conditions

Replace the architecture if independent review or repeated runs show that the local file-based approach cannot preserve isolation, reproducibility, traceability, or decision usefulness.

## Diminishing-Returns Decision

Stop adding architecture after this cycle. The next decision-changing evidence must come from independent review, isolated agent runs, or unseen outcomes.

## Suggested Commit Message

`build agent evaluation research foundation`
