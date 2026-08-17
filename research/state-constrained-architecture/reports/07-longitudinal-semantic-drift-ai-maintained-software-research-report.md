# AI Research Mission 07 — Longitudinal Semantic Drift in AI-Maintained Software

## Research question

**Does explicit, machine-visible semantic authority prevent repeated AI maintenance from turning temporary assumptions and implementation accidents into durable system truth—and does that materially reduce long-term correctness risk and agent execution cost?**

---

# 1. Executive verdict

The central hypothesis should be divided into three claims because the evidence is very different for each.

### Claim A — software meaning drifts during long-lived maintenance

**Strongly established.**

Decades of software-evolution, architecture-erosion, requirements-traceability, program-comprehension, technical-debt, and API-evolution research establish that long-lived systems accumulate complexity, lose rationale, develop divergence between intended architecture and implementation, and acquire dependencies on behaviors that were not necessarily designed as enduring contracts.

That phenomenon predates AI.

### Claim B — AI agents make this semantic drift worse

**Moderate and rapidly improving evidence, but not yet a settled result.**

Current 2025–2026 research establishes several adjacent facts:

- AI-generated code can introduce maintainability and architecture problems that persist.
- Continuous coding-agent performance falls materially when agents inherit the consequences of their earlier output.
- Sequential benchmarks show quality degradation that one-shot correctness benchmarks miss.
- Current agents still struggle badly with release-level and milestone-level evolution compared with isolated issue repair.
- AI-assisted code volume can increase faster than architectural quality improves.

But the literature does **not yet cleanly demonstrate**:

> AI-maintained systems lose business meaning faster than comparable human-maintained systems.

Most existing studies measure:
- functional failures,
- structural smells,
- code complexity,
- test passing,
- technical debt,

not semantic divergence from an independent business oracle.

So "AI amplifies semantic drift" remains a credible, high-value research hypothesis—not an established fact.

### Claim C — explicit semantic authority can reduce that drift

**Moderately strong architectural case, limited direct AI evidence.**

Requirements traceability, architecture conformance, formal specifications, typed closed-state modeling, dependency analysis, provenance, versioned policy, and truth-maintenance ideas all support portions of the proposed solution.

The strongest architectural principle is:

> **Implementation artifacts should provide evidence about intended semantics, but they should not automatically become semantic authority.**

A test, database column, API fallback, comment, prompt, workaround, or previous AI patch may reflect intended meaning—or may merely reflect history.

The proposed architecture creates a way to distinguish those.

The highest-value mechanism is not simply "use state machines."

It is:

> **Make consequential semantic decisions identifiable, versioned, traceable, and mechanically connected to all implementations that depend on them.**

This can interrupt the likely AI drift loop:

```text
uncertain requirement
    ↓
agent chooses plausible interpretation
    ↓
interpretation becomes code/test/schema
    ↓
later agent sees surviving artifact
    ↓
artifact is mistaken for authority
    ↓
new code depends on it
    ↓
correction cost grows
```

The key missing experiment is exactly the longitudinal benchmark proposed in the mission:

- same initial software,
- same sequence of 50–100 evolving requirements,
- conventional versus semantic architecture,
- agent-generated changes carried forward,
- hidden business-semantic oracle,
- fresh agent sessions,
- periodic ambiguous requirements and product pivots.

That experiment would test something current benchmarks largely do not:

**semantic retention over time.**

---

# 2. Definition of semantic drift

A useful definition is:

> **Semantic drift is the accumulation of system behavior, rules, representations, or dependencies that diverge from currently intended domain meaning without a corresponding explicit and reviewable semantic decision.**

This definition has four requirements.

## 2.1 There must be domain meaning

A mere textual or structural change is not semantic drift.

## 2.2 There must be divergence

Implementation behavior or interpretation differs from the intended meaning.

## 2.3 The divergence is not an explicit accepted evolution

If the business intentionally changes a refund policy, that is semantic evolution.

## 2.4 The divergence persists in system artifacts

The unintended interpretation becomes durable enough to influence future behavior or maintenance.

Examples:

- a temporary API workaround becomes treated as normal business behavior,
- one fallback branch becomes a de facto policy,
- an obsolete test causes future agents to restore obsolete semantics,
- a database field originally meaning "approved by reviewer" gradually becomes interpreted as "approved for fulfillment,"
- an AI-selected default becomes copied into five modules and later appears intentional.

---

# 3. Intentional evolution vs semantic drift

The distinction is critical.

## Intentional semantic evolution

```text
Business decision:
Refund window changes from 30 days to 45 days.

Policy version:
RefundPolicy@12 -> RefundPolicy@13

Affected interpretations are deliberately migrated.
```

This is not drift even though system meaning changed.

## Drift

```text
Agent discovers some 45-day handling in one customer path.

Agent generalizes that behavior.

New test encodes 45 days.

Later agent sees the test and extends the rule elsewhere.

No semantic decision ever changed RefundPolicy@12.
```

The external behavior may eventually look coherent.

It is still drift because the semantics changed through artifact propagation rather than deliberate domain authority.

A useful test is:

> **Can the system identify the semantic decision that authorized the changed meaning?**

If yes, likely evolution.

If no, and consequential behavior changed, likely drift or unresolved assumption.

---

# 4. Human software-evolution literature

The proposed problem has strong roots in classical software evolution.

## 4.1 Lehman's software-evolution work

Lehman's work on E-type systems argues that software embedded in real social or organizational environments must continually change and tends toward increasing complexity unless effort is actively spent controlling that complexity.

This is highly relevant.

The hypothesis does not require AI to create a new law of software evolution.

A more defensible hypothesis is:

> **AI may increase the rate at which change is produced without proportionally increasing the rate at which semantic understanding and architectural control are maintained.**

That could accelerate an already-known evolutionary pressure.

## 4.2 Parnas and software aging

Parnas distinguished causes of software aging including:
- failure to modify software as needs change,
- degradation caused by modifications themselves.

The proposed semantic-drift mechanism fits the second category.

Changes can make a system locally useful while reducing the clarity and stability of its conceptual model.

## 4.3 Implication

AI should initially be treated as an **accelerant of known maintenance dynamics**, not as evidence that traditional maintenance theory is obsolete.

---

# 5. Architecture erosion literature

Architecture erosion is well established.

A 2021 systematic mapping study covering 73 studies found architecture erosion manifests through architectural violations and structural problems and negatively affects software quality and evolution.

Practitioner research similarly finds that evolving systems can diverge from intended architecture through both technical and non-technical causes.

This provides a close structural analogue.

However:

**architecture erosion != semantic drift.**

Architecture erosion asks:

> Is implementation diverging from architectural design?

Semantic drift asks:

> Is implemented business meaning diverging from intended domain meaning?

A system can have pristine module boundaries and still encode the wrong refund rule.

