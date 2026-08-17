# Synthesis of AI Research Missions 01–12
## Smallest Defensible Architecture, Corrections, Novelty, and Experimental Program
Date: 2026-08-14

# Executive conclusion

The 12 research tracks do not support building a universal "state machine architecture," a new general-purpose modeling language, or an application framework intended to describe every part of a system.

They support a narrower and stronger thesis:

> Probabilistic agents should operate against a small executable semantic control layer for consequential state and effects, instead of repeatedly reconstructing legality, authority, unresolved work, evidence quality, and change impact from implementation artifacts.

The architecture should be built on top of excellent ordinary software architecture, not instead of it.

The strongest design that survives all twelve investigations is:

    ordinary modular software
        +
    small consequential semantic core
        +
    deterministic commitment boundary
        +
    dynamic agent affordance/capability projection
        +
    semantic dependency + migration checks
        +
    optional domain profiles for obligations, evidence, and effect uncertainty
        +
    independent correctness oracles

This is not primarily primitive novelty. Almost every individual mechanism has substantial prior art.

The potentially differentiated contribution is the composition:

    one authoritative semantic model
        simultaneously supports:
            runtime legality
            agent-visible legal actions
            unresolved work
            semantic change impact
            migration completeness
            policy/evidence gating
            effect-safety behavior
            compact agent context

The commercial/research hypothesis that remains unproven is economic:

> Can explicit semantic structure replace enough repeated probabilistic reconstruction that AI agents become materially cheaper per semantically correct completion?

That should now become the primary experimental question.

---

# Part I — What survived all 12 investigations

## 1. Probabilistic exploration, deterministic commitment

This is the strongest general principle.

The deterministic system should own:

- authoritative state mutation;
- legality;
- hard invariants;
- authority;
- version/freshness checks;
- policy conditions that are mechanically decidable;
- protected effect execution rules;
- capability validation;
- semantic migration completeness.

The AI should own or assist with:

- interpretation;
- search;
- recommendation;
- hypothesis generation;
- design alternatives;
- prioritization among legal choices;
- planning where deterministic planning is not economical;
- explanation;
- identifying possible defects in the semantic model itself.

The boundary is:

    model proposes / reasons
        ->
    deterministic commitment gate validates
        ->
    authoritative change occurs

The important claim is not that deterministic rules are always correct.

They are not.

The claim is that probabilistic reasoning should not acquire consequential authority merely by producing plausible output.

---

## 2. Excellent ordinary architecture remains the baseline

Good modularity already solves a great deal:

- information hiding;
- bounded contexts;
- aggregate ownership;
- ports/adapters;
- clean dependency direction;
- local invariants;
- strong types;
- architecture tests;
- static dependency graphs;
- repository retrieval;
- code indexing;
- well-defined APIs.

Therefore semantic architecture should never be compared with a weak CRUD monolith and called a victory.

The fair comparison is:

    excellent conventional modular architecture

versus:

    excellent conventional modular architecture
        +
    one semantic mechanism at a time

This changes the research program from:

    "Does semantic architecture beat normal software?"

to:

    "What marginal value remains after normal architecture and tooling have already done their job?"

That is a much stronger scientific question.

---

## 3. Semantic islands, not universal modeling

The architecture is most defensible around consequential state.

Examples:

- payments;
- approvals;
- identity;
- access/security;
- compliance;
- healthcare evidence;
- deployments;
- logistics;
- external commitments.

Likely low-value areas:

- rendering;
- styling;
- content;
- simple CRUD;
- pure transformations;
- routine formatting;
- ordinary calculations.

The architecture should therefore support semantic islands:

    ordinary application
        |
        +-- ordinary module
        +-- ordinary module
        +-- semantic island: Payment
        +-- semantic island: Identity
        +-- ordinary module

This sharply reduces tooling and adoption cost.

---

## 4. Consequential semantic identity

Stable semantic identity survived the research strongly.

A semantic ID distinguishes:

- rename;
- replacement;
- split;
- merge;
- deprecation.

Example:

    SC-APPROVED

A label changing from "Approved" to "Fully Approved" need not imply semantic replacement.

