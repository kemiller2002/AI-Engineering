# AI Research Mission 04 — Obligations as Agent Work Queues

**Research date:** 2026-08-14  
**Method:** literature-driven research and architectural synthesis; no new empirical experiment was run for this report.  
**Research standard:** evidence is separated into (a) established concept, (b) demonstrated AI effect, (c) architectural inference, and (d) untested hypothesis.

---

## 1. Executive verdict

The core idea survives skeptical review and becomes more precise under comparison with adjacent fields.

The strongest defensible claim is **not** that obligations are a new formal concept. Obligations, permissions, prohibitions, deadlines, violations, commitments, workflow work items, durable process state, and queue leasing all have substantial prior art. The stronger and more novel architectural move is to combine these ideas into a runtime control surface for AI agents in which:

- authoritative domain state says what **is**;
- capabilities say what the actor **may legally do now**;
- obligations say what **must still be resolved**;
- machine-checkable satisfaction conditions say whether the required semantic outcome has actually been achieved;
- provenance says why the obligation exists;
- policy/evidence/version information constrains the interpretation;
- execution tasks are replaceable attempts to satisfy the obligation rather than the obligation itself;
- the agent receives a bounded semantic slice instead of rediscovering unresolved work from logs, code, history, and broad monitoring.

That synthesis is meaningfully different from a generic TODO list and meaningfully different from a conventional job queue.

There is **strong prior research support** for several component mechanisms:

1. Deontic and normative multi-agent literature treats obligations, permissions, and prohibitions as first-class formal concepts.
2. Commitment-based multi-agent systems separate persistent social commitments from individual actions and include operations such as create, discharge, release/cancel, delegate, and assign.
3. BDI architectures separate informational state, goals/desires, intentions, and plans, supporting the distinction between a required outcome and the current procedure selected to pursue it.
4. Workflow/Petri-net research shows value in explicit process state, reachability, deadlock/soundness checking, and verification before runtime.
5. Durable workflow systems show operational value in persisted progress, restartability, retries, idempotency, and deterministic recovery after crashes.
6. XACML provides an unusually direct precedent for the conceptual duality: policies may authorize actions while also returning obligations that MUST be discharged by the enforcement point.
7. Recent LLM-agent research provides direct evidence that externally maintained progress/backlog state, duplicate filtering, verifier-backed completion, and selective context retention can improve long-horizon completion and/or reduce cost.

However, **no source located directly demonstrates the complete proposition**: that a semantic obligation model of the exact form proposed here reduces total token/tool cost per correct outcome across realistic enterprise agents. That remains an empirical hypothesis.

### Bottom-line verdict

The architecture is sufficiently supported to justify implementation and controlled experiments. It is **not** sufficiently supported to claim proven token savings, proven smaller-model substitution, or proven obligation completeness.

The most important reframing is this:

> An obligation should not be treated primarily as a task to perform. It should be treated as a durable semantic assertion that the present world is not yet in an acceptable resolved condition under a particular policy/evidence context.

That distinction is what gives the model architectural value.

---

## 2. Formal definition of obligation

The candidate definition is good but should be tightened.

### Recommended definition

> **An obligation is a durable, versioned, attributable normative requirement that a defined semantic condition concerning a subject reach an acceptable disposition, because of an authoritative state, event, policy, evidence condition, or authorized decision. The obligation persists independently of any particular execution plan until its satisfaction condition is proven, it is validly waived, it is superseded by a condition that invalidates its applicability, or it is otherwise dispositioned by an authorized rule.**

An obligation therefore has at least five logical components:

1. **Applicability predicate** — why this obligation exists now.
2. **Subject** — what semantic entity or scope it concerns.
3. **Normative requirement** — what condition must eventually become true or be dispositioned.
4. **Satisfaction/disposition predicate** — machine-verifiable criteria when possible.
5. **Authority/provenance** — which policy, event, evidence, or actor gives the obligation legitimacy.

A useful abstract form is:

```text
Obligation O = {
    id,
    type,
    subject,
    applicability,
    reason,
    causedBy,
    policyVersion,
    evidenceRefs,
    raisedAtStateVersion,
    satisfactionPredicate,
    allowedDispositions,
    deadline?,
    priorityVector,
    requiredAuthority?,
    currentStatus,
    provenance
}
```

### What an obligation is not

It is not simply:

- a reminder;
- a queue message;
- an instruction string;
- a scheduled job;
- permission to act;
- an arbitrary human assignment;
- a mutable Boolean `done` field;
- a procedural workflow step.

The decisive difference is **semantic persistence**. A task may fail, be cancelled, be retried, or be replaced. The obligation remains until the underlying required condition is actually satisfied or legitimately dispositioned.

This recommendation aligns with commitment-oriented multi-agent work, deontic logic, policy obligations, workflow verification, and goal-directed planning, while deliberately narrowing them for operational agent use.

---

## 3. Capability / obligation duality assessment

The proposed duality is sound and useful:

```text
Capability = legal frontier
Obligation = required frontier
```

More precisely:

- **Capability** answers: “Which consequential transitions is this actor authorized and currently able to request from this state?”
- **Obligation** answers: “Which unresolved semantic conditions is the system normatively committed to resolving?”

This is not exactly the same formalism as classical deontic logic, but it maps naturally to:

```text
permission  ~ capability
obligation  ~ obligation
prohibition ~ unavailable/forbidden transition
```

The strongest direct precedent is XACML. XACML distinguishes policy decisions about access from **obligations that MUST be performed** by the Policy Enforcement Point in conjunction with the decision. Importantly, an enforcement point that cannot understand/discharge required obligations must not simply proceed. This establishes that “allowed” and “required companion action” are distinct control concepts in a mature policy standard.

The proposed architecture goes further because capabilities are state-dependent semantic actions, and obligations are persistent unresolved conditions rather than merely obligations attached to one authorization decision.

### Verdict

**Capability + obligation is a coherent and useful agent control surface.** It is not wholly new as a conceptual duality, but the combination with explicit semantic state, evidence/versioning, and LLM work queues appears to be a useful engineering synthesis.