Conversely, a structurally messy system may still preserve business semantics.

Therefore semantic drift deserves separate measurement if the concept proves empirically useful.

---

# 6. Technical debt, semantic debt, and assumption debt

## Technical debt

Broad umbrella covering future cost induced by expedient design/implementation decisions.

## Architecture debt

Future cost due to architectural compromises.

## Requirements debt

Deferred or incomplete requirements work.

## Knowledge/cognitive debt

Loss of developer understanding and organizational knowledge.

## Proposed semantic debt

A useful narrow definition is:

> **Semantic debt is future change and correction cost caused by consequential domain meaning being encoded implicitly, redundantly, ambiguously, or inconsistently rather than through identifiable semantic authority.**

Examples:
- duplicated eligibility rule,
- state meaning inferred from nullable fields,
- undocumented policy embedded in UI code,
- database schema acting as accidental domain model.

## Proposed assumption debt

A narrower concept:

> **Assumption debt is consequential behavior that depends on a proposition whose authority, provenance, or continued validity is unresolved.**

These concepts are useful only if measurable.

Do not create new vocabulary merely to rename technical debt.

They earn distinct status if they predict:
- semantic correction cost,
- context reconstruction cost,
- drift,
- or agent failure

better than existing debt metrics.

---

# 7. Requirements and design-rationale loss

Requirements traceability literature strongly supports the general problem.

A systematic mapping study covering 63 studies found traceability supports numerous maintenance/evolution activities, with change management the most frequently supported area.

The same literature identifies the core economic drawback:

> establishing and maintaining trace links is expensive.

That is highly relevant to the proposed semantic architecture.

The opportunity is not to rediscover traceability.

It is to make traceability more operational and cheaper.

Traditional link:

```text
Requirement R42
    ↔
Source file PaymentService.cs
```

Proposed semantic link:

```text
RefundPolicy@13
    ↓
SC-REFUND-ELIGIBILITY
    ↓
CanRefund
    ↓
RefundTransition
    ↓
UI eligibility
    ↓
API operation
```

The latter is executable.

It can support:
- impact analysis,
- compilation,
- agent context generation,
- migration validation.

That is potentially more valuable than a passive trace matrix.

---

# 8. AI-specific drift mechanism

The strongest AI-specific hypothesis is **artifact-authority confusion**.

Coding agents generally infer intent from the artifacts they can observe:

- code,
- tests,
- schemas,
- API shape,
- documentation,
- names,
- examples,
- prior patches,
- prompts.

That is necessary.

The repository is often the best source available.

But it creates a problem:

> **survival is evidence of use, not proof of semantic authority.**

A later agent generally does not know whether a line exists because:

1. the business explicitly required it,
2. an engineer deliberately chose it,
3. an engineer worked around a vendor bug,
4. an old requirement used to require it,
5. a previous AI guessed,
6. a test accidentally entrenched it,
7. a schema constraint forced it,
8. nobody noticed it.

A human expert may possess institutional context that distinguishes these.

A fresh agent usually does not.

This is the distinctive mechanism worth testing.

---

# 9. Current evidence for long-horizon AI degradation

The 2026 research landscape is materially stronger than one-shot SWE-bench-era evidence.

## 9.1 SWE-EVO

SWE-EVO evaluates release-scale software evolution across mature repositories.

Reported comparison:

- GPT-5 with OpenHands resolved roughly 21% of SWE-EVO tasks,
- versus approximately 65% on SWE-bench Verified in the reported comparison.

The important point is not the specific model ranking.

It is the enormous gap between:
- isolated issue resolution,
- coordinated long-horizon evolution.

This shows one-shot coding success does not imply software-evolution competence.

## 9.2 SWE-Milestone / EvoClaw

Continuous-evolution work preserves temporal dependency across changes rather than resetting the repository for each task.

SWE-Milestone explicitly argues that isolated benchmarks fail to capture accumulated technical debt and cross-task error propagation.

Its related EvoClaw results report pass rates dropping substantially under continuous evolution compared with isolated evaluation.

Again:

this is evidence for **compounding**, not specifically semantic drift.

## 9.3 SlopCodeBench

SlopCodeBench is particularly important for this hypothesis.

Its design carries the agent's previous workspace forward:

```text
y1 = agent(spec1, empty)
y2 = agent(spec2, y1)
y3 = agent(spec3, y2)
...
```

The prior conversation is not provided.

The agent must infer the system from the code it previously created.

That is almost exactly the proposed mechanism.

The benchmark explicitly notes:

> a bad architectural decision at checkpoint i becomes the foundation for checkpoint i+1.

It measures quality continuously, rather than replacing prior agent output with a gold implementation.

This establishes that **self-created precedent matters**.

What it does not yet measure is whether business meaning itself diverges.

## 9.4 Large-scale AI-generated debt studies

A 2026 study of more than 300,000 verified AI-authored commits across thousands of repositories found hundreds of thousands of static-analysis issues attributable to AI-authored changes, with a meaningful portion still surviving in later repository revisions.

Other 2026 work reports architecture/code smells and structural quality problems in agent-generated systems.

These results weaken any assumption that:

> AI-generated code is automatically self-cleaning because future AI can repair it.

Some generated problems persist.

---

# 10. Is AI worse than humans?

This remains unresolved.

There are reasons AI could be worse:

- no stable institutional memory,
- fast local optimization,
- pattern imitation,
- high code-generation volume,
- tendency to infer intent from surviving artifacts,
- cheap replication of existing patterns,
- short task horizons.

There are also reasons AI could be better:

- cheap repository-wide search,
- consistent application of patterns,
- no fatigue,
- ability to inspect large numbers of artifacts,
- automated test/compiler loops,
- persistent machine-readable memory,
- easy re-analysis when context changes.

Some empirical work finds AI-assisted repositories do not necessarily show worse structural metrics across all dimensions.

Therefore the research should **not** start with:

"AI causes more drift."

It should start with:

> **Under what conditions does AI maintenance amplify or reduce existing semantic drift mechanisms relative to human and human+AI maintenance?**

---

# 11. Pattern propagation

LLMs are intentionally good at pattern continuation.

Repository agents frequently exploit:
- nearby implementations,
- naming conventions,
- similar handlers,
- existing architecture,
- test style.

This is economically useful.

It also implies a symmetric risk:

> good precedent scales; bad precedent scales.

If one accidental rule appears in five places because agents copied the established pattern, later agents may treat repetition as independent evidence that the behavior is intentional.

This resembles evidence-lineage problems from epistemic systems.

Semantic provenance can reveal:

```text
Module A
Module B
Module C
Module D

all ultimately implement semantic rule SC-17
```

or:

```text
all descend from temporary workaround W-5
```

That is much more informative than raw repetition.

---

# 12. Test entrenchment

Tests are powerful authority artifacts because agents optimize against them.

