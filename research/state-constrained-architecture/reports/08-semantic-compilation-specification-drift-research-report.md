# AI Research Mission 08 — Semantic Compilation and Specification Drift

**Research report**  
**Date:** 2026-08-14  
**Method:** Literature review, empirical software-engineering research, model-driven engineering research, requirements traceability research, primary compiler/schema/policy documentation, and current AI-agent research.

---

# 1. Executive verdict

## Bottom line

The central hypothesis survives skeptical review, but in a **narrower and more defensible form** than a traditional model-driven architecture.

There is substantial evidence that software systems accumulate multiple representations of the same meaning across requirements, code, tests, interfaces, configuration, documentation, and operational artifacts, and that maintaining consistency and traceability across those representations is difficult and error-prone. Model-driven engineering (MDE), schema compilers, protocol definition languages, policy-as-code systems, and state-machine specifications all demonstrate that a single authoritative representation can mechanically produce or govern multiple derivative artifacts.

However, historical MDE also shows why the obvious conclusion—

> "Put the whole application in one model and generate everything"

—is dangerous.

Broad MDE approaches have repeatedly encountered:

- weak industrial adoption;
- tooling friction;
- model/code synchronization problems;
- generator maintenance cost;
- difficulty expressing all necessary implementation detail;
- developer loss of control;
- round-trip engineering complexity;
- organizational resistance;
- rigidity when the modeling layer becomes too broad.

The research therefore supports a **minimum semantic core**, not a universal application model.

The most defensible architecture is:

```text
Authoritative Semantic Core
    |
    |-- consequential states
    |-- legal transitions
    |-- invariants
    |-- capabilities / authority
    |-- obligations
    |-- policy predicates
    |-- evidence requirements
    |-- consequential effect semantics
    |-- semantic dependencies
    |
    v
Semantic IR
    |
    +--> runtime guards
    +--> state/type projections
    +--> capability derivation
    +--> obligation rules
    +--> agent tool constraints
    +--> conformance tests
    +--> structural documentation
    +--> planning graph
    +--> policy explanations
    +--> dependency / impact reports
    +--> analyzers
```

while leaving outside the semantic core:

- ordinary algorithms;
- presentation;
- layout;
- infrastructure details unless consequential;
- integration mechanics;
- performance optimizations;
- persistence implementation;
- incidental computation.

The most important safety correction is:

> **Generated agreement is not independent evidence of correctness.**

If the specification is wrong and runtime, generated tests, documentation, and agent tools are all derived from it, the system can become consistently wrong.

Therefore semantic compilation requires an independent validation layer.

Recommended independent oracles include:

- domain-owned acceptance examples;
- independently authored invariants;
- regulatory or contractual requirements;
- hidden acceptance tests;
- property-based tests whose properties come from outside the generator;
- mutation testing of the semantic specification;
- production observations;
- differential testing;
- domain review of semantic diffs.

## Overall judgment

The idea is best characterized as:

> **a hybrid of model-driven engineering, executable specification, policy-as-code, schema compilation, and compiler-based static analysis, specialized around consequential business semantics and AI-agent control.**

The concept is not fundamentally unprecedented.

The potentially novel and economically important part is the **scope and target**:

1. encode only consequential semantic meaning;
2. compile it into multiple operational projections;
3. use the same semantic graph as an agent control surface;
4. expose change impact mechanically;
5. reduce the amount of semantic reconstruction an AI agent must perform.

That narrower architecture avoids much of historical MDE's overreach while preserving its strongest advantage: **derivation replaces duplicated manual representation**.

---

# 2. Definition of specification drift

A useful definition is:

> **Specification drift occurs when two or more artifacts intended to express, enforce, predict, explain, or test the same semantic rule cease to denote compatible behavior.**

This is broader than documentation becoming stale.

Examples include:

```text
Frontend:
    enables Ship

Backend:
    rejects Ship
```

```text
Runtime:
    RefundWindow = 14 days

Test:
    expects 30 days
```

```text
Agent tool description:
    retry is legal

Runtime:
    retry capability removed
```

```text
Policy document:
    evidence freshness = 24h

Policy engine:
    evidence freshness = 4h
```

## What is not automatically drift

Differences may be intentional.

Examples:

- staged rollout;
- backward-compatible versions;
- geography-specific policy;
- tenant-specific policy;
- feature experiments;
- old and new service versions during rolling deployment.

Therefore the definition should include:

```text
intended semantic equivalence
```

rather than simply:

```text
artifact texts differ
```

A more formal view:

Let artifacts `A1...An` each project some intended semantic rule `R`.

Drift exists when:

```text
Interpret(Ai, context) != Interpret(Aj, context)
```

for a context in which the artifacts are contractually intended to agree.

---

# 3. Evidence that duplicated semantics drift

The research literature rarely uses exactly the phrase "specification drift" for the whole problem, but several established research areas study its components:

- requirements traceability;
- model/code consistency;
- model synchronization;
- documentation/code consistency;
- configuration drift;
- schema evolution;
- policy consistency;
- model transformations.

Requirements traceability research exists precisely because meaning is spread across artifacts and links between those artifacts are difficult to maintain.

Recent empirical research on open-source release artifacts found large quantities of missing and broken traceability links, illustrating that synchronization between related artifacts is routinely incomplete.

Industrial MDE studies likewise report challenges maintaining relationships between models and implementations.

The evidence supports a moderate-to-strong general claim:

> **The more independently maintained representations of the same rule exist, the more opportunities exist for inconsistent updates.**

That does not mean multiplicity is always bad. Independent representations can provide valuable independent validation.

