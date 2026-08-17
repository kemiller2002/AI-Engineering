# AI Research Mission 10 — Semantic Modularity vs Ordinary Modularity for AI Agents

## Central question

**After giving conventional software the best reasonable modularity, typing, documentation, dependency tooling, and AI retrieval available, what meaningful benefit—if any—remains from making consequential state, legal transitions, capabilities, obligations, semantic dependencies, and migrations explicit and machine-authoritative?**

---

# 1. Executive verdict

The strongest skeptical conclusion is:

> **Good conventional modularity already captures a large fraction of the benefits that might otherwise be attributed to semantic modularity.**

That is not a weakness in the research program. It significantly sharpens it.

A competent conventional architecture can already provide:

- information hiding,
- strong module boundaries,
- data ownership,
- aggregate-level invariant protection,
- typed APIs,
- closed types and exhaustive handling in stronger languages,
- dependency rules,
- architecture tests,
- ports and adapters,
- contract tests,
- domain events,
- policy engines,
- workflow engines,
- task queues,
- repository maps,
- static dependency graphs,
- code search,
- graph-based retrieval,
- AI-generated module summaries.

Modern repository-retrieval work also shows that agent context acquisition is becoming increasingly sophisticated. ContextBench, SWE-Explore, Agent Retrieval Bench, CORE-Bench, structural repository indices, program-slicing approaches, and graph-based exploration all attack the same broad problem:

> finding the minimum code context needed to act correctly.

Therefore the proposed architecture should **not** claim:

> "Ordinary modules are insufficient for AI."

That is not supported.

A more defensible conclusion is:

> **Semantic modularity may provide incremental value specifically where ordinary modularity exposes structure but not authoritative meaning.**

The most promising incremental mechanisms are:

1. **Dynamic legal-action frontier**
   - the agent sees what can be done *now*, not merely what methods exist.

2. **Semantic dependency closure**
   - dependencies such as "RefundEligibility depends on interpretation of PaymentState.Captured" are explicit even when normal import/call graphs do not capture them.

3. **Semantic migration**
   - a state split, merge, or meaning change forces explicit redistribution of consequential interpretations.

4. **Machine-enforced semantic authority**
   - surviving code/tests/schema do not silently redefine domain meaning.

5. **Obligations**
   - unresolved semantic work becomes first-class rather than requiring open-ended discovery.

6. **Epistemic requirements**
   - actions can depend on evidence quality/authority rather than only structural state.

However, several proposed mechanisms appear largely **separable from modularity**:

- capabilities,
- obligations,
- epistemic state,
- outcome-unknown handling.

These may be valuable even if the underlying architecture remains conventionally modular.

That produces an important correction to the thesis:

> **The architecture's strongest value may not be "better modularity." It may be a semantic control layer placed on top of already-good modularity.**

The research therefore favors:

```text
strong ordinary modular architecture
    +
small semantic control layer around consequential state
```

rather than:

```text
replace ordinary architecture with a universal semantic architecture
```

The biggest over-engineering risk is building a custom semantic compiler that recreates:

- DDD,
- design by contract,
- workflow,
- policy engines,
- code graphs,
- architecture tests,

without producing measurable incremental correctness or context savings.

The best first experiment is an ablation ladder comparing:

```text
Conventional
+ docs
+ strong types
+ architecture tests
+ executable contracts
+ semantic state/transition model
+ capability frontier
+ dependency closure
+ semantic migration
```

on the **same tasks**.

The decisive result is not whether the full semantic architecture wins.

It is:

> **Where does marginal value actually appear?**

---

# 2. Fair definition of competent conventional modularity

The conventional baseline must be strong.

A fair Architecture A includes:

## Structural organization

- modular monolith or well-structured services,
- clear bounded contexts,
- explicit module APIs,
- internal implementation hiding,
- separate infrastructure adapters.

## Domain modeling

- DDD-style entities/value objects where useful,
- aggregate roots,
- invariants protected through methods,
- domain services,
- domain events.

## Type safety

Where language permits:

- closed enums/unions,
- nullability controls,
- exhaustive matching,
- immutable value objects,
- private constructors.

## Dependency control

- architecture tests,
- package/module visibility,
- dependency rules,
- static analysis.

## Persistence discipline

- module data ownership,
- no shared direct writes,
- repositories/read models.

## Documentation

- module contracts,
- ADRs,
- domain terminology,
- public API semantics.

## AI context tooling

- code search,
- symbol index,
- repository map,
- embeddings,
- graph retrieval,
- generated summaries.

This baseline is already excellent software architecture.

Any semantic architecture that only beats poor CRUD code proves very little.

---

# 3. Definition of semantic modularity

A semantic module can be defined as:

> **A module that owns authoritative consequential domain state and permits authoritative semantic change only through declared, machine-visible transitions whose legality and dependencies are explicit enough to be checked or derived.**

Potential contract:

```text
SemanticModule Payment {
    owns:
        PaymentState

    transitions:
        Authorize
        Capture
        Refund
        Dispute

    capabilities:
        CanCapture
        CanRefund

    obligations:
        ReconcileUnknownEffect

    policies:
        RefundPolicy

    evidence:
        FraudAssessment

    effects:
        ProcessorCharge
        ProcessorRefund

    dependencies:
        RefundEligibility
        ShipmentEligibility
}
```

Other modules may:

- observe state,
- consume trusted views/events,
- request transitions,
- depend on semantic interpretations.

They may not:

- directly mutate authoritative state,
- silently redefine the semantics of owned concepts.

---

# 4. Structural modularity vs semantic modularity

The cleanest distinction is:

## Structural modularity

Answers:

> **What code may depend on what?**

Examples:

- UI depends on application layer.
- Payment module cannot access Shipping internals.
- Infrastructure depends inward.

## Semantic modularity

Answers:

> **Who owns this meaning, what changes it legally, and what semantic consequences must be reconsidered when it changes?**

Example:

Structural graph:

```text
Shipping -> Payment API
```

Semantic graph:

```text
ShipmentEligibility
depends on
PaymentState.Captured
under
ShippingPolicy@7
```

The second relationship may not correspond to one static import.

This is the core incremental claim.

---

# 5. Information hiding comparison

