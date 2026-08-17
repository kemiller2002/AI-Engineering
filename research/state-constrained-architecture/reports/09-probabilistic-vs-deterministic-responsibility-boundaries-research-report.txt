# AI Research Mission 09 — Probabilistic vs Deterministic Responsibility Boundaries

## Central question

**Can AI-operated software safely assign probabilistic models the work they are good at—interpretation, inference, search, planning, recommendation—while keeping consequential authority, legality, and commitment in a small deterministic layer, and does that improve correctness and economics enough to justify the additional structure?**

---

# 1. Executive verdict

The proposed principle:

> **Exploration may be probabilistic. Commitment should be constrained.**

is **strongly defensible**, with one important correction:

> **Constraint strength should attach to the consequence and control requirements of an action, not merely to whether the action is called a “commitment.”**

Existing research provides unusually strong analogues for this architecture.

Across:

- reference monitors,
- safety kernels,
- runtime assurance,
- shielded reinforcement learning,
- constrained optimization,
- access control,
- transaction validation,
- policy enforcement,
- clinical decision support,
- high-assurance autonomous systems,

a recurring design pattern appears:

```text
complex / adaptive / probabilistic component
        ↓ proposes
small trusted component
        ↓ checks admissibility
controlled execution
        ↓ commits
```

This does **not** prove that every consequential business action should be reduced to a binary deterministic rule.

In fact, the evidence warns strongly against that.

Three distinct responsibilities are needed:

## Probabilistic AI

Best suited for:

- interpretation,
- search,
- hypothesis generation,
- prediction,
- evidence extraction,
- anomaly detection,
- ranking,
- optimization,
- planning,
- recommendation,
- natural-language explanation.

## Deterministic runtime

Best suited for:

- authority,
- state ownership,
- hard invariants,
- declared legal transitions,
- capability derivation,
- version checks,
- evidence sufficiency rules,
- policy preconditions,
- idempotency,
- transaction boundaries,
- effect execution,
- protected resource access,
- mechanically verifiable postconditions.

## Human authority

Best suited for:

- ambiguous normative judgments,
- exceptional cases,
- policy creation and interpretation,
- high-consequence irreversible decisions where rules are insufficient,
- decisions involving values, equity, clinical judgment, or organizational discretion,
- correcting wrong deterministic specifications.

This produces a more precise principle:

> **Probabilistic systems may infer and propose. Deterministic systems should mediate commitments whose legality or safety can be mechanically specified. Humans should retain authority where consequential judgment cannot be reduced safely to a stable machine-checkable rule.**

The strongest existing architectural analogue is not the classical expert system.

It is the **runtime assurance/reference-monitor pattern**:

> treat the intelligent controller as powerful but untrusted at the commitment boundary.

The strongest current AI-specific evidence comes from runtime policy enforcement and safe-agent research. For example, recent work on temporal-policy enforcement for LLM agents reports that formal runtime constraints can raise action conformance to 100% in evaluated domains while preserving or improving task utility. This is not universal proof, but it demonstrates that deterministic action mediation can improve agent safety without necessarily destroying usefulness.

The major risks are equally clear.

### Over-determinization risk

A system can encode:
- ambiguous policy,
- changing business judgment,
- poorly calibrated thresholds,
- exceptions

into rigid rules and become consistently wrong.

### Under-constraining risk

A probabilistic model may:
- infer its own authority,
- silently reinterpret policy,
- mutate authoritative state directly,
- execute an irreversible effect from a mistaken belief.

The optimal architecture is therefore **hybrid**.

---

# 2. Exploration vs commitment

The initial distinction is useful, but it should be formalized.

## Exploration

An operation is exploratory when its result does not by itself alter protected authoritative reality.

Examples:

- search,
- read,
- summarize,
- hypothesize,
- simulate,
- rank,
- score,
- draft,
- recommend,
- propose a plan,
- generate candidate code,
- construct candidate policy.

Exploration may still have cost or privacy implications, so it is not automatically unrestricted.

But a wrong exploratory conclusion can normally be discarded without needing to repair authoritative state.

## Commitment

A commitment is an operation that creates or changes a durable authoritative relationship with external consequence.

Examples:

- mutate authoritative domain state,
- transfer money,
- delete data,
- grant/revoke access,
- deploy software,
- send legally meaningful communication,
- establish a verified claim,
- execute external effect,
- publish data,
- approve/deny regulated action.

The key property is not persistence alone.

The key property is:

> **The operation changes what other components, people, institutions, or external systems are entitled to rely upon.**

That is a stronger definition of commitment.

---

# 3. Why “commitment” is not enough

Some commitments are trivial:

```text
save draft preference
```

Some non-persistent operations are dangerous:

```text
open industrial valve for 10 seconds
```

Therefore boundary strength should depend on more than storage mutation.

Use a multidimensional risk model.

At minimum evaluate:

1. consequence,
2. reversibility,
3. recoverability,
4. observability,
5. authority sensitivity,
6. uncertainty,
7. externality,
8. regulatory/safety requirements.

This produces a **control profile**, not a fake numerical score.

---

# 4. Reversibility and consequence framework

## Reversibility classes

### R0 — trivially reversible

Example:
- reorder a UI list.

### R1 — cheaply reversible

Example:
- change internal label.

### R2 — compensatable

Example:
- erroneous small refund that can be balanced through an accounting correction.

### R3 — expensive to reverse

Example:
- deploy breaking schema migration.

### R4 — practically irreversible

Example:
- disclose private data,
- execute a physical safety-critical action,
- make certain external legal commitments.

As reversibility decreases, preventive controls become more valuable than post-hoc correction.

## Consequence classes

### C0 — negligible

### C1 — limited

### C2 — material

### C3 — severe

### C4 — catastrophic / safety-critical

These classes should be domain-defined rather than universal.

A $100 decision may be trivial to one organization and consequential to another.

---

# 5. Observability and recoverability

Two errors with equal consequence can require different controls.

## Highly observable

Example:

AI proposes a malformed UI label.

Failure is immediate.

## Poorly observable

Example:

AI incorrectly classifies one subset of customers as ineligible for refund.

The system may operate “successfully” for months while violating policy.

Low observability increases the value of prevention.

Similarly:

## Recoverable error

Can be:
- detected,
- reversed,
- compensated,
- audited.

## Nonrecoverable error

Damage persists even after detection.

A practical boundary rule is:

