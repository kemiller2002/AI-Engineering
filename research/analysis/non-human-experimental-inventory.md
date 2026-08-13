---
identifier: RP-2026-07-30-NHE-INVENTORY
title: Non-Human Experimental Inventory
version: 1.0.0
status: complete
confidence: high-for-corpus-coverage
---

# Non-Human Experimental Inventory

## Scope and search method

This inventory covers repository evidence through commit `aff6ec9` and the
pre-change validation run on 2026-07-30. It includes computational experiments,
designed probes, preflights, failed or blocked tests, and design studies. It
excludes cited external studies as repository experiments, human-subject
proposals, ordinary repository validation not framed as research, and candidate
tasks that were never instantiated.

The corpus was located by reading governance and the REP specification, searching
all Markdown, JSON, Python, Git history, registries, cycles, journals, fixtures,
outputs, and validation logs for experiment/test/run/probe language, and then
checking the implemented evaluator against the records. Missing means not
recorded; it does not mean zero.

## Master inventory

| ID | What was actually done | Type | Executed? | Unit/sample | Raw data | Reconstruction | Capability evidence? |
|---|---|---|---:|---|---|---|---:|
| EX-E001 | Repository artifacts and history were mapped to 16 candidate task families and eight constructs | Design/observational mapping | Yes | One repository snapshot; no trials | Narrative registry/cycle record | Substantial; search protocol and item-level coding are not preserved | No |
| EX-E002 | ET-004-P01 contract and four authored outcome probes were designer-audited | Task-integrity pilot | Yes | 1 task, 4 probes | Versioned fixture files | Complete for supplied artifacts | No |
| EX-E003 | ET-014-P01 contract and three authored outcome probes were designer-audited | Task-defect pilot | Yes | 1 task, 3 probes | Versioned fixture files | Complete for supplied artifacts | No |
| EX-E004 | One deterministic evaluator classified the seven probes against predeclared labels | In-sample grader calibration | Yes | 7 dependent authored probes, one execution recorded | Inputs, expected labels, code; console result reproducible | Complete except environment snapshot and immutable raw run record | No |
| EX-E005 | Repeated contained agent baseline | Stochastic capability baseline | No; blocked | Planned ≥3 runs per valid pilot | None | Protocol only | No |
| EX-E006 | Compare contamination conditions (Git/web/gold access) | Controlled comparison | No; planned | Not specified | None | Question only; design incomplete | No |
| EX-E007 | Export each pilot into an agent-readable directory and scan exported filenames for gold/probe/grader indicators | Preflight/security check | Yes | 2 exports; narrow detector | Exporter code and recorded summary; disposable exports not retained | Substantial; output file hashes and raw export report are absent | No |

## Reconstruction fields

| Field | EX-E001 | EX-E002 | EX-E003 | EX-E004 | EX-E007 |
|---|---|---|---|---|---|
| Research question | Recorded | Recorded | Recorded | Recorded | Recorded |
| Hypothesis | Linked, not one-to-one | HY-E002/HY-E006 | HY-E002/HY-E004/HY-E006 | HY-E003 | HY-E006/HY-E009 |
| Subject | Repository corpus | ET-004 contract/probes | ET-014 contract/probes | Evaluator + 7 probes | Exporter + 2 fixtures |
| Date | 2026-07-23 | 2026-07-28 | 2026-07-28 | 2026-07-28, reproduced 2026-07-30 | 2026-07-28 |
| Executing agent/model/provider | Missing | Missing | Missing | No model invoked; researcher identity missing | No model invoked; researcher identity missing |
| Intervention/comparison | Candidate family coding | Outcome class variations | Defect diagnosis variations | Expected versus actual class | Source versus exported contents |
| Baseline/control | None | Base fixture | Task materials | Predeclared labels | Source fixture contents |
| Controlled variables | Not documented | Fixture and grader | Fixture and grader | Code/fixtures versioned; environment partly missing | Export code/fixture versioned |
| Software/repository version | Git `0205032` for inspection | Commit not recorded in experiment | Commit not recorded in experiment | Commit not recorded; reconstructed by Git history | Commit not recorded |
| Seed/randomization | Not applicable | None; probes purposive | None; probes purposive | None; deterministic | None; deterministic |
| Trials/runs | One mapping exercise | 4 authored cases | 3 authored cases | One recorded aggregate run; exact rerun succeeds | 2 exports |
| Evaluation | Researcher categorization | Designer integrity audit | Designer integrity audit | Exact class equality | Filename substring detector |
| Statistics | None | Counts only | Counts only | 7/7 overall, 4/4 accepted, 3/3 rejected | 2/2 export; 0 flags |
| Confidence claim | Design cycle medium | Provisional | Provisional | High only for probes | High only for current exporter |
| Key limitation | No coding representativeness | Same designer authored task/probes/grader | Same designer; semantic space narrow | Complete circularity risk; no unseen cases | Detector ignores many content/semantic leakage routes |
| Reproducibility | Partial | High locally | High locally | High locally | High locally if a new directory is supplied |

## Stated–implemented–measured–claimed mismatches

| Mismatch | Affected IDs | Finding |
|---|---|---|
| “Independent review” appears in pilot independent variables but no reviewer participated | EX-E002, EX-E003 | The implemented activity is designer review plus probe construction, not an independent-review experiment |
| “Blind” describes export content, not a blinded evaluator or trial | EX-E007 | The check detects certain filenames only; no agent received the exports and no adversarial leakage test occurred |
| Seven matches can resemble seven replications | EX-E002–EX-E004 | They are seven purposive cases reused by one calibration run, not independent replications |
| Contract validity can resemble task validity | EX-E002–EX-E004 | Required JSON fields and known probe separation do not establish fairness, representativeness, or unseen grading validity |
| Design changes are used as support for audit value | EX-E002, EX-E003 | This is credible process evidence that audit found issues, but not a controlled estimate of prevented false conclusions |
| Registry status “completed” can resemble empirical completion | EX-E001 | EX-E001 is a design/observational mapping exercise, not a controlled experiment |

## Exclusions and discovery limits

- ET-001–ET-016 are task families, not 16 experiments.
- Repository integrity validator tests are software tests, not part of the
  historical evaluation research question.
- External papers EV-E001–EV-E013 inform hypotheses but are not executions in
  this repository.
- Course notes and handbook assertions contain no reconstructable trials.
- No raw model outputs, reasoning traces, agent runs, stochastic seeds, cost
  logs, intervention logs, or independent ratings were located.

Coverage confidence is high for versioned artifacts and lower for uncommitted or
discarded work that left no durable record. Git history is short and commit
messages are coarse, so silent failed attempts cannot be ruled out.