Parnas's information-hiding principle is a formidable competitor.

Classic modularity already says:

> hide design decisions likely to change behind stable interfaces.

This directly provides:

- reduced change propagation,
- lower cognitive load,
- local reasoning,
- implementation substitution.

A well-designed Payment interface may hide:

- gateway,
- storage,
- internal state representation.

Semantic modularity is **not** a replacement for this.

Its claimed extension is:

> make not only the implementation boundary explicit, but the **meaning-change boundary**.

An interface such as:

```text
Refund(paymentId)
```

hides implementation.

It does not necessarily make explicit:

- in which states refund is legal,
- which authority is required,
- what evidence must be fresh,
- whether a prior external outcome is unknown,
- which other semantic interpretations become stale after a state split.

Those can be documented or implemented conventionally.

The semantic approach's value is only incremental if making them machine-authoritative changes agent behavior or maintenance cost measurably.

Verdict:

**Semantic modularity extends information hiding rather than superseding it.**

---

# 6. DDD bounded-context comparison

DDD bounded contexts already provide explicit semantic locality.

A bounded context says:

> this model and language have coherent meaning within this boundary.

That is extremely close to semantic ownership.

DDD also acknowledges that the same term may have different meaning in different contexts.

Therefore claims that semantic modularity uniquely introduces "semantic boundaries" would be inaccurate.

The incremental differences are more specific:

DDD bounded contexts do not inherently require:

- machine-readable legal transition closure,
- dynamic capability exposure,
- epistemic requirements,
- obligation exposure,
- semantic dependency closure,
- migration completeness.

They *can* implement all of them.

But they are not intrinsic requirements of bounded-context design.

Verdict:

**Bounded contexts solve semantic namespace and model ownership very well. Semantic modularity adds stronger executable evolution/control semantics.**

---

# 7. Aggregate comparison

DDD aggregates may be the closest conventional analogue.

An aggregate:

- owns a consistency boundary,
- protects invariants,
- controls mutation through aggregate-root behavior.

Example:

```text
payment.Refund(...)
```

can validate:

- current state,
- amount,
- domain rules.

This already captures:

```text
state ownership
+
legal mutation boundary
+
invariants
```

Therefore:

> explicit semantic transitions are in large part a stricter, more analyzable form of aggregate discipline.

The incremental benefit comes if transitions become first-class data for:

- agent capability generation,
- migration checking,
- dependency analysis,
- tool exposure.

Without those downstream uses, the distinction may be mostly stylistic.

---

# 8. Actor-model comparison

Actors provide:

- state ownership,
- message-mediated mutation,
- isolation,
- serialized handling.

This is strongly analogous to:

```text
semantic owner
+
transition request
```

An actor can reject invalid messages.

What the actor model does **not** automatically provide is:

- declared exhaustive transition legality,
- machine-readable capability frontier,
- semantic dependency closure,
- epistemic requirements,
- migration semantics.

So:

> actor ownership is a strong implementation mechanism for semantic ownership, but not a complete semantic contract.

---

# 9. Ports and adapters comparison

Ports and adapters isolate domain logic from infrastructure.

For tasks such as:

> replace Stripe with Adyen

ordinary ports/adapters should perform nearly optimally.

Semantic modularity should not claim meaningful additional value.

The semantic layer becomes relevant when the requested change affects:

- domain meaning,
- state legality,
- effect semantics,
- authority,
- cross-module semantic dependencies.

Verdict:

**Infrastructure pivotability is primarily an ordinary modularity benefit.**

---

# 10. Clean Architecture comparison

Clean Architecture's dependency direction:

```text
outer details -> inner business rules
```

already protects durable semantics from volatile infrastructure.

The proposed:

```text
product hypothesis
    -> orchestration
        -> durable semantics
```

is structurally similar.

The new element is not inward dependency.

It is the machine-readable contract around:

- what semantic state exists,
- how it may change,
- what consequences depend on it.

Therefore semantic modularity should be presented as an **enforcement/representation extension**, not as a new discovery that durable business rules should be isolated.

---

# 11. Modular-monolith comparison

Modern modular monoliths can provide:

- module isolation,
- data ownership,
- public interfaces,
- domain events,
- architecture tests,
- explicit dependency direction.

This captures much of the proposed ownership model cheaply.

A strong modular monolith may already prevent:

```text
Shipping directly updates Payment tables
```

using:

- database permissions,
- schema ownership,
- architectural conventions,
- tests.

Semantic modularity's incremental claim is:

```text
Shipping can request CapturePayment
only when the semantic transition is valid
and the agent sees that capability dynamically
```

That is action semantics rather than deployment structure.

---

# 12. Strong-type comparison

Strong languages already provide some of the most valuable semantic guarantees.

## F#

Can naturally express:

- discriminated unions,
- exhaustive pattern matching,
- private representations,
- immutable data,
- typed results.

## Rust

Provides:

- enums,
- exhaustive matching,
- ownership,
- strong encapsulation,
- typestate patterns.

## Kotlin

Provides:

- sealed classes/interfaces,
- exhaustive `when`,
- null safety,
- visibility controls.

## C#

Increasingly supports:

- records,
- pattern matching,
- required members,
- nullability,
- strong encapsulation,

though algebraic data modeling is less direct than F#/Rust.

## TypeScript

Can support:

- discriminated unions,
- `never` exhaustiveness,
- readonly structures,

but structural typing and escape hatches weaken enforcement.

## JavaScript/Python

Require much more convention/runtime checking.

A strong-language baseline may capture:

- illegal-state prevention,
- exhaustive state interpretation,
- transition encapsulation.

This substantially narrows the semantic compiler's unique value.

---

# 13. What strong types do not naturally solve

Even strong types do not automatically encode:

- policy provenance,
- evidence freshness,
- authority,
- cross-service semantic dependency,
- outstanding obligation,
- historical semantic identity,
- migration rationale,
- agent tool frontier.

You *can* model these in types.

The question becomes economic:

> at what point does ordinary language-level modeling become awkward enough that a semantic IR is worthwhile?

This is an experiment, not a philosophical answer.

---

# 14. Architecture-test comparison

Architecture tests can enforce:

```text
Module A cannot depend on Module B internals.
Infrastructure may not be referenced from Domain.
Shipping cannot access Payment persistence.
```

Tools such as:

- ArchUnit,
- NetArchTest,
- dependency-cruiser,
- custom Roslyn analyzers,

can make ordinary architecture mechanically self-defending.

This weakens any claim that a semantic compiler is required merely to enforce module ownership.

Architecture tests are likely an excellent low-cost baseline.

Where they become less natural:

```text
Every consumer of semantic interpretation SC-APPROVED
must be explicitly migrated after SC-APPROVED splits.
```

That requires semantic identity and meaning-level dependency metadata.

---

# 15. Static dependency graphs

Static graphs expose:

- imports,
- calls,
- inheritance,
- data flow,
- symbol references.

These are increasingly valuable for agents.

Recent work shows that structured repository graphs can improve navigation/context acquisition.

But static graphs generally answer:

> what code structurally depends on this code?

They do not necessarily answer:

> what semantic conclusion depends on this domain meaning?

Example:

```text
CanShip
```

may be derived through:

```text
EligibilityService
 -> PolicyResolver
 -> PaymentProjection
```

The relationship to:

```text
PaymentState.Captured
```

may be structurally discoverable through dataflow, but not necessarily explicit or stable.

Semantic graphs trade:

- modeling cost,

for:

- higher intended-meaning precision.

Whether that trade pays off must be measured.

---

# 16. Program slicing comparison

Program slicing is a strong conventional/analysis competitor.

A slice can answer:

> which statements influence value X?

This can produce highly relevant code context.

Recent 2026 work such as ARISE and other code-property-graph approaches explicitly explores exposing structured slices to agents.

This means a semantic graph must beat not merely grep, but:

- data-flow slicing,
- code-property graphs,
- symbol graphs,
- structural indices.

Potential difference:

Program slice:

```text
what code causally influences this result?
```

Semantic slice:

```text
what declared domain meanings are affected by this semantic change?
```

They overlap but are not identical.

---

# 17. Modern repository retrieval comparison

Current retrieval research significantly strengthens the conventional baseline.

## ContextBench

1,136 issue-resolution tasks across 66 repositories.

Findings include:

- agents tend to favor recall over precision,
- sophisticated scaffolding gives only marginal retrieval gains in some settings,
- explored context and actually useful context differ materially.

This demonstrates that context selection is still an unsolved bottleneck.

## SWE-Explore

848 issues across 203 repositories.

It isolates repository exploration and finds:

- exploration quality strongly tracks downstream repair behavior,
- file-level localization is increasingly strong,
- line-level coverage and context efficiency remain differentiators.

## Agent Retrieval Bench

427 samples across 25 repositories, nearly 400K files and millions of chunks.

Important results:

- no single retrieval family dominates,
- RepoMap performs strongly under budget constraints,
- embedding methods vary by task,
- logged trajectories can miss every gold file on a substantial fraction of cases.

This is a strong warning against claiming "modern retrieval already solves context."

It does not.

But it also shows the competitor is improving quickly.

---

# 18. Structural indices and graphs

Research in 2026 increasingly explores:

- structural repository indices,
- code-property graphs,
- repository graphs,
- lexical + structural retrieval.

This supports the counter-hypothesis:

> **A significant fraction of the proposed context-compression benefit may come from better structural retrieval rather than semantic modeling.**

The semantic architecture must therefore show incremental performance beyond:

```text
excellent repository index
+
strong types
+
module boundaries
```

---

# 19. Documentation baseline

Excellent documentation is a serious competitor.

A module contract could say:

```text
Payment states:
    Authorized
    Captured
    Refunded

Refund:
    only after Captured
    requires refund authority
    cannot retry if processor outcome unknown
```

That gives the agent much of the desired context.

Advantages:

- cheap,
- familiar,
- flexible.

Weaknesses:

- can go stale,
- not necessarily executable,
- agent may ignore it,
- cannot automatically force migration.

Therefore explicit semantics and machine enforcement must be separated experimentally.

---

# 20. AI-generated summary baseline

AI-generated module summaries may compress repositories very effectively.

But they create two risks:

1. stale summaries,
2. summaries that infer accidental implementation behavior as intended meaning.

This makes a useful three-way comparison:

```text
A. raw module
B. AI-generated summary
C. authoritative generated semantic contract
```

If B performs nearly as well as C, a semantic compiler may not justify its cost.

---

# 21. Executable-contract baseline

Design by contract can encode:

```text
requires
ensures
invariants
```

Example:

```text
Refund requires:
    state == Captured
    amount <= refundableAmount
```

This may capture much transition legality without introducing a semantic IR.

Therefore a fair ablation must compare:

```text
strong types
+
DbC
+
module boundaries
```

against semantic transitions.

The semantic model adds value only if its first-class representation enables further capabilities such as:

- dependency closure,
- tool derivation,
- migration.

---

# 22. Ordinary API contract vs explicit state model

Consider:

```text
interface Payment {
    Capture()
    Refund()
    GetStatus()
}
```

This API can be perfectly adequate for humans.

Why might an agent need more?

Because method existence does not reveal:

```text
Refund exists
```

vs:

```text
Refund is legal now
```

An ordinary API describes possible operations.

A capability frontier describes currently executable operations.

This distinction is one of the strongest incremental mechanisms.

---

# 23. Semantic ownership incremental value

Ordinary architecture already supports ownership through:

- private state,
- aggregate root,
- service ownership,
- actor state,
- database permissions.

Therefore the semantic architecture should not claim ownership itself as unique.

The incremental value is:

> **ownership is connected to an explicit model of semantic change and agent-visible authority.**

Evidence grade:

**Moderate incremental value; largely achievable conventionally.**

---

# 24. Capability-frontier incremental value

This appears more unique.

Conventional modules commonly expose:

```text
Capture
Refund
Cancel
Dispute
```

regardless of current state.

Agent must determine legality.

Capability frontier:

```text
Current:
    Capture
    Cancel

Blocked:
    Refund
        reason: PaymentNotCaptured
```

This reduces action-space uncertainty.

A workflow engine or policy engine can also provide this.

Therefore the unique value may be **integration**, not novelty.

Evidence grade:

**Strong conceptual incremental value for agents; direct cost evidence still limited.**

---

# 25. Obligations incremental value

Ordinary modules usually expose:

- state,
- events.

They do not always expose:

> what unresolved semantic work remains.

Workflow/task systems already provide this concept.

So obligations are not unique to semantic modularity.

Incremental value exists if obligations are **derived automatically from state/evidence/policy transitions**.

Example:

```text
Evidence expired
    ->
ReverifyClaim obligation
```

Evidence grade:

**Useful but separable from modularity.**

---

# 26. Epistemic-state incremental value

Ordinary modularity generally does not model:

- reported,
- inferred,
- supported,
- verification policy,
- provenance.

But most software does not need this.

Epistemic modeling is valuable only where consequential decisions depend on evidence authority.

Therefore it is a **domain-specific semantic extension**, not a general modularity improvement.

Evidence grade:

**High incremental value in evidence-sensitive domains; low value elsewhere.**

---

# 27. OutcomeUnknown incremental value

Outcome-unknown handling is important for external effects.

But ordinary architecture can model:

```text
Result =
    Success
    Failure
    OutcomeUnknown
```

using a normal sum type.

A semantic compiler is unnecessary for the primitive itself.

Potential incremental value:

- enforce that all protected effects use it consistently,
- link unknown outcomes to obligations/capabilities.

Verdict:

**The primitive is mostly ordinary type modeling; integration is the semantic value.**

---

# 28. Dependency-closure incremental value

This may be the strongest unique component.

Ordinary structural dependency:

```text
A imports B
```

Semantic dependency:

```text
ShipmentEligibility
depends on interpretation:
    Payment.Captured means financially committed
```

When:

```text
Captured
```

splits into:

```text
Settled
AuthorizedButPendingSettlement
```

the structural graph may not know which interpretation must be revisited.

The semantic dependency graph can.

The key challenge:

> semantic edges must be created and maintained correctly.

A graph that misses edges produces false confidence.

Verdict:

**Potentially strong unique value, but expensive to establish and currently lacking direct empirical validation.**

---

# 29. Semantic-migration incremental value

Semantic migration is probably the clearest differentiator.

Type-system migration catches:

```text
new enum case not handled
```

Semantic migration asks:

```text
what did old concept mean in every consequential dependency,
and where does each meaning go now?
```

Example:

```text
Approved
    ↓ split
ConditionalApproval
FullApproval
```

A normal compiler may catch direct exhaustive matches.

It may not catch:

```text
CanFund depends on an indirectly derived "approved enough" interpretation.
```

A semantic migration requires explicit disposition.

Verdict:

**Strongest candidate for genuinely unique value.**

---

# 30. Pivotability comparison

Clean architecture, ports/adapters, bounded contexts, and information hiding already provide strong pivotability.

Example:

```text
replace provider
```

ordinary architecture wins easily.

Semantic modularity may help when the pivot changes domain meaning:

```text
self-service approval
    ->
advisor-assisted conditional approval
```

because obsolete semantic dependencies can be surfaced.

But over-modeling can make pivots harder.

Therefore:

> semantic modularity likely improves **semantic pivot correctness**, not necessarily raw pivot speed.

---

# 31. Token/context comparison

The hypothesis is not:

```text
semantic contract always smaller than code
```

It may not be.

Semantic contracts add:

- IDs,
- states,
- transitions,
- policies,
- dependencies,
- evidence.

The correct measure is:

```text
total context required for correct completion
```

not contract size.

A 2,000-token contract could be economically superior to:

```text
500-token interface
+
9,000 tokens of implementation/tests
```

But a high-quality conventional summary may provide:

```text
1,500 tokens
```

and perform equally well.

This must be benchmarked.

---

# 32. Minimum sufficient context

Define:

> **Minimum Sufficient Context is the smallest context set under which the agent reaches the target semantic correctness with acceptable reliability.**

For each architecture, search context budget downward.

Compare:

```text
tokens
files
semantic facts
tool calls
```

This is more meaningful than raw repository size.

---

# 33. Module contract overhead

Measure:

```text
ContractTokens
```

separately.

Also:

```text
ImplementationExposureRatio =
implementation tokens loaded from outside target module
/
total task tokens
```

A good modular system should already drive this down.

Semantic modularity must improve it further to justify context claims.

---

# 34. Lazy detail retrieval

Both architectures can use lazy retrieval.

Conventional:

```text
module summary
-> fetch implementation
```

Semantic:

```text
semantic contract
-> fetch evidence/dependency/implementation
```

Therefore lazy retrieval itself is not a unique benefit.

The question is whether semantic metadata yields **better first-hop selection**.

---

# 35. Model-size interaction

Prediction:

Frontier models may infer hidden semantics from strong conventional modules well enough that incremental gains are modest.

Smaller models may benefit disproportionately from:

- explicit legal frontier,
- explicit dependency graph,
- semantic migration checklist.

This should be treated as an interaction:

```text
benefit = f(model capability, environment strength)
```

Do not generalize one model tier.

---

# 36. Language interaction

The architecture may be compensating for weak languages.

Test:

## Strong-language conventional

- F#,
- Rust,
- Kotlin.

## Mainstream moderate

- C#,
- Java.

## Weaker semantic enforcement

- TypeScript,
- Python,
- JavaScript.

Hypothesis:

```text
incremental semantic-compiler benefit
is larger
as native language semantic enforcement decreases
```

But capabilities/dependency closure may remain valuable even in F# or Rust.

---

# 37. Strong-language baseline

A particularly important benchmark:

```text
F#
+
DUs
+
private constructors
+
exhaustive matching
+
good modules
+
architecture tests
```

versus:

```text
same
+
semantic layer
```

If semantic architecture produces little additional value here, the product may be primarily:

> a semantic-strengthening layer for mainstream/weak ecosystems.

That would materially change startup positioning.

---

# 38. Weak-language baseline

TypeScript/Python may show larger gains because:

- runtime invalid states are easier to construct,
- encapsulation is easier to bypass,
- exhaustiveness is weaker or optional,
- structural conventions dominate.

But comparing only against weak languages would overstate the architecture's fundamental novelty.

---

# 39. Longitudinal drift interaction

