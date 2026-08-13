---
identifier: RP-2026-07-30-NHE-COMPARATIVE-REVIEW
title: Non-Human Experimental Evidence Comparative Review
research_area: AI research systems
discipline: experimental methods and agent evaluation
author_agent: Codex
version: 1.0.0
confidence: medium-high
completion: complete
priority: critical
related_projects: [AI-ROS agent evaluation]
related_documents:
  - research/analysis/non-human-experimental-inventory.md
  - research/analysis/non-human-experimental-comparative-analysis.md
supersedes: []
superseded_by: []
tags: [experiments, evidence, evaluation, non-human]
keywords: [lineage, calibration, task validity, grader validity]
---

# Non-Human Experimental Evidence Comparative Review

## Research State Snapshot

- **Theory version:** No canonical theory records exist.
- **Knowledge base version:** Repository at `aff6ec9`, reviewed 2026-07-30.
- **Highest confidence:** supplied-probe evaluator behavior and current fixture
  export behavior.
- **Lowest confidence:** task validity, grader generalization, capability,
  repeatability, transfer, and verified-outcome cost.
- **Largest remaining unknown:** whether independent reviewers validate the two
  pilots and a frozen grader survives unseen outcomes.
- **Active streams:** Cycle 004 independent review; RFR-001–RFR-003.
- **Recently invalidated ideas:** 7/7 calibration is not seven replications;
  “blind export” is not a general contamination result.
- **Priority changes:** independent review is paired with an unseen frozen-grader
  challenge before an agent baseline.

## Executive Summary

Seven experiment IDs were located. Four describe executed empirical or preflight
activities (EX-E002, E003, E004, E007), one is a completed design study
(EX-E001), and two are unexecuted (EX-E005, E006). The executed evidence consists
of two designer-built task pilots, seven purposive outcomes classified by a
co-designed deterministic grader, and two fixture exports checked by a narrow
filename predicate.

The evidence supports local reproducibility and useful preflight tooling. It
supports no agent capability claim and contains no independent scientific
replication. The highest-value next mission is independent task review combined
with frozen-grader evaluation on unseen, blinded outcomes.

## Original Objective

Reconstruct, normalize, compare, challenge, and synthesize all discoverable
non-human experimental evidence in the repository, then design the next
decision-relevant research program.

## Scope

Included repository computational/design experiments, probes, preflights,
negative results, scripts, fixtures, registries, cycles, journals, and Git
provenance. Excluded human-subject research, uninstantiated candidate tasks,
external papers as local experiments, and ordinary tests without a research
claim.

## Repository Context

Markdown is canonical. The Constitution prioritizes epistemic correctness,
traceability, contradictory evidence, and negative results. The evaluation
program explicitly warns that Cycles 002–003 calibrated tasks/graders rather
than agents. Pre-change validation passed.

## Current Understanding

The research system has advanced from design prose to executable preflight
artifacts, but the empirical frontier remains before the first independently
validated, contained agent observation. Counts in the current results are
mechanical agreement counts over dependent, authored cases.

## Key Discoveries

1. Effective independent replications: zero.
2. Agent trials: zero.
3. EX-E004 is a dependent replay of EX-E002/003 evidence, not replication.
4. EX-E007 checks known exported filenames, not general leakage.
5. HY-E003 is not tested: no layered-grader comparison occurred.
6. Missing negative experiments are documented well, but lack raw artifacts.
7. Status terms can overstate validity when separated from scope warnings.

## Evidence Registry

| Evidence | Observation | Reliability | Limits |
|---|---|---|---|
| NHE-EV-001 | Registry/corpus contains EX-E001–007 only | High for versioned corpus | Discarded/unversioned work unknowable |
| NHE-EV-002 | Current `evalctl.py all` reproduces 7/7 classes | High for exact cases | Co-designed, in-sample |
| NHE-EV-003 | Exporter prepares two fixtures without predicate flags | High for predicate | Narrow filename/content coverage |
| NHE-EV-004 | No agent run, independent review, unseen case, or cost log found | High for repository | Off-repository activity cannot be excluded |

## Hypothesis Registry

| Hypothesis | Assessment | Reason |
|---|---|---|
| HY-E002 audit prevents false conclusions | Suggestive | Designs changed; no counterfactual consequence |
| HY-E003 layered graders reduce false accepts | Unresolved/unsupported locally | Only deterministic grader tested |
| HY-E004 task defects common | Unresolved locally | Planted defect cannot estimate prevalence |
| HY-E006 controls reduce contamination | Weak narrow support | Known file omission only |
| HY-E007 three repeats aid debugging | Untested | No stochastic runs |
| HY-E008 repository underrepresents coding | Strong for snapshot | Inventory and history are documentation-heavy |

## Failed Assumptions

- Registered experiment IDs imply independent evidence.
- A correct known-case ratio estimates general accuracy.
- Blind export and blinded evaluation are equivalent.
- Contract completeness equals task validity.
- A planted task defect estimates defect prevalence.

## Open Questions

- Do two independent reviewers accept each pilot?
- What false-accept and false-reject modes appear on unseen outcomes?
- Does gold separation survive adversarial inspection?
- What variance and operational failures appear in contained agent runs?
- Does the method transfer to a separately authored code task?

## Recommended Next Research

Execute NX-001 in
`research/analysis/non-human-next-experiments.md`: two independent task reviews,
then a frozen grader against balanced unseen outcomes labeled under blinding.
Only tasks that pass proceed to the contained repeated baseline.