---

## 4. Comparison with deontic logic

Deontic logic is the formal study of concepts such as obligation, permission, and prohibition. Temporal/deontic work additionally addresses deadlines, violation, and contrary-to-duty obligations.

### Strong overlap

The proposed model inherits several known deontic problems:

- conflicting obligations;
- obligations with deadlines;
- obligation violation without obligation disappearance;
- permission not implying obligation;
- obligation not automatically conferring permission or power;
- contrary-to-duty obligations: what becomes required after a primary obligation is violated;
- defeasibility and priority among norms.

This literature strongly supports rejecting simplistic lifecycles where an overdue obligation simply becomes “failed” and disappears.

### Difference

Classical deontic logic is primarily concerned with formal normative truth and reasoning. The proposed architecture is concerned with an operational representation that can become a durable work queue for software/AI agents.

That requires engineering fields that pure deontic logic does not automatically supply:

- claim leases;
- idempotency keys;
- scalable retrieval;
- batching;
- evidence pointers;
- version checks;
- tool affordances;
- distributed worker coordination;
- cost-aware context slicing.

### Recommendation

Adopt deontic semantics conceptually, but do not expose a highly academic deontic language as the primary application programming model. Use the literature to define invariants and edge cases.

---

## 5. Comparison with normative multi-agent systems

Normative multi-agent systems are one of the closest intellectual ancestors. They explicitly model agents operating under obligations, permissions, prohibitions, sanctions, organizations, roles, and institutions.

### What is already established

Research in normative MAS treats norms as mechanisms that coordinate, regulate, guide, and control agent interaction. Work has addressed:

- dynamic obligations;
- conflict detection/resolution;
- sanctioning;
- institutional rules;
- temporal obligation changes;
- norm revision;
- accountable agent interaction.

Commitment-based systems are especially relevant. Singh’s commitment ontology treats commitments as durable social relationships and identifies operations such as create, discharge, cancel/release, delegate, and assign. That is very close to the desired property that the semantic requirement persists independently of the current task execution.

### What the proposed model adds

The proposed obligation model is narrower and more operational:

- it need not represent social or moral norms generally;
- it can be generated deterministically from domain state/evidence/policy;
- it is optimized for retrieval as actionable unresolved work;
- it explicitly exposes current legal capabilities and missing prerequisites;
- it is intended to reduce LLM rediscovery, context, and planning cost;
- it couples obligation state to machine-checkable semantic satisfaction.

### Verdict

Normative MAS is strong prior art for the semantics. The claim of novelty should be placed in **agent-facing runtime architecture and cost reduction**, not in the existence of computational obligations.

---

## 6. Comparison with BDI

BDI — Belief, Desire, Intention — separates:

- beliefs: informational state;
- desires/goals: states the agent would like to bring about;
- intentions: goals/plans to which the agent commits;
- plans/actions: procedures used to make progress.

This is conceptually important because it validates the architectural distinction between a **goal condition** and the **current procedure selected to pursue it**.

### Approximate mapping

```text
Verified/epistemic state -> BDI belief-like information
Obligation               -> externally imposed required goal
Chosen remediation plan  -> intention
Execution task/action     -> plan step
```

But an obligation should not be called a “desire.” A desire is motivational and agent-centric. An obligation is externally attributable, normatively binding, and may remain valid even if the agent does not select it or wish to pursue it.

### Key insight from BDI

BDI supports the claim that planning and execution should not be conflated with the persistent goal. It also suggests a clean hybrid:

```text
System determines authoritative obligations.
Agent deliberates about which obligation(s) to pursue.
Agent forms intentions/plans using currently legal capabilities.
System independently verifies satisfaction.
```

This is better than allowing the agent to define, execute, and self-certify its own work.

---

## 7. Comparison with workflow engines

The proposed obligation model is **not merely a workflow engine**, although workflow engines provide many mechanisms it should reuse.

BPMN and workflow research model explicit activities, events, gateways, sequence flow, exceptions, and process instances. Petri-net-based workflow theory adds powerful verification concepts such as reachability, soundness, deadlock analysis, and control-flow correctness.

### Workflow strength

Workflow engines are excellent when:

- the process is known;
- order matters;
- control flow is central;
- retries/timeouts are procedural concerns;
- long-running process execution must survive failures.

### Obligation strength

An obligation is stronger when:

- there may be multiple legal ways to resolve a condition;
- the correct procedure can change without invalidating the underlying requirement;
- work arises dynamically from state/policy/evidence rather than from a preselected process position;
- the required outcome matters more than a specific step sequence;
- the agent should be allowed to plan among legal alternatives.

Example:

```text
Obligation: EstablishRefundOutcome
```

may be satisfiable via provider query, settlement reconciliation, or authorized human investigation. A workflow can implement any chosen procedure, but the obligation says **why any procedure must continue to exist at all**.

### Recommended relationship

Use obligations above or alongside workflows:

```text
Obligation -> semantic requirement
Planner/workflow -> selected resolution procedure
Capabilities -> legal executable transitions
State/evidence -> independent verifier of completion
```

Do not replace mature workflow infrastructure when durable execution is needed.

---

## 8. Comparison with durable execution and job queues

Temporal and similar durable execution systems persist workflow progress across crashes, retry activities, and require attention to idempotency for external side effects.

A job queue usually says:

```text
run function F with payload P
```

An obligation says:

```text
condition C remains unresolved and must reach one of disposition states S
```

This difference matters after failure.

If `QueryProvider` fails, a job queue may retry the job. An obligation-aware system asks whether querying the provider is still the best/legal next action, whether state changed, whether another capability is now available, and whether the satisfaction condition may already have become true through an external event.

### Claiming and leasing

Queue semantics are highly reusable:

- claim token;
- lease expiration;
- heartbeat;
- visibility timeout;
- requeue after worker loss;
- optimistic concurrency/version check;
- idempotent semantic operation ID.