But a passing test establishes:

> implementation matches the assertion.

It does not establish:

> the assertion reflects current business intent.

Stale-test failure mode:

```text
Business intentionally changes Policy P.
Implementation updated.
One old test still encodes P-1.

Agent runs tests.
Old test fails.
Agent restores P-1 behavior.
```

Without semantic authority, the agent faces conflicting artifacts.

With explicit authority:

```text
Policy@8 is current.
Test T17 traces to Policy@7.
```

The correct action becomes much easier to identify.

Generated semantic tests could reduce this class of drift because tests derive from the current authority.

But that creates correlated failure if the authority is wrong.

---

# 13. Documentation and summary entrenchment

AI makes documentation easier to create.

That is useful but potentially dangerous.

Cycle:

```text
implementation accident
    ↓
AI summarizes repository
    ↓
summary describes accident as intended behavior
    ↓
later agent reads summary
    ↓
summary becomes apparent rationale
```

This is a new form of **authority amplification**.

A generated semantic summary is safer only if it derives mechanically from authoritative semantic declarations.

An AI-written summary should retain provenance:

```text
Summary generated from implementation artifacts
Not semantic authority
```

This distinction may become increasingly important as agent-context systems depend on repository summaries.

---

# 14. Database semantic drift

Database schemas are unusually sticky artifacts.

Historical decisions survive in:

- nullable fields,
- overloaded status values,
- denormalized booleans,
- magic codes,
- legacy tables,
- migration scripts.

Agents can easily infer domain meaning from those structures.

But persistence representation and semantic authority are different.

Example:

```text
isApproved = true
```

may historically mean:
- underwriting completed,
- human approved,
- eligible for funding,
- legacy migration default.

A semantic architecture should make persistence an implementation of state—not the definition of state.

---

# 15. API contract entrenchment and Hyrum's Law

Hyrum's Law states, in essence, that with enough API consumers, every observable behavior may eventually be depended upon.

That is highly relevant.

A temporary implementation artifact can become real external semantics because clients depend on it.

Once that happens, the distinction becomes subtle:

- it may have started as drift,
- but ecosystem dependence makes it a real compatibility constraint.

AI agents may amplify this in two ways:

1. generating more consumers more quickly,
2. inferring intended contract from observed behavior.

Therefore semantic authority cannot simply declare incidental behavior nonexistent.

It needs a path for:

```text
incidental behavior
    ↓
observed external dependency
    ↓
explicit compatibility decision
    ↓
promoted semantic contract
```

This turns accidental reality into deliberate authority when necessary.

---

# 16. Prompt and agent-instruction drift

Modern software behavior can be spread across:

- code,
- prompts,
- tool descriptions,
- policy text,
- system instructions,
- workflow definitions.

That makes semantic drift harder to observe.

Example:

```text
backend allows refund
tool description says refund unavailable after shipment
system prompt says ask human
UI disables button
```

All may encode different semantics.

Semantic compilation could provide value by deriving or validating these surfaces from one set of consequential rules.

This may be a particularly AI-native source of semantic fragmentation.

---

# 17. Semantic authority model

A practical hierarchy is:

## Tier 1 — Domain semantic authority

- state identities,
- transition identities,
- policies,
- verified decision rules,
- capability conditions,
- evidence requirements.

## Tier 2 — Generated/enforced interpretation

- compiler checks,
- runtime guards,
- generated tests,
- generated agent tools,
- semantic dependency graph.

## Tier 3 — Application implementation

- service code,
- UI,
- persistence,
- adapters.

## Tier 4 — Probabilistic interpretation

- AI patches,
- summaries,
- suggestions,
- inferred assumptions.

The rule is not:

> lower tiers can never reveal a problem in higher tiers.

They absolutely can.

The rule is:

> **lower-tier artifacts cannot silently redefine higher-tier semantics.**

Instead they create:
- proposal,
- conflict,
- assumption,
- migration request.

This preserves both authority and adaptability.

---

# 18. Provenance implications

Every consequential semantic rule does not need an essay.

Useful provenance may be compact:

```text
SemanticId: SC-REFUND-WINDOW
Introduced: Decision D-117
Reason: Regulatory change
Source: Policy document P-22
Version: 13
Supersedes: version 12
Effective: 2026-09-01
```

This allows later agents to answer:

> Why does this rule exist?

without inventing a plausible story.

The key value is **rationale recovery accuracy**.

Provenance should be:
- machine-linked,
- concise,
- immutable historically,
- lazily retrievable.

Too much provenance becomes bureaucratic noise.

---

# 19. Semantic IDs

Stable identifiers can distinguish:

### Rename

```text
SC-APPROVED
label "Approved"
→ label "Fully Approved"
```

same meaning.

### Replacement

```text
SC-APPROVED deprecated
SC-ELIGIBLE created
```

different meaning.

### Split

```text
SC-APPROVED
→ SC-CONDITIONAL-APPROVAL
→ SC-FULL-APPROVAL
```

one semantic identity becomes two.

This matters because text-based search and git diff often cannot distinguish them reliably.

Stable IDs turn semantic evolution into explicit operations.

---

# 20. Semantic migration

State splitting is one of the strongest examples.

Original:

```text
Approved
```

New:

```text
ConditionallyApproved
FullyApproved
```

Every consequential interpretation of `Approved` must now receive disposition.

Possible dispositions:

```text
CanShip
    FullyApproved -> true
    ConditionallyApproved -> false

CanFund
    FullyApproved -> true
    ConditionallyApproved -> policy dependent
```

A compiler or migration checker can surface unresolved interpretations.

This prevents a default branch from silently deciding the meaning.

This is not full formal verification.

It is **migration completeness enforcement**.

That is likely a high-ROI feature.

---

# 21. Wildcard/default drift

The mission's example is strong:

```text
Captured -> CanRefund
_        -> CannotRefund
```

Later add:

```text
Disputed
```

The program automatically concludes:

```text
Disputed -> CannotRefund
```

No human or agent explicitly made that semantic decision.

This is a precise example of semantic drift.

The implementation remains:
- type-correct,
- compiling,
- testable.

The semantic problem is hidden.

For consequential closed state families:

> **New members should normally force explicit interpretation.**

Wildcards should require:
- declared semantic equivalence,
- or explicit exemption.

This converts implicit inheritance into reviewed meaning.

---

# 22. Semantic dependency closure

Let:

`D(S)` = all consequential interpretations dependent on semantic concept S.

A semantic migration is complete when every affected member of `D(S)` has an explicit new disposition.

This resembles:
- requirements traceability,
- change-impact analysis,
- dependency graphs,
- program slicing.

The AI-specific benefit is context generation.

Instead of:

```text
grep Approved
search synonyms
read tests
inspect SQL
guess impact
```

the environment can produce:

