# NEXT AGENT: START HERE

## Current State

Cycles 001–003 created the evaluation foundation, two pilot contracts, calibrated deterministic probes, and blind fixture export. **No agent capability experiment has been run. Do not quote performance numbers.**

## Your Single Next Objective

Obtain independent integrity reviews for ET-004-P01 and ET-014-P01, then run the first contained exploratory baseline if the reviews pass.

## Read in This Order

1. `research/evaluation/00-charter.md`
2. `research/evaluation/12-research-and-engineering-roadmap.md`
3. `research/evaluation/cycles/2026-07-28-cycle-003.md`
4. `research/evaluation/08-decision-framework.md`
5. `research/evaluation/10-threat-model.md`
6. `research/evaluation/02-evaluation-specification.md`
7. `research/evaluation/09-research-journal.md`
8. `research/evaluation/13-independent-review-protocol.md`

## Required Work

1. Give two reviewers the task contracts, visible materials, probe outcomes, and integrity questionnaire.
2. Capture their labels independently before adjudication.
3. Revise, validate, or quarantine each pilot.
4. Export blind fixtures with:

   `python3 tools/evaluation/evalctl.py prepare --output <new-disposable-directory>`

5. Run each valid pilot at least three times using one frozen agent configuration.
6. Capture the full metadata specified in `02-evaluation-specification.md`.
7. Use results to estimate variance and repair the suite; do not rank models.

## Do Not

- treat candidate tasks as validated;
- run broad model comparisons or expose probe outcomes to the agent;
- collapse safety and task defects into one score;
- overwrite the Cycle 001 journal;
- infer coding-agent capability from this documentation-heavy repository.

## Stop Condition

Stop the next cycle after independent review plus either (a) a contained exploratory baseline or (b) a documented reason the baseline remains blocked.

## Files to Update

- `03-evidence-registry.md`
- `04-hypothesis-registry.md`
- `05-experiment-registry.md`
- `06-failure-taxonomy.md` if new failures appear
- append a new entry to `09-research-journal.md`
- a new immutable file under `cycles/`
- this handoff
- repository `CURRENT-STATE.md`, `ROADMAP.md`, and `CHANGELOG.md`

## Current Blocker

Independent review cannot be honestly simulated by the task author. If reviewers are unavailable, record that limitation and do not promote the pilots beyond provisional status.
