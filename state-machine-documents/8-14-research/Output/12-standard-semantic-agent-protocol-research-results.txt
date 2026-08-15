# AI Research Mission 12 — A Standard Semantic Protocol for AI Agents

**Research report**  
**Date:** 2026-08-14  
**Method:** Primary protocol specifications, REST/hypermedia literature, FIPA agent-communication standards, planning literature, capability-security literature, official MCP documentation, and current LLM tool-use research.

---

# 1. Executive verdict

## Bottom line

The hypothesis is **plausible and partially supported by strong prior art**, but the best implementation is probably **not a raw generic protocol exposed directly to the model**.

The strongest design that emerges from the literature is:

```text
Semantic runtime / reference monitor
        |
        | stable internal semantic ABI
        |
        +--> inspect current semantic state
        +--> derive current capabilities
        +--> expose unresolved obligations
        +--> validate requested transitions
        +--> explain blocked actions
        +--> track uncertain effects
        |
        v
Dynamic agent projection
        |
        +--> only currently legal typed tools
        +--> compact state/context
        +--> lazy evidence/policy expansion
```

In other words:

> **Use a small semantic protocol internally, but expose dynamically generated typed capability tools to the model whenever doing so improves type safety and usability.**

This is stronger than either extreme:

### Static bespoke tools

```text
refund_payment
capture_payment
ship_order
cancel_order
reopen_claim
...
```

These create a large, mostly static action vocabulary and often expose operations that are irrelevant or illegal in the current state.

### Raw generic protocol

```text
request_transition(
    subject="P42",
    transition="TRANS-PAYMENT-REFUND",
    inputs={...}
)
```

This reduces the number of tool names but can become stringly typed, harder to debug, and more prone to parameter/runtime mistakes.

### Recommended hybrid

The runtime internally represents:

```text
CapabilityInstance {
    semanticId
    subject
    inputSchema
    stateVersion
    policyVersion
    authority
}
```

and projects only current capabilities as agent tools:

```text
refund_payment_P42(amount, reason)
```

or a structured equivalent.

The agent therefore gets:

- small action frontier;
- typed inputs;
- current legality;
- less schema context;
- no need to know implementation details.

The semantic ABI remains stable beneath the projection.

## Strongest conceptual prior art

The closest historical analogue is **HATEOAS / hypermedia affordances**.

REST's hypermedia constraint says the server should communicate available next interactions dynamically through representations rather than requiring clients to hard-code the entire application interaction graph.

That is extremely close to:

```text
get_capabilities(subject)
```

The important difference is that the proposed system strengthens ordinary hypermedia by incorporating:

- actor-specific authority;
- semantic state versions;
- evidence;
- obligations;
- policy;
- effect uncertainty;
- planning prerequisites;
- deterministic transition validation.

Current 2026 IETF work explicitly applies HATEOAS-style in-band capability discovery to LLM agents operating constrained RESTful environments, making this more than a historical analogy.

## Relationship to MCP

MCP is complementary rather than competitive.

MCP standardizes:

- protocol connectivity;
- tools;
- resources;
- prompts;
- authorization infrastructure;
- tasks/extensions in newer specifications.

It does **not** standardize:

- domain state semantics;
- currently legal transitions;
- obligations;
- satisfaction criteria;
- policy/evidence semantics;
- effect uncertainty;
- legal path planning.

Therefore the clean layering is:

```text
MCP
    = transport/tool interoperability layer

Semantic Agent Protocol
    = authoritative domain-control layer
```

The semantic protocol could itself be exposed through MCP.

## Overall verdict

A small semantic interaction grammar can probably generalize across domains **at the level of interaction structure**, not domain vocabulary.

The protocol should standardize:

```text
how to inspect
how to discover legal action
how to discover unresolved work
how to request consequential change
```

It should **not** standardize:

```text
what "Refund", "Diagnosis", "Deployment", or "Shipment" universally mean
```

That boundary is essential.

---

# 2. Minimal semantic protocol definition

The research prompt proposes many operations:

```text
get_state
get_capabilities
get_obligations
explain_blocked
find_paths
request_transition
get_evidence
get_policy_context
observe_effect
reconcile_effect
```

That is probably too large for the core.

A better v0-level decomposition is:

## Core read operation

```text
inspect(subject, fields?)
```

Returns an authorized projection of:

- current semantic state;
- current state version;
- current capabilities;
- unresolved obligations;
- optionally relevant claims.

## Core write operation

```text
request_transition(
    subject,
    capability,
    inputs,
    expectedStateVersion,
    semanticOperationId?
)
```

## Core work-discovery operation

```text
get_obligations(scope, filters?)
```

This is needed because work queues may cross subjects.

## Optional explanation operation

```text
explain(actionOrGoal, subject)
```

Could cover:

- why unavailable;
- missing prerequisites;
- relevant producer transitions;
- redacted policy explanation.

Everything else can initially be represented as:

- fields within inspection;
- transition results;
- optional extensions.

### Recommended minimal v0.1

```text
inspect
get_obligations
request_transition
explain
```

The absolute minimum could be:

```text
inspect
act
```

but that is probably too opaque for diagnostics and distributed work discovery.

---

# 3. Tool API vs semantic protocol

The central distinction is not simply:

```text
many tools vs few tools
```

It is:

```text
static application-specific action inventory
```

versus:

```text
stable interaction grammar + dynamically derived legal action frontier
```

## Static tool API

The model sees:

```text
refund_payment
capture_payment
void_payment
ship_order
cancel_order
approve_order
reopen_claim
...
```

Tool descriptions must explain:

- when each action is valid;
- what prerequisites exist;
- what should not be retried;
- which actor may use it.

The model must reason over legality.

## Semantic protocol

The system computes legality.

The model asks:

```text
inspect(Order123)
```

and receives:

```text
State:
    Approved

Capabilities:
    CapturePayment

Obligations:
    none
```

The action space has already been filtered.

This is conceptually closer to **action masking** than ordinary tool routing.

Current tool-use research supports the idea that pruning the available tool set improves reliability, especially for smaller models.

A 2026 ACL Findings paper on dynamic tool-dependency retrieval reported that hard masking of the available tools achieved the strongest accuracy for smaller models in evaluated settings.

---

# 4. MCP comparison

## What MCP standardizes

The official Model Context Protocol specification defines a standardized mechanism by which LLM applications interact with external context and capabilities.

MCP servers can expose:

- tools;
- resources;
- prompts.

Tools are named and include metadata describing input schemas.

The 2026-07-28 MCP specification further evolves the protocol around a stateless core, extensions, tasks, authorization, and broader production scalability.

## What MCP does not standardize

MCP itself does not define a universal domain model for:

```text
state
legal transitions
capabilities
obligations
evidence
policy
effect uncertainty
semantic versions
```

An MCP server may choose to expose those concepts, but the meanings are application-defined.

Therefore:

> **MCP solves connection and tool interoperability. It does not solve authoritative semantic interoperability.**

## Recommended relationship

Expose the semantic protocol through MCP.

For example an MCP server might expose:

```text
semantic.inspect
semantic.get_obligations
semantic.request_transition
semantic.explain
```

or dynamically expose current capability tools backed by those operations.

This avoids inventing a redundant transport ecosystem.

---

# 5. HATEOAS / hypermedia comparison

This is the most important prior-art comparison.

Roy Fielding's REST architecture treats hypermedia as the engine of application state.

The server's representation contains controls that tell the client what interactions are available next.

A client therefore does not need to possess a hard-coded complete navigation graph.

Conceptually:

```text
resource representation
    ->
available hypermedia controls
```

maps closely to:

```text
semantic subject
    ->
available capabilities
```

## Example

A conventional hypermedia response might expose:

```text
capture-payment
cancel-order
```

but omit:

```text
ship-order
```

when shipping is not currently allowed.

That is almost exactly:

```text
get_capabilities(Order123)
```

## Incremental value of semantic capability model

The proposed system goes further by asserting that capabilities are not merely navigation affordances.

They can be:

- actor scoped;
- state-version bound;
- policy-version bound;
- evidence dependent;
- authority dependent;
- revocable;
- auditable;
- possibly represented by unforgeable tokens.

Thus ordinary HATEOAS answers:

```text
what interactions does this representation advertise?
```

The proposed system answers:

```text
what consequential actions is this authenticated actor currently authorized and semantically allowed to request against this exact authoritative state?
```

That is a stronger claim.

---

# 6. Affordance comparison

Affordance theory broadly concerns actions made possible by an environment.

For AI-agent architecture, a useful distinction is:

## Affordance

```text
action structurally possible from current state
```

Example:

```text
Order is Captured
=> Ship is a possible state transition
```

## Capability

```text
action currently permitted for this actor under state, authority, policy, and evidence
```

Example:

```text
Ship structurally possible
but autonomous support agent lacks shipping authority
```

Therefore:

```text
Affordance = state-conditioned possibility
Capability = authorized semantic action
```

The protocol should probably retain the term **capability** for its stronger security meaning.

---

# 7. FIPA / KQML comparison

Historical multi-agent systems attempted standardized communication grammars.

FIPA ACL defines communicative acts such as:

- request;
- inform;
- agree;
- refuse;
- propose.

FIPA's specifications draw from speech-act theory and define formal semantics for communicative acts.

KQML similarly attempted a standard interaction language around agent messaging.

## Lesson

These systems standardized:

```text
what kind of communicative act is being performed
```

but still needed:

- shared content languages;
- ontologies;
- domain interpretation.

That reveals a key risk for the proposed protocol:

> A generic interaction verb does not eliminate the ontology/domain problem.

For example:

```text
request_transition
```

can be standardized.

But:

```text
RefundPayment
```

remains domain-specific.

That is acceptable if the protocol explicitly standardizes only the **grammar**, not universal domain meaning.

## Important lesson from ACL systems

Do not attempt to standardize a rich universal semantic language for all business domains.

That path becomes an ontology/governance problem.

---

# 8. BDI comparison

Belief-Desire-Intention architectures provide another close conceptual mapping.

Possible correspondence:

```text
Beliefs
    ~ verified semantic state / evidence

Desires / Goals
    ~ obligations or desired goal conditions

Intentions
    ~ chosen plans

Actions
    ~ capabilities / transitions
```

But the proposed system is intentionally narrower.

BDI usually models internal agent cognition.

The proposed semantic protocol models **authoritative environment semantics**.

This is an important distinction:

```text
agent believes X
```

does not mean:

```text
authoritative system state = X
```

The protocol should expose external truth and legal action boundaries, leaving agent reasoning internal.

---

# 9. STRIPS / PDDL / planner comparison

PDDL separates:

- domain actions;
- predicates;
- preconditions;
- effects;

from:

- current problem state;
- goal.

This strongly resembles:

```text
semantic state
transitions
requirements
goal / obligation
```

PDDL was explicitly developed as a standard representation for planning domains and competition/interchange.

## What PDDL provides conceptually

An action:

```text
CapturePayment
```

has:

```text
preconditions
effects
```

A planner can search for a sequence from current state to goal.

## What commercial semantic systems additionally require

PDDL-style planning does not by itself capture all of:

- authority;
- evidence provenance;
- policy version;
- state version;
- optimistic concurrency;
- external-effect uncertainty;
- irreversible effects;
- obligations;
- privacy/scoped disclosure;
- audit provenance.

Therefore the proposed architecture can be viewed as:

> **an operational planning interface hardened for authoritative enterprise systems.**

---