> **Prevent mechanically specifiable errors when they are high-consequence, hard to observe, or hard to recover from.**

---

# 6. Probabilistic vs deterministic responsibility map

| Responsibility | Best default owner | Reason |
|---|---|---|
| Interpret ambiguous human language | AI / human | inherently uncertain |
| Search repository/documents | AI | probabilistic retrieval useful |
| Extract candidate facts | AI + provenance | extraction uncertain |
| Predict risk | ML/AI | probabilistic by nature |
| Rank alternatives | AI/optimizer | soft preference |
| Generate hypotheses | AI/human | exploration |
| Plan among legal actions | AI | combinatorial/judgment |
| Select wording | AI/human | soft judgment |
| Define legal state transition set | deterministic spec + human policy | normative authority |
| Check transition legality | deterministic runtime | exact where modeled |
| Check permissions | deterministic runtime | security boundary |
| Derive capabilities | deterministic runtime | avoid inferred authority |
| Check evidence freshness | deterministic runtime | mechanical |
| Enforce monetary limit | deterministic runtime | hard invariant |
| Prevent duplicate external effect | deterministic runtime | exact transactional property |
| Validate version/concurrency | deterministic runtime | exact |
| Execute irreversible effect | trusted executor | commitment boundary |
| Interpret ambiguous policy | human + AI support | false precision risk |
| Change policy | authorized human/governance workflow | normative |
| Propose policy change | AI allowed | exploratory |
| Explain deterministic rejection | AI may translate | source reason remains deterministic |

---

# 7. Human-role map

The architecture should not collapse into:

```text
AI
vs
rules
```

The meaningful design is triangular.

## AI owns uncertainty processing

- infer,
- compare,
- search,
- recommend.

## Runtime owns enforceable authority

- allow,
- deny,
- validate,
- commit.

## Humans own unresolved normative authority

- decide policy gaps,
- approve exceptions,
- resolve ambiguity,
- revise policy,
- accept exceptional risk.

This prevents two mistakes:

1. treating AI judgment as authority,
2. pretending all human judgment can be converted to rules.

---

# 8. Prediction vs policy

This is one of the strongest conceptual separations.

## Prediction

Answers:

> What is likely?

Examples:

```text
fraud probability = 0.87
churn probability = 0.92
diagnostic likelihood = 0.65
```

## Policy

Answers:

> What should the organization do given that information?

Example:

```text
if:
    approved model version
    score >= policy threshold
    evidence age <= 30m
then:
    RequireFraudReview
```

Prediction is empirical/descriptive.

Policy is normative.

A model output should generally not silently define policy.

---

# 9. ML output as evidence rather than authority

A useful default is:

> **Treat model output as an assessment/evidence item consumed by policy, not as an intrinsic grant of authority.**

Example:

```text
RiskAssessment {
    score = 0.87
    model = FraudModel@19
    producedAt = T
    inputVersion = V
}
```

Then:

```text
FraudPolicy@12
    evaluates RiskAssessment
```

This preserves:
- calibration provenance,
- model version,
- policy version,
- freshness,
- auditability.

However, this pattern has an important limitation.

If the deterministic policy says:

```text
score >= 0.8 => deny
```

then a miscalibrated model can still create systematic harm.

The deterministic layer guarantees policy execution, not policy wisdom.

---

# 10. Deterministic threshold risk

Thresholds can look objective while encoding value judgments.

Examples:

- credit cutoff,
- fraud score,
- medical alert threshold,
- anomaly score.

Risks include:

- distribution shift,
- calibration drift,
- disparate impact,
- changing cost ratios,
- context dependence,
- cliff effects near the threshold.

Therefore thresholds should be:

- versioned,
- monitored,
- justified,
- testable,
- reviewable.

Gray zones may require:

```text
score < A
    normal flow

A <= score < B
    human review

score >= B
    strong restriction
```

This is often superior to one binary threshold.

---

# 11. Normative vs descriptive

AI systems are often strongest in descriptive tasks:

- detect patterns,
- estimate probabilities,
- summarize evidence.

Normative rules answer:

- permitted,
- required,
- prohibited,
- authorized.

Normative systems have long been studied through:
- deontic logic,
- policy systems,
- authorization systems.

But not every normative decision is mechanically decidable.

The correct principle is not:

> all normative rules must be deterministic.

It is:

> **Once an organization has declared a hard normative constraint precisely enough to enforce, probabilistic agents should not be allowed to override it implicitly.**

---

# 12. Hard rules vs soft rules

This is essential.

## Hard constraint

```text
Do not transfer more money than authorized amount.
```

Violation is unacceptable.

## Soft preference

```text
Prefer lower-cost supplier.
```

Tradeoffs may justify violation.

The architecture should represent these differently.

One useful formalization:

```text
maximize utility
subject to hard constraints
```

The agent optimizes within the feasible set.

This is directly analogous to constrained optimization and safe RL.

---

# 13. Constrained optimization framing

Let:

```text
A = possible actions
L(s) = legal actions in current state s
U(a, s) = utility/preference model
```

Then the model should solve:

```text
argmax U(a, s)
for a ∈ L(s)
```

The runtime computes or enforces `L(s)`.

The model chooses among those actions.

This cleanly separates:

**feasibility**

from:

**preference optimization**.

In real systems, `L(s)` may be:
- deterministic,
- policy-relative,
- versioned,
- uncertainty-dependent.

---

# 14. Safe RL and shielding

Shielded reinforcement learning is one of the strongest analogues.

The classic shielding pattern is:

```text
learner proposes action
        ↓
shield checks action against safety specification
        ↓
safe action allowed / unsafe action corrected or blocked
```

Alshiekh et al. demonstrated that formally synthesized shields can enforce temporal-logic safety requirements while allowing an RL learner to optimize within the permitted action space.

Later work has extended shielding to:
- probabilistic environments,
- multi-agent settings,
- verification-guided shielding,
- dynamic model-predictive shields,
- explainable shields.

This directly supports the conceptual separation:

> **optimization can remain adaptive while a distinct mechanism protects hard constraints.**

Transfer to LLM agents is not automatic, because:
- LLM action spaces are richer,
- tools have complex semantics,
- policies may be natural-language and incomplete,
- world state may be partially observed.

But the architecture pattern transfers strongly.

---

# 15. Recent LLM runtime enforcement

Current agent research is moving toward explicit runtime policy enforcement.

Recent systems explore:

- temporal action constraints,
- per-tool authorization,
- symbolic guardrails,
- policy-constrained execution,
- runtime governance.

Agent-C is especially relevant because it enforces temporal policies over LLM-agent actions. Its reported evaluation achieved complete conformance on its tested policy suite and improved utility over unrestricted or softer guardrail baselines for the evaluated models/domains.

This is strong evidence for one narrow claim:

> **Hard runtime constraints can outperform prompt-only safety instructions for enforceable action policies.**

It does not show:
- all business policy should be formalized,
- every policy is complete,
- the formal policy is correct.

---

# 16. Reference-monitor comparison

The classical reference-monitor concept has three famous properties:

1. complete mediation,
2. tamper resistance,
3. verifiability/simplicity.

This maps extremely well to AI action control.

## Complete mediation

Every protected consequential action must pass the gate.

An agent cannot:
- call database directly,
- use alternate API,
- mutate state through hidden path.

## Tamper resistance

Agent cannot:
- disable validator,
- rewrite policy,
- grant itself capability.

## Verifiability

Trusted enforcement should be small enough to inspect/test/formally verify where justified.

This suggests:

> **The semantic runtime should behave like a reference monitor for consequential domain actions.**

---

# 17. Safety kernel and runtime assurance

Safety-critical control research provides an even closer analogy.

Runtime Assurance and Simplex-style architectures allow:

- a complex, high-performance controller,

while preserving:

- a simpler trusted safety controller/monitor.

NASA research explicitly studies runtime assurance as a way to integrate AI/ML or otherwise difficult-to-verify controllers into safety-critical systems.

This suggests a useful AI architecture:

```text
Agent / model
    = complex untrusted planner

Semantic runtime
    = assurance monitor

Trusted executor
    = commitment mechanism
```

The safety kernel should not contain the entire intelligence of the system.

Its value comes from remaining small.

---

# 18. Minimal trusted core

The deterministic core should contain only what must be trusted for consequential correctness.

Likely candidates:

- state identity/version,
- legal transition schema,
- hard invariants,
- authority,
- capability derivation,
- evidence sufficiency for hard rules,
- effect identity/idempotency,
- transactional commit validation,
- policy versions,
- protected exception mechanism.

Keep outside:

- recommendation strategy,
- natural-language interpretation,
- ranking,
- search,
- broad business optimization,
- prose explanation,
- exploratory planning.

This is analogous to minimizing the Trusted Computing Base.

---

# 19. Control-plane analogy

A useful but imperfect analogy:

## Semantic/control plane

Defines:
- legality,
- policy,
- authority.

## Agent plane

Chooses:
- goals,
- tactics,
- plans.

## Execution plane

Performs:
- effects.

This separation helps prevent the agent from simultaneously defining policy and executing it.

However, avoid stretching networking terminology too far.

The important property is separation of responsibility and authority.

---

# 20. Evidence vs decision boundary

A robust pattern:

```text
AI observes / extracts / scores
        ↓
EvidenceRecord
        ↓
Policy evaluates evidence
        ↓
Capability generated
        ↓
Agent selects legal action
        ↓
Runtime commits
```

This makes the boundary auditable.

It also supports re-evaluation when:
- evidence changes,
- model version changes,
- policy changes.

---

# 21. Epistemic implications

Capabilities can depend on evidence quality rather than only domain state.

Example:

```text
CanApprove
requires:
    Identity verification current
    Fraud assessment fresh
    Required evidence not conflicted
```

If evidence becomes stale:

```text
CanApprove disappears
GatherEvidence appears
Escalate appears
```

This produces an **uncertainty-dependent capability frontier**.

That is more expressive than binary state legality.

---

# 22. Graceful degradation

A deterministic system should not always respond to uncertainty with:

```text
blocked
```

Safer alternatives may exist.

Example:

```text
AutoApprove unavailable
ManualReview available
RequestEvidence available
SaveDraft available
```

This is crucial economically.

A system that turns every uncertainty into human escalation may be safe but useless.

The runtime should derive the **safest available capability set**, not simply deny everything.

---

# 23. Policy gaps

A robust system must represent:

```text
NoAuthorizedDecision
```

or:

```text
PolicyDecisionRequired
```

when no existing rule covers the situation.

This is preferable to:
- AI inventing a rule,
- forcing an unrelated rule,
- silently using precedent.

This also preserves semantic integrity over time.

---

# 24. Ambiguous policy

Natural-language policy often contains ambiguity.

A dangerous architecture is:

```text
ambiguous text
    ↓
AI formalizes automatically
    ↓
precise deterministic rule
```

Precision can hide interpretation error.

Safer pipeline:

```text
policy text
    ↓
AI proposes candidate formalization
    ↓
ambiguities surfaced
    ↓
authorized review
    ↓
tests/examples
    ↓
versioned formal policy activated
```

The AI can reduce knowledge-acquisition cost without receiving unilateral policy authority.

---

# 25. Expert-system warning

Rule-based expert systems provide a major historical warning.

Problems included:

- knowledge acquisition bottlenecks,
- rule explosion,
- brittle interactions,
- maintenance difficulty,
- poor handling of novel cases,
- opaque exception behavior.

The proposed architecture avoids recreating this only if it follows one discipline:

> **Encode legality and stable commitment-critical constraints—not all expertise.**

Do not try to formalize:
- every judgment,
- every heuristic,
- every business preference.

AI remains valuable precisely because those areas are difficult to reduce to rules.

---

# 26. Knowledge-acquisition bottleneck

Explicit semantic constraints require people to identify:

- states,
- rules,
- exceptions,
- authority,
- evidence.

That is real work.

AI may help by:
- mining existing code,
- extracting candidate rules,
- comparing policy documents,
- generating tests,
- identifying contradictions.

But AI-generated rules should initially be:

```text
proposed
```

not authoritative.

Otherwise the architecture merely formalizes hallucinations faster.

---

# 27. Exceptions

Real systems require exceptions.

An exception mechanism should preserve:

```text
scope
authority
reason
expiration
provenance
affected rules
```

Example:

```text
Exception EX-71
allows:
    ManualRefund

for:
    Account A17

until:
    2026-08-30

authorizedBy:
    RefundOperationsManager

reason:
    settlement correction
```

This is superior to:
- bypass flags,
- hidden admin endpoints,
- editing policy.

---

# 28. Temporary exceptions

Temporary exceptions should expire automatically or create review obligations.

Without expiration:
- exceptions become permanent shadow policy.

