# Research Mission: Long-Horizon Agent Evaluation and Verification

## Mission Metadata

- **Identifier:** RM-2026-07-23-001
- **Status:** Ready to execute
- **Priority:** Critical
- **Estimated research time:** 2–4 weeks of bounded research cycles
- **Primary discipline:** AI evaluation engineering
- **Required disciplines:** software testing, measurement science, security engineering, human factors, economics, knowledge management
- **Related REP:** `research/AI-State-of-the-Field-REP.md`

## Objective

Design, implement, and validate a reproducible evaluation and verification framework that determines whether long-horizon AI agents complete AI-ROS repository tasks correctly, safely, economically, and with adequate evidence traceability.

Do not optimize a model leaderboard. Determine which measurements and verification methods predict useful real repository outcomes.

## Background

AI-ROS has strong hypotheses about externalized state, verification over trust, controlled delegation, context engineering, research relays, and durable artifacts. It does not yet have empirical evidence showing which agent architectures, context policies, or review methods work.

Current evidence shows that:

- public coding benchmarks can contain substantial broken-task rates;
- agent capability depends on the model, harness, tools, context, and environment;
- long-horizon performance remains unreliable;
- selective context may outperform full-history retention;
- growing autonomy raises the cost of weak permissions and poor auditability.

Read before acting:

1. `AGENTS.md`
2. `CURRENT-STATE.md`
3. `docs/governance/000-engineering-constitution.md`
4. `ai-prompts/Research-Execution-Package-Specification-v2.md`
5. `content/disciplines/ai-engineering/research-program.md`
6. `content/disciplines/ai-engineering/research-relay-system.md`
7. all four `research/AI-*.md` artifacts dated 2026-07-23

## Known Information

- Final prose quality is not sufficient evidence of task completion.
- Environment state and regressions must be inspected.
- Evaluation tasks themselves can be invalid.
- Human review is expensive and must be measured.
- Repeated runs are needed for probabilistic systems.
- The full agent system, not just the model, is the unit under evaluation.

## Unknown Information

- Which metrics best predict acceptable repository outcomes?
- How many and what kinds of tasks form a useful minimum suite?
- Which graders agree with expert review?
- What run count provides decision-useful confidence?
- How should correctness, safety, cost, latency, regressions, and human intervention be combined?
- Which trace fields are necessary for diagnosis?
- How frequently do task defects reverse conclusions?
- Do model or architecture rankings change when evaluated by verified outcome rather than pass rate?

## Research Questions

1. What representative task taxonomy covers AI-ROS work?
2. What makes each task valid, unambiguous, reproducible, and resistant to gaming?
3. Which combination of deterministic checks, state inspection, rubrics, provenance checks, trace grading, and human review is reliable?
4. How should partial completion and persuasive-but-wrong output be scored?
5. What failure taxonomy is stable across task types?
6. What is the cost per verified successful outcome?
7. What permission and safety violations must be treated as hard failures?
8. How much evaluator disagreement is acceptable?
9. What evidence would falsify the repository’s candidate engineering principles?

## Required Competing Hypotheses

- **HY-A:** public benchmark rank predicts AI-ROS task performance.
- **HY-B:** repository-native executable evaluation changes at least one system ranking.
- **HY-C:** final-state deterministic checks are sufficient.
- **HY-D:** combined final-state, trajectory, provenance, and human-escalation checks provide material additional signal.
- **HY-E:** more context monotonically improves task reliability.
- **HY-F:** structured artifact state or selective context improves reliability-adjusted cost.

Add competing hypotheses when evidence warrants it. State falsification conditions before running experiments.

## Evidence Requirements

- Prefer executable repository evidence and primary sources.
- Record model and harness versions, prompt/instructions, tools, permissions, context policy, environment, timestamps, run duration, token/cost data, retries, and human interventions.
- Preserve complete raw outcomes and failure traces without placing secrets in the repository.
- Use at least three independent runs per stochastic configuration where feasible.
- Separate task defects from agent failures.
- Independently audit a meaningful sample of tasks and grader decisions.
- Search for examples that contradict the leading conclusion.

## Required Experiment Program

### Experiment 1 — Task-suite construction

Select 12–20 tasks across:

- repository navigation and question answering;
- evidence-backed research synthesis;
- bounded content editing;
- cross-file state maintenance;
- reference/path validation;
- code or automation changes;
- adversarial or conflicting instructions.