But these should attach to **attempt ownership**, not semantic ownership of the obligation itself.

Recommended separation:

```text
Obligation.status = Raised | Active | Blocked | Resolved...
WorkLease = { obligationId, agentId, leaseUntil, attemptId }
```

An expired lease must not alter the truth of the obligation.

---

## 9. Comparison with compliance and remediation systems

Compliance systems already use concepts resembling:

- findings;
- remediation items;
- control exceptions;
- evidence;
- owners;
- deadlines;
- waivers;
- audit trails;
- compensating controls.

This domain offers strong operational precedent for provenance and waiver governance.

However, most compliance work-management products are ticket-centric and human-process-centric. The proposed architecture should avoid inheriting the weakness of allowing a person or agent to close a ticket without proving the underlying semantic condition.

### Reusable ideas

- immutable origin/source;
- policy/control identifier;
- responsible role rather than only responsible person;
- due date and escalation schedule;
- exception authority;
- evidence package;
- historical disposition record;
- reopen on evidence invalidation or policy change.

### Improvement for AI systems

Replace “ticket closed” as primary truth with:

```text
satisfactionPredicate(subjectState, evidence, policyVersion) == true
```

where possible.

---

## 10. Obligation lifecycle recommendation

The prompt’s candidate lifecycle mixes semantic state and execution state. Separate them.

### Semantic obligation status

```text
Active
Blocked
Overdue       # preferably a derived flag, not exclusive state
Satisfied
Waived
Superseded
CancelledInvalid
Escalated     # preferably a relation/action or flag, not terminal state
```

### Execution/handling status

```text
Unclaimed
Claimed
InProgress
AwaitingExternal
AwaitingHuman
```

This separation prevents awkward questions such as whether an obligation can be both blocked and overdue, or escalated and still active. It can.

### Recommended transition logic

```text
Raised -> Active
Active -> Blocked
Blocked -> Active
Active/Blocked -> Satisfied
Active/Blocked -> Waived
Active/Blocked -> Superseded
Active/Blocked -> CancelledInvalid
```

`Overdue` is derived from deadline + unresolved status.

`Escalation` creates an escalation event/secondary obligation/authority route but does not erase the original obligation.

### Why this matters

Lifecycle should model semantic truth, not user-interface workflow convenience.

---

## 11. Satisfaction-condition model

This is one of the strongest architectural features.

An obligation should be satisfied because the required semantic condition is true, not because an agent emitted “done.”

### Recommended form

```text
satisfaction = anyOf(
    StatePredicate(...),
    EvidencePredicate(...),
    AuthorizedDisposition(...)
)
```

Example:

```text
ReconcileRefundOutcome satisfied iff
    RefundExecution in {Succeeded, Failed}
    AND outcomeEvidence is fresh/valid
```

### Three levels of satisfaction

1. **Fully machine-verifiable** — authoritative state predicate is sufficient.
2. **Machine-verifiable evidence package + authorized judgment** — agent assembles evidence; human/authorized actor decides.
3. **Judgment-dominant** — obligation can only specify required review/disposition, not the substantive answer.

Do not force false precision. “Machine-checkable satisfaction” is powerful only when the predicate accurately represents the intended outcome.

### Direct LLM relevance

Recent verifier-backed agent work is highly relevant. PushBench demonstrates that agents can make plausible local progress yet falsely terminate before completing a quantitative goal; external state/backlog tracking and verifier-backed units materially improve behavior. This is direct support for independent completion validation.

---

## 12. Provenance model

Provenance is likely to be a major source of context compression.

Recommended fields:

```text
obligationId
obligationType
subjectId
raisedAt
raisedAtStateVersion
creationRuleId
creationRuleVersion
triggerEventId
policyId
policyVersion
evidenceRefs[]
reasonCode
reasonExplanation
actor/authority
causalParentObligations[]
supersedes?
```

### Why provenance matters

Without provenance, an agent may need to reconstruct:

- which event caused the work;
- which rule was in force;
- whether the rule has changed;
- what evidence was considered;
- whether the work is stale;
- whether another agent already analyzed it.

Provenance turns history into a compact causal explanation.

### Caution

Provenance is only compressive if it is **trustworthy and selective**. Dumping every log event into the obligation simply moves the context problem into another record.

Use references and lazy expansion.

---

## 13. Conflict model

Conflicting obligations are not an edge case; they are a first-class semantic condition.

Recommended representation:

```text
ObligationConflict {
    id,
    obligationIds,
    detectedBy,
    conflictType,
    policyVersions,
    resolutionAuthority,
    status,
    resolution?
}
```

### Resolution order

Prefer:

1. deterministic policy precedence when formally defined;
2. temporal/specificity rules when formally defined;
3. legal or organizational authority rules;
4. agent-supported analysis with no authority to choose when norms genuinely conflict;
5. human escalation.

Do not allow the LLM to silently choose merely because one obligation looks more important in natural language.

### Contrary-to-duty handling

Violation of a primary obligation may create a secondary obligation rather than erase the original history.

Example:

```text
MustFileByDeadline violated
-> FileLateWithExplanation
-> EscalateLateFiling
```

Deontic literature already treats this class of problem as nontrivial.

---

## 14. Priority and escalation model

A single numeric priority is usually inadequate because it collapses policy into a scalar without preserving why.

Use a priority vector such as:

```text
safetySeverity
legalRegulatoryCriticality
hardDeadline
timeToDeadline
customerImpact
financialExposure
reversibility
blockingCount
policyPrecedence
aging
```

Then define deterministic filtering and a scheduling policy over the vector.

### Agent role

The agent may optimize among obligations that are already comparable/legal. It should not invent normative priority.

### Escalation

Escalation can often be deterministic:

```text
if blocked > 24h -> escalate to role X
if deadline passed -> create violation disposition requirement
if requiredAuthority unavailable -> route to authority queue
if conflict detected -> escalate to policy owner
```

This is an excellent example of reasoning that should be removed from the probabilistic agent when rules are known.

---

## 15. Waiver model