```text
Change SC-APPROVED affects:
    CanShip
    CanFund
    ApprovalDisplay
    FundingPolicy
    ApprovalAudit
```

This can reduce both stale dependency risk and agent exploration cost.

The challenge is graph completeness.

A bad dependency graph creates false confidence.

---

# 23. Semantic Change Coverage

The proposed metric is useful:

```text
SCC =
mechanically surfaced consequential interpretations
/
actually affected consequential interpretations
```

This can be evaluated against a hidden semantic oracle.

Interpretation:

- SCC = 1.0 means all affected semantic interpretations were surfaced.
- Lower SCC means some dependencies remained invisible.

A complementary metric is needed:

## Semantic Impact Precision

```text
SIP =
surfaced interpretations actually affected
/
all surfaced interpretations
```

Otherwise a system can achieve perfect SCC by flagging everything.

The target is high:
- recall,
- precision.

---

# 24. Epistemic-state implications

A consequential proposition introduced by an agent may be:

```text
ProposedAssumption
```

rather than immediately becoming domain authority.

Example:

Task:
"Premium customers can cancel later."

Agent chooses:
`48 hours`.

If no requirement establishes 48 hours:

```text
Assumption A-27:
PremiumCancellationWindow = 48h
Origin: Agent inference
Authority: unresolved
```

Implementation may be allowed in an experimental environment.

But promotion to durable semantic core requires:
- human decision,
- trusted policy,
- or other declared authority.

This directly connects semantic drift control with epistemic-state research.

---

# 25. Assumption-review obligations

Not every assumption deserves review.

Otherwise the system becomes unusable.

A review obligation should be generated when an assumption is:

1. consequential,
2. persistent,
3. likely to gain downstream dependencies,
4. required for a production commitment,
5. not already covered by explicit risk policy.

Example:

```text
O-118 ValidatePremiumCancellationWindow
```

Low-consequence UI spacing assumption:

no obligation.

This preserves architecture focus.

---

# 26. Semantic diff

Git diff answers:

> Which text changed?

A semantic diff should answer:

> Which domain meaning changed?

Example:

```text
Semantic Diff

State added:
    SC-DISPUTED

Transition added:
    Capture -> Disputed

Capability changed:
    CanRefund now permits Disputed

Policy changed:
    RefundPolicy@12 -> @13

Unresolved impact:
    RefundDisplay
    SettlementReconciliation
```

This could improve:
- AI review,
- human review,
- audit,
- migration quality.

It may also act as compact agent context.

---

# 27. Longitudinal context-cost hypothesis

Conventional maintenance often requires reconstructing semantics from increasing historical artifacts.

A fresh agent may need to read:

- code,
- tests,
- migrations,
- docs,
- tickets,
- comments,
- schema,
- history.

As the system ages, this reconstruction may become more expensive.

The semantic architecture hypothesis is:

```text
current semantic slice
+
relevant migration history
+
dependency impact
```

can replace much of that archaeology.

This produces a measurable prediction:

> **Context reconstruction cost should grow more slowly with system age.**

This is more important than a one-time token reduction.

---

# 28. Context growth rate

Measure at task indices:

```text
1
10
25
50
75
100
```

Record before first correct edit:

- tokens,
- files read,
- search operations,
- graph queries,
- time.

Fit:

```text
TaskIndex -> ContextReconstructionCost
```

Compare slopes.

The strongest economic result would be:

```text
slope_semantic << slope_conventional
```

even if the semantic architecture is more expensive initially.

---

# 29. Semantic context half-life

This is a useful concept if operationalized.

Definition:

> **The semantic context half-life of a generated summary is the amount of system evolution after which the summary's factual/semantic accuracy falls below an agreed threshold.**

Experiment:

- generate repository summary at T0,
- apply N semantic changes,
- test summary claims after each change.

Compare:

1. AI-written repository summary,
2. compiler-generated semantic projection.

Expected result:

A generated projection should have effectively no staleness if regenerated from current authority.

An AI summary will require explicit invalidation/re-generation.

---

# 30. Persistent memory counterargument

Persistent agent memory may reduce reconstruction cost.

This is a serious alternative.

But memory introduces its own drift:

- stale facts,
- conflicting observations,
- outdated policy,
- previous AI assumptions,
- unverified rationale.

Memory answers:

> What did previous agents believe or record?

Semantic authority answers:

> What currently defines the consequential behavior?

Both can coexist.

A useful architecture is:

```text
Memory:
    historical observations, explanations, discoveries

Semantic core:
    authoritative current meaning

Provenance:
    connection between them
```

Persistent memory therefore does not eliminate the semantic-authority problem.

---

# 31. Retrieval counterargument

Modern retrieval may solve much repository exploration.

Embeddings, symbol graphs, code search, RAG, and repository maps can help agents find relevant artifacts.

But retrieval solves:

> Where is potentially relevant information?

It does not necessarily solve:

> Which artifact is authoritative when artifacts disagree?

Example:

Search returns:
- test says 30 days,
- wiki says 45,
- code says 60,
- migration says 30,
- comment says temporary.

Better retrieval does not resolve authority.

This is the strongest distinction between:
- information retrieval,
- semantic governance.

---

# 32. Documentation/ADR counterargument

High-quality ADRs and documentation can preserve rationale cheaply.

They should absolutely be used.

The limitation is enforcement.

ADRs usually do not mechanically prevent:

- bypassing transition,
- adding wildcard,
- implementing obsolete policy,
- failing to update dependent semantics.

The likely efficient architecture is:

```text
ADR / decision provenance
        ↓
machine-linked semantic rule
        ↓
compiler/runtime enforcement
```

Not:

replace all prose documentation with formal models.

---

# 33. DDD counterargument

Strong Domain-Driven Design already provides:

- bounded contexts,
- aggregates,
- ubiquitous language,
- explicit domain concepts,
- controlled invariants.

This may capture much of the benefit.

The proposed architecture's incremental value is primarily:

- explicit semantic identity,
- machine-enforced migration,
- dependency closure,
- epistemic provenance,
- capability derivation,
- obligation generation,
- agent-specific semantic context.

Therefore the benchmark should include a **competent conventional/DDD baseline**, not a deliberately bad CRUD application.

Otherwise the experiment will prove little.

---

# 34. Strong-types counterargument

F#, Rust, Kotlin, Scala, Haskell, and disciplined TypeScript/C# can already encode:

- closed state families,
- exhaustive pattern matching,
- immutability,
- typed transitions,
- optionality,
- ownership.

A semantic compiler adds value only where the language/compiler cannot already answer:

- why rule exists,
- which policy version owns it,
- which cross-language artifact implements it,
- which prompts/tools depend on it,
- which assumption introduced it,
- which semantic migration remains unresolved.

Therefore:

> **Use language/compiler guarantees first. Add semantic infrastructure only for information the normal type system cannot economically represent.**

---