Ordinary modularity already reduces drift by localizing changes.

Semantic modularity may add:

- explicit authority,
- semantic provenance,
- migration completeness.

Track over 50 sequential changes:

```text
ModuleEscapeRate
SemanticRetention
AssumptionSurvival
DependencyMissRate
```

The architecture's strongest long-term case is if good conventional boundaries remain structurally clean but semantic meaning still drifts.

---

# 40. Architecture self-defense

Conventional architecture can defend itself through:

- module visibility,
- architecture tests,
- database permissions,
- static analyzers.

Semantic architecture can additionally reject:

- illegal transition,
- stale capability,
- unresolved semantic migration.

Measure **bypass cost**.

Example agent shortcuts:

```text
direct DB write
public constructor
wildcard default
skip policy engine
call effect directly
```

If ordinary tests already block nearly all of these, semantic enforcement adds little.

---

# 41. Maintenance burden

Semantic architecture adds artifacts:

- model,
- semantic IDs,
- dependency metadata,
- migration declarations,
- generator/compiler,
- runtime.

These create:

- tooling maintenance,
- debugging complexity,
- onboarding cost,
- version upgrades.

This is the largest economic counterweight.

The architecture should not be evaluated only on runtime task cost.

---

# 42. Toolchain complexity

A custom compiler/IR introduces adoption risk.

Companies already understand:

- TypeScript compiler,
- Java compiler,
- .NET tooling,
- IDEs,
- standard debuggers.

A semantic compiler may require:

- new build steps,
- custom diagnostics,
- generated code,
- plugins,
- schema evolution.

This increases failure surface.

Therefore start with:

```text
library + analyzer + generated metadata
```

before:

```text
new language/toolchain
```

unless evidence demands the latter.

---

# 43. Debugging risk

Model-driven/generated layers can obscure execution.

Lessons from model-driven engineering suggest generated abstractions can create debugging distance between:

```text
declared model
```

and:

```text
runtime behavior
```

Mitigation:

- transparent generated code,
- stable semantic IDs,
- traceable diagnostics,
- no hidden magic,
- inspectable transition logs.

---

# 44. Incremental adoption

The strongest commercial architecture is likely:

```text
ordinary modular application
    +
semantic islands around consequential state
```

Examples:

- payment,
- identity,
- approval,
- deployment,
- healthcare claim verification.

Rendering/content/reporting remain ordinary code.

This sharply reduces adoption cost.

---

# 45. Semantic islands

A semantic island should expose a standard boundary:

```text
observe
request transition
get capabilities
get obligations
explain blocked
```

Outside modules can remain:

- ordinary TypeScript,
- C#,
- Java,
- Python.

This enables migration without rewrite.

---

# 46. Domain selection

## High incremental value likely

- payments,
- approval workflows,
- compliance,
- healthcare evidence,
- security authorization,
- deployment,
- logistics state,
- regulated workflows.

## Moderate

- complex subscriptions,
- order lifecycle,
- fulfillment,
- customer eligibility.

## Low

- rendering,
- CMS content,
- simple CRUD,
- analytics formatting,
- pure transformations.

This should be action-driven rather than industry-driven.

---

# 47. CRUD counterexample

Consider:

```text
AdminNote {
    id
    text
}
```

Operations:

```text
create
edit
delete
```

No complex authority or lifecycle.

A semantic compiler likely adds negative ROI.

This is an important falsification case.

---

# 48. Pure-function counterexample

Example:

```text
resizeImage(input, width, height)
```

Ordinary:

- type signature,
- tests,
- module interface

is enough.

There is little meaningful state authority or transition semantics.

Again:

**semantic modularity is not universally better architecture.**

---

# 49. High-consequence example

Refunds expose the full incremental set:

- state-dependent legality,
- authorization,
- policy,
- amount limits,
- external-effect uncertainty,
- idempotency,
- obligations after unknown outcome.

This is an ideal target domain.

---

# 50. Cross-module change example

Task:

> Customer risk block added after payment capture must prevent shipment.

Conventional strong modules:

Agent may need:

- Customer risk API,
- Payment state API,
- Shipping eligibility,
- tests.

Semantic system:

```text
ShippingEligibility depends on:
    CustomerRiskClear
    PaymentCaptured

Policy change affects:
    CanShip
```

This tests semantic dependency discovery.

---

# 51. Local refactor example

Task:

> replace payment gateway adapter.

Ports/adapters should let conventional architecture solve with almost no domain context.

Expected semantic incremental value:

**near zero.**

If benchmark shows otherwise, likely baseline is unfair.

---

# 52. State addition example

Task:

```text
add Payment.Disputed
```

Strong language + exhaustive matching may catch most direct consequences.

Semantic graph must show additional value through:

- indirect dependencies,
- capabilities,
- obligations,
- cross-language consumers.

This is an excellent ablation.

---

# 53. State split example

Task:

```text
Approved
    ->
Conditional
FullyApproved
```

This is likely the best semantic-migration test.

Conventional compiler:

- catches direct exhaustive use.

Semantic migration:

- surfaces all registered meaning dependencies,
- requires redistribution.

This may be the strongest differentiator.

---

# 54. Policy-change example

Task:

```text
evidence freshness 24h -> 4h
```

Ordinary:

```text
policy engine
```

may solve perfectly.

If so, semantic architecture should concede no unique benefit.

Potential incremental value:

- dependency impact,
- capability regeneration,
- obligations for existing claims.

---

# 55. Ablation ladder

The benchmark should compare:

## A — Conventional

Good modules, tests.

## B — + excellent docs

Explicit states/rules in Markdown.

## C — + strong types

Closed state, private constructors, exhaustiveness.

## D — + architecture tests

Boundary enforcement.

## E — + executable contracts

Pre/postconditions/invariants.

## F — + semantic state/transition model

First-class transition metadata.

## G — + capability frontier

Dynamic legal actions.

## H — + obligations

Unresolved work.

## I — + semantic dependency closure

Meaning-level graph.

## J — + semantic migration

Explicit redistribution after change.

This ladder is more scientifically useful than A vs J.

---

# 56. Expected marginal value curve

A plausible prior:

```text
A -> C:
large correctness gain

C -> D:
moderate boundary gain

D -> E:
moderate legality gain

E -> F:
small-to-moderate

F -> G:
large agent-operational gain

G -> H:
domain-dependent

H -> I:
potentially large cross-module gain

I -> J:
potentially large evolution gain
```

This is a hypothesis.

The experiment must be allowed to contradict it.

---

# 57. Semantic Modularity Index

Avoid one subjective score.

Track dimensions:

## Ownership Closure

Percent of consequential state with one enforced write owner.

## Transition Closure

Percent of consequential mutations represented by declared transitions.

## Authority Closure

Percent of protected actions with explicit authority requirements.

## Dependency Closure

Percent of affected semantic dependencies mechanically surfaced.

## Obligation Exposure

Percent of unresolved semantic work represented explicitly.

These can characterize an architecture without saying:

```text
semantic modularity = 8.2/10
```

---

# 58. Metrics

## Context Tokens per Correct Completion

## Files Read

## Search/Tool Calls

## Module Escape Rate

```text
tasks expected local
that require unexpected outside context
/
local tasks
```

## Implementation Exposure Ratio

```text
external implementation tokens loaded
/
total context
```

## Dependency Recall

```text
relevant dependencies surfaced
/
all relevant dependencies
```

## Dependency Precision

```text
relevant surfaced dependencies
/
all surfaced
```

## Illegal Mutation Rate

## Semantic Error Rate

## Repair Loops

## Human Review Minutes

## Semantic Retention

Longitudinal.

## Cost per Correct Completion

Include semantic tooling amortization.

---

# 59. Economic model

Let:

```text
TotalCostSemantic(N)
=
BuildSemanticLayer
+ MaintainSemanticLayer(N)
+ AgentCostSemantic(N)
+ ReviewSemantic(N)
+ DefectCostSemantic(N)
```

Conventional:

```text
TotalCostConventional(N)
=
ArchitectureCost
+ RetrievalTooling
+ AgentCostConventional(N)
+ ReviewConventional(N)
+ DefectCostConventional(N)
```

Break-even requires:

```text
saved agent/review/defect cost
>
semantic modeling/tooling cost
```

The full architecture likely breaks even earliest when:

- high consequence,
- high agent task volume,
- long system life,
- repeated cross-module semantic changes,
- high rule fan-out.

---

# 60. Startup implications

Startups are especially sensitive to fixed modeling/tooling cost.

Recommendation:

> **Do not require semantic modeling of the entire product.**

Use it only around:

- irreversible money,
- identity,
- compliance,
- core workflow state.

Keep experimental product surface ordinary and flexible.

This preserves pivot speed.

---

# 61. Enterprise implications

Enterprise conditions favor semantic investment:

- long-lived systems,
- many teams,
- compliance,
- cross-system policies,
- high agent volume,
- high context reconstruction cost.

But enterprises also impose:

- tooling approval,
- training,
- integration,
- legacy constraints.

Therefore incremental adoption is crucial.

---

# 62. Legacy adoption strategy

Do not rewrite a legacy module first.

Possible path:

```text
Legacy Payment System
        ↓
Semantic Wrapper
    - canonical state view
    - transition requests
    - policy checks
    - effect guards
        ↓
Legacy implementation
```

The wrapper can gradually become authoritative.

This tests value before expensive migration.

---

# 63. Agent-only semantic layer

A descriptive semantic map could exist only for agents.

Benefits:

- context compression,
- dependency navigation.

No runtime enforcement.

This is a valuable ablation because it separates:

```text
agent-context benefit
```

from:

```text
control benefit
```

Risk:

the map drifts from implementation.

---

# 64. Runtime-only semantic layer

The inverse experiment:

- enforce transitions/capabilities,
- provide no special context to agent.

Measure:

- correctness,
- illegal actions,
- token usage.

This separates enforcement from context compression.

---

# 65. Which benefit comes from what

The architecture should explicitly decompose:

## Modularity benefit

Information hiding and local change.

## Typing benefit

Invalid-state reduction and exhaustiveness.

## Runtime enforcement benefit

Illegal action prevention.

## Agent-context benefit

Smaller/relevant context.

## Planning benefit

Capabilities/obligations/prerequisites.

## Migration benefit

Change completeness.

Without this decomposition, every improvement risks being incorrectly attributed to "semantic modularity."

---

# 66. Strongest counter-hypothesis: good modularity + retrieval is enough

Evidence supporting this:

- classic modularity already reduces cognitive context,
- modern retrieval increasingly finds relevant files/symbols efficiently,
- program slicing can provide precise dynamic/static dependencies,
- good module docs can explicitly state state/rules,
- strong types encode many invariants.

This counter-hypothesis should win on:

- local refactors,
- infrastructure substitutions,
- simple feature additions,
- CRUD,
- strongly typed local state changes.

If semantic architecture claims broad superiority here, the benchmark design is likely biased.

---

# 67. Second counter-hypothesis: strong types solve most of it

This may be true for:

- state enumeration,
- exhaustiveness,
- invalid construction,
- local transition APIs.

It is less likely to solve economically:

- cross-module semantic dependency,
- provenance,
- policy version,
- obligations,
- agent tool frontier.

The experiment should determine whether those residuals justify a semantic layer.

---

# 68. Third counter-hypothesis: capabilities/obligations matter, semantic compiler does not

This is highly plausible.

A company could build:

```text
good DDD modules
+
capability API
+
work queue
```

without a semantic compiler.

If that captures most operational-agent benefit, the product should narrow accordingly.

This is a critical falsification condition.

---

# 69. Fourth counter-hypothesis: the real benefit is action control

Also plausible.

Research mission 09 strongly supports deterministic commitment boundaries.

It is possible that:

```text
semantic modularity
```

adds little,

while:

```text
runtime capability gating
```

adds substantial safety.

If true, the architecture should stop claiming a general modularity revolution.

---

# 70. Fifth counter-hypothesis: semantic dependency closure is the unique valuable piece

This may prove correct.

Ordinary architecture handles:

- ownership,
- APIs,
- typing.

The truly missing component may be:

> a machine-readable graph of domain-meaning dependencies.

If so, the startup could focus on:

```text
semantic change impact
+
agent context generation
```

