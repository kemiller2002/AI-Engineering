# Evaluation Research Journal

This file is append-only. Correct prior entries with a new dated entry rather than rewriting history.

## JR-2026-07-23-E001 — Cycle 001

### Objective

Identify what must exist before an AI-ROS agent baseline can support credible capability conclusions.

### Actions

- Rehydrated from the mission, current state, REP specification, research relay, and state-of-field REP.
- Inspected repository history and artifact types for candidate tasks.
- Reviewed current work on benchmark defects, agent grader stacks, repository prompt sensitivity, search-time contamination, state-based evaluation, and generated held-out cases.
- Defined constructs, outcome classes, task audit rules, task families, hypotheses, experiments, and failure labels.

### Observations

- The repository has enough variety for evaluation of research and repository-governance work, but not for broad coding-agent claims.
- Repository history is a source of realistic tasks and a source of leakage/hidden context.
- Deterministic final-state checks are strong when semantics are formalized, but can be overly strict or incomplete.
- Human and model review can detect ambiguity but also introduce judgment variance.
- Unanimous system failure should trigger task/evaluator audit, not an automatic “hard task” label.

### Interpretation Changes

- Reduced confidence that “repository-native” is itself a quality criterion.
- Narrowed the role of trajectory grading to constructs that genuinely require process evidence.
- Reclassified three repeats as exploratory rather than sufficient for stable comparisons.
- Added task defect and infrastructure failure as outcomes outside capability scoring.

### Negative Results

- No independent reviewer was available in this cycle.
- No task instance, executable grader, agent baseline, cost measurement, or inter-rater result was produced.
- Repository evidence could not support a representative production coding suite.

### Decision

Run task-integrity pilots before agent capability baselines.

### Next Entry Trigger

Append the next entry only after ET-004 and ET-014 are instantiated and independently reviewed, revised, or quarantined.

## JR-2026-07-28-E002 — Cycles 002 and 003

### Objective

Build the two specified pilot tasks, calibrate a minimum deterministic grader, audit the roadmap, and stop when further progress requires external evidence.

### Actions

- Created ET-004-P01 and ET-014-P01 fixtures and task contracts.
- Created complete, alternative-correct, incomplete-polished, regressive, and task-defect probes.
- Implemented a dependency-free evaluator and blind fixture exporter.
- Ran contract validation, seven probe calibrations, and two blind exports.
- Added current protocol-validity, evaluation-security, long-horizon monitoring, and verified-outcome economics evidence.
- Created the decision framework, threat model, system architecture, plain-language guide, and roadmap v2.

### Observations

- Both pilots needed design changes before baseline, supporting task audit as a valuable gate.
- A minimal deterministic grader is sufficient for the known state-observable probes.
- ET-014 requires semantic/human adjudication for novel defect explanations.
- Gold separation can be implemented cheaply at this scale.
- Security containment is a parallel prerequisite, not a later serial phase.
- The current repository still cannot support broad coding-agent conclusions.
- Git tracked three case-only root path pairs that collapsed on the current filesystem; canonical uppercase paths were retained after identical-blob and provenance checks.

### Negative Results

- No independent reviewers participated.
- No model/harness baseline, stochastic variance, human review time, tokens, cost, or transfer evidence exists.
- Prose-only and trajectory graders were not run; doing so without blinded labels would add machinery without decision-grade evidence.

### Hypothesis Changes

- HY-E002 strengthened.
- HY-E003 received limited in-sample support only.
- HY-E006 and HY-E009 strengthened.
- HY-E005 remains unresolved.
- HY-E007 remains unresolved.

### Decision

Freeze further architecture work until independent review or agent-run evidence is available. The next cycle is empirical, not another design expansion.

### Exact Next Action

Obtain two independent pilot reviews. Resolve or record disagreements. Then run contained exploratory baselines using blind fixtures and capture complete run metadata.