# 35. Formal-methods counterargument

Formal methods can verify much stronger properties.

Examples:
- TLA+,
- Alloy,
- refinement types,
- proof assistants,
- model checking.

But formal verification proves conformance to a specification.

It does not prove:

> the business intended the specification.

This research concerns partly a **specification authority and evolution** problem.

The proposed architecture may therefore be best understood as:

> a practical operational layer connecting domain decisions to compiler/runtime enforcement,

rather than a competitor to formal methods.

Formal tools can strengthen the trusted semantic core where consequence justifies them.

---

# 36. Wrong-specification risk

This is the most dangerous failure mode.

If the authoritative semantic specification is wrong:

```text
semantic core wrong
    ↓
generated tests wrong
    ↓
capabilities wrong
    ↓
agent context wrong
    ↓
all implementations consistently wrong
```

A conventional messy system may at least contain contradictory clues.

A centralized semantic system can create **correlated error**.

Mitigations:

- independent acceptance examples,
- policy provenance,
- specification mutation testing,
- human review for consequential changes,
- external business oracle,
- differential validation,
- explicit epistemic status for uncertain semantics.

Consistency is not truth.

---

# 37. Specification correction

Central authority also has an advantage when it is corrected.

Suppose:

`SC-REFUND-WINDOW` was wrong.

If dependencies are explicit:

```text
correct SC-REFUND-WINDOW
    ↓
surface every dependent interpretation
    ↓
invalidate generated tests
    ↓
recalculate capabilities
    ↓
produce migration obligations
```

This may make correcting a centralized error cheaper than discovering and repairing an implicit duplicated rule across a conventional system.

That is an important symmetry:

> centralization amplifies both wrongness and repair leverage.

The benchmark must measure both.

---

# 38. Over-modeling and rigidity

The architecture can fail by making every product idea "semantic."

That creates:
- migration overhead,
- design ceremony,
- resistance to experimentation,
- ossification,
- slow pivots.

Recommended classification:

## Experimental

May change quickly.
Minimal enforcement.

## Provisional

Used operationally but expected to evolve.
Some provenance and controlled boundaries.

## Durable

Consequential, validated, reused.
Strong semantic authority and enforcement.

Promotion should be explicit but lightweight.

This allows a startup to explore without freezing hypotheses prematurely.

---

# 39. Minimum semantic core

Only encode a concept in the trusted semantic core if one or more is true:

- incorrect interpretation creates material consequence,
- multiple modules depend on it,
- agents repeatedly need to reconstruct it,
- it governs authority/capability,
- it affects external effects,
- migration mistakes are expensive,
- historical audit matters.

Do not encode:
- transient UI state,
- harmless formatting,
- speculative product detail,
- trivial local calculations.

This keeps the system adaptable.

---

# 40. Volatility classification

A useful metadata field:

```text
semanticStability:
    Experimental
    Provisional
    Durable
```

This does not mean the concept cannot change.

It informs:
- migration expectations,
- review requirements,
- agent context,
- allowed shortcuts.

The hypothesis to test:

> explicit volatility prevents experimental assumptions from silently becoming durable semantics.

---

# 41. Deprecation and orphan detection

Semantic removal should be explicit.

Example:

```text
SC-LEGACY-APPROVAL deprecated
replacement: none
effective removal: version 22
```

Compiler/report can surface:
- remaining consumers,
- unused capabilities,
- reachable but obsolete paths,
- stale tests,
- prompt references.

This is stronger than static dead-code analysis because semantically obsolete code may still execute.

---

# 42. Semantic health report

A periodic report could include:

- unresolved assumptions,
- orphaned semantic IDs,
- stale policy versions,
- wildcard/default violations,
- bypassed transitions,
- duplicated semantic implementations,
- unfulfilled migration obligations,
- high-fan-out concepts,
- stale evidence,
- direct persistence mutations.

This should not become a generic architecture dashboard.

Its value is:

> identify places where semantic authority is weakening.

If useful, the report also becomes compact agent context.

---

# 43. Metrics

## Semantic Drift Rate

```text
SDR =
unintended semantic deviations
/
maintenance tasks
```

Requires hidden oracle.

## Semantic Retention

```text
SR =
previous validated semantics still correct
/
previous semantics expected to survive
```

## Assumption Accumulation

Count/weighted count of unresolved consequential assumptions after N tasks.

## Assumption Survival Rate

```text
ASR(N) =
unsupported assumptions still consequential after N later changes
/
unsupported assumptions introduced
```

## Stale Dependency Rate

```text
SDR2 =
affected semantic interpretations not updated
/
affected interpretations
```

## Semantic Change Coverage

```text
SCC =
mechanically surfaced affected interpretations
/
all actually affected interpretations
```

## Semantic Impact Precision

```text
SIP =
surfaced interpretations actually affected
/
all surfaced interpretations
```

## Rationale Recovery Accuracy

```text
RRA =
correct provenance explanations
/
semantic decisions queried
```

## Authority Violation Count

Number of semantic behaviors introduced outside authorized semantic paths.

## Constraint Erosion Rate

Count of:
- wildcard additions,
- public-constructor openings,
- analyzer suppressions,
- direct state mutation,
- capability bypasses.

## Context Reconstruction Cost

Tokens + file reads + searches before first semantically correct edit.

## Cost Per Semantically Correct Change

```text
CPSC =
total execution + correction + review cost
/
semantically correct changes
```

---

# 44. Longitudinal benchmark design

The benchmark should improve on current long-horizon work by evaluating **semantic retention**, not merely passing tests or structural quality.

## 44.1 Repositories

Create two implementations with identical externally visible V1 behavior.

### A — Strong conventional baseline

Use:
- good modularity,
- good types,
- normal tests,
- ADRs/docs,
- competent engineering.

### B — Semantic architecture

Add:
- semantic IDs,
- explicit state ownership,
- exhaustive interpretation,
- semantic dependency links,
- versioned policy,
- protected transitions,
- semantic migration enforcement,
- provenance,
- epistemic assumptions,
- generated semantic impact.

Do not intentionally handicap A.

## 44.2 Hidden oracle

Maintain an evaluator-only canonical semantic specification.

Agents do not receive the full oracle.

After each change evaluate:
- new requirement correctness,
- old semantic retention,
- unintended behavior.

This is essential.

Otherwise the repository becomes its own truth source and drift cannot be distinguished from self-consistency.

---

# 45. Task sequence

Use 75 or 100 sequential changes.

Include:

- local features,
- state additions,
- state splits,
- merges,
- policy changes,
- UI requests,
- bug fixes,
- cross-module changes,
- temporary workarounds,
- ambiguous requirements,
- external effects,
- API compatibility changes,
- product pivot.

Some tasks should deliberately create opportunities for accidental assumptions.

---

# 46. Fresh-agent protocol

Every task should begin with a fresh session.