# 10. Workflow-engine comparison

Workflow engines often expose:

```text
current step
next legal step
task queue
workflow state
```

This looks extremely similar.

The distinction depends on whether the semantic model is tied to one procedural workflow.

## Workflow step

Usually means:

```text
this procedure currently expects action X
```

## Semantic capability

Means:

```text
given authoritative state, action X is currently legal
```

## Obligation

Means:

```text
this unresolved semantic condition must be dispositioned
```

An obligation may survive replacement of the workflow procedure.

Therefore the semantic protocol is broader than one workflow instance.

But if a system is already completely modeled through a workflow engine, much of the benefit may already exist.

This is a genuine falsification boundary.

---

# 11. Capability-security comparison

Capability-security systems provide strong prior art for the idea that authority can be represented by possession of an unforgeable reference/token granting specific rights.

The crucial security principle is:

> Hiding unavailable actions is not security.

A client can fabricate:

```text
transitionId = RefundPayment
```

unless runtime enforcement rejects it.

Therefore a capability instance should be server-authoritative.

Possible representation:

```text
CapabilityInstance {
    id: opaque or signed
    type: CAP-PAYMENT-REFUND
    subject: Payment42
    actor: Agent17
    stateVersion: 18
    policyVersion: 7
    expiresAt: ...
}
```

The server validates it at execution.

This is much closer to actual capability security than simply listing tool names.

---

# 12. CQRS / command-query comparison

The proposed protocol naturally divides into queries and commands.

## Query side

```text
inspect
get_obligations
explain
```

These observe without committing consequential change.

## Command side

```text
request_transition
```

This is analogous to CQRS's command/query separation.

The separation is useful because it reinforces:

```text
probabilistic observation/planning
```

versus:

```text
deterministically validated commitment
```

The agent may explore freely through read-side operations while all authoritative mutation goes through one commitment boundary.

---

# 13. Generic transition vs typed tool comparison

This is one of the most important unresolved design choices.

## Generic

```text
request_transition(
    subject="P42",
    transition="TRANS-PAYMENT-REFUND",
    inputs={"amount": 50}
)
```

### Advantages

- tiny fixed protocol;
- easy cross-domain reuse;
- stable operation vocabulary;
- runtime implementation simple.

### Disadvantages

- stringly typed semantic IDs;
- parameter errors occur later;
- harder model discoverability;
- schema lookup required;
- poorer debugging.

## Typed domain tool

```text
refund_payment(
    payment_id="P42",
    amount=50
)
```

### Advantages

- better parameter schema;
- natural tool description;
- strong model/tool affordance;
- easier debugging.

### Disadvantages

- large static tool inventory;
- potentially high schema token cost;
- may expose illegal tools.

## Best solution

Generate typed tools dynamically from current semantic capabilities.

The backend still uses a generic semantic transition ABI.

This separates:

```text
agent ergonomics
```

from:

```text
runtime semantic standardization
```

---

# 14. Raw protocol vs dynamic typed-tool projection

Recommended architecture:

```text
Agent
    |
    | sees only:
    v
Dynamic typed capability tools
    |
    v
Semantic adapter
    |
    v
Stable semantic ABI
    |
    v
Authoritative runtime
```

Example internal capability:

```text
CAP-PAYMENT-REFUND
```

becomes temporary agent tool:

```text
refund_payment(
    amount: Money,
    reason: RefundReason
)
```

When state changes and refund becomes illegal, that tool disappears.

This provides:

- state-conditioned action masking;
- typed schema;
- semantic stability;
- reduced tool frontier.

Recent tool-use research strongly supports dynamic tool narrowing.

HyperAgent models tool dependencies as a schema graph and dynamically constructs state-conditioned support graphs. It reports improved task completion while reducing redundant calls, LLM interactions, and token usage on AppWorld.

SING similarly demonstrates large reductions in exposed tool schema through active tool discovery.

These are not identical to semantic legality filtering, but they validate the economics of not exposing every tool all the time.

---

# 15. State-inspection model

`inspect(subject)` should not return the raw application object.

Recommended compact response:

```text
subject:
    id
    semanticType

version:
    stateVersion
    semanticSpecVersion
    policyVersion

state:
    relevant state families / current cases

capabilities:
    current capability instances

obligations:
    unresolved obligations

claims:
    optional relevant verified claims
```

## Principle

Return:

```text
minimum sufficient semantic view
```

not:

```text
everything known about object
```

This is important for:

- token cost;
- privacy;
- security;
- agent reasoning.

---

# 16. Capability model

Distinguish:

## Capability type

```text
RefundPayment
```

Static semantic definition.

## Capability instance

```text
RefundPayment
for Payment P42
for actor Agent17
against StateVersion 18
under PolicyVersion 7
```

The protocol must expose instances.

Suggested compact shape:

```text
Capability {
    token
    semanticId
    label
    inputSchemaRef
    consequenceClass
    expiresAt?
}
```

Schemas should be lazy-loadable where possible.

---

# 17. Obligation model

Obligations provide agent work discovery.

Suggested representation:

```text
Obligation {
    id
    semanticType
    subject
    reasonCode
    satisfactionCondition
    priority/urgency
    deadline?
    availableCapabilities
    blockedBy?
}
```

The protocol should avoid:

```text
agent manually marks obligation done
```

where semantic state can resolve it automatically.

The preferred flow is:

```text
agent performs transitions
    ->
semantic state changes
    ->
satisfaction condition becomes true
    ->
obligation resolves automatically
```

---

# 18. Block-explanation model

A useful structured result:

```text
BlockedAction {
    action
    subject

    missing:
        PaymentState = Captured

    producerCapabilities:
        CapturePayment

    otherConstraints:
        FraudEvidenceExpired

    disclosure:
        scoped/redacted
}
```

The agent can plan without loading entire policy source.

