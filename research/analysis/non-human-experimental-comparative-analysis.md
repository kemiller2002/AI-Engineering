---
identifier: RP-2026-07-30-NHE-COMPARATIVE
title: Comparative Analysis of Non-Human Experimental Evidence
version: 1.0.0
status: complete
confidence: medium-high
---

# Comparative Analysis of Non-Human Experimental Evidence

## Executive finding

The repository establishes that its current deterministic evaluator can
reproduce designer-declared classifications for seven supplied probes and that
its exporter can omit known outcome/grader files under a narrow check. It does
not establish task validity, grader generalization, agent capability,
repeatability, transfer, safety under agent execution, or cost effectiveness.

The body of evidence is internally consistent once design studies, pilot
construction, calibration, and capability experiments are separated. Most
apparent contradictions are scope or measurement mismatches rather than
opposing experimental results.

## Normalization strategy

| Metric | Construct | Scale/direction | Reliability | Comparable? | Decision |
|---|---|---|---|---|---|
| Contract validity | Presence of declared fields/probes | Binary; pass better | High for schema presence | Across two pilots only | Preserve 2/2; do not call task validity |
| Classification match | Agreement with designer label | Count/proportion; high better | High mechanically, low external validity | Same grader run only | Preserve 7/7; no interval/effect estimate |
| Accepted intended cases | Known positive-case separation | Count | Same caveat | Across pilots descriptively | Preserve 4/4 |
| Rejected intended cases | Known negative-case separation | Count | Same caveat | Across pilots descriptively | Preserve 3/3 |
| Export detector flag | Known filename exposure | Count; low better | High for implemented predicate | Same exporter only | Preserve 0/2 flags; not “zero leakage” |

No transformation was applied. Formal pooling, confidence intervals, regression,
Bayesian updating, and meta-analysis are unjustified because cases were
purposively constructed, share an author and evaluator, and are not sampled from
a defined population.

## Experiment quality matrix

Ratings are explicit ordinal judgments: strong, moderate, weak, absent, or not
applicable. They are not a composite score.

| Experiment | Hypothesis clarity | Controls | Sample adequacy | Metric validity | Raw data | Reproducibility | Independence | Overall strength |
|---|---|---|---|---|---|---|---|---|
| EX-E001 | Moderate | Absent | Weak | Moderate for coverage design | Weak | Partial | Weak | Weak design evidence |
| EX-E002 | Moderate | Base fixture | Weak | Moderate for known state cases | Strong | Strong local | Absent | Moderate preflight, weak validity evidence |
| EX-E003 | Moderate | Fixed task materials | Weak | Moderate for known contradiction | Strong | Strong local | Absent | Moderate preflight, weak validity evidence |
| EX-E004 | Strong | Predeclared labels | Inadequate for generalization | Strong for exact label match; weak for semantic validity | Strong | Strong local | Absent | Strong regression check, weak scientific inference |
| EX-E005 | Strong | Planned, incomplete | Not executed | Not measured | Absent | Absent | Not applicable | No evidence |
| EX-E006 | Weak | Proposed conditions | Not specified | Not measured | Absent | Absent | Not applicable | No evidence |
| EX-E007 | Strong | Source/export comparison | Adequate only for two current fixtures | Strong for filename predicate; weak for leakage construct | Moderate | Strong local | Weak | Moderate narrow preflight |

## Comparability matrix

| Experiment A | Experiment B | Comparable dimensions | Incompatible dimensions | Shared dependencies | Comparison validity |
|---|---|---|---|---|---|
| EX-E002 | EX-E003 | Contract completeness, alternative/incomplete probe pattern | Different task constructs and grader logic | Researcher, workflow, evaluator file | Moderate for process comparison only |
| EX-E002 | EX-E004 | ET-004 probe labels and classifications | Pilot design versus aggregate calibration | Same four probes/labels | High for traceability; invalid as replication |
| EX-E003 | EX-E004 | ET-014 probe labels and classifications | Pilot design versus aggregate calibration | Same three probes/labels | High for traceability; invalid as replication |
| EX-E002 | EX-E007 | Fixture handling | Task semantics versus file exposure | ET-004 fixture | Narrow extension, not result replication |
| EX-E003 | EX-E007 | Fixture handling | Task semantics versus file exposure | ET-014 fixture | Narrow extension, not result replication |
| EX-E004 | EX-E007 | Deterministic tooling, same repository era | Classification versus isolation outcomes | Researcher, codebase, fixtures | Incomparable outcomes |
| EX-E004 | EX-E005 | Intended grader use | Known probes versus stochastic agent outputs | Planned grader/task reuse | No comparison until EX-E005 runs |

## Experiment-family and pairwise synthesis

### Task-integrity pilots: EX-E002 and EX-E003

Both pilots show that constructing positive alternatives and negative cases
exposes design risks before an agent run. ET-004 revealed literal semantic and
collateral-change concerns; ET-014 revealed taxonomy strictness. The stable
pattern is useful as workflow evidence. It is not an effect estimate because
both tasks were selected and revised by the same researcher and there was no
unaudited control condition.

ET-004 measures bounded state editing. ET-014 measures detection of a planted,
explicit contradiction. Their shared acceptance/rejection counts should not be
interpreted as equal difficulty or pooled task success.

### Calibration family: EX-E002–EX-E004

EX-E004 is a deterministic replay over the artifacts produced by EX-E002 and
EX-E003. It adds implementation evidence: the code matches the intended labels.
It does not add an independent sample. The strongest supported conclusion is
software-regression-level: the current code separates the current cases.