This simulates:
- agent turnover,
- missing institutional memory,
- real autonomous execution.

The agent can inspect only:
- current repository,
- configured project memory,
- semantic system if present.

This tests whether the repository remains self-explanatory.

A secondary condition can use persistent memory.

---

# 47. Hidden-assumption experiment

Task:

> "Allow premium customers to cancel later."

Do not specify exact extension.

Measure whether agent:

1. asks/flags ambiguity,
2. chooses an arbitrary rule,
3. records it as assumption,
4. silently encodes it.

Later tasks should encounter the chosen behavior.

Measure whether it gains authority through repetition.

---

# 48. Temporary workaround experiment

Task explicitly states:

> "Use this fallback temporarily until provider API V3 is available."

Ten tasks later:
- V3 becomes available.

Measure whether:
- workaround is identifiable,
- agent removes it,
- dependent semantics remain,
- later code treats fallback as permanent contract.

Provenance should provide a large advantage here if the hypothesis is correct.

---

# 49. Bug-as-feature experiment

Inject behavior known by the hidden oracle to be a bug.

Leave it for several changes.

Later agent sees:
- code,
- tests,
- consumers.

Measure whether bug becomes:
- copied,
- tested,
- documented,
- defended.

Then explicitly reveal the intended rule.

Measure correction fan-out.

This directly tests artifact-authority confusion.

---

# 50. Stale-test experiment

Change a business policy intentionally.

Leave one old test.

Observe:

- conventional agent restores old behavior,
- agent questions test,
- semantic system marks test as linked to superseded policy.

This tests authority hierarchy.

---

# 51. Copy-pattern propagation experiment

Introduce one questionable implementation pattern.

Give future tasks in neighboring modules.

Track number of descendants after:
- 5,
- 10,
- 20 changes.

Use provenance or structural similarity to identify copies.

This tests whether AI accelerates precedent propagation.

---

# 52. Rename vs semantic-split experiment

Scenario A:

```text
Approved -> FullyApproved
```

label-only rename.

Scenario B:

```text
Approved
→ ConditionallyApproved
→ FullyApproved
```

semantic split.

Measure whether agents:
- preserve identity in A,
- redistribute dependencies explicitly in B.

Stable semantic IDs should help.

---

# 53. Policy-version experiment

Change a policy twice.

Then ask:

> Why was transaction T approved 20 tasks ago?

Score against actual historical policy.

This measures:
- rationale recovery,
- temporal semantic accuracy,
- false retrospective reinterpretation.

---

# 54. Product-pivot experiment

After task 40:

invalidate one major product assumption.

Example:

Old:
`Every order must receive underwriting approval.`

New:
`Low-risk orders bypass underwriting.`

Measure after 20 more tasks:
- obsolete semantic remnants,
- stale tests,
- unused states,
- workaround persistence,
- context needed,
- migration cost.

This tests both drift resistance and rigidity.

---

# 55. Parallel-change experiment

Two agents work concurrently.

Agent A:
- partial refunds.

Agent B:
- dispute handling.

Both affect payment semantics.

Measure:
- textual merge conflicts,
- hidden semantic conflicts,
- inconsistent policies,
- migration obligations.

Semantic dependency graph should surface non-textual overlap.

---

# 56. Different-model handoff

Rotate model families every 5–10 tasks.

This tests whether explicit semantics reduce variation caused by different model priors and coding styles.

Measure:
- semantic retention,
- rationale recovery,
- context reconstruction.

---

# 57. Context-limit experiment

Run with:
- generous context,
- constrained context.

Prediction:

Semantic architecture should degrade more gracefully because:
- impacted semantic slices are machine-generated,
- agents do not need to rediscover as much context.

If advantage disappears under generous context, the architecture may primarily be a context-compression tool.

That is still economically useful.

---

# 58. Ablation plan

Test B without each mechanism.

1. no semantic provenance,
2. no dependency closure,
3. no migration enforcement,
4. allow wildcard/default,
5. no epistemic assumption tracking,
6. no policy versioning,
7. no semantic IDs,
8. no generated context.

Measure marginal effect on:
- drift,
- retention,
- context,
- cost.

This answers:

> Which mechanisms actually matter?

A full semantic compiler may not be necessary.

---

# 59. Wrong-specification falsification

Deliberately introduce one wrong authoritative semantic rule.

Measure whether the semantic architecture:
- propagates the error more consistently,
- creates more correlated failures,
- hides contradictory implementation evidence.

Then correct it.

Measure whether dependency closure makes correction faster and more complete.

This is essential.

A benchmark that tests only correct specifications would overstate the architecture.

---

# 60. Architecture self-defense

Track agent attempts to weaken constraints:

```text
make constructor public
add wildcard/default
disable analyzer
cast around type
direct SQL update
bypass capability
change generated file
suppress failing test
```

A strong architecture should mechanically detect many of these.

Metric:

```text
Constraint Defense Rate =
blocked erosion attempts
/
all erosion attempts
```

Also track whether agents learn to avoid attacking constraints over time.

---

# 61. Human comparison

Include at least a smaller human baseline if economically possible.

Conditions:

1. human,
2. human + AI,
3. agent,
4. agent + semantic architecture.

Otherwise conclusions should be limited to:

> semantic architecture changes AI-agent maintenance behavior.

Do not infer:

> AI is worse than humans.

---

# 62. Economic model

For N sequential tasks:

```text
TotalMaintenanceCost(N) =
    EnvironmentConstruction
    + SemanticMaintenance
    + AgentInference
    + Retrieval/Tools
    + HumanReview
    + Rework
    + EscapedSemanticDefects
```

The architecture is economically interesting if:

```text
d(CostSemantic)/dN
<
d(CostConventional)/dN
```

after initial investment.

The most valuable result may be a lower **cost growth slope**, not lower first-task cost.

---

# 63. Longitudinal cost model

Record cumulative:

```text
CumulativeTokens(N)
CumulativeToolCalls(N)
CumulativeHumanMinutes(N)
CumulativeSemanticDefects(N)
CumulativeRepairCost(N)
```

Plot against task count.

Three possible outcomes:

## Outcome A — semantic advantage compounds

Cost gap widens over time.

Strong support.

## Outcome B — fixed advantage

Both slopes similar.

Architecture helps but does not change longitudinal economics.

## Outcome C — semantic maintenance dominates

Semantic architecture becomes more expensive over time.

Hypothesis weakened.

---

# 64. Semantic fan-out

For each semantic rule:

```text
FanOut(S) = number of consequential dependents
```

Track growth over time.

Hidden assumptions with increasing fan-out are especially dangerous.

Proposed risk score:

```text
AssumptionRisk =
consequence
×
semantic fan-out
×
age
×
authority uncertainty
```

This could prioritize review obligations.

---

# 65. Repair cost of old assumptions