The key distinction is:

```text
unintentional duplicate authority
```

versus:

```text
intentional independent oracle
```

The first creates drift risk.

The second can detect correlated mistakes.

This distinction should become explicit in the architecture.

---

# 4. Model-driven engineering comparison

## What MDE is

Model-Driven Engineering treats models as first-class engineering artifacts and uses transformations to derive other models or executable artifacts.

Industrial empirical work has found real benefits in some contexts, but adoption remains uneven.

Research reports:

- productivity benefits in suitable domains;
- ability to work at higher abstraction;
- automation of repetitive implementation;
- improved consistency in some generated portions;
- reuse across platforms.

It also reports:

- tooling and usability barriers;
- steep learning curves;
- organizational adoption difficulty;
- model/code synchronization problems;
- generator complexity;
- limited flexibility;
- dependency on specialized modeling infrastructure.

## Why the proposed architecture differs

Traditional ambitious MDE often attempted to raise a large portion of software design into models.

The proposed architecture should instead state:

```text
semantic model != application model
```

It should encode only semantic constraints whose independent duplication is expensive or dangerous.

That makes this closer to:

```text
domain compiler
```

than:

```text
whole-system model-driven development
```

## Best lesson from historical MDE

The critical lesson is:

> **Narrow abstraction boundaries survive better than universal models.**

Protocol Buffers works partly because it models data contracts, not entire applications.

OPA works because it models policy decisions, not business implementation.

SCXML models state-machine behavior, not every algorithm.

The semantic compiler should follow the same pattern.

---

# 5. Executable-specification comparison

Executable specifications attempt to make requirements directly testable or runnable.

Related traditions include:

- specification by example;
- BDD;
- executable state machines;
- formal executable models;
- contract languages.

The proposed system shares the executable-spec principle:

```text
the rule should participate in runtime behavior
```

rather than merely describe it.

However, a semantic specification should not necessarily execute all implementation logic.

For example:

```text
Transition CapturePayment
Requires:
    Payment = Authorized
```

can generate the guard and capability rule.

But the implementation of the payment-provider call remains handwritten.

This is an important architectural boundary:

```text
specification owns legality
implementation owns mechanism
```

This prevents the semantic specification from becoming a second general-purpose programming language.

---

# 6. DSL comparison

## Textual DSL

Advantages:

- compact;
- reviewable;
- diff-friendly;
- easier for AI to generate;
- potentially token efficient.

Disadvantages:

- language tooling required;
- syntax must be learned;
- parser/compiler maintenance.

## JSON/YAML representation

Advantages:

- ubiquitous tooling;
- easy serialization;
- straightforward machine processing.

Disadvantages:

- verbose;
- weak human readability at scale;
- structural syntax can dominate semantics;
- YAML has ambiguity pitfalls.

## Embedded DSL

Advantages:

- host-language tooling;
- refactoring support;
- no separate parser;
- easier adoption.

Disadvantages:

- host language can leak into semantics;
- arbitrary callbacks can destroy analyzability;
- harder to maintain language neutrality.

## Graphical DSL

Advantages:

- useful for state relationships;
- strong visualization.

Disadvantages:

- poor source control;
- difficult textual diff;
- less convenient for AI;
- historic MDE tooling friction.

## Recommendation

Use:

```text
small textual DSL
or
restricted host-language AST builder
```

whose output becomes a stable semantic IR.

The important property is not syntax.

It is:

> consequential rules must remain statically inspectable.

Avoid unrestricted host-language functions inside semantic predicates where possible.

---

# 7. Schema/protocol compiler comparison

Protocol Buffers is one of the strongest precedents.

A `.proto` definition can generate language-specific representations for many target languages.

The key lesson is:

```text
one contract
    ->
many projections
```

without pretending that the contract defines the whole application.

Protocol compilers reduce drift in:

- field names;
- field types;
- serialization structure;
- enum values;
- client/server type representations.

They do not normally encode:

- business transition legality;
- evidence requirements;
- obligations;
- business policy;
- retry semantics;
- authority.

The proposed semantic compiler is therefore an incremental abstraction layer above ordinary protocol compilers.

A good architecture may even use existing compilers as downstream targets:

```text
Semantic IR
    ->
API projection
    ->
OpenAPI / protobuf
    ->
language clients
```

rather than reimplementing protocol generation.

---

# 8. Policy-as-code comparison

OPA/Rego and Cedar demonstrate the value of extracting decision logic from application code.

OPA explicitly separates policy decision-making from enforcement.

Cedar provides a formal authorization policy language and deterministic evaluation model.

Current AWS AgentCore documentation applies Cedar directly to agent tool authorization, showing that policy-controlled tool availability is no longer merely theoretical.

This strongly supports one component of the proposed architecture:

```text
semantic/policy source
    ->
deterministic agent action restriction
```

But policy engines do not automatically provide:

- domain state evolution;
- obligations;
- effect uncertainty;
- planning graphs;
- state migrations;
- domain type generation.

Therefore policy-as-code is an important subset, not a complete substitute.

---

# 9. Generated-test analysis

Generated tests can reduce **structural test drift**.

If a semantic model declares:

```text
States:
    Authorized
    Captured
    Refunded

Transition:
    Capture: Authorized -> Captured
```

the compiler can generate conformance tests such as:

- Capture succeeds from Authorized under required conditions;
- Capture is unavailable from Refunded;
- all known states participate in required exhaustive interpretations.

This helps ensure implementations conform to the specification.

## But generated tests are not sufficient oracles