With overly difficult exception processes:
- users bypass the semantic runtime.

The design problem is governance, not simply stricter code.

---

# 29. Capability implications

Capabilities are the cleanest agent-facing representation of deterministic legality.

Instead of telling the model:

```text
Never refund after settlement unless...
```

the runtime returns:

```text
Available:
    OpenCase
    RequestApproval
    ExplainDecision

Unavailable:
    ExecuteRefund
```

The model's action space is reduced.

But for planning, it may still need to know why blocked.

Therefore provide:

```text
explain_blocked(ExecuteRefund)
```

Returning:

```text
SettlementFinal
No approved exception
```

This supports safe planning without executable authority.

---

# 30. World model vs executable frontier

This distinction is important.

An agent should be able to reason about:

- prohibited actions,
- hypothetical changes,
- counterfactual states.

Example:

> "If a refund exception were approved, the customer could receive $400."

It should not automatically possess the tool to execute it.

Therefore separate:

## Conceptual action model

What actions exist in the domain.

## Executable capability frontier

What the current actor may execute now.

Over-restricting the agent's conceptual world model can degrade planning.

---

# 31. Obligation implications

When no legal action satisfies the goal, the deterministic system can expose unresolved work.

Examples:

```text
Obligation:
    ObtainManagerApproval

Obligation:
    RefreshIdentityEvidence

Obligation:
    ResolvePolicyGap
```

This converts:

> "Figure out why I cannot proceed."

into:

> "Here is the unresolved prerequisite."

That may reduce both tool calls and model reasoning.

---

# 32. External-effect implications

External effects require especially strong boundaries because the model may not know whether an attempted effect succeeded.

Example:

```text
Refund API times out.
```

Possible realities:

- refund did not occur,
- refund occurred,
- outcome unknown.

The runtime should preserve:

```text
OutcomeUnknown
```

and prevent unsafe retry until effect identity/status is reconciled.

This is deterministic execution safety independent of whether the AI's original decision was reasonable.

---

# 33. Transactional proposal pattern

A strong generic pattern is:

```text
Agent proposes:
    transition
    parameters
    evidence refs
    optional rationale

Runtime checks:
    current state
    version
    authority
    policy
    evidence
    invariant
    effect constraints

If valid:
    commit atomically

Else:
    structured rejection
```

This resembles:
- optimistic concurrency control,
- database transaction validation,
- design by contract.

The model never directly mutates authoritative state.

---

# 34. AI rationale

AI rationale should generally not determine legality.

A persuasive paragraph should not override:

```text
amount > authorizedLimit
```

Rationale may be required for:
- audit,
- human escalation,
- exception request.

But it should be treated as:
- explanation,
- proposal evidence,

not magic authority.

---

# 35. Postconditions

Where possible, check postconditions before committing.

Example:

AI generates candidate schedule.

Validator checks:

- no forbidden overlap,
- required staffing,
- budget bounds.

Then commit.

This allows flexible generation inside a deterministic envelope.

The same pattern applies to agent-generated code:

```text
candidate implementation
    ↓
compiler/tests/static checks
    ↓
accepted artifact
```

The boundary reduces the amount of trust placed in the generator.

---

# 36. Sandboxing

Exploration should often happen in:

- dry-run,
- preview,
- simulation,
- sandbox,
- transaction staging.

This creates a powerful principle:

> **Think broadly; commit narrowly.**

The system can allow the agent to explore even invalid hypothetical plans as long as those plans cannot cross the protected commitment boundary.

---

# 37. Wrong-rule risk

Deterministic does not mean correct.

This is the biggest conceptual error to avoid.

A wrong rule can be more dangerous than a probabilistic error because it fails systematically.

Example:

```text
RiskScore >= .8 => deny
```

If the score is biased or threshold is wrong:

the runtime enforces the wrong policy perfectly.

Mitigations:

- policy versioning,
- monitoring,
- appeal/exception pathways,
- independent tests,
- distribution-shift detection,
- human review,
- policy provenance,
- mutation tests,
- measured false-block rates.

---

# 38. False-block risk

A safety system must measure:

> how often legitimate/desirable actions are prevented.

Define:

```text
FalseBlockRate =
legitimate actions incorrectly blocked
/
legitimate actions attempted
```

This must be a first-class metric.

A system with:

```text
IllegalCommitmentRate = 0
```

but:

```text
FalseBlockRate = 60%
```

is not successful.

It simply disabled autonomy.

---

# 39. Human escalation

Human review should be reserved for cases where it adds authority or judgment.

Bad design:

```text
anything uncertain -> human
```

Better:

```text
uncertainty + consequence + missing machine-resolvable condition
    -> human
```

Examples:

Machine can resolve:
- stale evidence → refresh it,
- missing approval → request approval.

Human needed:
- ambiguous policy,
- exception justification,
- conflicting high-authority evidence,
- normative tradeoff.

Measure escalation rate and handling time.

---

# 40. Autonomy levels

A useful operational model:

## Level 0 — Recommend

AI cannot execute.

## Level 1 — Reversible execution

AI may execute low-consequence reversible actions.

## Level 2 — Constrained consequential execution

AI may execute consequential actions through deterministic commitment gates.

## Level 3 — Policy proposal

AI may propose changes to constraints but cannot activate them.

## Level 4 — Meta-policy autonomy

AI may change policy within a higher-level deterministic governance framework.

Level 4 should be considered exceptional and requires its own research.

For most enterprise systems, Level 2–3 is likely the practical frontier.

---

# 41. Domain case study — healthcare

Architecture research only; not clinical advice.

## Probabilistic

AI may:
- summarize chart,
- identify candidate diagnoses,
- detect patterns,
- rank differential,
- find literature.

## Deterministic

System may check:
- known medication interactions,
- allergy conflicts,
- dosage bounds where formally represented,
- authorization,
- evidence provenance,
- required documentation.

## Human

Clinician often retains:
- diagnosis,
- treatment choice,
- interpretation of ambiguous evidence.

FDA clinical decision-support guidance reinforces a risk-based distinction around software outputs and the ability of healthcare professionals to independently review the basis of recommendations.

The broader lesson is:

> the more software substitutes for professional judgment rather than supports it, the stronger the assurance burden becomes.

---

# 42. Domain case study — finance

## AI/ML

- anomaly detection,
- fraud score,
- document extraction,
- customer intent interpretation.

## Deterministic