## Security caveat

Explanations can leak sensitive policy.

For example:

```text
blocked because fraud score >= 82
```

might expose fraud-defense thresholds.

Therefore explanations require authorization/redaction policy.

---

# 19. Planning / path model

`find_paths(goal)` is plausible but should **not** be core v0.1.

Why?

Planning may involve:

- optimization;
- preferences;
- uncertainty;
- cross-service state;
- human judgment.

If the semantic runtime already has transitions and prerequisites, deterministic path search can be useful.

But making it core risks turning the protocol into a planner platform.

Better initial design:

```text
inspect + explain
```

can expose:

- missing conditions;
- producer capabilities.

A separate planner service can be added later.

---

# 20. Transition-request model

Recommended internal ABI:

```text
request_transition {
    subject
    capabilityToken
    transitionSemanticId
    inputs
    expectedStateVersion
    semanticOperationId?
}
```

Runtime revalidates:

- actor identity;
- capability validity;
- current state;
- state version;
- policy;
- authority;
- evidence;
- freshness;
- concurrency;
- external-effect policy.

The capability token is not sufficient by itself if runtime state changed.

---

# 21. Effect/outcome model

Transition results should not use generic success/error alone.

Possible result family:

```text
Completed
Rejected
Conflict
Pending
OutcomeUnknown
```

For consequential effects:

```text
OutcomeUnknown
```

should trigger reconciliation semantics rather than ordinary retry.

The protocol may represent effect observation through:

```text
inspect(effectId)
```

rather than a dedicated `observe_effect` operation.

This suggests `observe_effect` is redundant in the minimum protocol.

Likewise, reconciliation may simply be another capability/transition:

```text
ReconcileRefundOutcome
```

rather than a universal `reconcile_effect` operation.

Thus:

> **`reconcile_effect` is one of the most redundant proposed core operations.**

Reconciliation is domain-specific semantic work and can usually be represented as capability + obligation.

---

# 22. Evidence / policy model

Evidence should be retrieved lazily.

`inspect` might expose:

```text
Claim:
    FraudVerified
    evidenceRef = E22
```

The agent requests evidence detail only when needed.

Policy should similarly expose:

```text
policyVersion
reasonCode
compact explanation
```

not necessarily the entire policy language.

Dedicated:

```text
get_evidence
get_policy_context
```

can be optional extension calls or resource retrieval.

---

# 23. Versioning / concurrency model

Stateful agent interactions require explicit concurrency handling.

Inspection response:

```text
stateVersion = 18
semanticSpecVersion = 12
policyVersion = 7
```

Transition request binds to:

```text
expectedStateVersion = 18
```

If state is now 19:

```text
StaleState {
    currentVersion = 19
    refreshRequired = true
}
```

The agent refreshes.

This prevents acting on stale reasoning.

Policy changes can similarly produce:

```text
PolicyChanged
```

rather than silently applying assumptions from the earlier plan.

---

# 24. Security model

Core requirements:

## Authenticated actor

The runtime, not the model, determines actor identity.

## Complete mediation

Every consequential mutation crosses the semantic transition boundary.

## Unforgeable or server-validated capability instances

Do not trust semantic IDs alone.

## Runtime revalidation

Never assume a capability remains valid because it was returned previously.

## Tool isolation

If the agent simultaneously has:

- SQL admin;
- shell;
- cloud console;

the semantic protocol can be bypassed.

Therefore infrastructure permissions must match protocol authority.

## Idempotent semantic operation identity

Retries must distinguish:

```text
same semantic operation
```

from:

```text
new consequential operation
```

---

# 25. Privacy / disclosure model

Read-side access must also be authorized.

An agent may not be entitled to inspect:

- full clinical evidence;
- fraud thresholds;
- internal HR policy;
- unrelated customer records.

Therefore `inspect` returns an actor-scoped projection.

## Partial observability

This creates a planning tradeoff.

The agent may know:

```text
Refund unavailable
```

but not all reasons.

The runtime can expose safe next actions without revealing sensitive rules.

This favors:

```text
capability projection
```

over:

```text
full policy disclosure
```

---

# 26. Cross-domain portability analysis

The interaction grammar appears portable across domains.

## Payments

```text
inspect payment
capabilities: refund
obligation: reconcile refund
```

## Deployment

```text
inspect release
capabilities: deploy staging
obligation: resolve failed verification
```

## Healthcare

```text
inspect case
capabilities: request review
obligation: resolve missing evidence
```

## Compliance

```text
inspect control
capabilities: submit evidence
obligation: remediate deficiency
```

## Travel

```text
inspect booking
capabilities: rebook
obligation: obtain traveler approval
```

The domain vocabulary remains different.

The grammar remains similar:

```text
what is true?
what may I do?
what must be resolved?
what is blocking the desired action?
request legal change
```

That is the strongest argument for generalization.

---

# 27. Token / context analysis

Large static tool catalogs can consume significant context.

Current research increasingly investigates:

- tool retrieval;
- lazy schema loading;
- schema graph planning;
- hard masking.

HyperAgent reports lower redundant API calls, LLM interactions, and token usage through structured tool dependency reasoning.

SING reports dramatically reducing full-corpus schema exposure while improving retrieval and downstream success.

A separate 2026 Tool Attention paper reports large simulated schema-token reductions through dynamic gating and lazy schema loading, though several end-to-end benefits in that paper are projections rather than directly measured live-agent results. This limitation matters.

## Semantic protocol mechanism

Static:

```text
protocol grammar
semantic schema
```

can be cached.

Dynamic per-task context becomes:

```text
state
3 capabilities
2 obligations
```

rather than:

```text
100 tool schemas
```

This is a plausible form of context compression.

---

# 28. Caching / cold-start analysis

## Cold start

The agent must learn:

- protocol grammar;
- semantic state vocabulary;
- relevant transition schemas.