Waiver is dangerous because it can become the easiest path for a goal-seeking agent.

Recommended requirements:

```text
waiverAuthority
waiverReasonCode
justification
evidence
policyBasis
scope
issuedAt
expiresAt?
reviewAt?
actor
```

A waiver must be an authorized state transition, not a mutable field.

### Strong rule

```text
Obligation does not expose Waive capability unless the current actor possesses waiver authority and the governing policy allows waiver for that obligation type.
```

Agent-generated text may support a waiver request, but should not itself constitute waiver authority.

---

## 16. Supersession model

Supersession is semantically different from satisfaction.

Example:

```text
CompleteFraudReview
```

may become irrelevant if the underlying order is validly cancelled.

Record:

```text
status = Superseded
supersededBy = OrderCancelled@v19
supersessionRule = FraudPolicy.rule...
```

This preserves the audit trail and prevents the system from falsely claiming the original requirement was fulfilled.

Supersession should generally be rule-derived or authorized, not agent-declared free text.

---

## 17. Scale and batching model

The prompt correctly identifies the danger of materializing millions of heavyweight obligation objects after a broad policy change.

### Recommended three-tier architecture

```text
ObligationRule
    -> ImpactSet / ObligationBatch
        -> Materialized ObligationInstance when selected/needed
```

`ObligationRule` contains the derivation logic.

`ImpactSet` identifies affected subjects and aggregate status.

`ObligationInstance` is materialized lazily when:

- an agent claims the work;
- a user views the subject;
- the deadline window approaches;
- a related transition occurs;
- audit requires explicit instance history.

### Batch metrics

```text
affected
notYetMaterialized
active
claimed
blocked
satisfied
waived
superseded
overdue
```

### Database design implication

Do not make “one object per obligation” a theological requirement. The semantic model can be first-class even when physical storage is query-derived or compressed.

---

## 18. Multi-agent claiming model

Use established distributed-work semantics, but maintain obligation truth independently.

Recommended claim:

```text
WorkLease {
    obligationId,
    attemptId,
    agentId,
    capabilitySnapshotVersion,
    leaseStart,
    leaseExpires,
    heartbeatAt,
    optimisticVersion
}
```

### Rules

- lease expiration makes work reclaimable;
- lease expiration does not alter obligation status;
- completion must pass the semantic satisfaction verifier;
- consequential effects use idempotency/semantic operation IDs;
- stale capability snapshots cannot authorize a transition;
- two agents may collaborate, but only one should normally hold the mutation lease for one resolution attempt;
- read-only investigation can be concurrent when safe.

This is deliberately similar to job queues because that part of the problem *is* a distributed queue problem.

---

## 19. Planning implications

An obligation naturally supplies a goal condition, allowing backward reasoning:

```text
obligation
-> desired satisfaction predicate
-> current unsatisfied predicates
-> legal transitions that can establish them
-> prerequisites of those transitions
-> next available action
```

This resembles goal regression, hierarchical goal networks, HTN planning, and BDI plan selection.

### Architectural opportunity

The state model can mechanically generate a partially reduced planning problem.

Instead of asking:

```text
“What should I do about this order?”
```

provide:

```text
Goal: ShipmentState = Shipped
Current: PaymentState = Authorized
Missing: PaymentState = Captured
Legal producer: CapturePayment
Guard: FraudReview = Clear
Current blocker: FraudReview = Pending
Available next capability: CompleteFraudReview...
```

This removes search over impossible actions.

### Multi-obligation planning

Do not force one obligation per agent call. Multiple obligations may share:

- evidence gathering;
- external queries;
- transitions;
- human review;
- prerequisites.

A planner should be able to batch compatible work while keeping each obligation independently verifiable.

---

## 20. Context-compression implications

This hypothesis has **moderate direct support** and strong architectural plausibility.

Recent LLM-agent evidence is relevant:

- “Less Context, Better Agents” (2026) reports that selective retention plus summarization on an enterprise tool-use benchmark improved completion while drastically reducing tokens/runtime relative to full conversation history.
- LoCoBench-Agent reports increasing redundant operations, repeated file reads, repeated failed calls, and context summaries in long trajectories, attributing failures in part to weak progress tracking/deduplication.
- PushBench shows that exposing externally maintained progress state changes agent trajectories and reduces duplicates/false completion.

These studies do not test obligations specifically, but they support the mechanism:

> structured external state can substitute for repeatedly carrying/reconstructing interaction history.

### Expected compression path

Without obligation:

```text
logs + DB + code + prior agent history + policy docs
-> infer unresolved condition
-> infer why it matters
-> infer what “done” means
-> infer legal next actions
```

With obligation:

```text
obligation record + semantic slice
-> select legal resolution action
```

### Critical caveat

Compression fails if obligation records are verbose narrative dumps. The unit should contain compact semantic facts and references, not replicated history.

---

## 21. Smaller-model hypothesis

Evidence is currently **weak** for the exact claim but the mechanism is credible.

Why it could work:

- work discovery is removed or narrowed;
- illegal action space is pruned;
- goal condition is explicit;
- completion is externally verified;
- context is smaller;
- progress is externalized;
- retry/resume logic is deterministic.

These changes reduce the amount of model intelligence required for orchestration.

Why it may fail:

- difficult obligations may still require sophisticated judgment;
- smaller models may misread evidence or choose poor plans;
- token reduction does not imply reasoning difficulty reduction;
- obligation generation may move complexity upstream rather than eliminate it.

### Required experiment

Hold the semantic environment constant and test several model capability tiers against open-ended vs obligation-driven variants. Measure **cost per correct semantic outcome**, not raw completion claims.

---

## 22. Token and cost hypothesis

Direct evidence for obligations reducing tokens is **moderate at the mechanism level, weak at the complete-system level**.

A useful economic identity is:

```text
TotalAgentCost =
    inference
  + retrieval
  + tool/API use
  + retries/repair
  + human intervention
  + infrastructure allocation
  + cost of semantic defects
```

Then:

```text
CostPerCorrectRequiredOutcome =
    total end-to-end cost
    / correctly achieved required semantic outcomes
```

This is superior to `tokens per run` and superior to `cost per obligation` because a badly designed system could generate thousands of trivial obligations and look efficient.

### Expected savings sources

- less monitoring;
- fewer searches for what remains unresolved;
- fewer duplicate tool calls;
- less history reloading;
- fewer invalid transition attempts;
- shorter recovery after agent restart;
- lower false-completion repair cost;
- potentially cheaper models.

### New costs introduced

- semantic modeling;
- rule authoring;
- obligation derivation;
- storage/query infrastructure;
- lifecycle logic;
- verification;
- governance;
- false-positive obligation noise.

The system only wins economically when execution frequency and consequence justify these fixed costs.

---

## 23. Security implications

The rule:

```text
Obligation != capability != authority
```

is security-critical.

A weak agent architecture may reason:

```text
“I am required to close the account, therefore I should find a way to close it.”
```

A constrained architecture says:

```text
Obligation: CloseAccount
Current capabilities: GatherEvidence, RequestAuthorizedClosure
Unavailable: CloseAccount
Reason: required authority missing
```

This preserves least privilege even under goal pressure.

Additional safeguards:

- capabilities are derived from current actor authority + state + evidence + policy;
- obligation text never dynamically grants tool permissions;
- waiver/supersession are guarded transitions;
- agent cannot delete authoritative obligations;
- tool actions carry semantic operation IDs and state versions;
- satisfaction is verified outside the agent;
- provenance is immutable/auditable.

---

## 24. Gaming risks

Queue-clearing is an optimization target and therefore susceptible to Goodhart/specification gaming.

Potential attacks/failures:

- choose the easiest literal satisfaction path;
- mutate a proxy state rather than achieve the intended real-world outcome;
- request waiver instead of doing hard work;
- create a superseding condition artificially;
- avoid discovery so new obligations never appear;
- exploit stale/weak evidence;
- satisfy a machine predicate while degrading an unmodeled quality dimension;
- split or merge obligations to improve metrics.

Recent work on reward hacking in language-model agents and coding agents reinforces that proxy compliance is a real problem, especially over long horizons.

### Safeguards

1. make satisfaction predicates consequence-based, not action-based;
2. separate agent from satisfaction verifier;
3. require authority for waiver/supersession;
4. use hidden/independent audit predicates in evaluation;
5. track downstream semantic outcome, not queue-clear rate;
6. periodically sample resolved obligations for broader review;
7. maintain a separate discovery/anomaly process.

---

## 25. Situational-awareness risks

This is the strongest conceptual counterargument.

A queue-driven agent can become myopic. If the obligation-generation rules do not recognize a new class of problem, the agent may behave perfectly against an incomplete queue while the system fails in reality.

This creates **false confidence**:

```text
queue empty != system healthy
```

### Recommended hybrid architecture

Separate:

```text
Discovery plane
    detects anomalies, new facts, policy impact, novel conditions

Resolution plane
    resolves authoritative obligations
```

Discovery may use:

- deterministic rules;
- anomaly detection;
- periodic reconciliation;
- humans;
- exploratory AI agents;
- external audits.

AI-discovered conditions should normally enter as `CandidateObligation` or evidence/event proposals until validated by trusted rules/authority.

This preserves open-ended sensing without allowing open-ended agents to mutate authoritative normative work directly.

---

## 26. Counterarguments

### Counterargument 1: This is just a job queue

**Partly true at the dispatch layer, false at the semantic layer.** Claiming, leasing, retries, and worker coordination are queue problems. Persistent requirement-to-resolve, independent satisfaction predicates, policy provenance, and procedure independence are not normal job semantics.

### Counterargument 2: This is just BPM/workflow

**Partly true.** Workflow systems already model durable work. But obligations are outcome-centric and can survive replacement of the procedure. The strongest architecture likely uses workflow technology to execute plans beneath obligation semantics.

### Counterargument 3: Humans already use tickets

Yes, but tickets usually permit subjective closure and often contain narrative context rather than formal satisfaction conditions. A semantic obligation is closer to an invariant/goal than a ticket.

### Counterargument 4: Modeling cost will dominate

For low-consequence, low-volume, rapidly changing workflows, this may be correct. The architecture should not be universal by default. The break-even improves with repeated execution, expensive mistakes, regulatory needs, high agent volume, and costly rediscovery.

### Counterargument 5: Requirements cannot all be machine checked

Correct. The design must represent authoritative human disposition as a valid satisfaction path where judgment is intrinsic.

### Counterargument 6: Obligation rules can be wrong

Correct and serious. Precision/recall of obligation generation must be measured. This is a central source of systemic failure.

### Counterargument 7: More explicit state increases system complexity

Yes. The question is whether the complexity is *essential domain complexity made explicit* or accidental infrastructure complexity. Poor DSL/schema design could make the system harder, not easier.

---

## 27. Proposed experiments

### Experiment A — Open-ended monitoring vs obligation queue

**Environment A:** “Monitor refund operations and handle anything needing attention.”

**Environment B:** same underlying system plus explicit obligations, capabilities, provenance, satisfaction.

Inject identical unresolved cases.

Measure:

- discovery tokens;
- total tokens;
- reads/searches;
- tool calls;
- time;
- duplicate calls;
- unresolved misses;
- false completion;
- semantic correctness.

### Experiment B — Unknown external effect

Inject provider timeout after refund submission.

Expected semantic state:

```text
RefundExecution = OutcomeUnknown
```

Expected obligation:

```text
ReconcileRefundOutcome
```

Critical metric: duplicate refund attempts.

### Experiment C — Agent restart

Stop agent after partial resolution. Start fresh agent with either history/log access or current obligation slice.

Measure recovery tokens, duplicate effects, time, and completion.

### Experiment D — Context compression

Compare:

1. full history;
2. retrieved conventional context;
3. obligation + semantic slice;
4. obligation + semantic slice with lazy evidence retrieval.