But:

    SC-APPROVED
        ->
    SC-CONDITIONAL-APPROVAL
    SC-FULL-APPROVAL

is a semantic split.

This matters because textual diffs and repository search cannot reliably distinguish vocabulary change from meaning change.

Stable semantic IDs should be first-class in the core.

---

## 5. Explicit legal transitions around consequential state

The research still supports declared transitions, but only where they matter.

Do not model every function call as a transition.

Use transitions for:

- authoritative domain state changes;
- protected external effects;
- high-consequence commitments.

A transition should have at minimum:

- semantic ID;
- subject/state family;
- source state or applicability predicate;
- target/effect;
- requirements/guards;
- version semantics;
- relevant dependencies.

The important rule is:

> authoritative consequential state should not be freely mutated outside the declared transition boundary.

---

## 6. Dynamic capabilities are one of the strongest AI-specific mechanisms

Normal APIs answer:

    What operations exist?

Capabilities answer:

    What can this actor legally do now?

That is a significant distinction.

Capability derivation may depend on:

- current state;
- actor authority;
- policy;
- evidence;
- freshness;
- versions;
- conflicting operations.

The strongest result from research is not "fewer tools are always better."

It is:

> Deterministic computation should decide which actions are admissible; probabilistic reasoning should choose among admissible actions.

This matches prior art in:

- safe/shielded RL;
- reference monitors;
- capability systems;
- planning preconditions;
- formal policy enforcement.

The economic advantage of PRE-filtering rather than merely rejecting illegal calls afterward remains unproven and should be tested directly.

---

## 7. Obligations survive, but as semantic requirements rather than tasks

The obligation concept became substantially better defined.

An obligation is not:

- a TODO;
- a job;
- a queue message;
- an agent instruction;
- a mutable "done" bit.

It is:

> a durable semantic assertion that the current world has an unresolved required condition under a particular policy/evidence context.

A task or plan is one attempt to satisfy it.

Therefore:

    obligation != task
    task failure != obligation failure
    task completion != proof of obligation satisfaction

An obligation should include:

- identity;
- subject;
- applicability/reason;
- provenance;
- policy/version;
- satisfaction/disposition criteria;
- allowed dispositions;
- possibly deadline/escalation information.

The research also supports separating:

Semantic obligation status:
    Active
    Blocked
    Satisfied
    Waived
    Superseded
    CancelledInvalid

from execution/lease status:
    Unclaimed
    Claimed
    InProgress
    AwaitingExternal
    AwaitingHuman

Overdue and escalation should generally be orthogonal properties/events.

---

## 8. Discovery plane + resolution plane

This is one of the strongest architectural additions produced by the research.

A pure obligation-driven agent can become dangerously myopic.

An empty queue does not prove the system is healthy.

Therefore separate:

DISCOVERY PLANE
    open-ended
    anomaly-oriented
    exploratory
    proposes:
        new evidence
        candidate obligations
        semantic conflicts
        possible model gaps

RESOLUTION PLANE
    bounded
    obligation-driven
    capability-constrained
    resolves authoritative work
    validates completion

This allows open-ended intelligence without giving open-ended reasoning direct authority over consequential state.

---

## 9. Epistemic modeling survives, but the original enum should be removed

The original:

    Unknown
    Reported
    Assumed
    Inferred
    Supported
    Verified
    Contradicted
    Invalidated

should NOT be one linear authoritative state machine.

Those categories mix dimensions:

- origin;
- derivation;
- support;
- contradiction;
- verification;
- evidence validity;
- information absence.

A better architecture is:

Claim
    stable proposition identity

Evidence
    source/provenance
    observed time
    scope
    support/opposition relation
    validity

Derivation
    reported / inferred / model-generated / imported / etc.

VerificationRecord
    verification policy
    authority
    evidence set
    time
    policy version

DerivedEpistemicView
    computed for the current purpose

Then:

    evidence + provenance + policy + authority + time
        ->
    verification record
        ->
    derived usability
        ->
    capabilities / obligations