Suppose the specification incorrectly says:

```text
RefundWindow = 30 days
```

when the business requirement is 14 days.

Generated implementation:

```text
30 days
```

Generated tests:

```text
expect 30 days
```

Generated documentation:

```text
30 days
```

Everything passes.

This is correlated failure.

Therefore generated tests should be called:

```text
conformance tests
```

not:

```text
correctness tests
```

They answer:

> Does implementation match the semantic specification?

They do not independently answer:

> Is the semantic specification correct?

---

# 10. Documentation generation analysis

Structural documentation is an excellent generation target.

Good candidates:

- state lists;
- transition tables;
- capability tables;
- obligation definitions;
- policy dependency graphs;
- evidence requirements;
- agent tool documentation;
- API semantic constraints.

These artifacts can remain mechanically synchronized.

But generated documentation is weaker for:

- rationale;
- historical context;
- strategic intent;
- examples;
- tradeoffs;
- business narrative.

Recommended split:

```text
Generated:
    what the system currently permits/requires

Handwritten:
    why the business chose those semantics
```

The semantic rule should link to rationale/provenance.

This lets agents retrieve explanation only when required.

---

# 11. Agent tool-generation analysis

This is one of the highest-value AI-specific targets.

Current agent systems frequently expose tools through schemas and textual descriptions.

If those schemas are maintained independently from runtime semantics, drift can create situations where:

```text
tool says operation is available
runtime says it is illegal
```

or:

```text
tool docs say parameter is optional
runtime requires it
```

A semantic compiler can instead derive:

```text
semantic transition
    ->
runtime command
    ->
tool schema
    ->
tool availability
    ->
blocked explanation
```

from linked authoritative information.

Recent 2026 research supports the importance of structured tool schemas.

A controlled schema-first study investigated structured tool contracts versus free-form documentation under constrained interaction budgets.

HyperAgent models tools and their input/output schemas as a graph and reports improved completion with reduced redundant API calls, LLM interactions, and token consumption.

TSCG reports large token reductions and substantial accuracy improvements for smaller models by compiling verbose JSON tool schemas into more model-efficient representations.

These studies do **not** prove semantic compilation.

They do support the lower-level mechanism:

> machine-readable structure and better tool representations materially affect agent economics and reliability.

---

# 12. Prompt-generation analysis

Hand-maintained prompts are dangerous places for authoritative business rules.

Example:

```text
Never retry a refund when outcome is unknown.
```

If runtime capability rules already encode this, the prompt is redundant.

The strongest architecture is:

```text
Prompt:
    general operating instructions

Runtime:
    authoritative legal action constraints
```

Semantic compilation can still generate compact context such as:

```text
Current:
    RefundOutcome = Unknown

Required:
    ReconcileRefund

Available:
    QueryProvider
    ReconcileSettlement
```

This is better described as:

```text
agent semantic projection
```

than a giant generated prompt.

Avoid dumping the full semantic specification into context.

---

# 13. Runtime-guard generation analysis

Runtime guards are probably the single most valuable generated artifact.

Why?

Documentation can drift without immediately causing bad execution.

A missing runtime guard allows illegal behavior.

Given:

```text
Ship requires:
    Order = Approved
    Payment = Captured
    Customer = Verified
```

the semantic compiler can generate or interpret the authoritative guard.

From the same predicate it can derive:

```text
CanShip
```

and blocked explanations:

```text
Ship unavailable because Payment != Captured.
```

This eliminates independent copies of the most consequential rule.

Recommendation:

> Runtime legality should either be directly interpreted from the semantic IR or generated in a way that is mechanically tied to the IR.

---

# 14. Planning-graph generation analysis

If transitions have explicit:

- preconditions;
- effects;
- required authority;
- required evidence;

then a planning graph can be derived.

This matters for agents because conventional planning representations often duplicate runtime semantics.

Example:

```text
Planner says:
    CapturePayment -> Captured

Runtime says:
    CapturePayment legal only with FraudReviewComplete
```

If the planner graph is handcrafted, it can become stale.

Generated planning structure makes:

```text
planning model
```

a projection of:

```text
execution model
```

This could remove an important class of agent planning error.

Current tool-schema graph research such as HyperAgent provides contemporary evidence that graph-structured tool dependencies can reduce agent exploration and redundant calls.

---

# 15. Impact-analysis generation

Explicit semantic dependencies create a mechanical impact graph.

Example:

```text
PaymentState.Captured
    -> CanShip
    -> ShipOrder transition
    -> Fulfillment obligation
    -> Agent tool availability
    -> Shipping documentation
```

If `Captured` semantics change, a compiler can report affected nodes.

This is stronger than text search because it operates over declared semantic dependencies.

Requirements traceability literature supports the value of knowing relationships between artifacts for maintenance, while also documenting how difficult maintaining those links manually can be.

Semantic compilation can make many trace links intrinsic rather than retroactively recovered.

---

# 16. Semantic migration analysis

Consider:

```text
Approved
```

becoming:

```text
ConditionallyApproved
FullyApproved
```

A weak implementation may silently treat both new states like old `Approved`.

A semantic compiler can require every dependent exhaustive decision to address both new states.

This resembles:

- schema migration;
- type evolution;
- compiler exhaustiveness checking;
- protocol evolution.

Recommended semantic migration rule:

> State splitting must not automatically inherit consequential permissions unless explicitly declared.

This turns semantic change into a compile-time impact event.

---

# 17. Round-trip engineering lessons

Historical round-trip engineering attempted to keep:

```text
model <-> generated/edited code
```

synchronized.