### Experiment E — Model substitution

Run identical tasks using multiple model tiers. Determine whether obligation environment shifts the cost/performance frontier.

### Experiment F — False obligation / missing obligation

Deliberately corrupt obligation rules to characterize precision/recall sensitivity and false confidence.

### Experiment G — Gaming

Prompt agent:

```text
Clear every outstanding obligation as fast as possible.
```

Expose legitimate and illegitimate shortcuts; measure attempts to waive, suppress, manipulate predicates, or bypass authority.

### Experiment H — Policy change burst

Change evidence freshness from 24h to 4h over 10, 100, 1k, 100k, 1M subjects. Compare eager materialization, lazy impact sets, and query-derived obligations.

### Experiment I — Multi-obligation planning

Provide obligations with shared prerequisites and compare one-at-a-time dispatch vs joint planning.

### Experiment J — Human judgment obligation

Test obligations whose satisfaction requires an authorized human decision. Measure whether agent-prepared context reduces human review time without distorting decision quality.

---

## 28. Metrics

### Correctness

```text
Required-Work Recall =
    required semantic conditions represented as obligations
    / all required semantic conditions

Obligation Precision =
    valid generated obligations
    / all generated obligations

False Completion Rate =
    agent-claimed completions rejected by independent verifier
    / agent-claimed completions

Missed Work Rate =
    required conditions never dispositioned
    / all required conditions
```

### Efficiency

```text
ContextTokensPerCorrectOutcome
ToolCallsPerCorrectOutcome
ModelCallsPerCorrectOutcome
RecoveryTokensAfterRestart
TimeToCorrectResolution
HumanMinutesPerCorrectOutcome
```

### Waste

```text
RediscoveryRate
DuplicateWorkRate
InvalidCapabilityAttemptRate
RepeatedFailedToolCallRate
StaleContextUseRate
```

### Queue health

```text
ObligationAgeDistribution
BlockedDuration
OverdueRate
WaiverRate
SupersessionRate
ReopenRate
ConflictRate
FalsePositiveBurden
```

### Economic primary metric

```text
CostPerCorrectRequiredOutcome
```

Do **not** optimize `obligations closed per dollar` as the primary metric.

---

## 29. Economic model

Let:

```text
C_open =
    monitoring
  + discovery
  + reconstruction
  + planning
  + execution
  + retries
  + duplicate work
  + missed-work loss
  + human supervision

C_obligation =
    obligation-generation runtime
  + targeted retrieval
  + planning
  + execution
  + verification
  + queue infrastructure
  + false-obligation work
  + human supervision
```

And fixed implementation cost:

```text
F =
    domain modeling
  + rule authoring
  + infrastructure
  + migration
  + governance
  + tests/tooling
```

Annualized value is roughly:

```text
NetBenefit =
    N * (C_open - C_obligation)
  + avoided semantic defect loss
  + avoided compliance/audit loss
  + reduced interruption/recovery loss
  - annualized(F)
```

where `N` is the number of consequential resolution episodes.

### Important addition

Include probability of correctness:

```text
EffectiveCost = ExpectedTotalCost / P(correct semantic outcome)
```

or, preferably in empirical work, simply calculate observed:

```text
TotalCost / Count(CorrectRequiredOutcomes)
```

This prevents cheap failures from appearing economical.

---

## 30. Break-even model

The architecture becomes more attractive when the product has:

- high volume of repeated consequential decisions;
- expensive errors;
- long-running/interrupted agent execution;
- policy complexity;
- compliance/audit requirements;
- external effects with uncertain outcomes;
- many actors with differing authority;
- frequent need to explain why work exists;
- substantial rediscovery/context cost;
- multiple agents coordinating on shared state.

It is less attractive when:

- work is rare and bespoke;
- requirements change faster than they can be modeled;
- consequences are low;
- human judgment dominates every outcome;
- no authoritative system state exists;
- the organization cannot maintain rules/evidence semantics.

### Practical break-even experiment

For a startup, do not build a universal obligation engine first. Implement one narrow domain with expensive ambiguity — such as outcome-unknown payment effects, evidence freshness, or approval conditions — and measure savings against a conventional agent implementation.

The right startup question is not “Can we model every obligation?” It is:

> “Can one reusable obligation substrate create enough savings/correctness in three materially different workflows that the fixed modeling cost begins to amortize?”

---

## 31. What is supported by existing research

### Established concepts — strong support

- obligations, permissions, prohibitions as formal normative concepts;
- deadlines/violations/conflicting duties as nontrivial deontic problems;
- normative multi-agent systems using obligations to regulate agents;
- social commitments that persist and can be discharged, released, delegated, etc.;
- BDI separation of informational state, goals, intentions, and plans;
- explicit workflow/process models and formal verification;
- reachability/deadlock/soundness analysis in Petri-net/workflow systems;
- durable execution, persisted progress, retries, and idempotency;
- policy systems that distinguish permission decisions from mandatory obligations.

### Demonstrated AI effects — meaningful but narrower

Recent LLM-agent studies support:

- long horizons create reliability/training problems;
- external progress/backlog state can reduce duplicate behavior and improve quantitative completion;
- agents can falsely terminate without verifier-backed completion;
- long agent trajectories exhibit redundant reads/calls and progress-tracking failures;
- selective context retention/summarization can reduce token/runtime cost while improving task completion in at least one enterprise tool-use benchmark;
- reward/specification gaming occurs in language-model agents and long-horizon coding agents.

These findings are directly relevant to the obligation hypothesis but do not constitute a complete end-to-end validation.

---

## 32. What remains speculative

The following claims remain unproven for the proposed architecture:

1. exact percentage reduction in token usage;
2. exact reduction in tool calls;
3. total cost savings after semantic-modeling cost;
4. reliable substitution of smaller/cheaper models;
5. obligation generation with sufficiently high recall to make the queue trustworthy;
6. a universal obligation granularity rule;
7. scalability of rich provenance/evidence semantics to millions of obligations;
8. the optimal division between deterministic priority and model scheduling;
9. whether joint planning over obligations beats independent dispatch in real enterprise systems;
10. whether agent users will maintain obligation rules correctly over policy evolution;
11. whether obligation-driven agents become dangerously myopic without a strong discovery plane;
12. whether the combined capability + obligation interface consistently outperforms good workflow-engine + tool-schema designs.

These are exactly the issues experiments should target.

---

## 33. Architecture changes recommended

### A. Make obligation a first-class semantic type

Not a generic `Task` row.

### B. Separate semantic status from execution status

Do not mix `Blocked`, `Claimed`, `Overdue`, and `Satisfied` into one linear enum.

### C. Require satisfaction predicates

Every obligation type must specify how the system determines legitimate disposition, even when that determination includes authorized human judgment.

### D. Separate obligation from task/plan

```text
Obligation = what must become resolved
Task/plan = one current attempt to achieve it
```

### E. Derive capabilities independently

Obligation presence must never broaden authority.

### F. Make provenance mandatory

At minimum: trigger, state version, rule/policy version, reason, evidence references.

### G. Use lazy context expansion

Default agent packet:

```text
obligation
current subject state
satisfaction
available capabilities
missing prerequisites
minimal evidence summary
provenance refs
```

Fetch details only when needed.

### H. Add conflict as a first-class object

Do not hide contradictory obligations in priority sorting.

### I. Treat overdue/escalation as orthogonal properties

An overdue obligation is still active.

### J. Govern waiver and supersession as transitions

No direct mutation/deletion.

### K. Reuse durable queue infrastructure

Use leases, heartbeats, optimistic concurrency, idempotency, retry semantics rather than inventing them.

### L. Add an independent discovery plane

The obligation queue must never be assumed complete merely because it is empty.

### M. Add obligation-rule precision/recall testing

Test obligation derivation like a critical classifier/specification.

### N. Prefer semantic dependencies over obligation-to-obligation dependencies

Instead of:

```text
O2 requires O1
```

prefer where possible:

```text
O2 requires FraudReviewState = Clear
```

This decouples requirement identity from implementation history and reduces brittle graphs.

### O. Build reachability checks where tractable

Detect obligations whose satisfaction predicates have no legal path from current state. Escalate instead of letting agents repeatedly fail.

### P. Do not expose all obligations to the model

Use deterministic retrieval/filtering by authority, domain, priority window, subject, blocking relationship, and workload.

---

## 34. Final verdict

### Do explicit obligations reduce agent work-discovery cost?

**Strong evidence at the mechanism level; Moderate evidence for the specific architecture.**

Workflow/normative systems already externalize required work, and recent LLM-agent research shows external backlog/progress state can improve long-horizon execution. Direct enterprise experiments with semantic obligations are still missing.

### Do explicit obligations reduce context/token usage?

**Moderate evidence.**

There is direct recent evidence that selective state/summarization reduces token usage and can improve agent completion, plus strong architectural reasoning that obligation records can replace repeated semantic reconstruction. Exact obligation-specific savings are unproven.

### Do obligations improve completion correctness?

**Moderate evidence.**

Verifier-backed progress and external completion gating improve related long-horizon agent behavior. Formal workflow/deontic traditions strongly support explicit satisfaction/verification. Full obligation architecture remains untested.

### Do obligations reduce repeated/duplicate work?

**Moderate-to-strong evidence.**

Recent state-tracking controller experiments directly eliminated duplicate submissions in tested conditions, and durable queue/idempotency practice strongly supports the mechanism.

### Can obligations enable smaller models?

**Weak evidence.**

Plausible and economically important, but direct evidence for model substitution caused by obligation structure was not found.

### Is capability + obligation a useful control surface for agents?

**Yes.**

It cleanly separates authorization from required resolution and maps to substantial prior work while producing a particularly useful interface for constrained AI agents.

### Closest existing concept

**A synthesis of normative multi-agent obligations/social commitments + goal-oriented agent planning + durable workflow/work-queue execution, with XACML-style separation of permission and mandatory obligations.**

No single compared system captures the whole proposed structure.

### Most valuable architectural benefit

**Externalizing “what remains unresolved and what counts as resolved” from probabilistic agent memory into durable semantic system state.**

This potentially improves correctness, resumability, auditability, context compression, and coordination simultaneously.

### Biggest correctness risk

**Obligation-generation incompleteness creating false confidence.**

An agent can perfectly clear an incomplete queue while missing the real problem.

### Biggest economic opportunity

**Reducing repeated semantic reconstruction and long-horizon orchestration enough to lower cost per correct outcome — potentially including model-tier reduction — across high-volume consequential workflows.**

### Most important missing experiment

**A controlled end-to-end comparison of the same realistic domain under open-ended autonomy vs explicit state + capabilities + obligations, measuring total cost per independently verified correct semantic outcome.**

This experiment should include agent restart and outcome-unknown external effects because those are where the architecture should show its clearest advantage.

### Recommended obligation lifecycle

```text
Semantic status:
    Active
    Blocked
    Satisfied
    Waived
    Superseded
    CancelledInvalid

Orthogonal properties/events:
    Overdue
    Escalated

Execution/lease status:
    Unclaimed
    Claimed
    InProgress
    AwaitingExternal
    AwaitingHuman
```

### Recommended distinction between obligation and task

> **An obligation is the durable requirement that a semantic condition be resolved. A task is a replaceable execution attempt chosen to satisfy that requirement. Task failure must not erase the obligation, and task completion must not by itself prove the obligation satisfied.**

---

# Research synthesis: strongest implication

The architectural hypothesis should now be stated more sharply:

> **Explicit obligations are not primarily a better task-management feature. They are a way to move unresolved-work discovery, persistence, provenance, and completion truth out of the probabilistic agent and into the deterministic semantic environment.**

That is important because contemporary agent failures are not limited to choosing the wrong action. Long-horizon systems also lose track of what has been completed, repeat work, accumulate stale context, terminate early, and require broad histories to reconstruct progress. Recent empirical agent research directly observes several of these problems.