This cost may be comparable to loading some bespoke tools.

## Warm start

Protocol grammar is unchanged.

Static semantic schema can be cached.

Only dynamic frontier changes.

This is where the strongest economic advantage should appear.

A fair benchmark must therefore measure separately:

```text
cold-start context cost
warm-task context cost
```

If only first-task cost is measured, benefits may be underestimated.

If schemas must be rediscovered constantly, benefits may disappear.

---

# 29. Smaller-model hypothesis

The hypothesis is plausible:

```text
smaller model + tiny legal frontier
```

may compete with:

```text
larger model + large arbitrary tool catalog
```

The 2026 dynamic tool-dependency work supports this direction: hard masking performed particularly well for smaller models.

But domain reasoning still matters.

A smaller model may know:

```text
CapturePayment is available
```

without understanding whether doing so satisfies the user's intent.

Therefore capability restriction reduces action-selection complexity but does not eliminate goal understanding.

Evidence level:

**Moderate for action selection; weak for full cross-domain autonomy.**

---

# 30. Multi-agent implications

A shared semantic protocol can become a coordination layer.

Different agents can inspect:

- same authoritative state;
- same obligation set;
- actor-specific capabilities.

This reduces disagreements caused by private reconstructed state.

Potential work-queue extensions:

```text
claim_obligation
release_claim
```

But those should probably belong to an orchestration profile rather than the minimal semantic core.

Semantic obligation identity is still useful because agents coordinate over unresolved outcomes rather than arbitrary task strings.

---

# 31. Federated-system implications

Federation is a major complexity boundary.

Suppose:

```text
Order service
Payment service
Shipping service
```

each exposes a semantic runtime.

A global goal:

```text
Order ready to ship
```

may require transitions across all three.

Options:

## Central semantic router

Aggregates state and capabilities.

Advantages:

- simple agent view.

Risks:

- centralized authority;
- security coupling;
- synchronization complexity.

## Module-local protocols

Agent or planner composes across runtimes.

Advantages:

- preserves ownership boundaries.

Risks:

- more calls;
- harder planning;
- version coordination.

Recommended starting point:

> Keep semantic authority module-local. Add federation only after a real cross-runtime requirement exists.

---

# 32. Runtime vs development profiles

A useful separation:

## Runtime profile

```text
inspect
get_obligations
request_transition
explain
```

## Development profile

Possible operations:

```text
semantic_diff
impact_report
validate_migration
get_dependencies
```

Coding agents benefit from the development profile.

Operational agents should not need repository or compiler information.

This keeps the runtime protocol small.

---

# 33. Protocol versioning strategy

Two versions must remain distinct:

```text
protocolVersion
semanticSpecVersion
```

The protocol grammar may remain stable while domain semantics evolve rapidly.

Example:

```text
protocolVersion = 0.1
semanticSpecVersion = payments/42
```

Client caches semantic schemas keyed by:

```text
semanticSpecVersion
```

State responses carry version.

When version changes:

```text
cached schema invalidated
```

Transition IDs should use stable semantic identifiers and explicit deprecation/migration maps where needed.

---

# 34. Minimal v0.1 recommendation

## Operation 1

```text
inspect(subject, fields?)
```

Default response:

- state summary;
- version;
- current capabilities;
- subject obligations.

## Operation 2

```text
get_obligations(scope, filters?)
```

Needed for work discovery independent of a known subject.

## Operation 3

```text
request_transition(capabilityToken, inputs, expectedStateVersion, operationId?)
```

Primary commitment boundary.

## Operation 4

```text
explain(subject, actionOrGoal)
```

Optional but high-value diagnostic/planning primitive.

### Do not initially include

- `find_paths`
- `get_policy_context`
- `get_evidence`
- `observe_effect`
- `reconcile_effect`
- obligation progress APIs.

These can be represented by lazy resources, capabilities, or later profiles.

---

# 35. Counterarguments

## 1. "MCP + normal tools already solves this."

MCP solves interoperability but leaves domain legality application-specific.

It is necessary infrastructure, not equivalent semantics.

## 2. "This is just HATEOAS."

HATEOAS is the closest ancestor.

The proposed design adds:

- actor authority;
- capability security;
- obligations;
- versioning;
- evidence;
- effects;
- explicit semantic compiler/runtime.

The correct conclusion is not to deny the lineage but to build on it.

## 3. "Generic transition calls are less type safe."

Correct.

This is why raw generic calls should be internal ABI, not necessarily the model-facing tool layer.

## 4. "Discovery adds calls."

Correct.

Batch inspection and lazy schema caching are needed.

## 5. "Natural-language tools are already good enough."

For small toolsets, probably.

The value proposition grows with tool count, dynamic legality, and consequence.

## 6. "Bespoke APIs are easier to debug."

Often true for humans.

Generated typed projections retain that benefit.

## 7. "Universal protocols become lowest-common-denominator abstractions."

Avoid universal domain vocabulary.

Standardize grammar only.

## 8. "Domain semantics cannot be standardized."

Agreed.

They should not be.

## 9. "Generic IDs become stringly typed."

Use schemas, stable IDs, and dynamic typed projections.

## 10. "Planning should remain agent-side."

Often yes.

`find_paths` should not be core initially.

## 11. "`find_paths` may hide bad semantics."

Correct.

Keep planner optional and inspectable.

## 12. "Capability tokens complicate development."

They do, but high-consequence operations may justify them.

Local development SDKs can hide token mechanics.

## 13. "Cross-service semantics explode complexity."

Correct.

Keep authority local initially.

## 14. "Blocked explanations leak secrets."

Correct.

Explanations must be scoped/redacted.

## 15. "Standardization is premature."

Strongly agree.

This should begin as internal ABI.

## 16. "Dynamic typed tools solve most of it."