When an unsupported assumption is finally corrected, measure:

- files changed,
- tests changed,
- semantic nodes changed,
- database migrations,
- agent tokens,
- human decisions.

Hypothesis:

> correction cost rises with downstream fan-out and assumption age.

The semantic architecture should either:
- surface the assumption earlier,
- or make dependents easier to locate.

---

# 66. Code-generation volume implication

AI reduces the marginal cost of producing code.

That may change the scarce resource from:

**writing**

to:

**understanding and governance**.

Current empirical studies provide some evidence that AI adoption can increase code volume while quality/debt does not improve proportionally.

This supports—but does not prove—the strategic concern:

> an organization can create semantic surface area faster than humans can understand it.

If true, explicit semantic authority becomes more valuable as generation throughput rises.

---

# 67. Legacy-system implications

Legacy systems contain decades of implicit semantics.

An agent must reconstruct meaning from:
- code,
- tests,
- data,
- schema,
- tickets,
- behavior.

That reconstruction has explicit token/tool cost.

Therefore AI may make legacy semantic debt economically measurable for the first time.

Possible migration workflow:

```text
AI extracts candidate semantic model
    ↓
human/domain expert validates
    ↓
semantic IDs established
    ↓
dependencies linked incrementally
    ↓
future agent changes use authority layer
```

The critical step is human/domain validation.

AI reverse engineering should produce:

`candidate semantics`

not authoritative truth.

---

# 68. What existing research already supports

## Strongly supported

- Long-lived software requires continuing evolution.
- Complexity and erosion can accumulate without active control.
- Architecture erosion is a real maintenance problem.
- Requirements traceability improves change-impact and maintenance activities, though maintaining trace links is costly.
- Observable implementation behavior can become depended upon regardless of intended API contract.
- Long-horizon coding tasks are materially harder for current agents than isolated issue repair.
- Continuous agent evolution exposes failure modes hidden by one-shot benchmarks.
- AI-generated code can introduce maintainability issues that persist.

## Moderately supported

- AI-generated/agent-generated systems can accumulate structural quality degradation over repeated work.
- Persistent repositories create compounding effects because agents inherit their own earlier decisions.
- AI adoption can increase code volume without proportionate architectural-quality improvement.

---

# 69. What remains speculative

The following are not yet established:

1. AI agents cause **semantic** drift faster than human developers.
2. Pattern imitation is a primary causal mechanism of semantic drift.
3. Test/documentation artifacts become semantic authority more often under AI maintenance.
4. Explicit semantic authority materially lowers drift.
5. Semantic dependency closure materially lowers long-term context growth.
6. Stable semantic IDs materially improve agent interpretation.
7. Assumption obligations reduce drift without overwhelming teams.
8. Semantic architecture pays for itself economically.
9. Smaller models benefit disproportionately from semantic authority.
10. Semantic context remains bounded as repositories become very large.

These are research targets.

---

# 70. Recommended architecture changes

Based on the evidence, prioritize the smallest mechanisms that directly address longitudinal risk.

## 1. Stable semantic IDs

Cheap and foundational.

## 2. Closed/exhaustive consequential state interpretation

Prevents new states inheriting accidental defaults.

## 3. Explicit semantic migration

State split/merge/replacement must redistribute dependents.

## 4. Versioned policy

Preserves historical meaning.

## 5. Machine-linked semantic provenance

Answer "why does this rule exist?"

## 6. Semantic dependency impact

Generate affected interpretations.

## 7. Explicit agent assumptions

Do not let unsupported consequential choices silently become durable truth.

## 8. Semantic diff

Give humans and agents compact change context.

## 9. Constraint-defense checks

Prevent agents from weakening the architecture for convenience.

Do **not** initially build:
- universal ontology,
- full proof system,
- giant knowledge graph,
- formal model of every product hypothesis.

---

# 71. Highest-value experiment

The best first experiment is smaller than a 100-task benchmark but preserves the longitudinal mechanism.

## 20-task pilot

Two repositories:

- competent conventional architecture,
- semantic architecture.

Same model.
Fresh context each task.

Sequence includes:

1. normal feature,
2. state addition,
3. ambiguous requirement,
4. temporary workaround,
5. related feature,
6. copied-pattern opportunity,
7. policy change,
8. stale test,
9. bug that survives,
10. cross-module change,
11. rename,
12. state split,
13. API compatibility request,
14. second policy change,
15. agent handoff,
16. conflicting requirement,
17. assumption correction,
18. specification bug correction,
19. mini product pivot,
20. rationale explanation.

Measure:

- semantic retention,
- assumption survival,
- context reconstruction,
- semantic change coverage,
- correction fan-out,
- total cost.

If no meaningful signal appears in 20 tasks, the 100-task study may not be justified.

---

# 72. Final verdict

## Does longitudinal semantic drift exist in conventional software?

**Strongly established**, broadly understood through software evolution, requirements drift, architecture erosion, design-rationale loss, technical debt, and accidental API dependence.

The exact term "semantic drift" is less standardized, but the underlying phenomena are well established.

## Is there evidence AI agents amplify it?

**Moderate evidence for adjacent long-horizon degradation; weak-to-moderate direct evidence for semantic drift specifically.**

Current continuous-agent benchmarks and AI technical-debt studies show compounding and persistence. They do not yet isolate divergence from business meaning.

## Does explicit semantic authority plausibly reduce it?

**Moderate to strong architectural plausibility.**

Traceability, conformance, explicit state modeling, provenance, versioning, and formal methods all support constituent mechanisms.

Direct longitudinal AI validation is missing.

## Does semantic dependency closure plausibly reduce stale assumptions?

**Moderate.**

Change-impact and traceability literature strongly support surfacing dependencies. Complete business-semantic closure remains difficult.

## Does provenance plausibly reduce rationale loss?

**Strong.**

Provenance does not guarantee good decisions but materially improves the ability to identify why and where a rule originated.

## Does semantic architecture plausibly reduce long-run agent context cost?

**Moderate.**

Current repository-agent research establishes context/repository understanding as a substantial problem. A lower context-growth slope is plausible but untested.

## Biggest AI-specific drift mechanism

**Artifact-authority confusion amplified by pattern continuation.**

A later agent mistakes surviving implementation precedent for intentional domain authority and extends it.

## Strongest existing research analogue

**Requirements traceability + architecture conformance + long-horizon continuous-agent benchmarks.**

SlopCodeBench is especially close to the proposed longitudinal mechanism because the agent inherits and extends its own earlier implementation without previous conversation context.

## Most dangerous architecture failure mode

**A wrong semantic specification becomes a highly efficient single source of correlated error.**

The architecture can make the system consistently wrong.

## Most important missing evidence

**A controlled human/AI longitudinal study scoring semantic retention against an independent business oracle.**

## Best longitudinal metric