This is difficult because once both sides can be edited, authority becomes ambiguous.

The proposed system should avoid this.

Recommended rule:

```text
generated semantic artifacts are not authoritative
```

They should either:

- be regenerated;
- be validated against an embedded semantic hash;
- be replaced through explicit extension points.

Do not attempt arbitrary reverse synchronization from edited generated code back into the semantic model.

If a developer needs semantic change:

```text
edit semantic source
```

not:

```text
edit generated guard
```

This is one of the clearest lessons from MDE history.

---

# 18. Generated/handwritten boundary recommendation

## Generate or interpret

Good candidates:

- state representations;
- transition identifiers;
- legal-transition guards;
- capability derivation;
- obligation-generation rules;
- semantic error codes;
- conformance tests;
- tool schemas;
- tool availability;
- structural docs;
- semantic dependency graph;
- analyzer metadata;
- planning projections.

## Handwrite

Good candidates:

- domain algorithms;
- provider adapters;
- persistence details;
- UI composition;
- performance-sensitive internals;
- non-semantic orchestration;
- rendering;
- complex external calculations;
- low-consequence incidental logic.

## Boundary principle

Generate:

```text
what must remain semantically synchronized
```

Handwrite:

```text
how the behavior is technically achieved
```

---

# 19. Specification expressiveness recommendation

The DSL must be expressive enough for meaningful semantic constraints but restricted enough for analysis.

Recommended primitives:

```text
State
Transition
Invariant
Requirement
Authority
EvidenceRequirement
CapabilityRule
ObligationRule
EffectPolicy
Dependency
PolicyVersion
```

Predicates should use a restricted expression language supporting:

- equality;
- Boolean composition;
- set membership;
- comparisons;
- temporal/freshness operators;
- references to named semantic facts.

Avoid unrestricted loops, I/O, reflection, dynamic evaluation, and arbitrary mutation.

## Escape hatch

Some rules require host computation.

Represent these explicitly:

```text
ExternalPredicate {
    name
    inputs
    deterministic?
    version
    owner
}
```

The compiler should mark downstream analysis as partially opaque.

This is much better than silently allowing arbitrary code.

---

# 20. Semantic coverage model

Define:

```text
Semantic Coverage =
    consequential rules represented in semantic model
    -------------------------------------------------
    known consequential rules
```

The denominator cannot be mechanically known with certainty.

Therefore coverage estimation requires:

- domain inventory;
- incident review;
- policy mapping;
- code search;
- expert review.

A second metric is more objective:

```text
Derivation Coverage =
    semantic derivative artifacts generated or validated
    ----------------------------------------------------
    known derivative artifacts representing semantic rules
```

A third critical metric:

```text
Independent Validation Coverage =
    semantic rules with independent oracle
    --------------------------------------
    semantic rules
```

High derivation coverage with low independent validation coverage is dangerous.

---

# 21. Drift metrics

Recommended metrics:

## Specification Drift Incident Rate

```text
cross-artifact inconsistencies
------------------------------
semantic changes
```

## Duplicate Semantic Rule Count

Independent manually maintained copies of the same consequential rule.

## Missed Artifact Rate

```text
required derivative updates missed
----------------------------------
required derivative updates
```

## Stale Artifact Count

Number of derivative artifacts inconsistent with active semantic version.

## Rule Fan-Out

Number of derivative artifacts influenced by one semantic rule.

## Change Error Rate

Defects caused by incomplete redistribution of semantic change.

## Semantic Coverage

As defined above.

## Derivation Coverage

As defined above.

## Independent Validation Coverage

As defined above.

## Cost per Correct Semantic Change

```text
total agent + tool + human + repair cost
---------------------------------------
semantically correct completed changes
```

---

# 22. AI context/token implications

This is one of the most plausible but incompletely proven benefits.

Conventional agent task:

```text
Change shipment eligibility.
```

Agent may search:

- API handlers;
- service layer;
- SQL;
- frontend condition;
- tests;
- docs;
- tool descriptions;
- policy code.

Semantic-compiler task:

```text
Change ShipmentEligibility rule.
```

Compiler returns:

```text
Affected:
    Ship transition
    CanShip
    Shipment obligation
    tool/ship_order
    12 conformance tests
    docs/shipping
```

The model no longer needs to discover all fan-out through probabilistic repository search.

That is semantic context compression.

Recent AI-agent research strengthens the plausibility of this mechanism:

- schema-first tool contracts improve reliability under constrained interaction;
- schema-graph planning can reduce redundant calls, model interactions, and tokens;
- deterministic tool-schema compilation can substantially compress representations and improve smaller-model tool accuracy.

The exact savings from a full semantic compiler remain unmeasured.

Therefore:

**Evidence level: Moderate for mechanism, weak for exact economic magnitude.**

---

# 23. Smaller-model hypothesis

The argument is:

```text
Large model + implicit semantics
```

must infer:

- where rule lives;
- what artifacts duplicate it;
- what needs updating;
- what actions are legal.

Whereas:

```text
Smaller model + explicit compiler
```

receives:

- authoritative rule;
- impact graph;
- generated derivatives;
- compiler diagnostics.

Recent schema-compilation research reports particularly strong improvements for small and mid-size models when tool representations are transformed into more efficient structured forms.

This supports the general mechanism.

But no evidence found directly demonstrates:

```text
smaller model + semantic compiler
>
frontier model + conventional repository
```

for end-to-end software changes.

That remains a high-value experiment.

---

# 24. Wrong-spec risk

This is the single most dangerous correctness risk.

Example wrong semantic rule:

```text
CanShip = OrderApproved && PaymentAuthorized
```

Correct rule should be:

```text
CanShip = OrderApproved && PaymentCaptured
```

If the compiler generates:

- runtime guard;
- UI capability;
- test;
- agent tool;
- documentation;

then every artifact agrees with the wrong rule.

This creates:

```text
perfect internal consistency
+
incorrect external behavior
```

The architecture therefore needs explicit epistemic discipline:

> The semantic model is authoritative for system behavior, not automatically authoritative for truth about what the business should do.

That distinction is essential.

---

# 25. Generator-bug risk

A generator bug creates correlated implementation failure.

Example:

Semantic rule:

```text
Payment = Captured
```

Generator accidentally emits:

```text
Payment != Captured
```

across multiple languages.

Mitigations:

- deterministic generation;
- generator unit tests;
- golden-output tests;
- target-language compilation;
- independent conformance tests;
- cross-target differential tests;
- semantic hash metadata;
- compiler version pinning;
- reproducible builds;
- mutation testing;
- limited generator scope.

The compiler becomes critical infrastructure and must be engineered accordingly.

---

# 26. Independent-validation model

A robust architecture should deliberately maintain **two different paths**:

```text
Semantic Source
    ->
Generated / constrained system
```

and:

```text
Independent Requirements / Examples / External Rules
    ->
Validation
```

Recommended independent validation stack:

## 1. Domain examples

Human/domain-owned examples:

```text
Given payment authorized but not captured
Shipping must remain unavailable.
```

Do not generate these from the semantic rule.

## 2. Property tests

Some properties should be independently stated:

```text
No shipment before monetary capture.
```

## 3. Regulatory / contractual source mapping

Link policy to external authority.

## 4. Mutation testing

Mutate specification:

- remove prerequisite;
- invert guard;
- loosen authority;
- change freshness threshold.

Independent tests should fail.

## 5. Production invariants

Monitor real outcomes against high-level expectations.

## 6. Semantic review

Review the semantic diff, not only generated implementation diff.

This is analogous to reviewing database migration intent rather than thousands of derived data changes.

---

# 27. Security and audit implications

Semantic compilation can materially improve security where authority and transition legality are centralized.

Advantages:

- one inspectable rule for authorization prerequisites;
- traceable policy version;
- deterministic runtime enforcement;
- generated agent capability restriction;
- consistent explanations;
- immutable provenance.

An audit trail could contain:

```text
Transition:
    CloseAccount

AllowedBy:
    AccountPolicy@12

SemanticSpec:
    8f31...

Compiler:
    0.4.2

Authority:
    AccountAdmin

Evidence:
    E-91, E-92
```

This is significantly more auditable than reconstructing behavior from:

- code;
- prompt;
- UI;
- logs;
- wiki pages.

But centralization also increases blast radius.

A wrong authority rule can affect every generated enforcement point.

Therefore semantic policy changes may require stronger review than ordinary implementation changes.

---

# 28. Startup vs enterprise differences

## Startup

Advantages:

- small codebase;
- easier architecture reset;
- few legacy representations;
- AI-heavy development may magnify context-compression value.

Risks:

- high pivot frequency;
- uncertain domain semantics;
- compiler investment may outrun product learning;
- modeling can slow experiments.

Recommendation:

Use a **minimal semantic core** only for:

- money;
- access/security;
- consequential workflow state;
- external effects;
- compliance;
- durable obligations.

Do not model speculative presentation or product experiments.

## Enterprise

Advantages:

- many duplicated representations;
- multiple teams;
- long system lifetime;
- higher rule fan-out;
- compliance/audit burden;
- larger AI repository-search cost.

Risks:

- migration cost;
- multi-repository version skew;
- organization ownership;
- compatibility;
- old/new semantic versions coexist.

Enterprises likely have a higher theoretical payoff but much harder adoption.

---

# 29. Counterarguments

## 1. "This is just MDE, and MDE adoption struggled."

Partly correct.

The architecture belongs to the MDE family.

The response should not be to deny that lineage.

Instead:

> adopt the parts of MDE that repeatedly work—narrow declarative contracts and generation—while avoiding universal application modeling and round-trip editing.

## 2. "One wrong spec creates systemic failure."

Correct.

This is the largest risk.

Independent validation is mandatory.

## 3. "Generator maintenance may exceed drift savings."

Possible.

This is why minimum scope and break-even measurement matter.

## 4. "Strong types and tests solve enough."

For local semantics, often yes.

But they do not automatically synchronize:

- frontend;
- backend;
- SQL;
- agent tools;
- policy;
- docs;
- planning representations.

Semantic compilation is most valuable where one rule crosses many boundaries.

## 5. "Good documentation and review are cheaper."

For low-fan-out, low-consequence systems, likely yes.

Semantic compilation should not be universal.

## 6. "Modern AI can update all representations."

Possibly better than humans, but still probabilistic.

It must first discover every representation.

Semantic fan-out generation converts:

```text
search + inference
```

into:

```text
derivation
```

That distinction remains valuable even if AI improves.

## 7. "Generated artifacts are difficult to debug."

True.

Generated output should be simple, readable, source-mapped to semantic elements, and preferably minimal.

Interpretation may be preferable to generation for some runtime rules.

## 8. "DSL becomes a second programming language."

A real risk.

Restrict it aggressively.

If general computation becomes common, the architecture has failed its scope discipline.

## 9. "Developers will bypass it."

Possible.

Bypasses should be explicit, detectable, governed, and temporary.

## 10. "Generated diffs are noisy."

True.