The strongest AI-specific purpose is prevention of assumption laundering:

    model guessed X
        ->
    persisted X
        ->
    later model sees X
        ->
    later model assumes X was authoritative

The architecture should interrupt that chain.

---

## 10. Unknown must remain distinct from false

This survived every relevant line of research.

Absence of evidence cannot silently become false unless a specific closed-world policy says so.

Likewise:

- contradicted is not automatically false;
- reported is not verified;
- high confidence is not authority;
- repeated copies of one source are not independent evidence.

This is particularly important in:

- healthcare;
- compliance;
- accessibility;
- fraud;
- security;
- scientific/research systems.

---

## 11. External-effect uncertainty is real and needs explicit representation

This is one of the best-supported concrete mechanisms.

A timeout means:

    the caller did not receive a conclusive response

not:

    the effect definitely failed

Therefore:

    transport failure != known business failure

For consequential external actions, the system should represent outcome knowledge explicitly.

But the original ternary:

    Success
    Failure
    OutcomeUnknown

is too small as a universal algebra.

Real systems may require:

    Rejected
    Accepted
    Pending
    Succeeded
    KnownFailed
    PartiallySucceeded
    OutcomeUnknown
    ReconciliationConflict
    AdministrativelyResolved

The core invariant is simpler:

> Unknown outcome must never be silently collapsed into success or failure.

---

## 12. Semantic operation identity

External effects should have stable business-operation identity independent of transport attempts.

Example:

    semanticOperationId = Refund:Payment123:Request17

HTTP retry 1, retry 2, workflow retry 3 are attempts of the same operation.

This distinction allows:

    RetrySameSemanticOperation

to be different from:

    StartNewSemanticOperation

During OutcomeUnknown, a new semantic operation should normally be unavailable.

A retry of the same operation may be legal if the provider gives strong idempotency/deduplication guarantees.

---

## 13. OutcomeUnknown should create unresolved work

A strong integration pattern is:

    external effect outcome = OutcomeUnknown
        ->
    remove unsafe new-effect capability
        ->
    expose observation/reconciliation capabilities
        ->
    create reconciliation obligation

This composes three separate research areas:

- distributed-system uncertainty;
- capabilities;
- obligations.

That composition is one of the more interesting system-level elements.

---

## 14. Semantic dependency closure remains a high-value differentiator

Ordinary code dependency asks:

    What code references what?

Semantic dependency asks:

    What consequential meaning depends on this meaning?

Example:

    ShipmentEligibility
        depends on
    PaymentState.Captured

That relation may be indirect and not correspond cleanly to one import/call edge.

The research consistently identifies semantic dependency as one of the most plausible residual advantages over:

- strong modularity;
- strong typing;
- code search;
- AST graphs;
- program slicing;
- retrieval.

The main risk is graph incompleteness.

A semantic graph that omits dependencies creates dangerous false confidence.

Therefore dependency closure must be measured as recall and precision, not assumed.

---

## 15. Semantic migration is probably the strongest development-time differentiator

This survived skeptical review particularly well.

Example:

    Approved
        ->
    ConditionallyApproved
    FullyApproved

A normal compiler may catch direct exhaustive matches.

A semantic migration system should force explicit disposition of consequential interpretations.

For example:

    CanFund:
        old Approved behavior cannot automatically propagate to both new states.

The critical rule is:

> A semantic split invalidates dependent interpretations until they are explicitly redistributed.

This creates deliberate semantic friction exactly where meaning has become ambiguous.

That is likely much more valuable than merely generating state types.

---

## 16. Wildcards/defaults are a semantic hazard in consequential closed worlds

Example:

    Captured -> CanRefund
    _        -> CannotRefund

Later:

    Disputed

silently becomes:

    Disputed -> CannotRefund

No one explicitly decided that.

For consequential closed state families, the architecture should reject catch-all interpretation unless the remaining cases have been explicitly declared semantically equivalent for that interpretation.

This is a good analyzer/compiler rule.

---

## 17. One operational authority, multiple independent oracles

This is perhaps the most important correction from the semantic-compilation research.

If one semantic source generates:

- runtime;
- tests;
- documentation;
- tools;
- policies;