This may be true—and supports the hybrid architecture.

Dynamic tools still require a semantic source for legality and schema generation.

## 17. "Workflow engines already expose next steps."

In fully workflow-modeled domains, much of the value may already exist.

The semantic protocol is most useful where authoritative state exceeds one workflow.

## 18. "BDI/planners already expose similar structures."

Conceptually yes.

The contribution is operational hardening around authority, evidence, policy, concurrency, and effects.

## 19. "Tool schema cost may be negligible with caching."

Possible.

Must be measured in target platform.

## 20. "Smaller models still need domain knowledge."

Correct.

The protocol reduces action/legal inference, not business comprehension.

---

# 36. Proposed experiments

## Experiment A — 100 actions, 3 legal

Compare:

A. 100 static typed tools  
B. raw semantic protocol  
C. semantic ABI + 3 dynamic typed tools

Measure:

- success;
- illegal attempts;
- token cost;
- schema exposure;
- tool-selection errors.

## Experiment B — new-domain cold start

Give agent unfamiliar domain.

Compare bespoke tools vs semantic protocol.

Measure:

- first-task success;
- prompt additions;
- schema/tool calls;
- tokens.

## Experiment C — cross-domain transfer

Use same agent on payments first, then deployment.

Test whether protocol familiarity improves second-domain adaptation.

## Experiment D — blocked action

Goal:

```text
Ship order
```

but payment not captured.

Compare:

- generic tool failure;
- specialized error;
- structured explain response.

## Experiment E — stale state

Agent inspects v18.

State changes to v19.

Attempt transition.

Measure stale-action recovery.

## Experiment F — OutcomeUnknown

Refund effect becomes uncertain.

Protocol should:

- remove new-refund capability;
- expose reconciliation obligation/capability.

Measure duplicate effects.

## Experiment G — work discovery

Prompt:

```text
Handle outstanding work.
```

Compare search over many tools vs `get_obligations`.

## Experiment H — forged capability

Agent manually supplies an unavailable transition ID.

Runtime must reject.

## Experiment I — generic vs typed parameters

Compare parameter error rate for:

```text
request_transition(...)
```

against generated typed tool.

## Experiment J — caching

Measure cold and warm token/tool cost separately.

---

# 37. Metrics

## Tokens per Correct Completion

## Tool Calls per Correct Completion

## Model Calls per Correct Completion

## Cost per Correct Completion

## Illegal Transition Request Rate

```text
illegal transition requests
---------------------------
total transition attempts
```

## Stale Capability Attempt Rate

## Parameter Error Rate

## Obligation Resolution Rate

## Average Legal Frontier Size

## Tool Schema Exposure Tokens

## Cold-Start Context Cost

## Warm-Task Context Cost

## Protocol Reuse Ratio

Possible definition:

```text
shared protocol instructions
----------------------------
total operational instructions
```

## Cross-Domain Adaptation Cost

Prompt/tool/schema additions needed for new application.

## Round-Trip Latency

Protocol savings must not hide latency increases.

---

# 38. Economic model

Conventional tool architecture:

```text
Cost =
    static schema context
  + tool-selection reasoning
  + illegal action attempts
  + per-app prompt engineering
  + integration maintenance
  + drift repair
```

Semantic ABI:

```text
Cost =
    semantic runtime implementation
  + capability derivation
  + inspection calls
  + schema discovery
  + protocol infrastructure
  + dynamic tool projection
```

Potential savings compound when:

- many applications use same grammar;
- action sets are large;
- legal frontier is small;
- semantic schema is cacheable;
- agents work repeatedly over same runtime;
- consequences of invalid action are high.

The largest economic opportunity is not necessarily raw token reduction.

It is:

> **reusing one agent interaction model across many systems while pushing legality and work discovery into deterministic software.**

---

# 39. What is already established prior art

## Strongly established

- REST/HATEOAS supports dynamic server-provided next interactions.
- Planning languages separate state, preconditions, actions, effects, and goals.
- Workflow engines expose procedural current/next work.
- Capability systems represent authority through protected/unforgeable references or tokens.
- FIPA ACL standardizes generic agent communicative acts independent of domain payload.
- MCP standardizes LLM/tool/context interoperability.
- Dynamic tool retrieval/masking can reduce the number of tools exposed to LLMs and improve some tool-use outcomes.
- State/version concurrency controls are standard distributed-system practice.

## Important 2026 evidence

An IETF Internet-Draft on agentic operation of constrained RESTful environments explicitly applies HATEOAS to LLM-based agents so they can discover device capabilities in-band without prior device-specific knowledge.

This is extremely close prior art for the core discovery concept, although it is focused on REST/IoT and remains an Internet-Draft rather than a final standard.

---

# 40. What appears genuinely useful/new

The novelty is not:

```text
servers should advertise actions
```

HATEOAS already established that.

Nor:

```text
agents should use generic communication verbs
```

FIPA/KQML already explored that.

Nor:

```text
planning actions have preconditions/effects
```

STRIPS/PDDL already established that.

The potentially distinctive synthesis is:

```text
authoritative state
+
actor-scoped legal capabilities
+
unresolved obligations
+
evidence/policy/version context
+
uncertain external effects
+
generic transition commitment
```

presented specifically as an **AI-agent operating interface**.

Especially useful is the combination:

```text
HATEOAS-style dynamic affordance discovery
+
capability security
+
deontic obligations
+
planner-compatible state/transition metadata
+
runtime reference-monitor enforcement
```

That combination appears meaningfully useful even though its components have deep prior art.

---

# 41. Public standard or internal ABI?

## Recommendation

**Internal semantic ABI first.**

Do not attempt a public standard yet.

Reasons:

1. the minimal operation set is not experimentally validated;
2. raw generic vs dynamic typed tools is unresolved;
3. federation semantics are immature;
4. obligation/effect representations need testing;
5. premature standardization risks locking in weak abstractions;
6. existing MCP transport can carry the protocol without a new ecosystem.

The correct evolution path is:

```text
internal ABI
    ->
multiple internal domains
    ->
cross-domain benchmark
    ->
external adapters
    ->
only then consider public specification
```

If the architecture proves itself, the public standardization target would likely be the **semantic ABI**, not the internal DSL or compiler implementation.

---

# 42. Architecture changes recommended

## 1. Reframe protocol as semantic ABI

Not universal public API.

## 2. Use MCP as one transport option

Do not reinvent tool transport/discovery.

## 3. Make HATEOAS lineage explicit

Capability exposure is AI-oriented hypermedia with stronger authority semantics.

## 4. Separate affordance from capability

```text
affordance = possible
capability = currently authorized/legal
```

## 5. Prefer four-operation v0.1

```text
inspect
get_obligations
request_transition
explain
```

## 6. Make dynamic typed tools the default model-facing projection

Raw generic transition remains internal.

## 7. Keep schemas lazy

Load input details only for current/relevant capabilities.

## 8. Include explicit versioning

State, policy, semantic spec, and protocol.

## 9. Use server-authoritative capability instances

Do not trust IDs alone.

## 10. Treat reconciliation as a semantic capability

Do not add a universal `reconcile_effect` primitive yet.

## 11. Keep planning optional

Do not make `find_paths` core until measured.

## 12. Support compact authorized projections

For privacy and tokens.

## 13. Separate runtime and development profiles

Operational agents need smaller grammar.

## 14. Instrument protocol behavior

Measure:

- frontier size;
- illegal attempts;
- schema tokens;
- stale requests;
- obligation resolution.

## 15. Benchmark three architectures

Static tools vs raw protocol vs dynamic typed projections.

That comparison is essential.

---

# 43. Final verdict

## Can a small semantic interaction grammar generalize across domains?

**Moderate evidence**

Strong prior art supports generic interaction structures across domains, especially HATEOAS, planning languages, workflow systems, and agent communication protocols. Direct LLM evidence for the complete proposed grammar remains limited.

## Does it reduce application-specific tool complexity?

**Moderate**

It clearly reduces static tool-name/schema count at the protocol layer, but domain-specific transition schemas remain.

Dynamic typed projection is likely necessary to realize the benefit without sacrificing usability.

## Does it reduce agent context/token cost?

**Moderate**

Current dynamic tool-retrieval and schema-graph research supports the mechanism. Exact savings for the proposed semantic ABI remain unmeasured.

## Does it improve action correctness?

**Moderate-to-strong conceptually**

Dynamic legality filtering and runtime revalidation strongly reduce illegal action opportunities.

Current tool-masking work also supports smaller legal/relevant action sets.

## Does it enable model portability across applications?

**Plausible / Moderate**

The grammar is reusable, but domain vocabulary and goal interpretation remain application-specific.

Cross-domain transfer needs direct measurement.

## Is the closest prior art primarily?

**HATEOAS**, with major contributions from:

- planner interfaces;
- capability security;
- workflow systems;
- MCP;
- FIPA/agent communication languages.

## Best protocol architecture

**Dynamic typed tools over a semantic ABI**

not raw generic protocol.

## Minimum core operations

```text
inspect
get_obligations
request_transition
explain
```

Potential future reduction:

```text
inspect
act
```

but only if diagnostics/work discovery remain adequate.

## Most important operation

**inspect**

because it provides the compact current semantic frontier:

- what is true;
- what is legal;
- what remains unresolved.

Without a good inspection primitive, agents fall back to broad discovery.

## Most redundant proposed operation

**reconcile_effect**

Reconciliation should generally be represented as a domain capability/obligation rather than a universal protocol verb.

`observe_effect` may also be folded into inspection.

## Strongest existing analogue

**HATEOAS / hypermedia controls**

The current 2026 IETF work applying hypermedia capability discovery to LLM agents further strengthens this comparison.

## Most important lesson from HATEOAS

> **Dynamic discoverability is powerful only when clients and tooling actually benefit from it.**

Historically, many human developers preferred explicit/static client APIs and documentation.

AI agents may change that economic tradeoff because they can consume dynamic affordances directly—but this must be proven, not assumed.

## Most important lesson from agent communication languages

> **Standardize interaction grammar, not universal domain ontology.**

A protocol that tries to define the meaning of every business concept will repeat the ontology problem encountered by broad agent-communication systems.

## Most important security requirement

> **Runtime must reject forged, stale, unauthorized, or semantically illegal transition requests even if the agent manually supplies a valid-looking semantic ID.**

Capability hiding is not security.

## Biggest economic opportunity

**Cross-application reuse of the same agent operating grammar plus dramatic reduction of the dynamically exposed action frontier.**

If successful, the agent learns:

```text
inspect
understand capabilities
work obligations
request transitions
```

once.

Applications supply their domain semantics as data.

## Biggest abstraction risk

**The protocol merely moves complexity into dynamic schemas and IDs, creating more tool calls and runtime errors than typed bespoke APIs.**

This is why raw generic protocol must be benchmarked against dynamic typed projection.

## Best first experiment

Build one domain with approximately:

```text
50-100 possible semantic transitions
3-5 legal at any moment
```

Compare:

1. static bespoke typed tools;
2. raw generic semantic protocol;
3. semantic ABI + dynamically generated typed legal tools.

Measure:

- success rate;
- illegal attempts;
- parameter errors;
- tokens;
- tool calls;
- latency;
- schema context;
- cost per correct completion.

Then repeat the same agent design in a second unrelated domain to test portability.

## Should this initially be?

**Internal semantic ABI**

with a generated agent adapter.

Public standardization would be premature.

---

# Research synthesis