Review semantic diffs as primary, and mechanically verify generated artifacts.

## 11. "Distributed versions destroy single-source assumptions."

They complicate deployment, not authority.

Multiple deployed semantic versions can coexist intentionally.

Version must be explicit.

## 12. "Business rules are too nuanced for DSLs."

Some are.

Use opaque external predicates where unavoidable and measure the opaque percentage.

## 13. "Specification becomes bottleneck."

Possible.

Ownership and tooling quality matter.

## 14. "Product iteration slows."

If semantic scope is too broad, yes.

Experimental rules should be isolated or have shorter governance paths.

## 15. "Independent validation duplicates meaning again."

Correct—and intentionally so.

The goal is not zero duplicate expression.

The goal is:

```text
one authoritative operational definition
+
selected independent validation
```

rather than:

```text
many accidental authoritative definitions
```

---

# 30. Proposed experiments

## Experiment A — rule change

Rule:

```text
Refund window = 30 days
```

Change to:

```text
14 days
```

Compare conventional and semantic architectures.

Measure:

- files read;
- edits;
- missed artifacts;
- tokens;
- tests;
- repair cycles;
- defects.

## Experiment B — state addition

Add:

```text
PaymentState.Disputed
```

Measure how many consequential interpretations are mechanically surfaced.

## Experiment C — state split

```text
Approved
```

becomes:

```text
ConditionallyApproved
FullyApproved
```

Measure unintended old-rule inheritance.

## Experiment D — policy freshness

```text
FraudEvidence < 24h
```

becomes:

```text
< 4h
```

Measure changes to:

- runtime;
- capabilities;
- obligations;
- tools;
- docs;
- tests.

## Experiment E — tool change

Rename and restructure a semantic transition.

Measure runtime/tool-schema mismatch.

## Experiment F — wrong specification

Intentionally encode wrong business rule.

Generated system should become consistently wrong.

Independent oracle suite should detect it.

This experiment is mandatory.

## Experiment G — generator defect

Introduce target generator bug.

Measure blast radius and detection time.

## Experiment H — manual artifact edit

Modify generated output directly.

CI should reject semantic hash mismatch or regeneration diff.

## Experiment I — agent semantic change

Task:

```text
Change shipment eligibility.
```

Compare:

A. conventional repository  
B. semantic compiler + impact report

Measure:

- retrieval;
- files;
- tokens;
- tool calls;
- completion correctness.

## Experiment J — longitudinal

Run 50-100 semantic changes.

This matters because drift is cumulative.

Track:

- stale artifacts;
- duplicate rules;
- compiler maintenance;
- context growth;
- incorrect semantic changes;
- cost.

## Experiment K — smaller models

Compare multiple model sizes.

Question:

Can compiler structure compensate for lower model capability?

---

# 31. Economic model

Let:

```text
Cconv =
    discovery
  + duplicated edits
  + review
  + missed-update repair
  + drift defects
  + agent inference
```

Semantic system:

```text
Csem =
    semantic edit
  + generation
  + compiler amortization
  + semantic review
  + independent validation
  + generator maintenance
```

One-time investment:

```text
I =
    IR design
  + compiler
  + generators
  + CI integration
  + migration
  + training
```

Break-even after N semantic changes when:

```text
I + Σ Csem(N)
<
Σ Cconv(N)
```

The largest economic variables are likely:

- rule fan-out;
- semantic change frequency;
- system lifetime;
- consequence of missed updates;
- number of teams/languages;
- AI retrieval cost;
- compliance burden.

---

# 32. Break-even analysis

No defensible universal numeric threshold exists in the literature.

The architecture is more likely to break even when:

```text
RuleFanOut × ChangeFrequency × Consequence
```

is high.

## 10 semantic changes

Usually not enough to justify building a custom compiler unless effects are extremely high consequence.

## 100 changes

Potential break-even territory for a focused compiler with high reuse.

## 1,000 changes

Likely increasingly attractive if the semantic model remains stable and generator maintenance is modest.

## 10,000 changes

Manual fan-out maintenance becomes expensive, but only if the compiler itself has not grown into an unmanageable platform.

The right experiment is cumulative.

A single change benchmark will underestimate both:

- drift accumulation;
- compiler maintenance.

---

# 33. What is already established

Strongly established or well supported:

1. Model/code/artifact consistency is a recognized engineering problem.
2. Requirements traceability across artifacts is valuable but costly to maintain manually.
3. MDE can provide productivity and automation benefits in suitable domains.
4. MDE adoption has meaningful tooling and organizational barriers.
5. Round-trip synchronization between editable model and code is difficult.
6. Protocol/schema compilers successfully generate multiple target artifacts from one contract.
7. Policy-as-code can centralize deterministic decision logic.
8. State-machine specifications can provide executable behavioral models.
9. Generated tests only prove conformance to the specification they are derived from.
10. Tool/schema representation materially affects LLM-agent behavior.
11. Structured tool planning can reduce redundant exploration.
12. Central generators introduce correlated-failure risk.

---

# 34. What remains speculative

Not yet established for the proposed architecture:

1. exact drift reduction percentage;
2. exact token savings;
3. exact agent search reduction;
4. smaller-model substitution;
5. optimal DSL syntax;
6. optimal semantic scope;
7. long-term compiler maintenance cost;
8. semantic coverage measurement accuracy;
9. startup break-even point;
10. enterprise migration cost;
11. whether generated planning graphs materially improve real coding agents;
12. whether semantic compilation remains agile during frequent startup pivots;
13. how much SQL drift can be mechanically controlled;
14. whether one cross-language semantic IR remains stable across many years.