instead of building a complete execution platform.

---

# 71. Proposed experiment suite

## Experiment 1 — local adapter refactor

Expected:
conventional ≈ semantic.

## Experiment 2 — state addition

Compare:
strong type exhaustiveness vs semantic dependency.

## Experiment 3 — state split

Primary semantic-migration test.

## Experiment 4 — cross-module eligibility rule

Dependency-discovery test.

## Experiment 5 — policy freshness change

Policy-engine competitor.

## Experiment 6 — OutcomeUnknown refund

Type-system vs integrated obligation/capability.

## Experiment 7 — product pivot

Clean architecture vs semantic retention.

## Experiment 8 — 50-task longitudinal sequence

Drift/context-growth comparison.

---

# 72. Context experiment design

For each task, give Architecture A:

- module interface,
- docs,
- repository tools,
- structural graph,
- full search.

Architecture B:

same tools
+
semantic contract.

Do **not** remove conventional tooling from B.

Measure:

- tokens before correct edit,
- files opened,
- search calls,
- dependency misses.

This isolates incremental semantic information.

---

# 73. Model-tier experiment

Run:

- small,
- medium,
- frontier.

Hypothesis:

```text
semantic explicitness benefit
is inversely related to model capability
```

If only small models benefit, that is still economically important.

If frontier models benefit equally, stronger general case.

---

# 74. Language experiment

At minimum:

```text
F# or Rust
C#
TypeScript
```

Task suite identical in semantic shape.

This tests whether semantic tooling:

- complements strong language,
- or compensates for weaker one.

This is strategically important for adoption.

---

# 75. Human-review experiment

Provide reviewers:

## Conventional

git diff + tests.

## Semantic

git diff + semantic diff + impact report.

Measure:

- review time,
- missed semantic issue,
- confidence calibration.

If semantic diff materially improves human review, the value extends beyond agents.

---

# 76. What ordinary modularity already solves

A competent conventional architecture already solves much of:

- local reasoning,
- implementation hiding,
- data ownership,
- dependency direction,
- infrastructure substitution,
- aggregate invariants,
- module boundaries,
- structural change containment,
- testability,
- architectural conformance.

These benefits should never be rebranded as semantic-layer innovation.

---

# 77. What remains uniquely unsolved

The strongest residual problems are:

## 1. Current legal action frontier

Normal APIs describe operations, not necessarily current legality.

## 2. Meaning-level dependency closure

Static graph knows code relation, not necessarily domain interpretation.

## 3. Semantic migration

Normal refactoring catches syntax/type breakage, not all meaning redistribution.

## 4. Machine-authoritative provenance

Why does this domain rule exist?

## 5. Epistemic action requirements

Is the evidence authoritative enough to permit the action?

These are the best candidates for incremental innovation.

---

# 78. Minimum semantic layer worth building

The research favors a much smaller v0.1 than a full semantic compiler.

## Core 1 — Semantic IDs

Stable identity for consequential concepts.

## Core 2 — Explicit transitions

Only for consequential state.

## Core 3 — Capability derivation

Current legal action frontier.

## Core 4 — Semantic dependency registration

Only for high-value cross-module interpretations.

## Core 5 — Migration checker

State split/merge/removal requires disposition.

Everything else can initially use ordinary architecture:

- module system,
- language types,
- tests,
- docs,
- policy engine,
- queue,
- persistence.

Add obligations/epistemics only where domain needs them.

---

# 79. Recommended implementation posture

Do not create a new programming language.

Prefer:

```text
native language
+
small declarative semantic metadata
+
compiler/analyzer
+
runtime library
```

Example:

- F#/C# attributes/types,
- TypeScript declarations,
- generated JSON/IR,
- analyzers.

This reduces adoption friction and lets the architecture coexist with ordinary tooling.

---

# 80. Final verdict

## Does competent conventional modularity reduce AI context substantially?

**Moderate-to-strong evidence.**

Classic modularity reduces the amount of implementation knowledge needed for local change, and modern repository-retrieval research shows strong gains from structural/context tooling.

Direct controlled AI studies of modularity itself are still limited, so "strong evidence" should be used cautiously.

## Does semantic modularity add material context reduction beyond that?

**Unclear to moderate.**

The mechanism is plausible, especially for legal-action and cross-module semantic context, but modern retrieval is a strong competitor and direct head-to-head evidence is missing.

## Does semantic modularity add material correctness benefit?

**Moderate.**

Strongest where:
- legality,
- migration,
- authority,
- semantic dependencies

are explicit.

Much local correctness is already captured by strong types/contracts.

## Does semantic dependency closure provide unique value?

**Moderate to strong potential.**

It targets dependencies not naturally represented by structural graphs, but modeling completeness is the unresolved risk.

## Does semantic migration provide unique value?

**Strong potential.**

It is the clearest mechanism beyond ordinary refactoring/type exhaustiveness.

## Are capabilities/obligations separable from modularity benefits?

**Yes, mostly.**

They are agent-operational primitives that can sit on conventional modules.

## Can strong languages + ordinary architecture capture most benefit?

**Probably for local state integrity and modularity.**

Probably not for:
- semantic dependency closure,
- agent action frontier,
- semantic migration,
- epistemic authority.

## Most valuable incremental semantic mechanism

**Semantic migration backed by meaning-level dependency closure.**

This directly addresses changes where syntax/types remain valid while business interpretation becomes stale.

## Least valuable / most redundant mechanism

**Basic state ownership and encapsulated mutation**, if already implemented with strong DDD aggregates/actors/module ownership.

Those are well-established conventional patterns.

## Strongest conventional competitor

**Strongly typed DDD modular monolith + architecture tests + executable contracts + modern structural repository retrieval.**

That should be the benchmark baseline.

## Best minimal architecture

```text
Strong ordinary modularity
+
semantic IDs
+
explicit consequential transitions
+
dynamic capability frontier
+
semantic dependency graph
+
semantic migration checker
```

Add:
- obligations,
- epistemics,
- effect uncertainty

only where the domain requires them.

## Biggest over-engineering risk

**Building a semantic compiler that reproduces capabilities already available from strong types, DDD, architecture tests, policy/workflow engines, and modern repository retrieval.**