Each task must define initial state, allowed actions, expected observable state, regression checks, prohibited outcomes, ambiguity review, and grading logic.

### Experiment 2 — Baseline repeatability

Run a common agent configuration repeatedly. Quantify success variance, failure modes, reviewer agreement, latency, cost, and intervention.

### Experiment 3 — Grader comparison

Compare deterministic tests, repository-state inspection, structured rubric, provenance verification, trace grading, and expert review. Measure false acceptance and false rejection.

### Experiment 4 — Benchmark integrity audit

Use independent review to identify underspecification, overly strict checks, weak coverage, leakage, or misleading instructions. Repair or remove invalid tasks and report whether conclusions change.

### Experiment 5 — System comparison

Compare at least two meaningful system configurations, such as model tier, harness, context policy, or checkpoint strategy. Change one major variable at a time where possible.

### Experiment 6 — Adversarial verification

Include persuasive-but-incomplete output, hidden regressions, stale state, contradictory sources, prompt injection in tool content, excessive permissions, and fabricated provenance.

## Required Metrics

- complete success rate;
- partial success rate;
- regression rate;
- prohibited-action rate;
- unsupported-claim/provenance failure rate;
- task-defect rate;
- evaluator false-accept and false-reject rates;
- inter-rater agreement;
- retries and recovery rate;
- human intervention count and minutes;
- latency;
- tokens and monetary cost where available;
- cost per verified successful outcome.

Do not collapse all results into one score unless the weights and loss function are explicitly justified. Safety violations must remain visible.

## Success Criteria

The mission succeeds when:

1. another agent can reproduce the suite from repository instructions;
2. task validity has been independently audited;
3. the framework distinguishes complete, partial, regressive, unsafe, and persuasive-but-wrong outcomes;
4. evaluator agreement and error are measured;
5. at least two system configurations have repeatable baselines;
6. cost per verified outcome and human effort are reported;
7. at least one candidate AI-ROS principle is supported, weakened, or falsified by evidence;
8. a clear decision framework states which evaluation methods to use for which task/risk class.

## Expected Deliverables

- `research/evaluation/00-charter.md`
- `research/evaluation/01-task-suite-manifest.md`
- `research/evaluation/02-evaluation-specification.md`
- `research/evaluation/03-evidence-registry.md`
- `research/evaluation/04-hypothesis-registry.md`
- `research/evaluation/05-experiment-registry.md`
- `research/evaluation/06-failure-taxonomy.md`
- `research/evaluation/07-results.md`
- `research/evaluation/08-decision-framework.md`
- `research/evaluation/RP-long-horizon-agent-evaluation.md`
- executable evaluation assets under `tools/evaluation/`

Use stable identifiers from the canonical REP specification. Add only infrastructure demonstrated necessary by the experiments.

## Recommended Iteration Strategy

Work in bounded relay cycles:

1. rehydrate from current state and latest experiment;
2. select the uncertainty with the greatest decision impact;
3. state hypotheses and reversal conditions;
4. run the smallest discriminating experiment;
5. perform a skeptical review;
6. preserve failures and task defects;
7. update registries and current state;
8. choose the next uncertainty.

Stop when another iteration is unlikely to change an engineering decision, not merely when a report exists.

## Dependencies

- access to repository history and testable tasks;
- at least one runnable agent harness;
- ability to capture outputs and environment diffs;
- human review for a sampled audit;
- explicit permission boundaries for adversarial cases.

If paid APIs, external writes, credentials, or actions outside the repository are required, stop and obtain authorization.

## REP Output Requirements

The final REP must satisfy every mandatory section in `ai-prompts/Research-Execution-Package-Specification-v2.md`, including theory impact, evidence traceability, research debt, quality metrics, handoff instructions, and completion checklist.

Update `CURRENT-STATE.md`, `ROADMAP.md`, and `CHANGELOG.md` when repository state materially changes. Record structural decisions under `docs/repository/`. Validate every referenced path and command result before claiming completion.

## Final Challenge

Before concluding, ask:

- Did the suite measure real value or merely what was easy to grade?
- Could a persuasive agent game the graders?
- Did task defects get mislabeled as agent failures?
- Would rankings survive a different harness, model, or reviewer?
- Did cost accounting include retries and human attention?
- Which evidence would reverse the final decision?