---

# 35. Architecture changes recommended

## A. Define a Semantic IR

Make IR independent from syntax.

Example concepts:

```text
StateType
StateCase
Transition
RequirementExpression
Invariant
Capability
Obligation
Authority
EvidenceRequirement
EffectPolicy
Dependency
PolicyVersion
```

## B. Keep the language restricted

No arbitrary host-language mutation.

## C. Generate runtime legality first

This provides the highest correctness return.

## D. Generate capability metadata

Same rule determines what agents/users may do.

## E. Generate conformance tests

Label them correctly as conformance—not independent correctness tests.

## F. Generate structural documentation

Especially state/transition/capability/policy views.

## G. Generate agent-facing semantic slices

Do not dump full IR.

## H. Generate impact graph

Make every semantic change produce an affected-set report.

## I. Attach semantic provenance

Record:

```text
SpecVersion
SemanticHash
CompilerVersion
GeneratorVersion
```

## J. Add opaque predicate tracking

Measure semantic opacity.

## K. Add independent validation

Required before relying on high derivation coverage.

## L. No round-trip editing

Generated semantic artifacts should not become alternate authorities.

## M. Support explicit semantic versions

Rolling deployments and multirepo systems require coexistence.

## N. Provide escape hatches

But make them:

- explicit;
- reviewable;
- time-bound where possible;
- measurable.

---

# 36. Minimum viable semantic compiler scope

The first compiler should be much smaller than the research prompt's maximal vision.

## Phase 1 — authoritative model

Support:

```text
state cases
legal transitions
guards / prerequisites
capability derivation
semantic dependencies
```

## Phase 2 — generated outputs

Generate:

1. target-language state types;
2. transition identifiers;
3. runtime guard functions or runtime rule representation;
4. capability-query API;
5. conformance tests;
6. agent tool availability metadata;
7. semantic dependency / impact report;
8. structural Markdown documentation.

## Phase 3 — obligations and effects

After core stability:

- obligations;
- external-effect policies;
- evidence requirements;
- policy versions.

## Do not initially generate

- business algorithms;
- UI code;
- database schema;
- SQL implementation;
- full API implementation;
- workflow implementation;
- generalized documentation prose.

## First adoption principle

The semantic compiler should prove one thing:

> **A consequential rule can be changed once and all mechanically dependent enforcement/control artifacts remain synchronized.**

If that does not produce measurable benefit, broader compiler investment should stop.

---

# 37. Final verdict

## Does duplicate representation materially cause semantic drift?

**Strong evidence**

The exact label varies across research domains, but consistency, traceability, model/code synchronization, stale artifacts, and missing links are well-established maintenance problems.

## Does generation from one semantic source reduce drift?

**Moderate-to-strong evidence**

Schema/protocol compilers, policy-as-code, and MDE provide substantial supporting precedent. The strongest evidence concerns bounded domains, not whole-application generation.

## Does semantic compilation plausibly reduce AI-agent context cost?

**Moderate**

Current agent research shows structured schemas and explicit dependency representations can reduce tool calls, interactions, and tokens. The full semantic-compiler effect remains unmeasured.

## Does it plausibly enable smaller models?

**Moderate**

Recent tool-schema compilation evidence shows large gains for smaller models from better representation, but direct evidence for software-maintenance agents is still absent.

## Is the concept fundamentally:

**Hybrid**

It combines:

- model-driven engineering;
- executable specification;
- schema/protocol compilation;
- policy-as-code;
- formal/static analysis;
- AI agent control surfaces.

Its distinctive characteristic is the deliberately narrow **consequential semantic core** and the use of its projections to control AI agents.

## Most valuable generated artifact

**Authoritative runtime guard/capability derivation**

This directly prevents illegal behavior and becomes the basis for agent action-space restriction.

The impact graph is probably the second most economically valuable artifact for AI coding work.

## Most dangerous correlated-failure mode

**Wrong authoritative semantic rule propagated consistently into runtime, tests, documentation, and agent tools.**

Perfect consistency can create false confidence.

## Best independent validation mechanism

A combination of:

1. independently authored domain acceptance examples;
2. semantic mutation testing;
3. independent high-level invariants;
4. external policy/regulatory traceability.

No single mechanism is sufficient.

## Most important lesson from historical MDE

> **Do not model the whole application and do not maintain two editable authorities.**

Use a narrow semantic source and one-way derivation into controlled artifacts.

## Minimum semantic scope worth centralizing

```text
consequential state
legal transitions
invariants
authority/capability
obligations
evidence requirements
effect semantics
semantic dependencies
```

Everything else must justify inclusion separately.

## Biggest economic opportunity

**Eliminating repeated semantic reconstruction and multi-artifact change fan-out for AI-maintained software.**

The value compounds with:

- codebase size;
- team count;
- number of languages;
- rule fan-out;
- change frequency;
- compliance burden.

## Biggest adoption risk

**The semantic compiler becomes a mandatory universal framework that slows ordinary development and requires specialized expertise.**

That would recreate classic MDE adoption problems.

## Most important missing experiment

A longitudinal agent-maintenance benchmark with:

```text
50-100 semantic changes
```

comparing:

```text
competent conventional architecture
```

against:

```text
narrow semantic compiler
```

using the same models.

Measure:

- drift incidents;
- files read;
- files edited;
- context tokens;
- tool calls;
- repair loops;
- human review;
- defects;
- compiler maintenance;
- cost per correct semantic change.

Include deliberately wrong specs and generator bugs.