- account authority,
- transaction limits,
- AML/KYC requirements where formalized,
- ledger invariants,
- idempotency,
- balance constraints,
- policy version.

## Human

- high-risk exception,
- ambiguous investigation,
- policy adjudication.

A fraud score should not itself transfer money or freeze an account unless the organization has explicitly authorized that mapping.

---

# 43. Domain case study — security

## AI

- interpret logs,
- correlate signals,
- propose response,
- summarize incident.

## Deterministic

- authentication,
- authorization,
- least privilege,
- protected command access,
- network control boundaries,
- change approval.

The reference-monitor pattern is especially strong here.

An agent may recommend:

```text
disable account
```

but only a trusted authority path should perform it.

---

# 44. Domain case study — DevOps

## AI

- diagnose failure,
- propose rollback,
- generate fix,
- rank remediation.

## Deterministic

- environment access,
- deployment policy,
- approvals,
- test gates,
- health requirements,
- artifact identity,
- rollback constraints.

Useful protocol:

```text
propose_deploy(build)
    ↓
evaluate_deployability(build, environment)
    ↓
commit_deploy
```

---

# 45. Domain case study — customer support

This demonstrates why boundary should attach to actions, not domains.

AI can have broad freedom to:

- draft explanation,
- answer product question,
- summarize history.

But:

- refund money,
- change subscription,
- disclose private data,
- make contractual promise

requires stronger controls.

Same agent, different action boundary.

---

# 46. Decision framework for boundary placement

For each action, ask:

## Q1 — Is there authoritative consequence?

If no:
probabilistic execution may be acceptable.

## Q2 — Can legality/safety be stated mechanically?

If yes:
put that constraint in deterministic runtime.

## Q3 — How reversible is the action?

Lower reversibility → stronger pre-commit gate.

## Q4 — How observable is failure?

Lower observability → stronger prevention.

## Q5 — Does action require delegated authority?

If yes:
authority must not be inferred probabilistically.

## Q6 — Is evidence sufficiency mechanically testable?

If yes:
enforce it.

## Q7 — Is the policy ambiguous or value-laden?

If yes:
do not hide ambiguity inside deterministic code; use human/governance path.

## Q8 — Is there a safe reduced capability?

Prefer graceful degradation.

---

# 47. Recommended control classes

## Class A — Probabilistic

Characteristics:
- low consequence,
- reversible,
- highly observable,
- no protected authority.

Examples:
- drafting,
- ranking,
- recommendations.

## Class B — Validated probabilistic

AI produces artifact, deterministic validator checks it.

Examples:
- generated code,
- schedule,
- structured data extraction.

## Class C — Deterministically gated

AI chooses desired action, runtime enforces hard rules.

Examples:
- refund,
- state transition,
- deployment.

## Class D — Human-authorized

Rules cannot safely determine disposition.

Examples:
- policy exception,
- ambiguous high-consequence decision.

## Class E — Safety-kernel controlled

Safety-critical execution with independently verified fallback/monitor.

Examples:
- autonomous control systems.

This is more useful than a universal binary split.

---

# 48. Tool protocol

A minimal agent protocol could be:

```text
observe_state()
get_capabilities()
get_obligations()
explain_blocked(action)
simulate(action)
propose_transition(action, evidence)
```

The critical omission is:

```text
set_state_arbitrarily()
```

The runtime owns mutation.

This makes the boundary explicit in the tool interface.

---

# 49. Propose vs execute

For consequential actions, separate:

```text
propose_refund
```

from:

```text
execute_refund
```

But ideally the agent does not need to call two arbitrary tools.

Instead:

```text
request_transition(Refund(...))
```

The semantic runtime:
- validates,
- commits,
- invokes trusted effect adapter.

This avoids agent-side orchestration of safety-critical steps.

---

# 50. Context and token implications

A conventional agent prompt may include:

- all policy text,
- authorization rules,
- state transition rules,
- exception rules,
- retry rules.

A strong runtime can instead provide:

```text
Current state
Current capabilities
Relevant obligations
Blocked reasons on demand
```

This may reduce input context.

Example:

Instead of 8,000 tokens of refund policy:

```text
Capabilities:
    IssueCredit(max=50)
    RequestRefundApproval
    ExplainRefundPolicy
```

The model need not reason about every illegal branch.

This is a credible but incompletely measured economic benefit.

---

# 51. Diagnostic compression

The runtime should return structured reasons.

Bad:

```text
Action denied.
```

Better:

```text
REFUND_BLOCKED
reason:
    SettlementFinal

available paths:
    RequestException
    IssueCredit(max=50)
```

This reduces:
- trial and error,
- repository search,
- repeated prompt reasoning.

The deterministic system becomes a context generator as well as a guard.

---

# 52. Smaller-model hypothesis

A smaller model may perform well if it no longer needs to master:

- authorization,
- compliance edge cases,
- transition legality,
- effect retry semantics.

It still needs enough intelligence to:
- understand goal,
- choose among legal alternatives,
- interpret blocked reasons,
- recognize policy gaps.

The key experiment is:

```text
frontier model + permissive environment

vs

medium model + deterministic gate

vs

small model + highly structured capability environment
```

Measure:

- task success,
- illegal actions,
- false blocks,
- human escalation,
- tokens,
- total cost.

Current evidence makes this plausible but not proven.

---

# 53. Retry-loop risk

A restrictive runtime may create repeated failures:

```text
agent tries A
blocked
tries B
blocked
tries C
blocked
```

That can erase token savings.

Mitigation:

Expose:
- capability frontier,
- prerequisites,
- alternative paths,
- missing evidence.

The goal is **constraint-guided planning**, not blind rejection.

---

# 54. Economic model

Compare:

## A — Smart model, permissive runtime

Cost:

```text
expensive inference
+ prompt policy
+ retries
+ escaped errors
+ human review
```

## B — Medium model, constrained runtime

Cost:

```text
semantic infrastructure
+ policy maintenance
+ lower inference?
+ lower error?
+ some false blocks
```

## C — Small model, highly structured runtime

Cost:

```text
higher structure
+ cheaper inference
+ potentially higher inability/escalation
```

Use:

```text
TotalCost =
EnvironmentConstruction
+ PolicyMaintenance
+ ModelInference
+ ToolExecution
+ HumanEscalation
+ Repair
+ ExpectedErrorCost
```

Primary metric:

```text
CostPerCorrectAuthorizedCompletion
```

not raw token cost.

---

# 55. Crossover point