then all may agree perfectly while the semantic source is wrong.

Therefore:

    generated consistency != correctness

The architecture needs:

ONE OPERATIONAL AUTHORITY
    determines what the system actually permits/does

MULTIPLE INDEPENDENT ORACLES
    challenge whether the authority is correct

Independent oracles may include:

- domain-owned acceptance examples;
- external regulation/contract requirements;
- independently stated invariants;
- hidden acceptance tests;
- semantic mutation tests;
- production invariants;
- human/domain review;
- differential implementations.

Generated tests should be described as conformance tests, not independent correctness tests.

---

## 18. Semantic compilation survives only in narrow form

Historical MDE strongly argues against:

    model entire application
        ->
    generate everything

The safer model is:

    encode only consequential semantics
        ->
    generate/validate only artifacts whose independent duplication creates meaningful risk

Good generation targets:

- native state types;
- transition IDs;
- runtime guards;
- capability derivation;
- conformance tests;
- agent capability metadata;
- semantic impact graph;
- structural documentation;
- analyzers.

Bad initial generation targets:

- business algorithms;
- UI;
- general workflows;
- SQL implementation;
- full persistence;
- full API implementations;
- prose documentation.

The compiler should first prove one thing:

> A consequential semantic change can be made once and its mechanically dependent enforcement/control surfaces remain synchronized.

---

## 19. Do not invent a new programming language

The language research argues for:

    native language
        +
    small declarative semantic metadata
        +
    canonical semantic IR
        +
    analyzers
        +
    tiny trusted runtime

Use native strengths when they exist:

- F# DUs;
- Rust enums;
- Kotlin sealed hierarchies;
- Java sealed types;
- modern C# union/closed hierarchy capabilities;
- TypeScript tagged unions.

The semantic layer should not force all languages down to a weak common denominator.

---

## 20. Host language matters, but authority-boundary enforcement matters more

Strong languages improve:

- local exhaustiveness;
- construction safety;
- immutable modeling;
- diagnostics;
- local authority representation.

They do not solve:

- stale state;
- policy version;
- evidence freshness;
- distributed capability validity;
- SQL bypass;
- serialization;
- external effects;
- direct operational tool access.

Therefore:

> Put the strongest guarantees at the authority boundary, while exploiting native type-system strength wherever available.

SQL remains a major independent bypass risk.

A perfect F# or Rust model can still be invalidated by an unrestricted:

    UPDATE Orders SET Status='Shipped'

Therefore authoritative persistence ownership/tool permissions matter more than language purity.

---

## 21. Semantic ABI survives, public standard does not—yet

The protocol research supports a small internal semantic ABI.

Do not build a public standard now.

Likely v0.1 operations:

    inspect(subject, fields?)
    get_obligations(scope, filters?)
    request_transition(capabilityToken, inputs, expectedVersion, operationId?)
    explain(subject, actionOrGoal)

Do NOT initially put in core:

    find_paths
    reconcile_effect
    get_policy_context
    get_evidence
    obligation progress APIs

Those can be resources/capabilities/extensions.

The strongest agent-facing design is:

    semantic ABI internally
        ->
    dynamic typed legal tools externally

not a raw generic stringly-typed transition tool.

---

## 22. HATEOAS is important prior art

Dynamic capability exposure is very close to hypermedia affordances.

That is not a problem.

The useful extension is:

    hypermedia-style dynamic action discovery
        +
    actor authority
        +
    state/version checks
        +
    evidence/policy
        +
    obligations
        +
    protected transition execution

The lesson from HATEOAS is not "this has already failed."

It is:

> Dynamic discovery provides value only when clients can exploit it more effectively than static APIs.

AI agents may change that tradeoff because dynamic affordances are naturally consumable by agents.

That must still be experimentally demonstrated.

---

# Part II — What should be removed, changed, or demoted

## Remove / reject

### 1. Universal state-machine framing

Do not describe the whole system as state machines.

Too narrow semantically and too broad operationally.

### 2. Universal semantic modeling

Do not model ordinary algorithms, UI, layout, content, and low-consequence CRUD.