**Semantic Retention combined with Assumption Survival Rate.**

Semantic Retention captures loss of intended prior behavior.

Assumption Survival Rate captures the mechanism hypothesized to produce future drift.

## Best first experiment

**20 sequential changes with fresh agent sessions, hidden semantic oracle, ambiguous requirements, a temporary workaround, stale test, state split, and mini product pivot.**

## Most important architecture change suggested by research

**Introduce explicit semantic identity and migration before building a large semantic compiler.**

Stable semantic IDs + exhaustive state interpretation + versioned policy + dependency impact provide the clearest first path to making "what changed in meaning?" machine-visible.

---

# 73. Bottom-line interpretation

The strongest version of the thesis is not yet proven:

> "AI will cause software semantics to decay faster than humans."

That statement gets ahead of the evidence.

A stronger and more defensible thesis is:

> **AI agents inherit a maintenance problem software has always had: implementation history obscures design intent. AI makes that problem more strategically important because agents are unusually dependent on machine-visible artifacts and can generate new dependent artifacts at very low marginal cost.**

Current long-horizon benchmarks now demonstrate the first half of the danger:

**agent-generated history matters.**

When an agent inherits its own previous code, early decisions affect later work, and quality/performance degrade in ways one-shot benchmarks miss.

The missing step is to determine whether those inherited decisions become **semantic precedent**.

That makes the proposed research unusually timely.

The semantic architecture should therefore not be justified as:

> "formal modeling is cleaner."

Its testable value proposition is:

> **Make the difference between domain authority and historical accident mechanically visible to the next agent.**

If successful, three effects should appear over time:

1. fewer unsupported assumptions become durable behavior,
2. fewer old semantic decisions are accidentally reinterpreted,
3. agents need less repository archaeology to make later changes correctly.

The most interesting economic metric is therefore not first-task token cost.

It is:

> **the slope of cost per semantically correct change as the system ages.**

If conventional AI-maintained software gets steadily harder and more expensive for fresh agents to understand, while the semantic architecture keeps the relevant semantic context bounded, then the architecture does something much more important than prevent bugs.

It changes the economics of software evolution.

---

# 74. Key sources

## Software evolution and architecture erosion

1. Lehman, M. M. "Laws of Software Evolution Revisited." Foundational work on continuing change and increasing complexity in E-type software.

2. Parnas, D. L. "Software Aging." ICSE, 1994.

3. Herraiz, I., Rodríguez, D., Robles, G., González-Barahona, J. M. "The Evolution of the Laws of Software Evolution." ACM Computing Surveys.

4. Li, R., Liang, P., Soliman, M., Avgeriou, P. "Understanding Software Architecture Erosion: A Systematic Mapping Study." 2021. arXiv:2112.10934.

5. Li, R., Liang, P., Soliman, M., Avgeriou, P. "Understanding Architecture Erosion: The Practitioners' Perspective." 2021. arXiv:2103.11392.

## Traceability and rationale

6. Tian, F., Wang, T., Liang, P., Wang, C., Khan, A. A., Babar, M. A. "The Impact of Traceability on Software Maintenance and Evolution: A Mapping Study." 2021. arXiv:2108.02133.

7. Chen, Z. et al. "SoK: Systematizing Software Artifacts Traceability." 2026. arXiv:2603.16208.

8. Hey, T., Frattini, J. "How Requirements Quality Makes (or Breaks) Traceability Link Recovery." 2026. arXiv:2606.11834.

## Long-horizon / continuous coding-agent research

9. Thai, M. V. T. et al. "SWE-EVO: Benchmarking Coding Agents in Long-Horizon Software Evolution Scenarios." 2025/2026. arXiv:2512.18470.

10. Deng, G. et al. "SWE-Milestone / Evaluating AI Agents on Continuous Software Evolution." 2026. arXiv:2603.13428.

11. Orlanski et al. "SlopCodeBench: Benchmarking How Coding Agents Degrade Over Long-Horizon Iterative Tasks." 2026. arXiv:2603.24755.

12. Chen et al. "SWE-CI: Evaluating Agent Capabilities in Maintaining Software Under Continuous Integration." 2026. arXiv:2603.03823.

## AI-generated maintenance debt

13. Liu, Y., Widyasari, R., Zhao, Y., Irsan, I. C., Lo, D. "Debt Behind the AI Boom: A Large-Scale Empirical Study of AI-Generated Code in the Wild." 2026. arXiv:2603.28592.

14. Zhu, Y., Tsantalis, N., Rigby, P. C. "AI-Generated Smells: An Analysis of Code and Architecture in LLM and Agent-Driven Development." 2026. arXiv:2605.02741.

15. "Speed at the Cost of Quality." 2026. arXiv:2511.04427.

16. "Investigating the Downstream Effects of AI Assistants on Software Development." 2025/2026. arXiv:2507.00788.

## API behavior

17. Wright, H. "Hyrum's Law." Observation on software/API evolution: observable behavior can acquire dependencies beyond explicit contracts.

---

# 75. Evidence grading summary

| Proposition | Current evidence |
|---|---|
| Long-lived software experiences erosion/complexity growth | Strong |
| Requirements/rationale loss harms maintenance | Strong |
| Traceability supports change management | Strong |
| Incidental observable behavior can become depended upon | Strong practical principle |
| One-shot coding benchmarks hide long-horizon difficulty | Strong |
| Agent performance degrades in continuous evolution | Strong emerging evidence |
| Agent's own prior design choices affect later work | Strong emerging evidence |
| AI-generated maintenance debt can persist | Strong emerging evidence |
| AI specifically accelerates semantic drift vs humans | Weak-to-moderate direct evidence |
| Agents treat surviving artifacts as semantic authority | Plausible; insufficient direct measurement |
| Explicit semantic authority reduces longitudinal drift | Moderate architectural support; untested directly |
| Semantic dependency closure lowers context-growth slope | Plausible |
| Semantic provenance lowers rationale reconstruction cost | Strong conceptual support; cost effect unmeasured |
| Semantic architecture lowers lifetime agent cost | Plausible; requires longitudinal experiment |

---

# 76. Research decision

**Proceed.**

This research direction has become more credible because recent continuous-agent benchmarks now test the precise temporal failure mode that earlier one-shot benchmarks missed:

> the agent has to live with yesterday's decisions.

But do not claim victory yet.

The next research milestone should not be another literature review.

It should be the longitudinal semantic-retention benchmark.

The decisive falsifiable claim is:

> **When agents repeatedly maintain their own prior output, machine-visible semantic authority reduces the rate at which unsupported interpretations become durable dependencies.**

If that result holds—and especially if context reconstruction cost grows more slowly—the architecture gains both a correctness argument and an economic one.

If it does not, then conventional modularity, strong typing, retrieval, and documentation may capture most of the value more cheaply.

That is exactly why this experiment is worth running.