The deterministic architecture wins when:

```text
saved inference
+ saved review
+ prevented error cost
>
constraint construction
+ policy maintenance
+ false block cost
+ additional escalation
```

The crossover occurs sooner where:

- actions repeat frequently,
- consequences are high,
- rules are stable,
- authority is clear,
- hard invariants are few,
- model inference is expensive.

It occurs later or never where:

- decisions are rare,
- rules are volatile,
- judgment dominates,
- consequences are low.

---

# 56. Metrics

## Illegal Commitment Rate

```text
illegal commitments executed
/
commitment attempts
```

## Unauthorized Action Rate

```text
actions executed without valid authority
/
protected actions
```

## Wrong-but-Legal Decision Rate

Important because legality ≠ wisdom.

```text
legal actions producing reference-bad outcome
/
legal actions
```

## False Block Rate

```text
valid/desirable actions incorrectly blocked
/
valid/desirable attempts
```

## Human Escalation Rate

## Recovery Rate

## Policy Gap Rate

## Deterministic Policy Error Rate

## Boundary Leakage Count

Cases where agent bypasses/redefines deterministic control.

## Trusted Core Size

Code/specification required for consequential correctness.

## Autonomy Efficiency

```text
consequential tasks completed correctly without human
/
consequential tasks
```

subject to safety target.

## Cost Per Correct Authorized Completion

Primary economic metric.

---

# 57. Experiment A — fraud

Create known reference outcomes.

Model supplies risk assessment.

Compare:

### A

AI directly chooses hold/release.

### B

Deterministic threshold maps score to action.

### C

Two thresholds:

```text
low risk -> release
gray zone -> review
high risk -> hold
```

Measure:

- unsafe decisions,
- false blocks,
- human load,
- calibration sensitivity,
- cost.

Intentionally shift score calibration midway.

This tests threshold brittleness.

---

# 58. Experiment B — payment

Agent decides whether refund is desirable.

Runtime enforces:

- eligibility,
- amount,
- authority,
- version,
- idempotency,
- effect status.

Inject:

- stale state,
- duplicate attempt,
- timeout/OutcomeUnknown,
- unauthorized amount.

Measure whether permissive agents execute dangerous effects.

---

# 59. Experiment C — deployment

Agent proposes deployment.

Runtime checks:

- test state,
- artifact identity,
- environment,
- approval,
- health,
- policy window.

Include one scenario where policy is intentionally wrong.

Measure:
- unsafe deployment prevention,
- false block,
- policy error propagation,
- correction cost.

---

# 60. Experiment D — ambiguous policy

Give:

> "High-risk refunds usually need manager approval."

Do not formalize “high-risk.”

Compare systems.

Correct behavior is not necessarily to invent a threshold.

Measure:
- false precision,
- policy-gap escalation,
- unauthorized action.

This is a crucial falsification test.

---

# 61. Experiment E — illegal but desirable request

User requests an action currently prohibited.

Expected behavior:

```text
blocked
+ exact policy reason
+ authorized exception/escalation path
```

Not:

- agent circumvention,
- policy reinterpretation,
- direct mutation.

---

# 62. Experiment F — wrong deterministic rule

Encode a bad rule.

Example:

```text
refund <= $500 always allowed
```

when a missing condition should restrict fraud cases.

Compare harm against probabilistic-only system.

This tests correlated failure.

Then fix rule and measure recovery.

---

# 63. Experiment G — policy gap

Construct scenario not covered.

A mature architecture returns:

```text
PolicyDecisionRequired
```

and provides:
- relevant state,
- evidence,
- affected actions.

Measure whether permissive agent improvises.

---

# 64. Ablation

Remove:

1. capability filtering,
2. authority checks,
3. structured blocked explanation,
4. evidence sufficiency checks,
5. version checks,
6. idempotency/effect rules,
7. human escalation path.

Measure each mechanism's contribution.

This prevents the architecture from becoming an undifferentiated bundle.

---

# 65. Counterargument: deterministic rules are brittle

**True.**

Response:

- formalize only stable hard constraints,
- version policies,
- preserve policy gaps,
- allow authorized exceptions,
- keep judgment outside core.

---

# 66. Counterargument: AI can already reason about policy

**Often true.**

But reasoning does not equal enforceable authority.

Even a highly capable model can:
- forget rule,
- misread current state,
- use stale evidence,
- be prompt-injected,
- choose an unauthorized tool path.

The question is not whether AI can understand a rule.

It is whether the system should depend on probabilistic compliance for a hard invariant.

---

# 67. Counterargument: human review is simpler

Sometimes.

For low-volume, rare, high-consequence decisions:

human approval may be cheaper than building a policy engine.

This is why economics must include volume.

Do not automate for the sake of architecture purity.

---

# 68. Counterargument: constraints harm exploration

They can if they restrict the model's conceptual space.

Solution:

- broad simulation,
- blocked-action explanations,
- separate executable capability frontier.

The agent can think about illegal options without being able to execute them.

---

# 69. Counterargument: expert-system bottleneck

This is real.

Avoid formalizing soft expertise.

The deterministic core should answer:

```text
MAY / MUST / CANNOT
```

only where the organization actually has a stable answer.

Let AI/human judgment answer:

```text
WHICH / WHY / BEST
```

---

# 70. Counterargument: wrong deterministic rules can create worse harm

**Correct and serious.**

A deterministic error can have near-100% consistency.

Mitigation must include:
- independent validation,
- monitoring,
- policy versioning,
- appeals,
- exception path,
- rollback,
- metrics on false blocks/wrong legal decisions.

---

# 71. Counterargument: model confidence threshold

Naive:

```text
confidence > .95 -> execute
```

is generally weak.

LLM confidence can be poorly calibrated.

Prefer:
- explicit evidence sufficiency,
- approved predictive model calibration,
- policy-specific thresholds,
- uncertainty-aware escalation.

---

# 72. Counterargument: most actions are reversible

If true, strong gates may not pay.

Use lighter controls for:
- low-consequence,
- observable,
- reversible operations.

The architecture should not force the same ceremony on:
- changing a label,
- transferring $1M.

---

# 73. Counterargument: complex exceptions destroy simplicity

They can.

If hard rules have hundreds of exceptions, that may indicate:

- wrong abstraction,
- rule is actually soft judgment,
- policy lacks stable structure.

Do not solve every exception by adding another rule.

Sometimes the right output is:

`RequiresJudgment`.

---