### 3. Linear epistemic-state enum

Replace with claims/evidence/provenance/verification records + derived view.

### 4. Ternary universal effect algebra

Keep OutcomeUnknown as a required distinction, but allow richer effect profiles.

### 5. Generic public "agent protocol" as first product

Keep an internal ABI first.

### 6. `find_paths` as mandatory core feature

Planning is established technology and may be unnecessary for initial proof.

### 7. Obligation = workflow task

Reject this equivalence.

### 8. Generated tests as proof of correctness

They prove conformance only.

### 9. "Strong language solves the architecture"

False.

### 10. "Semantic compiler makes weak languages equivalent to strong languages"

Too strong.

It can approximate authoritative runtime correctness; it cannot equalize local proof strength/ergonomics.

### 11. "More deterministic means more correct"

False when the specification is wrong.

### 12. "Smaller models are proven to work"

Not proven.

This is a high-value experiment.

---

## Demote to optional/profile-level concepts

- Evidence/claims: only domains needing epistemic authority.
- Obligations: only domains with durable unresolved work.
- Effect profile: only consequential external effects.
- Policy engine integration: when policy is distinct and dynamic.
- Planning graph: when path search is actually useful.
- Formal model generation: for selected high-consequence components.
- Workflow engine: use existing workflow infrastructure where appropriate.

---

# Part III — Smallest defensible architecture

## Layer 0 — Excellent conventional architecture

Required baseline:

- modules/bounded contexts;
- explicit ownership;
- strong types where available;
- architecture tests;
- ordinary APIs;
- persistence discipline;
- normal testing;
- repository indexing/retrieval.

Do not replace these.

---

## Layer 1 — Minimal Semantic Source / IR

Required core primitives:

### SemanticId

Stable identity.

### SubjectType

What domain thing semantics concern.

### StateFamily / StateCase

Only for consequential closed state.

### Transition

Declared authoritative semantic change.

### RequirementExpression

Restricted analyzable predicate AST.

Examples:
- equality;
- membership;
- Boolean composition;
- comparisons;
- freshness/time predicates;
- references to named semantic facts.

### CapabilityRule

Derives currently legal action.

### SemanticDependency

Meaning-level dependency edge.

### SemanticMigration

Explicit split/merge/remove/replace disposition.

### Provenance

Compact source/rationale/version metadata.

### Versions

At minimum:
- semantic spec version;
- state version;
- policy version when relevant.

That is enough for v0.1.

---

## Layer 2 — Build-time semantic compiler/analyzer

Phase 1 checks:

- semantic IDs unique;
- references resolve;
- state families closed;
- consequential interpretation exhaustiveness;
- forbidden wildcard/default;
- transition declarations valid;
- dependencies resolvable;
- migration completeness;
- no stale generated semantic artifacts.

Generate:

- target-language state types;
- transition identifiers/interfaces;
- runtime rule tables/guards;
- capability-query metadata;
- conformance tests;
- semantic impact report;
- structural Markdown/docs;
- dynamic agent tool metadata.

Do not generate general business implementation.

---

## Layer 3 — Trusted runtime semantic kernel

This should be small.

Responsibilities:

- inspect current authoritative state;
- derive current capabilities;
- validate requested transition;
- check actor authority;
- check state/version;
- check policy/version;
- check evidence/freshness when profile is used;
- enforce concurrency;
- enforce effect safety;
- write authoritative transition result;
- create/update derived obligations when profile is used.

This is effectively a reference monitor for consequential semantic actions.

---

## Layer 4 — Authoritative persistence boundary

Rules:

- no unrestricted semantic-state writes;
- service/module owns writes;
- deserialize through validation;
- ORMs do not expose unrestricted semantic setters;
- SQL/admin overrides explicit, audited, governed;
- agent should not receive arbitrary SQL for authoritative mutation.

This is essential in mainstream stacks.

---

## Layer 5 — Agent semantic projection

Default operation:

    inspect

returns only an authorized compact projection:

- current semantic state;
- versions;
- current typed legal capabilities;
- subject obligations;
- relevant claim/evidence summary if needed.