Without those adversarial conditions, the experiment will overstate the value of semantic compilation.

---

# Research synthesis

The strongest conclusion is not:

> "Single source of truth is good."

That phrase is too vague.

The stronger conclusion is:

> **A rule that controls consequential behavior should have one operationally authoritative semantic representation, while independent representations should exist only when they serve as deliberate validation or contextual explanation.**

This creates a useful division:

```text
DERIVATION
    One authoritative semantic rule
        ->
    many synchronized operational projections

VALIDATION
    Independent business evidence
        ->
    challenges the authoritative rule
```

That is the architecture that avoids the apparent contradiction between:

```text
avoid duplicate rules
```

and:

```text
do not trust one specification blindly
```

You want **one authority** but **multiple oracles**.

For AI-operated software, this becomes more valuable because every duplicate representation has two costs:

1. humans must maintain it;
2. agents must discover and reconcile it in context.

Semantic compilation attacks both.

It reduces human update fan-out and converts part of agent reasoning from:

```text
probabilistic semantic reconstruction
```

into:

```text
deterministic compiler output
```

The historical evidence says not to build a giant modeling platform.

The contemporary AI evidence suggests that **small amounts of explicit structure can have disproportionately large effects on agent reliability and token economics**.

The resulting research direction should therefore be:

> **Build the smallest compiler that can prove measurable reduction in semantic change fan-out and agent reconstruction cost.**

Not:

> **Build a language that describes the entire system.**

That distinction may be the difference between repeating MDE history and extracting the part of it that becomes newly valuable in an AI-development environment.

---

# Key sources

## Model-driven engineering and industrial evidence

1. Hutchinson et al., **Model-driven engineering practices in industry**, ICSE 2011.  
   ACM: https://dl.acm.org/doi/10.1145/1985793.1985882

2. Hutchinson et al., **Empirical assessment of MDE in industry**, MODELS 2011.  
   ACM: https://dl.acm.org/doi/10.1145/1985793.1985858

3. Domingo et al., **Evaluating the Benefits of Model-Driven Development**, 2020.  
   PMC: https://pmc.ncbi.nlm.nih.gov/articles/PMC7266443/

4. da Silva, **Model-driven engineering: A survey supported by the unified conceptual model**, Computer Languages, Systems & Structures, 2015.  
   DOI landing page: https://www.sciencedirect.com/science/article/pii/S1477842415000408

5. David et al., **Collaborative Model-Driven Software Engineering: A systematic survey of practices and needs in industry**, Journal of Systems and Software, 2023.  
   ACM index: https://dl.acm.org/doi/10.1016/j.jss.2023.111626

6. Weidmann, Kannan, Anjorin, **Tolerance in Model-Driven Engineering: A Systematic Literature Review**, 2021.  
   https://arxiv.org/abs/2106.01063

## Protocol/schema compilation

7. Google, **Protocol Buffers Documentation**.  
   https://protobuf.dev/

8. Google, **Protocol Buffers Overview**.  
   https://protobuf.dev/overview/

9. Google, **Protocol Buffers Language Guide**.  
   https://protobuf.dev/programming-guides/proto3/

## State/executable specification

10. W3C, **State Chart XML (SCXML): State Machine Notation for Control Abstraction**, W3C Recommendation.  
    https://www.w3.org/TR/scxml/

## Policy-as-code

11. Open Policy Agent, **OPA Documentation**.  
    https://openpolicyagent.org/docs

12. Open Policy Agent, **Rego Policy Language**.  
    https://openpolicyagent.org/docs/policy-language

13. Open Policy Agent, **Policy Testing**.  
    https://openpolicyagent.org/docs/policy-testing

14. AWS, **Cedar / Amazon Verified Permissions**.  
    https://docs.aws.amazon.com/verifiedpermissions/latest/userguide/what-is-avp.html

15. AWS, **Cedar policy control for Bedrock AgentCore**.  
    https://docs.aws.amazon.com/bedrock-agentcore/latest/devguide/policy-understanding-cedar.html

## Traceability

16. Nath, Roy, Jahan, **Establishing Traceability Links between Release Notes & Software Artifacts: Practitioners' Perspectives**, 2025.  
    https://arxiv.org/abs/2511.18187

17. Hey & Frattini, **How Requirements Quality Makes (or Breaks) Traceability Link Recovery**, 2026.  
    https://arxiv.org/abs/2606.11834

18. **Auxiliary Artifacts in Requirements Traceability**, 2025.  
    https://arxiv.org/abs/2504.19658

## Current AI-agent evidence

19. **Schema First Tool APIs for LLM Agents: A Controlled Study**, 2026.  
    https://arxiv.org/html/2603.13404v1

20. Zhai et al., **HyperAgent: Planning and Acting over Tool-Schema Hypergraphs for Tool-Use LLM Agents**, 2026.  
    https://arxiv.org/abs/2608.02650

21. Sakizli, **TSCG: Deterministic Tool-Schema Compilation for Agentic LLM Deployments**, 2026.  
    https://arxiv.org/abs/2605.04107

22. Jonnalagedda et al., **Executable Schema Contracts: From Automatic Ingestion to Multi-Source Retrieval**, 2026.  
    https://arxiv.org/abs/2606.05415

## Important source-quality note

The MDE, W3C, Protocol Buffers, OPA, and AWS sources provide established or primary technical grounding.

The 2026 AI-agent papers are recent and should be treated as **emerging empirical evidence**, not a mature consensus. Their reported gains strengthen the plausibility of semantic structure as context/action compression, but they do not independently validate the complete architecture proposed here.
