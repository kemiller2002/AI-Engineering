# NEXT AGENT: START HERE

## Current State

Cycle 001 designed the evaluation foundation. **No agent capability experiment has been run. Do not quote performance numbers.**

## Your Single Next Objective

Execute the task-integrity pilots `EX-E002` and `EX-E003` for task families `ET-004` and `ET-014`.

## Read in This Order

1. `research/evaluation/00-charter.md`
2. `research/evaluation/cycles/2026-07-23-cycle-001.md`
3. `research/evaluation/02-evaluation-specification.md`
4. `research/evaluation/01-task-suite-manifest.md`
5. `research/evaluation/04-hypothesis-registry.md`
6. `research/evaluation/05-experiment-registry.md`
7. `research/evaluation/09-research-journal.md`

## Required Work

For each pilot, create a disposable fixture, visible prompt, outcome contract, complete outcome, incomplete-but-polished outcome, and alternative-correct outcome. Obtain two independent integrity reviews if possible; otherwise record the lack of independence as a blocker to validation.

Test these predictions:

- at least one pilot requires revision;
- prose-only grading falsely accepts an incomplete polished outcome;
- reviewers disagree more on task-defect classification than bounded editing.

## Do Not

- treat candidate tasks as validated;
- run broad model comparisons;
- collapse safety and task defects into one score;
- overwrite the Cycle 001 journal;
- infer coding-agent capability from this documentation-heavy repository.

## Stop Condition

Stop Cycle 002 after both pilots are validated, revised, or quarantined and the result is recorded—even if no agent baseline is yet justified.

## Files to Update

- `03-evidence-registry.md`
- `04-hypothesis-registry.md`
- `05-experiment-registry.md`
- `06-failure-taxonomy.md` if new failures appear
- append a new entry to `09-research-journal.md`
- a new immutable file under `cycles/`
- this handoff
- repository `CURRENT-STATE.md`, `ROADMAP.md`, and `CHANGELOG.md`