Model-facing actions should normally be dynamic typed tools generated from capability instances.

Blocked actions remain conceptually visible through:

    explain

so the agent can reason about prerequisites without being allowed to execute them.

---

## Optional Profile A — Obligations

Add:

- obligation rules;
- satisfaction predicates;
- provenance;
- disposition;
- lease/work attempt model;
- conflict representation.

Do not embed full workflow execution.

Use existing queues/workflow engines underneath when needed.

---

## Optional Profile B — Claims/Evidence

Add:

- Claim;
- Evidence;
- support/opposition edges;
- origin/derivation;
- VerificationRecord;
- validity/freshness;
- derived epistemic view.

Do not add one giant knowledge graph platform.

---

## Optional Profile C — External Effects

Add:

- semantic operation ID;
- invocation attempt records;
- effect outcome knowledge;
- idempotency/retry policy;
- authoritative observation/reconciliation capability;
- OutcomeUnknown support.

---

# Part IV — What is genuinely differentiated

## Low novelty

Do not claim novelty for:

- explicit state;
- transitions;
- invariants;
- capabilities;
- obligations;
- evidence;
- provenance;
- planning;
- model generation;
- deterministic agent guards.

These all have deep prior art.

## More defensible differentiation

### 1. One semantic authority shared by runtime and agent

The same semantics answer:

Runtime:
    Is this action legal?

Agent:
    What can I legally do now?

### 2. Semantic dependency + migration as AI change-control

Meaning change creates explicit required semantic work rather than relying on repository archaeology.

### 3. Capability/obligation dual frontier

    MAY frontier
    MUST-resolve frontier

presented directly to agents.

### 4. Effect uncertainty changes the affordance surface

OutcomeUnknown automatically changes what can be done and what must be resolved.

### 5. Semantic structure as precomputed reasoning/context compression

Pay modeling cost once, reuse the result across many inference episodes.

This is probably the most commercially significant and least validated claim.

---

# Part V — Strongest remaining hypotheses

Ranked by evidence and strategic value.

## H1 — Deterministic commitment gates improve consequential action safety

Evidence: strong.

Already substantially established.

Do not spend the first experiment proving only this.

---

## H2 — Dynamic legal-action filtering improves agent correctness and efficiency

Evidence:
- correctness: strong conceptual / emerging empirical;
- token/cost: moderate mechanism evidence;
- full economic effect: unproven.

High-value experiment.

---

## H3 — Semantic dependency + migration improves correctness on meaning-changing software evolution

Evidence:
- strong theoretical/engineering rationale;
- direct AI evidence: limited.

Probably the most important development-time experiment.

---

## H4 — Obligations reduce long-horizon work rediscovery

Evidence:
- component mechanisms strong;
- complete obligation-specific AI economics unproven.

Good operational-agent experiment.

---

## H5 — Explicit claims/evidence prevent assumption laundering

Evidence:
- knowledge/provenance mechanisms strongly supported;
- exact AI-specific longitudinal effect unproven.

Good second-phase experiment.

---

## H6 — Semantic context reduces total context cost

Evidence:
- repository/context problem strongly established;
- semantic compression directly unproven.

Core economic hypothesis.

---

## H7 — Stronger environment permits smaller/cheaper models

Evidence:
- plausible / moderate indirect;
- direct end-to-end evidence weak.

High strategic value, but should be tested after the architecture shows correctness/context gains.

---

## H8 — Semantic ABI improves cross-application agent portability

Evidence:
- plausible / moderate;
- strong prior art;
- direct cross-domain tests missing.

Later experiment.

---

# Part VI — Unified experimental program

Do not run twelve disconnected experiments.

Build one benchmark platform that tests multiple hypotheses.

## Domain

Use a payment/order/approval domain because it naturally contains:

- closed states;
- authority;
- cross-module dependencies;
- policy;
- obligations;
- external effect uncertainty;
- concurrency;
- semantic migration.

Example modules:

Customer
    Identity / Risk

Payment
    Authorized
    Captured
    Refunding
    Refunded
    Disputed

