---
id: RFA-2026-001
title: Repository Research Frontier
status: active
as_of: 2026-07-28
confidence: medium-high
---

# Repository Research Frontier

## Boundary of knowledge

AI-ROS has a coherent evaluation theory, candidate task taxonomy, two provisional pilot contracts, seven correctly classified designer probes, blind fixture export, and an explicit containment architecture. It does **not** yet have independently validated tasks, agent capability observations, variance estimates, external-validity evidence, or comparative evidence. The current boundary is therefore measurement readiness, not agent performance.

## Method and scope

This analysis reviewed the active and completed research program, evaluation artifacts, cycle records, repository state, roadmap, architecture, threat model, and canonical knowledge-platform documents. Draft fixtures were treated as experimental materials rather than accepted findings. Archived and superseded sources were excluded. Opportunities were traced to named sections; semantically overlapping candidates were merged. Scores use 1–5 ratings:

`Frontier score = knowledge gain × impact × reuse × scientific importance − dependency cost − implementation difficulty`

Scores are prioritization aids, not measurements. Effort and feasibility were challenged against the independent-review blocker, documentation-heavy sampling, and containment requirements.

## Stabilized ranking

| Rank | Record | Opportunity | KG | Impact | Reuse | Science | Dependency | Difficulty | Score |
|---:|---|---|---:|---:|---:|---:|---:|---:|---:|
| 1 | RFR-001 | Independent pilot integrity review | 5 | 5 | 5 | 5 | 1 | 2 | 622 |
| 2 | RFR-002 | Contained repeated exploratory baseline | 5 | 5 | 5 | 5 | 2 | 3 | 620 |
| 3 | RFR-003 | Grader external-validity study | 5 | 5 | 5 | 5 | 3 | 3 | 619 |
| 4 | RFR-004 | Representative repository task corpus | 5 | 5 | 5 | 5 | 4 | 5 | 616 |
| 5 | RFR-005 | Context-policy causal comparison | 4 | 5 | 5 | 4 | 5 | 4 | 391 |
| 6 | RFR-006 | Total verified-cost measurement | 4 | 5 | 5 | 4 | 5 | 5 | 390 |
| 7 | RFR-007 | Risk-triggered human escalation study | 4 | 5 | 4 | 4 | 5 | 4 | 311 |
| 8 | RFR-008 | Evaluation containment validation | 4 | 5 | 5 | 4 | 3 | 4 | 393 |
| 9 | RFR-009 | Stable identifiers and reference integrity | 3 | 4 | 5 | 3 | 1 | 2 | 177 |
| 10 | RFR-010 | Knowledge-graph value experiment | 3 | 3 | 5 | 3 | 6 | 4 | 125 |

Ties and near-ties are resolved by prerequisite value: RFR-001 precedes RFR-002, which produces observations needed by RFR-003. RFR-004 is more costly but required before broad claims. RFR-008 shares RFR-005's numeric score but follows it in the research ranking because RFR-008 is also mandatory parallel engineering work.

## Critical unknowns

1. Do independent experts agree that ET-004-P01 and ET-014-P01 measure their declared constructs and label the probes correctly?
2. What run-to-run variance and failure modes appear under one frozen, contained configuration?
3. Do deterministic probes agree with blinded expert judgments on naturally produced outcomes?
4. How representative is a documentation-heavy repository of production repository work?
5. Which context policy maximizes verified useful outcomes per total cost?
6. Which containment controls reduce consequential risk without unacceptable construct distortion?

## Contradictions

| Importance | Tension | Resolution path |
|---|---|---|
| Critical | Repository-native tasks are more decision-relevant, yet native tasks may inherit hidden context, leakage, narrow graders, and unrepresentative work. | RFR-001, RFR-003, RFR-004 |
| Critical | Layered grading is recommended, but added graders may add cost and noise; current deterministic checks only passed in-sample probes. | RFR-003 |
| High | Longer autonomy promises throughput while long-horizon evidence demands monitoring, pause, rollback, and human control. | RFR-007, RFR-008 |
| High | Context can improve capability, while accumulation can reduce performance and raise cost. | RFR-005 |
| Medium | A knowledge graph is architecturally attractive, but its maintenance value is unmeasured. | RFR-010 |

No accepted artifacts contain mutually exclusive empirical conclusions. Most conflicts are unresolved competing hypotheses, appropriately preserved as such.

## Confidence decay

- The 2026 state-of-field evidence is recent; no age-based downgrade is warranted.
- Confidence in benchmark-transfer claims remains medium because sources are benchmark- and vendor-specific.
- Confidence in Cycle 003 remains high **only for supplied probes** and decays sharply if generalized to natural agent outcomes.
- Architecture and roadmap confidence is provisional until operational evidence tests the contracts and controls.
- Revalidate all baselines after material model, harness, task, grader, or toolchain changes.

## Neglected disciplines

Statistics is underrepresented in power analysis, uncertainty intervals, and ranking stability. Human factors lacks measured reviewer burden and intervention timing. Economics lacks observed all-in cost. Security has a threat model but no control-effectiveness data. Accessibility and industrial/interaction design have not shaped task construction. Software maintenance research is needed for representative task sampling.

## Dependency path

`RFR-001 → RFR-002 → RFR-003 → RFR-004 → {RFR-005, RFR-006, RFR-007}`

`RFR-008 → RFR-002` and `RFR-009 → RFR-004 → RFR-010`.

The machine-readable graph is in `frontier-graph.json`.

## Executive recommendations

- **Fund one REP:** RFR-001 plus the immediately dependent RFR-002 as one bounded Cycle 004 REP. Review alone removes a blocker; the baseline supplies the first capability observations.
- **Most uncertainty reduced:** RFR-003, once natural outcomes exist, because it tests whether the measurement system agrees with independent judgment.
- **Largest unlock:** RFR-004; a representative corpus enables context, routing, orchestration, economics, and security comparisons.
- **Highest ROI now:** RFR-001. It is low effort, decision-critical, and prevents invalid pilots from consuming baseline resources.
- **Highest risk/highest reward:** RFR-010. A useful knowledge graph could compound repository learning, but premature implementation could create costly ontology debt.
- **Begin immediately:** Recruit truly independent reviewers under the existing protocol. Do not simulate independence.

## Self-critique

This pass is repository-internal and therefore cannot provide the independence it recommends. Artifact counting is sensitive to what qualifies as a research artifact; metrics state their denominator. Frontier scores multiply subjective ordinal ratings and must not be interpreted as interval measurements. Five opportunities per analyzed document can reward duplication, so document candidates were deduplicated into ten repository records. The analysis favors the active evaluation mission because it contains the strongest traceable evidence; this may underweight course, mobile, and knowledge-platform needs that have less empirical documentation.