### Isolation family: EX-E002/003–EX-E007

EX-E007 demonstrates a useful physical-export mechanism. Its predicate searches
exported filenames for `outcome`, `expected-calibration`, or `grader`. It does
not inspect semantic equivalence, hidden metadata, alternate names, symlinks, or
whether the visible task itself leaks the answer. Therefore “known files omitted”
is supported; “contamination controlled” remains suggestive.

## Longitudinal and cross-project analysis

The sequence from Cycle 001 to Cycle 003 improves artifact executability:
design-only taxonomy → versioned pilots → executable known-case calibration and
export. Because the intervention, artifacts, and measurements changed at each
step, this is maturation of the research system, not a longitudinal performance
improvement.

No cross-project experiment was conducted. External benchmark studies informed
the design but used different tasks, models, evaluators, datasets, and units.
They cannot be pooled with AI-ROS observations. Transfer remains untested.

## Quantitative synthesis

Direct observations:

- 2/2 pilot JSON contracts contain required fields and required outcome folders.
- 7/7 authored probe labels match evaluator output.
- 4/4 intended positive probes are accepted.
- 3/3 intended negative probes are rejected/classified.
- 2/2 current fixtures export.
- 0/2 exports trigger the narrow filename detector.
- 0 agent trials, 0 independent reviews, 0 unseen grader cases, and 0 cost
  observations exist.

The zeroes in the second group are absence-of-evidence counts, not measured null
effects. No statistical significance or effect size is claimed.

## Qualitative synthesis

Recurring risks are researcher circularity, gold co-location, literal semantic
grading, construct–metric mismatch, incomplete run provenance, and ambiguous
status language. The repository performs well at documenting negative results
and scope warnings. Its main research-system weakness is that narrative caveats
are more mature than empirical sampling.

## Confidence reassessment and findings matrix

| Finding | Supporting experiments | Contradicting experiments | Boundary conditions | Revised confidence |
|---|---|---|---|---|
| Current evaluator reproduces current labels | EX-E004 and exact 2026-07-30 rerun | None | Seven supplied, unchanged probes only | Established within tested conditions |
| Positive and negative probe construction can expose task/grader design issues | EX-E002, EX-E003 | No control | Two purposively selected documentation tasks | Moderately supported as process evidence |
| Current exporter omits known gold/probe/grader filenames | EX-E007 | None | Two current fixtures, narrow name predicate | Established within tested conditions |
| Mandatory integrity audit prevents material false capability conclusions | EX-E002, EX-E003 | None, but no counterfactual | Same designer; prevented consequence not observed | Suggestive, downgraded from medium-high |
| Layered graders reduce false acceptance | None directly; EX-E004 is deterministic only | EX-E004 shows extra layers unnecessary for known probes | State-observable authored cases | Unsupported/unresolved |
| Controlled fixtures reduce contamination without construct loss | EX-E007 narrowly | No agent trial | Known-file separation only | Weakly supported |
| Current repository underrepresents production coding | EX-E001 repository mapping | None | Snapshot at `0205032` | Strongly supported for this snapshot |
| Any agent can complete either pilot | None | None | No runs | Unresolved |
| Three repeats suffice for debugging but not ranking | Methodological judgment only | None | No observed variance | Suggestive, untested |

## Adversarial review of the five main conclusions

1. **Known-case calibration works.** Alternative: the apparent success is
   tautological because the grader and labels co-evolved. This does not overturn
   the software-regression conclusion, but blocks external-validity inference.
2. **Probe design found useful defects.** Alternative: ordinary implementation
   iteration, not a formal audit, caused the changes. Preferred conclusion is
   narrowed to process utility, not causal effectiveness.
3. **Export omits known sensitive files.** Alternative: gold remains inferable
   from visible content or disguised names. This is credible; the claim is
   limited to exact exported files and predicate.
4. **No capability conclusion is available.** Alternative: authored outcomes
   might proxy model behavior. They do not originate from a model or sampled
   process, so this conclusion survives strongly.
5. **Independent review is the next gate.** Alternative: unseen mutation cases
   could be automated first. That would improve grader evidence, but cannot
   supply independent task-validity judgment; reviews remain the gating evidence
   for promotion, while automated mutations are a parallel high-value test.

Repeated review did not change the ordering: independent review plus frozen,
unseen calibration is more decision-relevant than additional architecture.

## Research-gap matrix

| Gap | Affected conclusion | Risk | Experiment needed | Priority |
|---|---|---|---|---|
| Independent task labels absent | Pilot validity | Capability scores could be meaningless | Blinded dual review | Critical |
| Unseen outcomes absent | Grader generalization | Circular 7/7 result | Frozen-grader mutation/agent outputs | Critical |
| Contained run/telemetry absent | Capability, safety, cost | No operational evidence | Repeated contained baseline | Critical after reviews |
| Leakage audit narrow | Contamination control | Inflated results | Adversarial export audit | High |
| No task diversity | Transfer | Overgeneralization | Add independent code/automation task | High after baseline |
| No variance/sample rationale | Repeatability | Unstable comparisons | Exploratory repeats then power/sensitivity plan | High |
| No immutable run records | Reproducibility | Results cannot be reconstructed | Run-schema implementation | High |
| No audit counterfactual | Audit causal value | Governance cost may not pay off | Compare audit/no-audit decisions across tasks | Medium |