# 74. What is already established

## Strongly established

- Reference monitors benefit from complete mediation, tamper resistance, and small/verifiable trusted mechanisms.
- Safety-critical systems often separate complex controllers from trusted runtime assurance/safety mechanisms.
- Safe RL can optimize objectives under explicit safety constraints.
- Shielding can restrict unsafe actions while preserving adaptive optimization.
- Deterministic authorization is preferable to relying only on discretionary behavior for access control.
- Model prediction and policy decision are conceptually different.
- Deterministic rules can themselves be wrong.
- Human roles and responsibilities should be explicit in AI risk management.

## Strong emerging AI-specific evidence

- Runtime enforcement frameworks can enforce formal constraints over agent actions.
- Temporal policies can prevent LLM agents from taking prohibited action sequences more reliably than prompt-only controls in evaluated settings.
- Agent-specific access-control/runtime-governance architectures are actively emerging.

---

# 75. What remains speculative

The following still require direct measurement:

1. deterministic action boundaries reduce total token usage,
2. capability filtering enables smaller models,
3. semantic commitment gates reduce total cost after policy-maintenance overhead,
4. structured blocked explanations reduce retry loops substantially,
5. the optimal boundary can be predicted reliably from consequence/reversibility dimensions,
6. human escalation remains low enough for broad autonomous operation,
7. business policy is stable enough to justify formalization in most domains,
8. a universal agent-tool protocol around capabilities/obligations is superior to domain-specific APIs.

---

# 76. Recommended architecture changes

## 1. Adopt a commitment gate

Every consequential authoritative mutation should pass one controlled transition boundary by default.

Exceptions can exist, but must be explicit.

## 2. Do not make every action a formal state transition

That is too broad.

Use declared transitions for:
- authoritative consequential state,
- protected effects.

## 3. Derive executable capabilities

Expose what may currently be executed.

## 4. Preserve conceptual blocked actions

Allow simulation and `explain_blocked`.

## 5. Separate prediction from policy

Model output becomes typed evidence/assessment.

## 6. Add PolicyDecisionRequired

Do not let semantic gaps silently fall through to AI improvisation.

## 7. Add authorized exception records

Scoped, reasoned, expiring.

## 8. Use structured rejection diagnostics

Guard + context compression.

## 9. Keep trusted core small

Do not encode optimization strategy or broad expertise.

## 10. Measure false blocks as aggressively as illegal actions

Safety without utility is not success.

---

# 77. Recommended boundary decision framework

For any proposed AI action:

### Step 1 — classify the action

Is it:
- observation,
- recommendation,
- reversible mutation,
- consequential mutation,
- external effect,
- policy change?

### Step 2 — identify hard invariants

What must never be violated?

### Step 3 — identify authority

Who/what is allowed to authorize the action?

### Step 4 — determine mechanical decidability

Can the hard conditions be checked deterministically?

### Step 5 — assess consequence/reversibility/observability

Higher risk → stronger precommit control.

### Step 6 — identify ambiguity

If the normative rule is unresolved:
return policy gap, not fake precision.

### Step 7 — define reduced alternatives

What safer capability remains if the preferred action is unavailable?

### Step 8 — define exception route

If legitimate exceptions exist, model them explicitly.

### Step 9 — choose human role

Escalate only where judgment or authority is actually needed.

### Step 10 — measure

Track:
- illegal commitment,
- false blocks,
- escalation,
- cost,
- wrong-but-legal decisions.

---

# 78. Minimum generic rule

The mission proposed:

> If an action changes authoritative consequential state, it must pass a deterministic commitment gate.

Verdict:

**Usually correct and an excellent default.**

It should be weakened only where:

- deterministic validation is impossible,
- the domain explicitly delegates discretionary judgment,
- consequence is low enough that direct probabilistic action is acceptable.

Even then, authority and audit may still be deterministic.

---

# 79. Stronger rule evaluated

> Every consequential action must be represented as a declared transition.

This is **too strong as a universal rule**.

Some consequential operations:
- continuous control,
- open-ended expert judgment,
- complex optimization

may not map cleanly to discrete state transitions.

Better:

> Every consequential action must cross an explicit controlled commitment boundary whose invariants and authority are machine-enforced to the extent they are mechanically specifiable.

This preserves the architecture without forcing state-machine metaphysics onto every domain.

---

# 80. Weaker rule evaluated

> Only irreversible/high-risk effects require deterministic gates.

This is **too weak**.

Repeated moderate errors can create large harm.

Unauthorized state mutation may be reversible but still:
- corrupt audit history,
- trigger downstream effects,
- create security issues.

The decision should include:
- consequence,
- authority,
- observability,
- fan-out,

not irreversibility alone.

---

# 81. Final verdict

## Is “exploration permissive, commitment constrained” a defensible architecture principle?

**Strongly supported.**

It aligns closely with established high-assurance architectures and modern safe-agent/runtime-enforcement research.

Refinement:

> exploration should be broad but sandboxed where necessary; consequential commitment should be mediated according to consequence, authority, and mechanical enforceability.

## Should legal action availability be deterministic?

**Usually.**

Where legality is actually known and machine-specifiable, there is little reason to require the model to probabilistically rediscover it.

## Should AI/ML outputs generally be treated as evidence rather than authority?

**Usually yes.**

Especially when outputs are:
- predictive,
- inferential,
- classificatory.

Authority should come from policy/capability/governance.

## Should every consequential state mutation pass a deterministic commitment gate?

**Usually yes.**

This is the strongest generic architecture recommendation.

## Most appropriate role for AI

**Interpretation, inference, search, planning, optimization, recommendation, and explanation within an explicit authority envelope.**

## Most appropriate role for deterministic runtime

**Complete mediation of machine-specifiable legality, authority, invariants, versioning, evidence sufficiency, and protected effects.**

## Most appropriate role for humans

**Normative authority where policy is ambiguous, exceptional, high-consequence, or not safely reducible to stable rules; plus governance of the deterministic rules themselves.**

## Best criterion for where to draw boundary

**Consequence × reversibility × observability × authority sensitivity × mechanical decidability of the rule.**

Treat this as a structured qualitative assessment, not a pseudo-precise numeric score.

## Biggest risk of over-determinization

**Turning ambiguous or adaptive business judgment into brittle, systematically wrong rules—recreating the expert-system maintenance problem.**

## Biggest risk of under-constraining

**Allowing a probabilistic model to convert mistaken inference into authoritative irreversible action.**