## Research Backlog

1. NX-001 independent review + unseen grader challenge.
2. NX-002 contained repeated baseline.
3. NX-003 adversarial gold-separation audit.
4. NX-004 independent code-task replication.
5. NX-005 audit/no-audit counterfactual.

## Suggested Specialized Research Agents

- Independent task-integrity reviewers with no pilot-design involvement.
- A mutation/outcome author without grader access.
- A containment and leakage auditor independent of the exporter author.

These roles require independence; the original task author must not simulate
them.

## Parallel Research Opportunities

NX-003 may run while reviewers perform NX-001. Run-schema implementation may
proceed as bounded infrastructure, but no model matrix or architecture expansion
is justified.

## Risks

Reviewer independence may be nominal; unseen outcomes may remain narrow; model
or harness changes may obsolete early baselines; semantic adjudication may
introduce drift; documentation tasks may not transfer.

## Cross-Discipline Opportunities

Software mutation testing can strengthen negative cases; measurement theory can
separate constructs from proxies; causal inference can shape the audit
counterfactual; security testing can challenge gold isolation.

## Knowledge Relationships

EX-E001 selects EX-E002/003; those pilots supply all EX-E004 data and both
EX-E007 fixtures; EX-E002/003/007 gate EX-E005. The lineage is recorded in
`research/analysis/non-human-experimental-lineage.md`.

## Theory Impact Assessment

- **Affected theories:** no formal TH records exist.
- **Affected principles:** task/grader/agent validity separation strengthened.
- **New candidate:** known-case calibration is regression evidence until blinded
  unseen cases succeed.
- **Deprecated candidate:** document/ID counts as evidence counts.
- **Confidence changes:** HY-E002 downgraded; HY-E003 and E007 remain unresolved;
  HY-E008 strengthened for the snapshot.
- **Prediction created:** at least one frozen grader will require revision after
  diverse unseen semantic cases.
- **Prediction invalidated:** none empirically; reviewer-disagreement prediction
  remains untested.
- **Required registry update:** apply assessments during Cycle 004 while
  preserving historical cycle text.

## Research Quality Metrics

- Repository experimental records reviewed: 7/7.
- Executed empirical/preflight records: 4.
- Design-only records: 1.
- Planned/blocked records: 2.
- Raw-artifact-complete executed records: 3; EX-E007 raw exports/report incomplete.
- Independent experimental replications: 0.
- Counterinterpretations tested: at least one for each of five major conclusions.
- Formal quantitative pooling: rejected as invalid.
- Research completeness: complete for the versioned historical corpus; empirical
  program incomplete.
- Confidence gain: high on what the evidence does not establish; modest on
  intervention effectiveness.

## Research Debt

Missing independent labels, unseen cases, run metadata, environment snapshots,
costs, seeds/configuration, agent outputs, retained export manifests/hashes,
cross-task replication, and an audit counterfactual.

## Repository Updates

Added the inventory, JSON matrix, comparative analysis, lineage, contradiction
registry, failure taxonomy, cumulative findings, backlog, this REP, next-mission
prompt, and repository decision record. Updated current state, roadmap, and
changelog.

## Website Updates

None. No generated website is canonical or required for this mission.

## AI Consumption Notes

Read the JSON matrix for structured fields, then the inventory and comparative
analysis. Never treat `7/7` as a capability score or the two tasks as validated.
Use exact EX/NX identifiers and preserve “missing” rather than converting it to
zero.

## Handoff Instructions

1. Read `research/evaluation/13-independent-review-protocol.md`.
2. Execute the prompt at
   `prompts/Non-Human-Experimental-Research-Next-Mission.md`.
3. Preserve two reviews before adjudication.
4. Freeze task/grader hashes before unseen outcomes.
5. Update registries and create a new immutable cycle record.
6. Do not run agents on a quarantined task.

## Research Journal

### JR-2026-07-30-NHE-001

Read governance, REP rules, state, roadmaps, registries, cycles, journal,
fixtures, scripts, results, Git history, and all repository experiment
references. Reproduced baseline validation. Classified experimental status,
reconstructed implemented designs, mapped dependency, refused invalid
meta-analysis, challenged five conclusions, and prioritized NX-001.

### Negative journal entry

No hidden model runs, raw external reviews, costs, or additional experiment
packages were found. Independent review cannot be manufactured within this
review.

## Appendix

Primary artifacts:

- `research/analysis/non-human-experimental-inventory.md`
- `research/analysis/non-human-experiment-matrix.json`
- `research/analysis/non-human-experimental-comparative-analysis.md`
- `research/analysis/non-human-experimental-lineage.md`
- `research/analysis/non-human-experimental-contradictions.md`
- `research/analysis/non-human-experimental-failure-modes.md`
- `research/analysis/non-human-cumulative-findings.md`
- `research/analysis/non-human-next-experiments.md`

## Completion Checklist

- [x] Discoverable experiments inventoried and reconstructed.
- [x] Stated/implemented/measured/claimed distinctions recorded.
- [x] Lineage, independence, and replication evaluated.
- [x] Comparable items compared; incompatible metrics separated.
- [x] Descriptive quantitative synthesis completed; invalid pooling rejected.
- [x] Failure modes, contradictions, negative results, and confidence reassessed.
- [x] Cumulative findings and theory impacts recorded.
- [x] Falsifiable next experiments ranked.
- [x] Executable next mission written.
- [x] Repository state artifacts updated.
- [x] Validation rerun after changes.
