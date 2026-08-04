# Next Mission: Independent Pilot Review and Frozen-Grader Challenge

## Mission

Determine whether ET-004-P01 and ET-014-P01 are fair evaluation tasks and whether
their frozen deterministic graders generalize beyond the seven co-designed
calibration probes. This is non-human computational research. Do not recruit,
observe, profile, or test human participants; independent reviewers are research
auditors, not study subjects, and only their task judgments required by the
existing protocol may be recorded.

## Read first

1. `CURRENT-STATE.md`
2. `research/packages/RP-2026-07-30-NHE-COMPARATIVE-REVIEW.md`
3. `research/analysis/non-human-experiment-matrix.json`
4. `research/evaluation/13-independent-review-protocol.md`
5. `research/evaluation/08-decision-framework.md`
6. `research/evaluation/fixtures/et-004-p01/task.json`
7. `research/evaluation/fixtures/et-014-p01/task.json`

## Governing uncertainty

The current 7/7 result uses outcomes, labels, and grader logic created in one
research lineage. It may be a valid regression check or a circular estimate of
grader quality. Independent task review and unseen outcomes must distinguish
these explanations.

## Hypotheses

- **H1:** After bounded revisions, two independent reviewers find each task valid,
  and the frozen grader agrees with blinded consensus on materially distinct
  unseen outcomes.
- **H2:** At least one task is invalid/quarantined or the frozen grader produces a
  material false acceptance/rejection on unseen outcomes.

## Controls and comparison conditions

- Freeze and record repository commit, task hashes, grader hash, Python version,
  and configuration before generating unseen outcomes.
- Preserve the existing seven probes as regression controls.
- Obtain two independent reviews per task in the exact protocol order. Reviewers
  must not have designed the tasks, probes, or grader.
- Have an outcome author without grader-code access create at least six unseen
  outcomes per task, balanced across intended complete/defective and
  incomplete/regressive/persuasive-wrong classes. Include diverse paraphrases and
  near-boundary cases.
- Shuffle opaque outcome IDs. Reviewers label independently before seeing
  designer labels or grader output.
- Run the frozen grader only after labels are sealed.
- Preserve every output, including invalid, ambiguous, null, and failed cases.

## Measurements

Record task-validity labels, reviewer conflicts, per-outcome labels and evidence,
grader classifications, a confusion table, false acceptance/rejection cases,
runtime, hashes, revisions, exclusions, and exclusion reasons. Do not collapse
task defects, grader errors, and capability into one score. Do not estimate agent
capability; no agent run is part of this mission.

## Falsification and decision rules

H1 is falsified for a task if either independent reviewer identifies an
unresolved decision-material defect, if adjudication quarantines it, or if the
frozen grader has an unexplained material false acceptance. A semantic false
rejection requires revision or explicit human-adjudication routing before
promotion.

Promote a task only when the existing protocol’s criteria pass, known probes
remain green, and all material unseen disagreements are resolved or explicitly
retained. Never average away a validity defect.

## Required outputs

- Immutable reviews under `research/evaluation/reviews/`.
- Versioned unseen outcomes and sealed labels outside agent-readable fixtures.
- Machine-readable grader results and hashes.
- Adjudication record.
- Updated evidence, hypothesis, and experiment registries.
- New immutable cycle report and appended journal entry.
- Updated `CURRENT-STATE.md`, `ROADMAP.md`, and `CHANGELOG.md`.
- Exact validation output and a handoff stating which tasks may proceed to a
  contained baseline.

## Stop conditions

Stop when each pilot is validated, revised and rechecked, or quarantined, and the
frozen-grader unseen challenge has a recorded disposition. If two genuinely
independent reviewers are unavailable, record the blocker and stop; do not
simulate independence or proceed to capability baselines.

Run the repository’s documented validation commands before and after changes.
Do not silently repair historical records.