## Strongest existing architectural analogue

**Reference monitor + runtime assurance/safety-kernel architecture, with shielded reinforcement learning as the closest adaptive-agent analogue.**

## Most important missing experiment

**A controlled model-tier × boundary-strength benchmark measuring illegal actions, false blocks, human escalation, task utility, and total cost per correct authorized completion.**

## Most important architecture change suggested by research

**Make all consequential mutation pass through one tamper-resistant semantic commitment interface, while preserving a richer conceptual/simulation interface for agent reasoning.**

---

# 82. Bottom-line interpretation

The research does not support:

> "AI should think; rules should decide everything."

That would simply recreate brittle expert systems.

It supports something more precise:

> **AI should be free to be probabilistic where being wrong is informative, reversible, reviewable, or merely exploratory. It should not be the sole enforcement mechanism for hard authority and safety properties that the system already knows how to check deterministically.**

This reframes the purpose of the semantic architecture.

The deterministic layer is not intended to be smarter than the model.

It is intended to be **more authoritative about a small set of things**.

The model may know:
- more facts,
- more strategies,
- more possibilities.

The runtime only needs to know:

```text
Is this actor allowed?
Is this transition legal?
Is the evidence sufficient?
Is the state version current?
Would this violate an invariant?
May this effect execute?
```

That division of labor has deep precedent.

It is the same reason operating systems do not ask applications to remember whether they are authorized to access memory, and safety-critical control systems do not rely solely on an adaptive controller to remember every safety property.

The most important refinement to the broader architecture is therefore:

> **Do not constrain intelligence. Constrain authority.**

Allow the agent to:
- imagine,
- search,
- simulate,
- disagree,
- propose,
- optimize.

Make it cross a small, explicit, deterministic boundary when imagination becomes authoritative reality.

That is likely the cleanest responsibility boundary for agentic software.

---

# 83. Key research sources

## Safe RL / shielding

1. Alshiekh, M., Bloem, R., Ehlers, R., Könighofer, B., Niekum, S., Topcu, U. **Safe Reinforcement Learning via Shielding.** AAAI / arXiv:1708.08611.

2. Corsi, D. et al. **Verification-Guided Shielding for Deep Reinforcement Learning.** 2024. arXiv:2406.06507.

3. Hamel-De le Court, E., Belardinelli, F., Goodall, A. W. **Probabilistic Shielding for Safe Reinforcement Learning.** 2025. arXiv:2503.07671.

4. Pranger, S., Könighofer, B. **Easy-to-Use Shielding for Reinforcement Learning.** 2026. arXiv:2606.03804.

## Runtime assurance / high assurance

5. NASA runtime-assurance literature, including **A Formal Verification Framework for Runtime Assurance** (NFM 2024) and NASA guidance/research on runtime assurance for safety-critical autonomous systems.

6. NASA work on **Assuring Safety-Critical Machine Learning Enabled Systems** and dynamic safety assurance for autonomous systems.

## Reference monitors / isolation

7. Classical reference-monitor principles: complete mediation, tamper resistance, and verifiability; repeatedly used in security architecture and trusted computing base literature.

8. Roessler et al. **µSCOPE: A Methodology for Analyzing Least-Privilege Compartmentalization in Large Software Artifacts.** 2021.

## Current agent runtime enforcement

9. Kamath, A. et al. **Enforcing Temporal Constraints for LLM Agents (Agent-C).** 2025. arXiv:2512.23738.

10. **Customizable Runtime Enforcement for Safe and Reliable LLM Agents.** 2025. arXiv:2503.18666.

11. **Formal Policy Enforcement for Real-World Agentic Systems.** 2026. arXiv:2602.16708.

12. **An Attribute-Based Access Control Framework for Tool-Use Agents (AgentGuard).** 2026. arXiv:2605.28071.

13. **Runtime Governance for Policy-Constrained Execution.** 2026. arXiv:2604.07833.

## Safe / constrained decision systems

14. Constrained Markov Decision Process and Safe Reinforcement Learning literature, including recent surveys of constraint formulations and state-wise safety.

## Human/AI governance

15. NIST **AI Risk Management Framework** and AI RMF resources on governance, human roles, and intervention.

## Healthcare decision support

16. U.S. FDA **Clinical Decision Support Software Guidance**, updated January 29, 2026.

17. FDA resources on AI-enabled medical devices and risk-based assessment of AI use in regulatory decision-making.

---

# 84. Evidence grading

| Claim | Current evidence |
|---|---|
| A small trusted monitor can constrain a complex controller | Strong |
| Shielding can enforce hard safety properties around adaptive policies | Strong |
| Complete mediation is a sound security principle | Strong |
| Prediction and policy should be conceptually separated | Strong |
| Runtime constraints can improve LLM-agent policy compliance | Strong emerging |
| Prompt-only instructions are sufficient for hard action safety | Evidence against |
| Every business decision should be deterministic | Rejected |
| Every consequential mutation should cross a controlled gate | Strongly supported as default |
| AI outputs should normally carry authority by themselves | Rejected as default |
| Hard constraints + soft optimization is a sound architecture | Strong |
| Constraint strength should scale with action consequence | Strong |
| Deterministic boundaries reduce token cost | Plausible; insufficient direct evidence |
| Deterministic boundaries enable smaller models | Plausible; insufficient direct evidence |
| Expert-system-style comprehensive rule modeling is desirable | Evidence against |
| Human escalation can be eliminated | No |
| Deterministic rules are necessarily safer | No—wrong rules can cause systematic harm |

---

# 85. Research decision

**Proceed.**

This is one of the strongest-supported parts of the larger state-constrained architecture.

The new research should focus less on whether the architectural principle is reasonable and more on its **optimal scope and economics**.

The most important experiment is now:

```text
same agent task suite
×
different model tiers
×
different commitment-boundary strength
```

including:

- permissive,
- prompt-guided,
- runtime validation,
- capability-filtered,
- human gray zone.

The key result should not be:

```text
blocked more unsafe actions
```

alone.

It must jointly optimize:

- illegal commitment rate,
- wrong-but-legal rate,
- false block rate,
- human escalation,
- task success,
- latency,
- total cost.

The architecture is successful only if it creates **safe useful autonomy**, not merely safe inactivity.

The strongest conceptual conclusion is:

> **The deterministic system should not replace probabilistic intelligence. It should define the boundary across which probabilistic intelligence acquires authority.**