The core idea survives, but the research changes its framing.

The initial intuition is:

> Maybe agents should have a universal set of semantic tools.

The stronger architecture is:

> **Software should expose a universal pattern of semantic interaction, but the model-facing tool set should be dynamically compiled from the current legal frontier.**

This distinction resolves several tensions.

### Standardization vs type safety

Internal ABI is generic.

Agent tools can remain typed.

### Small protocol vs domain expressiveness

Protocol verbs are generic.

Domain transition schemas remain application-specific.

### HATEOAS vs capability security

The system advertises legal next actions like hypermedia.

But runtime capability instances add authority and version validation.

### Planner vs model reasoning

The runtime exposes preconditions and legal producer actions.

The agent can still perform preference/goal reasoning.

### MCP vs semantic control

MCP transports the interaction.

The semantic layer defines what the interaction means and what may legally happen.

The most useful mental model is therefore:

```text
MCP / HTTP / RPC
    =
transport/interoperability

Semantic ABI
    =
authoritative interaction grammar

Semantic compiler/runtime
    =
domain legality and state

Dynamic typed tools
    =
agent-facing projection
```

This is not a new replacement for MCP.

It is a layer above it.

And it is not a replacement for domain-specific APIs.

Humans and conventional applications can retain typed REST/GraphQL/SDK APIs.

The semantic ABI can exist specifically as the control plane for AI agents and other generic automation.

That may be the most important strategic conclusion from this research mission.

---

# Key sources

## Model Context Protocol

1. Model Context Protocol, **Specification**.  
   https://modelcontextprotocol.io/specification/2025-11-25

2. Model Context Protocol, **Tools specification**.  
   https://modelcontextprotocol.io/specification/2025-06-18/server/tools

3. Model Context Protocol Blog, **The 2026-07-28 Specification**.  
   https://blog.modelcontextprotocol.io/posts/2026-07-28/

4. Model Context Protocol, **Specification Enhancement Proposals**.  
   https://modelcontextprotocol.io/seps

## REST / HATEOAS

5. Roy T. Fielding, **Architectural Styles and the Design of Network-based Software Architectures**, doctoral dissertation, 2000.  
   https://www.ics.uci.edu/~fielding/pubs/dissertation/top.htm

6. IETF / IRTF T2TRG, **Guidance on RESTful Design for Internet of Things Systems**, 2026 draft material.  
   https://datatracker.ietf.org/doc/draft-irtf-t2trg-rest-iot/

7. IETF Internet-Draft, **Agentic AI Operation of Constrained RESTful Environments**, 2026.  
   https://datatracker.ietf.org/doc/html/draft-jimenez-t2trg-iot-agent-00

Important limitation: Internet-Drafts are works in progress and not final IETF standards.

## FIPA agent communication

8. FIPA, **Agent Communication Language Specifications**.  
   https://www.fipa.org/repository/aclspecs.html

9. FIPA, **Communicative Act Library Specification**.  
   https://www.fipa.org/specs/fipa00037/SC00037J.html

10. FIPA, **Interaction Protocol Library Specification**.  
    https://www.fipa.org/specs/fipa00025/XC00025E.pdf

## Planning

11. Fox & Long, **PDDL2.1: An Extension to PDDL for Expressing Temporal Planning Domains**, 2003.  
    Accessible through planning.wiki archive:  
    https://planning.wiki/_citedpapers/pddl212003.pdf

12. Planning Wiki, **What is PDDL?**  
    https://planning.wiki/guide/whatis/pddl

## Current LLM tool-use research

13. Zhai et al., **HyperAgent: Planning and Acting over Tool-Schema Hypergraphs for Tool-Use LLM Agents**, 2026.  
    https://arxiv.org/abs/2608.02650

14. Xiao et al., **SING: Synthetic Intention Graph for Scalable Active Tool Discovery in LLM Agents**, 2026.  
    https://arxiv.org/abs/2606.16591

15. Patel et al., **Dynamic Tool Dependency Retrieval for Lightweight LLM Agentic Systems**, Findings of ACL 2026.  
    https://aclanthology.org/2026.findings-acl.1680.pdf

16. Sadani & Kumar, **Tool Attention Is All You Need: Dynamic Tool Gating and Lazy Schema Loading for Eliminating the MCP/Tools Tax in Scalable Agentic Workflows**, 2026.  
    https://arxiv.org/abs/2604.21816

Important limitation: the Tool Attention paper directly measures schema-token reduction in its simulation but reports several end-to-end outcomes as projections rather than live-agent measurements. Those projections should not be treated as direct empirical proof.

## Capability security

17. Koppmann, **Utilizing Object Capabilities to Improve Web Application Security**, 2022.  
    https://www.acigjournal.com/Utilizing-Object-Capabilities-to-Improve-Web-Application-Security%2C184282%2C0%2C2.html

---

# Final research judgment

The research does not support immediately proposing a new public "AI semantic protocol" standard.

It does support building and experimentally testing a **small internal semantic ABI**.

The design should borrow explicitly from:

```text
HATEOAS
    for dynamic legal-action discovery

Capability security
    for actor-bound authority

PDDL / planning
    for state/precondition/effect structure

Workflow systems
    for durable work

FIPA
    for stable interaction grammar

MCP
    for modern AI transport/tool interoperability
```

The likely innovation is in their combination around one principle:

> **The authoritative software system, not the probabilistic model, should tell the agent what state is true, what actions are currently legal, what unresolved work exists, and whether a requested consequential transition may commit.**

The agent remains responsible for:

- understanding goals;
- choosing among legal alternatives;
- optimizing;
- communicating;
- gathering non-authoritative information.

The runtime remains responsible for:

- truth;
- legality;
- authority;
- versions;
- evidence;
- commitments.

That boundary is likely more important than whether the final wire operation is literally named `request_transition`.