## Best first experiment

**State-split benchmark with ablation ladder.**

Example:

```text
Approved
->
ConditionalApproval
FullyApproved
```

Compare:

- strong conventional,
- strong types,
- docs,
- executable contracts,
- semantic dependencies,
- semantic migration.

Measure:
- dependencies missed,
- tokens,
- files read,
- semantic defects,
- cost.

## Most important architecture change suggested by research

**Stop treating “semantic modularity” as an all-or-nothing replacement for conventional architecture. Treat it as a narrow semantic control/evolution layer that must earn its complexity mechanism by mechanism.**

---

# 81. Bottom-line interpretation

This research is valuable because the strongest counter-hypothesis is credible.

Good software architecture has been reducing cognitive load for decades.

Parnas, DDD, aggregates, actors, ports/adapters, strong types, dependency rules, and modern repository retrieval already solve substantial parts of the problem.

The proposed architecture should not compete with those.

It should build on them.

The real question is not:

> "Are semantic modules better than normal modules?"

That framing is too broad.

The useful question is:

> **What domain meaning is still invisible after we have already built an excellent normal module?**

The research suggests four especially important answers:

```text
What is legal right now?
What unresolved work exists?
What semantic meaning depends on this concept?
What must be explicitly reconsidered when that meaning changes?
```

Those are areas where ordinary structural modularity is weaker.

If experiments confirm that these four forms of explicitness:

- lower agent context,
- catch semantic omissions,
- reduce long-term drift,
- or allow cheaper models,

then the architecture has a real incremental contribution.

If not, the correct response is not to defend the larger design.

It is to remove the redundant layers and keep the pieces that actually work.

That produces a stronger startup strategy:

> **Start with excellent conventional architecture. Add semantic machinery only where the compiler, module system, contracts, and retrieval layer cannot reliably tell the agent what the system means.**

That principle also protects the project from becoming the kind of over-engineered framework it is explicitly trying to avoid.

---

# 82. Key sources

## Foundational modularity

1. Parnas, D. L. (1972). **On the Criteria To Be Used in Decomposing Systems into Modules.** Communications of the ACM, 15(12), 1053–1058.

Foundational information-hiding result: systems should be decomposed around design decisions likely to change, rather than merely procedural execution steps.

## Repository context and retrieval

2. Li, H. et al. (2026). **ContextBench: A Benchmark for Context Retrieval in Coding Agents.** arXiv:2602.05892.

3. Zhang, S. et al. (2026). **SWE-Explore: Benchmarking How Coding Agents Explore Repositories.** arXiv:2606.07297.

4. Qin, B., Xie, Y. (2026). **Agent Retrieval Bench: Evaluating Repository Context Retrieval for Coding Agents.** arXiv:2607.24882.

5. Zhang, F. et al. (2026). **CORE-Bench: A Comprehensive Benchmark for Code Retrieval in the Era of Agentic Coding.** arXiv:2606.11864.

6. **How Much Static Structure Do Code Agents Need?** 2026. arXiv:2606.26979.

7. **Code Isn’t Memory: A Structural Codebase Index Inside a Coding Agent.** 2026. arXiv:2606.22417.

8. **ARISE: A Repository-level Graph Representation and Interactive Slicing Environment for Agents.** 2026. arXiv:2605.03117.

9. **Lexically Anchored Repository Graph Exploration and Localization.** 2026. arXiv:2605.16352.

10. **LLM Agents Can See Code Repositories.** 2026. arXiv:2606.14061.

## Long-horizon context relevance

11. **SWE-EVO: Benchmarking Coding Agents in Long-Horizon Software Evolution Scenarios.** 2025/2026. arXiv:2512.18470.

## Conventional architecture families used in comparison

12. Domain-Driven Design literature on bounded contexts and aggregates.

13. Ports-and-adapters / hexagonal architecture literature.

14. Clean Architecture and dependency inversion traditions.

15. Actor-model literature on state ownership/message-mediated mutation.

16. Design-by-contract literature on preconditions, postconditions, and invariants.

17. Architecture conformance/testing tools such as ArchUnit, NetArchTest, and dependency-cruiser.

---

# 83. Evidence grading summary

| Proposition | Evidence |
|---|---|
| Good modularity reduces cognitive/change scope | Strong |
| Information hiding already protects likely-change decisions | Strong |
| DDD aggregates already support state ownership/invariant protection | Strong |
| Strong types can provide closed states/exhaustiveness | Strong |
| Architecture tests can mechanically enforce structural boundaries | Strong |
| Repository retrieval remains a major agent bottleneck | Strong current evidence |
| Structural graphs improve agent context/navigation | Strong emerging evidence |
| Modern retrieval completely solves context acquisition | No |
| Dynamic capability frontier adds value beyond ordinary API | Moderate/strong conceptual |
| Obligations are unique to semantic modularity | No |
| OutcomeUnknown requires semantic compiler | No |
| Epistemic state is a general modularity requirement | No |
| Semantic dependency closure adds unique value | Moderate, plausible |
| Semantic migration adds unique value | Strongest plausible incremental mechanism |
| Semantic metadata necessarily reduces tokens | No direct evidence |
| Strong languages eliminate all semantic-layer value | Unclear/probably no |
| Full semantic compiler is necessary | No evidence |
| Semantic islands around consequential domains are viable | Strong architectural plausibility |

---

# 84. Research decision

**Proceed, but narrow the architecture.**

This research does not justify building a universal semantic modularity platform.

It justifies testing a much more specific thesis:

> **After ordinary modularity, strong typing, contracts, and repository retrieval have done their work, explicit semantic dependency and migration information may still capture consequential meaning that structural code organization cannot reliably expose.**

The next experiment should therefore target exactly that residual.

Do not test:

```text
bad architecture
vs
semantic architecture
```

Test:

```text
excellent conventional architecture
vs
excellent conventional architecture
+
one semantic mechanism at a time
```

If:

```text
semantic dependency closure
+
semantic migration
```

does not materially improve the state-split/cross-module-change tasks, the broader semantic compiler thesis should be reduced sharply.

If it does, the architecture becomes much simpler and much stronger:

> **ordinary modules for software structure; semantic contracts only for meaning that must survive change.**