Order
    Pending
    Approved
    ConditionalApproval
    Fulfillable
    Cancelled

Shipment
    Ready
    Shipped

Effects
    Capture
    Refund
    Shipment creation

---

## Architecture variants

### A — Strong Conventional

- modular monolith;
- strong typing;
- good docs;
- architecture tests;
- tests;
- repository map/search;
- correct data ownership.

### B — + Semantic State/Transition Core

- stable semantic IDs;
- explicit transitions;
- restricted requirements;
- runtime commitment gate.

### C — + Capability Frontier

- dynamic legal action projection.

### D — + Obligations

- unresolved semantic work.

### E — + Semantic Dependency

- explicit meaning-level dependency graph.

### F — + Semantic Migration

- state split/merge disposition checker.

### G — + Effect Profile

- OutcomeUnknown;
- operation identity;
- reconciliation obligation.

### H — + Epistemic Profile

- claims/evidence/verification for one risk/identity condition.

This ablation ladder is more informative than comparing "normal vs everything."

---

## Model tiers

Use at least:

- small;
- medium;
- frontier.

Prefer two model families where practical.

Goal:

Find the cheapest model/environment pair that meets target semantic correctness.

---

## Task families

### 1. Local refactor control task

Replace payment gateway.

Expected semantic-layer advantage:
near zero.

This checks benchmark fairness.

### 2. State addition

Add Payment.Disputed.

Tests exhaustiveness.

### 3. State split

Approved -> ConditionalApproval | FullApproval.

Primary semantic migration test.

### 4. Cross-module policy change

Risk block prevents shipment after payment capture.

Primary dependency test.

### 5. Evidence freshness change

24h -> 4h.

Tests policy/evidence fan-out.

### 6. External-effect timeout

Refund succeeds remotely, response lost.

Tests OutcomeUnknown.

### 7. Agent restart

New agent resumes unknown effect/obligation.

Tests externalized work state.

### 8. Tool-space test

50-100 defined transitions, 3-5 legal now.

Tests dynamic capability projection.

### 9. Ambiguous requirement

Forces system to surface PolicyDecisionRequired rather than invent semantics.

### 10. Wrong semantic specification

Mandatory adversarial test.

Tests correlated failure and independent oracles.

### 11. Generator bug

Tests compiler blast radius.

### 12. SQL bypass

Tests authority boundary.

### 13. Product pivot

Changes hypothesis/workflow while durable semantics remain.

Tests semantic retention.

### 14. Longitudinal sequence

50-100 dependent modifications.

Tests drift/context growth.

---

# Part VII — Primary metrics

The headline metric should be:

    Cost per Semantically Correct Completion

not:

    tokens per run

Raw metrics:

- input tokens;
- cached input tokens;
- output tokens;
- reasoning tokens when available;
- tool calls;
- model calls;
- search calls;
- files read;
- unique files read;
- compiler/analyzer calls;
- tests;
- rejected illegal actions;
- repair cycles;
- wall-clock time;
- human intervention;
- semantic defects;
- escaped defects;
- false blocks;
- obligation misses;
- duplicate effects.

Derived metrics:

## Correct Completion Rate

    CCR = correct completions / attempts

## Effective Cost per Correct Completion

    ECC = mean execution cost / CCR

## Context Acquisition Cost

Tokens/tool calls before first semantically relevant action/edit.

## Semantic Change Coverage

    surfaced affected interpretations
    /
    actually affected interpretations

## Semantic Impact Precision

    surfaced interpretations actually affected
    /
    all surfaced interpretations

## Duplicate Effect Rate

## Unsafe Retry Rate

## Obligation Precision / Recall

## False Completion Rate

## False Block Rate

## Human Escalation Rate

## Semantic Retention

    previously validated semantics retained
    /
    prior semantics expected to survive

## Assumption Survival Rate

## Environment Leverage Ratio

    recurring agent/defect savings
    /
    amortized semantic infrastructure cost

---

# Part VIII — Decision gates for the research program

## Gate 1 — Does capability filtering add value?

If not:

Do not build sophisticated capability projection.

Keep runtime commitment gate only.