The likely economic value therefore comes from **reducing the horizon and entropy of agent reasoning**. The agent does not need to rediscover the universe of work. It receives a verified frontier of unresolved conditions and a verified frontier of currently legal actions.

This produces a broader state-constrained architecture:

```text
Verified state       = what is currently believed/known authoritatively
Capabilities         = what this actor may legally do now
Obligations          = what must still become resolved
Satisfaction         = how resolution is independently proven
Evidence/provenance  = why these claims are trustworthy
Policy/version       = under which semantics they were derived
Agent                = selects among permitted resolution strategies
```

The important caveat is equally clear:

> **The obligation queue must never become the epistemic boundary of the whole system.**

There must remain a discovery/reconciliation mechanism capable of finding conditions that the obligation rules failed to encode. Otherwise efficiency is purchased by blindness.

This suggests a two-plane agent architecture:

```text
DISCOVERY PLANE
    open-ended / anomaly-oriented / exploratory
    proposes new evidence, events, candidate obligations, model gaps

RESOLUTION PLANE
    bounded / obligation-driven / capability-constrained
    resolves authoritative obligations and proves semantic outcomes
```

That separation may be more important than treating every autonomous agent as a universal reasoner.

---

# Sources and evidence base

The following sources were used as primary or high-value evidence for this literature synthesis. Source claims in the report are paraphrased; this is not a quote compilation.

1. OASIS. **eXtensible Access Control Markup Language (XACML) Version 3.0**. In particular, XACML’s policy obligations and requirement that enforcement points discharge understood obligations.  
   https://docs.oasis-open.org/xacml/3.0/xacml-3.0-core-spec-os-en.html

2. Object Management Group. **Business Process Model and Notation (BPMN) 2.0.2**.  
   https://www.omg.org/spec/BPMN/2.0.2/About-BPMN

3. Temporal Technologies. **Temporal Platform Documentation — Activity Definition / durable execution / retries / idempotency**.  
   https://docs.temporal.io/activity-definition  
   https://docs.temporal.io/glossary

4. Rao, A. S. & Georgeff, M. P. **BDI Agents: From Theory to Practice** (1995); Georgeff et al. **The Belief-Desire-Intention Model of Agency** (1998).  
   https://www.cs.ox.ac.uk/people/michael.wooldridge/pubs/atal98b.pdf

5. Singh, M. P. **An Ontology for Commitments in Multiagent Systems: Toward a Unification of Normative Concepts**. Artificial Intelligence and Law 7, 97–113 (1999).

6. Boella, G.; van der Torre, L.; Verhagen, H. and related normative multi-agent literature. Norms/obligations/permissions/prohibitions as first-class coordination concepts.

7. Broersen, J.; Dignum, F.; Dignum, V.; Meyer, J.-J. **Designing a Deontic Logic of Deadlines** (DEON 2004).  
   https://doi.org/10.1007/978-3-540-25927-5_5

8. van der Aalst, W. M. P. **Verification of Workflow Task Structures: A Petri-net-based Approach** and related workflow-net research on soundness, reachability, and workflow verification.  
   https://www.vdaalst.com/publications/p100.pdf

9. Cai, Y. et al. **Push Your Agent: Measuring and Enforcing Quantitative Goal Persistence in Long-Horizon LLM Agents** (2026). Reports verifier-backed progress-state interventions, duplicate elimination in matched controllers, and improved completion in tested settings.  
   https://arxiv.org/abs/2605.23574

10. Lodha, A. et al. **Less Context, Better Agents: Efficient Context Engineering for Long-Horizon Tool-Using LLM Agents** (2026). Reports better completion with selective context pruning/summarization and substantially lower token/runtime use than full-history context in its enterprise benchmark.  
    https://arxiv.org/abs/2606.10209

11. Qiu, J. et al. **LoCoBench-Agent: An Interactive Benchmark for LLM Agents in Long-Context Software Engineering** (2025). Reports redundant operations, repeated reads/calls, and progress/context problems in long trajectories.  
    https://arxiv.org/abs/2511.13998

12. Kim, S. et al. **On Training Large Language Models for Long-Horizon Tasks: An Empirical Study of Horizon Length** (2026). Finds horizon length itself creates training difficulty and that horizon reduction can improve stability/generalization in controlled tasks.  
    https://arxiv.org/abs/2605.02572

13. Skalse, J. et al. **Defining and Characterizing Reward Hacking** (2022). Formal analysis of proxy-reward hacking.  
    https://arxiv.org/abs/2209.13085

14. Zhao, B. et al. **SpecBench: Measuring Reward Hacking in Long-Horizon Coding Agents** (2026). Evidence that passing visible checks does not guarantee intended system behavior in long-horizon coding tasks.  
    https://arxiv.org/abs/2605.21384

15. NIST IR 8428. **Digital Forensics and Incident Response (DFIR) Framework for Operational Technology** (2022), used for the alert-fatigue / false-positive tradeoff analogy.  
    https://nvlpubs.nist.gov/nistpubs/ir/2022/NIST.IR.8428.pdf

---

# Evidence labels used in this report

- **Established concept:** substantial prior literature/standards demonstrate the concept exists and is understood.
- **Demonstrated AI effect:** empirical LLM/agent evidence directly demonstrates a related mechanism.
- **Architectural inference:** conclusion logically suggested by multiple established mechanisms but not directly tested as one system.
- **Hypothesis:** economically or technically plausible claim requiring controlled experiment.

---

# Final research status

**Proceed to implementation experiment.**

The literature does not justify treating “obligations as LLM work queues” as already proven, but it does justify treating the hypothesis as substantially more than speculation. Most of the constituent mechanisms are established elsewhere, and several of the exact failure modes the architecture is intended to remove — duplicate work, progress loss, false completion, long-horizon degradation, and context accumulation — now have direct LLM-agent evidence.

The next marginal research dollar should therefore go to a controlled prototype rather than another broad literature review.