## Gate 2 — Does semantic dependency/migration outperform strong conventional tooling?

If not:

Reduce semantic compiler sharply.

## Gate 3 — Do obligations reduce restart/discovery cost?

If not:

Use ordinary workflow/task infrastructure.

## Gate 4 — Does semantic context reduce total context cost?

If not:

Stop positioning context compression as economic differentiator.

## Gate 5 — Can lower model tiers meet correctness targets?

If not:

Do not claim model substitution.

## Gate 6 — Does the architecture remain cheaper after modeling/tooling cost?

If not:

Limit it to high-consequence safety use cases.

---

# Part IX — Product / implementation roadmap

## Phase 0 — Freeze claims

Do not add more primitives before experiments.

## Phase 1 — Minimal semantic kernel

Build only:

- stable semantic IDs;
- state cases;
- transitions;
- requirements;
- capability derivation;
- semantic dependencies;
- migration checker;
- runtime commitment gate;
- inspect;
- request_transition;
- explain.

## Phase 2 — Dynamic typed tool projection

Benchmark:

- static bespoke tools;
- raw semantic ABI;
- dynamic typed capabilities.

## Phase 3 — Effect profile

Implement one real/simulated non-atomic external effect.

## Phase 4 — Obligations

Add one durable unresolved-work case:
    ReconcileRefundOutcome

## Phase 5 — Longitudinal coding benchmark

Run state split / cross-module evolution.

## Phase 6 — Epistemic profile

Only after the core is stable.

Implement claims/evidence for one consequential decision.

## Phase 7 — Cross-language targets

Start with mainstream targets where enterprise adoption matters.

A reasonable initial set:

- C#
- TypeScript

Use F# as a reference implementation/semantic design oracle if useful.

Do not support many languages until the IR earns its value.

## Phase 8 — Cross-domain portability

Second domain:
- deployment,
- healthcare simulation,
- compliance,
or logistics.

Only after the first domain demonstrates value.

---

# Part X — Research claims we can responsibly make now

Supported strongly enough to state:

1. Deterministic enforcement can prevent classes of illegal agent actions.
2. Current tool choice and context retrieval are meaningful agent bottlenecks.
3. Long-horizon software evolution is materially harder than isolated coding tasks.
4. Unknown external outcomes are a real and distinct systems condition.
5. Good conventional modularity already provides substantial context/change isolation.
6. Generated agreement does not establish specification correctness.
7. Semantic state/effect/policy abstractions should be applied selectively to consequential behavior.
8. Strong host-language guarantees help but cannot replace authoritative runtime/persistence boundaries.
9. The architecture has substantial prior art at the primitive level.

Reasonable but unproven:

1. Dynamic state-conditioned capabilities materially lower total agent cost.
2. Semantic dependency/migration materially reduce AI maintenance drift.
3. Obligations materially reduce long-horizon agent work-discovery cost.
4. Semantic context materially reduces token usage.
5. Smaller models can match larger models under stronger environments.
6. A stable semantic ABI materially improves cross-domain portability.
7. The full composition creates a commercially meaningful advantage over simpler combinations.

---

# Final architectural thesis

The strongest version of the idea after all twelve investigations is:

> Probabilistic agents should not be responsible for repeatedly reconstructing consequential software semantics from incidental implementation artifacts when those semantics can be made explicit once and enforced deterministically.

A good system should therefore expose to an agent:

    what is authoritatively true enough for this purpose,
    what the actor may legally do now,
    what remains unresolved,
    why an action is blocked,
    and how a requested consequential transition will be validated.

It should NOT attempt to encode all intelligence, all workflows, or the whole application.

The deterministic layer is not there to replace intelligence.

It defines the boundary at which probabilistic intelligence acquires authority.

The research program should now stop expanding the theory and start measuring the residual hypotheses against excellent conventional software.

The decisive commercial metric is:

> cost per semantically correct completion over time.

If the architecture wins there, the value is larger than safer agent code.

It means explicit semantics function as reusable precomputed reasoning.

If it does not, the architecture should be narrowed to the specific safety mechanisms that still produce measurable value.
