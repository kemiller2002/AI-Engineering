# AI Research Mission 11 — Can Semantic Compilation Compensate for Weaker Host Languages?

**Research report**  
**Date:** 2026-08-14  
**Method:** Official language/compiler documentation, programming-language research, source-generation/analyzer documentation, database/persistence analysis, empirical software-engineering literature, and current AI-coding research.

---

# 1. Executive verdict

## Bottom line

The hypothesis is **mostly supported**, but only if the claim is stated precisely.

A semantic compiler cannot make JavaScript "become Rust" or TypeScript "become F#." Native language semantics still matter for:

- compile-time exhaustiveness;
- local construction control;
- immutability;
- ownership/affine guarantees;
- local capability forgery resistance;
- type-level modeling ergonomics;
- quality and immediacy of compiler feedback.

However, many of the guarantees that matter most for **authoritative business correctness** are not fundamentally host-language guarantees at all.

They depend on:

- one authoritative semantic model;
- generated legal construction paths;
- build-time analyzers;
- CI enforcement;
- runtime state/version checks;
- capability validation;
- database ownership;
- serialization validation;
- tool permissions;
- external-effect handling.

That means a sufficiently strong architecture can make C#, Java, TypeScript, and even Python behave **far more like a semantically closed system** than ordinary idiomatic code in those languages.

The strongest conclusion is:

> **Semantic compilation can largely equalize authoritative runtime correctness across mainstream languages, but it cannot fully equalize compile-time ergonomics, local proof strength, or resistance to deliberate bypass.**

The practical architecture is therefore layered:

```text
Semantic IR
    |
    +--> native target types
    +--> generated transition API
    +--> analyzers / CI diagnostics
    +--> generated conformance tests
    +--> agent semantic view
    |
    v
Trusted Runtime Semantic Kernel
    |
    +--> current state/version validation
    +--> authority validation
    +--> evidence/policy validation
    +--> capability validation
    +--> obligation generation
    +--> effect semantics
    |
    v
Authoritative Persistence Boundary
```

The host language becomes one enforcement layer rather than the entire safety model.

## Practical verdict

- **F#/Rust/Swift/Kotlin/Scala/Haskell** remain stronger native semantic targets.
- **C# and Java** can achieve near-strong-language behavior for consequential domain code with generation, analyzers, disciplined module boundaries, and runtime enforcement.
- **TypeScript** is credible as a semantic-core target **with restrictions**.
- **Python** is credible **with restrictions and mandatory runtime validation**, but its compile-time closure remains weaker.
- **Plain JavaScript** should generally be **peripheral or runtime-enforced only**, not the preferred authoritative semantic implementation.
- **SQL is a major independent bypass risk regardless of application language**.

The most important architectural finding is therefore not:

```text
choose the strongest language
```

but:

```text
put the strongest guarantees at the authority boundary
```

while exploiting native host-language guarantees wherever they exist.

---

# 2. Precise definition of language-strength dimensions

"Strong" and "weak" are too vague to be useful.

For this research, language capability is evaluated by dimensions.

## 2.1 Closed-state representation

Can the language express a type whose valid cases are known and closed?

Examples:

- F# discriminated union
- Rust enum
- Swift enum
- Kotlin sealed hierarchy
- Java sealed hierarchy
- C# 15 union
- TypeScript tagged union

## 2.2 Exhaustive interpretation

Can the compiler force consequential pattern matching to account for every current case?

Important distinction:

```text
compiler-enforced exhaustiveness
```

versus:

```text
a coding convention that calls assertNever()
```

## 2.3 Construction control

Can code outside the semantic boundary create arbitrary values?

Mechanisms include:

- private constructors;
- module visibility;
- opaque representations;
- package-private types;
- generated factories;
- runtime validation.

## 2.4 Immutability

Can authoritative values be prevented from uncontrolled mutation?

This includes:

- top-level immutability;
- deep immutability;
- copy-on-write/value semantics;
- ownership.

## 2.5 Transition closure

Can authoritative state change only through declared transitions?

This usually requires architecture beyond the language.

## 2.6 Authority closure

Can capabilities/evidence/authority objects be protected against fabrication?

Local type safety and distributed security are different problems.

## 2.7 Dependency closure

Can the system know every semantic dependency affected by a state/policy change?

This usually requires semantic IR regardless of host language.

## 2.8 Escape-hatch strength

How easy is it to bypass guarantees?

Examples:

- `any`
- unsafe casts
- reflection
- direct mutation
- raw SQL
- monkey patching
- unsafe code.

## 2.9 Analyzer extensibility

Can custom static checks be integrated into normal builds and IDEs?

## 2.10 Runtime integrity

Can the host reliably call a trusted semantic runtime that revalidates authoritative actions?

---

# 3. Guarantee taxonomy

The core mistake would be to demand every guarantee from one layer.

A better taxonomy is:

## Compile-time-native guarantees

Best handled by host compiler when available:

- state-family closure;
- exhaustive interpretation;
- local constructor visibility;
- nullability;
- some immutability;
- ownership/borrowing;
- affine consumption.

## Build-time semantic guarantees

Best handled by semantic compiler/analyzers:

- dependency completeness;
- no wildcard/default in consequential matches;
- no direct semantic-field mutation;
- generated-artifact freshness;
- state migration completeness;
- semantic escape-hatch detection;
- analyzer suppression detection.

## Runtime guarantees

Must be runtime regardless of language:

- current state;
- state version;
- policy version;
- evidence freshness;
- authority;
- capability validity;
- distributed concurrency;
- external effect outcome;
- obligation lifecycle.

## Persistence/operational guarantees

Require architecture beyond ordinary language typing:

- no unauthorized direct DB mutation;
- serialization validation;
- ORM reconstruction;
- tool permissions;
- agent SQL restrictions;
- durable state integrity.

This division is central.

---

# 4. Compile-time / runtime / build-time responsibility matrix

| Semantic property | Host compiler | Semantic build/analyzer | Runtime kernel |
|---|---|---|---|
| Closed state family | Preferred | Can generate | Validate deserialized values |
| Exhaustive interpretation | Preferred | Can enforce where host cannot | Fallback validation |
| Protected construction | Helpful | Detect bypass | Validate authoritative creation |
| Transition closure | Partial | Detect direct writes | **Required** |
| Authority closure | Partial/local | Detect fabrication paths | **Required** |
| Dependency closure | No | **Required** | Uses compiled graph |
| Version-bound capabilities | No | Schema checks | **Required** |
| Evidence freshness | No | Rule generation | **Required** |
| Obligation semantics | No | Generate rules | **Required** |
| OutcomeUnknown effects | Type representation only | Generate contracts | **Required** |
| Semantic migrations | Compiler helps locally | **Required** | Version compatibility |
| SQL bypass prevention | No | Detect some access | DB/service boundary required |

The matrix shows why the architecture can compensate for host-language differences.

Several of the most important guarantees are language-independent by nature.

---

# 5. F# baseline

F# remains an excellent baseline for business-domain semantic modeling.

Official F# documentation describes discriminated unions as types whose values can be one of a set of named cases. Pattern matching naturally operates over those cases.

## Strengths

- native discriminated unions;
- associated data per case;
- strong pattern matching;
- compiler warnings for incomplete matches;
- immutable-by-default functional style;
- option types;
- module/private representation;
- succinct domain modeling.

## Important limitation

F# does **not** solve the entire architecture.

F# values can still cross:

- JSON;
- SQL;
- mutable .NET libraries;
- reflection;
- ORM/persistence;
- remote APIs.

A direct database write can invalidate a perfectly modeled F# domain.

Therefore F# provides excellent **local semantic pressure**, but authoritative correctness still needs runtime/persistence enforcement.

## Profile

Construction: **Strong**  
Transition: **Strong when encapsulated; runtime still required**  
Interpretation: **Strong**  
Authority: **Medium locally; runtime required when distributed**  
Dependency: **Semantic compiler required**  
Enterprise adoption: **Moderate; excellent for .NET domain modules but organizational adoption varies**

---

# 6. Rust baseline

Rust provides one of the strongest local guarantee profiles.

Official Rust documentation provides:

- enums;
- exhaustive `match`;
- ownership;
- borrowing;
- visibility;
- `Option`;
- `Result`.

## Strengths

- closed enum families;
- exhaustive matching;
- strong construction control;
- ownership and borrowing;
- affine-like resource semantics;
- strong mutation control;
- strong local capability modeling.

Rust is uniquely useful when capability/state safety overlaps resource ownership.

For example, a single-use local capability can potentially be represented through move semantics.

## Residual limits

Serialization destroys many purely local guarantees.

Once a token crosses a network:

```text
Rust move semantics
```

becomes:

```text
protocol validation
```

Similarly, database state must be reconstructed and validated.

Unsafe Rust also creates explicit escape hatches.

## Profile

Construction: **Very strong**  
Transition: **Very strong locally**  
Interpretation: **Very strong**  
Authority: **Strong locally**  
Dependency: **Generated semantic model required**  
Enterprise adoption: **Lower than Java/C#/TypeScript for general business stacks**  
Learning/tooling cost: **High relative to mainstream enterprise languages**

---

# 7. Kotlin baseline

Kotlin is an especially useful JVM baseline.

Official Kotlin documentation states that `when` over sealed classes can be exhaustively checked by the compiler without requiring `else`.

## Strengths

- sealed classes/interfaces;
- exhaustive `when`;
- null safety;
- data classes;
- strong visibility;
- concise modeling;
- Kotlin Symbol Processing (KSP).

KSP officially supports source generation and is designed as a lightweight compiler-processing mechanism.

## Limits

JVM interoperability creates bypass possibilities.

Java code, reflection, serializers, and persistence frameworks can circumvent purely Kotlin-level assumptions.

## Profile

Construction: **Strong**  
Transition: **Strong with encapsulation**  
Interpretation: **Strong**  
Authority: **Medium-strong locally**  
Dependency: **Semantic compiler required**  
Enterprise adoption: **High in JVM organizations willing to use Kotlin**

---

# 8. Java analysis

Modern Java is substantially stronger for closed domain modeling than older Java.

Official Java features include:

- sealed classes/interfaces;
- records;
- pattern matching for switch;
- compile-time exhaustiveness over sealed hierarchies.

Java 17 established sealed classes, while later pattern-matching support makes exhaustive interpretation increasingly natural.

## Generated semantic model

A semantic compiler can generate:

```text
sealed interface PaymentState
permits Authorized, Captured, Refunded, Disputed
```

and records for cases.

It can also generate exhaustive switch projections and prohibit `default` via analysis.

## Strengths

- closed hierarchy support;
- records;
- modules/packages;
- mature annotation processing;
- mature CI/IDE ecosystem;
- strong enterprise adoption.

## Weaknesses

- more verbose than F#/Kotlin;
- mutation remains ordinary;
- reflection is powerful;
- ORM conventions often favor mutable entities;
- direct persistence can bypass domain rules.

## Verdict

Java can achieve **near-Kotlin/F# authoritative safety** when:

- domain states are sealed;
- default branches are prohibited in consequential switches;
- construction is generated/private;
- semantic writes go through transition APIs;
- runtime kernel revalidates state/version/authority;
- DB access is constrained.

The remaining gap is mostly ergonomics and local expressiveness rather than runtime authority.

---

# 9. C# analysis

This area changed materially in 2026.

Microsoft's April 2026 .NET/C# announcement states that **C# 15 introduces union types in preview** with compiler-enforced exhaustive pattern matching.

That significantly reduces one historical difference between C# and F#.

## Existing C# strengths

- records;
- pattern matching;
- sealed classes;
- private constructors;
- nullable reference analysis;
- Roslyn analyzers;
- source generators;
- required members;
- excellent .NET tooling.

The Roslyn SDK officially supports semantic analyzers, code fixes, and source generators.

## New union significance

With C# 15 union support:

```text
union PaymentState
{
    Authorized;
    Captured;
    Refunded;
    Disputed;
}
```

can represent a genuinely closed family with exhaustive pattern matching.

This changes the research answer:

> The need to introduce F# solely to obtain discriminated-union-style state closure is materially weaker than it was before C# 15.

F# still has advantages:

- immutability culture/defaults;
- terser ADT syntax;
- functional decomposition;
- option/result idioms;
- fewer object-oriented escape tendencies.

But C# + unions + Roslyn analyzers + source generation + runtime enforcement can plausibly reach very high semantic safety.

## Profile

Construction: **Strong**  
Transition: **Strong with architecture**  
Interpretation: **Strong with C# 15 unions; otherwise medium-strong**  
Authority: **Medium locally; runtime required**  
Dependency: **Semantic compiler required**  
Enterprise adoption: **Very high in .NET organizations**

## Verdict

C# can achieve **near-F# semantic safety** for the proposed architecture.

---

# 10. TypeScript analysis

TypeScript is much more capable than plain JavaScript but remains structurally different from languages with runtime-retained nominal types.

Official TypeScript documentation supports discriminated unions and the use of `never` for exhaustiveness checking.

## Strengths

- tagged unions;
- literal types;
- control-flow narrowing;
- `never`;
- `readonly`;
- private class fields;
- compiler API;
- lint/analyzer ecosystem;
- broad enterprise/browser adoption.

## Weaknesses

### Structural typing

Shape compatibility can allow values that were not created by semantic constructors.

### `any`

`any` can erase type guarantees.

### Assertions

`as SomeType` can force compatibility.

### Runtime erasure

TypeScript types disappear at runtime.

### Mutation

Objects can remain mutable unless carefully constrained.

## Can generation compensate?

Largely, yes, if TypeScript is treated as **one layer**, not the authority boundary.

Recommended profile:

```text
Generated:
    tagged state unions
    readonly values
    private/non-exported constructors
    transition functions

Analyzer:
    forbid any in semantic modules
    forbid unsafe assertions
    forbid default in semantic matches
    forbid direct state mutation
    forbid analyzer suppression

Runtime:
    validate deserialization
    validate capability
    validate state/version
    own persistence mutation
```

## Critical rule

Do not rely on TypeScript type correctness as adversarial security.

A branded type may stop accidental misuse.

It does not make a remote or malicious capability unforgeable.

## Verdict

TypeScript is a credible semantic-core target **with restrictions**.

Its authoritative correctness can approach stronger languages if runtime enforcement is strong.

Its compile-time proof strength remains lower.

---

# 11. JavaScript analysis

Plain JavaScript has no static type phase.

## Available mechanisms

- generated constructors;
- closures;
- private fields;
- `Object.freeze`;
- runtime tagged values;
- generated validators;
- runtime transition kernel;
- static lint/analyzer passes.

## Core problem

Any semantic safety that depends on:

```text
developer must remember to use the generated API
```

is weak.

A coding agent can easily write:

```js
payment.status = "refunded";
```

unless architecture prevents authoritative mutation.

## Where JavaScript can work

JavaScript can be acceptable as:

- UI/peripheral code;
- adapter code;
- event glue;
- generated client layer;
- runtime consumer of semantic capabilities.

For an authoritative semantic module, JavaScript should require:

- encapsulated state;
- runtime-only transitions;
- no writable domain objects;
- server-side validation;
- CI analyzer enforcement.

## Verdict

Plain JavaScript is not the preferred authoritative semantic target.

It is credible only **with strong runtime restrictions**.

---

# 12. Python analysis

Python sits between TypeScript and JavaScript in practical enforceability.

## Available mechanisms

- dataclasses;
- frozen dataclasses;
- Enum;
- Literal;
- Protocol;
- type hints;
- pattern matching;
- mypy/pyright;
- runtime validators;
- modules.

Mypy documentation supports `Literal` types, and modern Python type checkers provide significant narrowing analysis.

## Weaknesses

- typing is optional;
- runtime remains dynamic;
- monkey patching;
- private members are largely conventional;
- mutation is easy;
- analyzers can be skipped;
- constructors can often be bypassed;
- reflection/dynamic access is ordinary.

## Generated Python strategy

Generate:

- frozen state dataclasses;
- discriminant `Literal` values;
- factory functions;
- transition entry points;
- runtime validators.

CI:

- mandatory type checking;
- no ignored semantic diagnostics;
- no direct state writes.

Runtime:

- validate every authoritative transition;
- reconstruct from persistence through validator.

## Verdict

Python can be a semantic-core target **with restrictions**, but most important guarantees ultimately rest on runtime enforcement.

Its build-time feedback will be materially weaker than F#/Rust/Kotlin/modern C#.

---

# 13. SQL analysis

SQL is not just another target language in this architecture.

It is often the **largest semantic bypass**.

A fully constrained application can be invalidated by:

```sql
UPDATE Orders
SET Status = 'Shipped'
WHERE Id = 42;
```

## SQL strengths

Databases can enforce some invariants strongly through:

- CHECK constraints;
- uniqueness;
- foreign keys;
- roles;
- row-level security;
- stored procedures;
- transactions;
- triggers.

## Risks

- direct UPDATE;
- DBA/admin access;
- scripts;
- migrations;
- stored procedures encoding stale semantics;
- duplicated CASE logic;
- ORM-generated writes;
- reporting scripts promoted into operational use.

## Recommended architecture

Prefer:

```text
authoritative semantic writes
    ->
owning service/module transition API
```

rather than allowing arbitrary application SQL writes.

At the database boundary:

- restrict roles;
- separate read/write permissions;
- generate or validate constraints where simple;
- preserve append-only semantic events where useful;
- validate transitions before commit;
- audit emergency overrides.

## Trigger caution

Triggers can enforce rules but hide behavior.

They can make AI/debugging harder.

Use them only when database-level enforcement materially improves authority integrity.

## Verdict

SQL bypass risk: **High**.

This finding weakens the argument that choosing Rust/F# alone solves semantic correctness.

---

# 14. Go analysis

Go is statically typed but does not natively provide the same closed-sum/exhaustiveness ergonomics as F#/Rust/Kotlin.

Official Go documentation provides interfaces and type switches, but interface implementations are open.

## Strengths

- simple type system;
- package visibility;
- generated code is culturally acceptable;
- `go generate`;
- predictable builds;
- simple runtime model.

## Weaknesses

- no native closed ADT equivalent with exhaustive case matching;
- type switches over interfaces do not naturally create closed interpretation;
- mutability is common;
- less expressive type-level state modeling.

## Compensation

A generator can create:

- tagged structs;
- unexported implementation types;
- constructors;
- generated exhaustive visitor functions;
- analyzer checks.

But this remains more emulation than native closure.

## Verdict

Go can support the semantic architecture, but interpretation closure is **more analyzer/generator-dependent** than Java/Kotlin/C#/F#/Rust.

---

# 15. Swift / Scala / Haskell comparison

## Swift

Official Swift documentation requires exhaustive `switch` over enums.

Strengths:

- enums with associated values;
- exhaustive switch;
- value semantics;
- access control.

Swift is a strong native target.

## Scala 3

Scala 3 provides enums and exhaustivity diagnostics.

Strengths:

- algebraic modeling;
- enums;
- sealed types;
- advanced type system;
- functional/OO hybrid.

It is a strong semantic target but carries greater language/tooling complexity than Java/Kotlin for many enterprise teams.

## Haskell

Haskell provides algebraic data types, pattern matching, powerful type-system mechanisms, and optional deeper guarantees through GADTs and advanced typing.

However, pattern-match exhaustiveness historically includes warning/configuration nuances, and Haskell's adoption cost is substantial for mainstream enterprise systems.

Haskell is valuable as a **semantic design reference**, not necessarily the enterprise deployment default.

---

# 16. Construction-closure comparison

## Strong native

- Rust
- F#
- Swift
- Kotlin
- Scala
- C# 15 union
- Java sealed hierarchy

## Strong with generated conventions

- TypeScript
- Go
- Python

## Primarily runtime

- JavaScript
- SQL-deserialized values

Important result:

> Generated private factories can approximate construction closure, but deserialization always creates a second construction boundary.

Therefore every target needs:

```text
serialized form
    ->
validated semantic reconstruction
```

even if the local language has strong constructors.

---

# 17. Transition-closure comparison

Transition closure is less language-dependent than expected.

Even in Rust:

```text
state field inaccessible
```

helps locally.

But a database row can still be mutated externally.

The strongest architecture is:

```text
authoritative state storage
    ->
write permission only through transition kernel
```

This can be implemented in nearly every host language.

Therefore:

**Transition closure can be made mostly language-independent.**

Native language support improves accidental-use prevention but is not sufficient.

---

# 18. Interpretation-closure comparison

This is where host languages differ most.

## Very strong native

- F#
- Rust
- Swift
- Kotlin
- Scala 3
- modern Java sealed switch
- C# 15 union

## Achievable with discipline

TypeScript:

- tagged union;
- `never`;
- analyzer forbidding default.

## Analyzer-dependent

- Python
- Go

## Runtime/generator-dependent

- JavaScript
- SQL CASE logic

Generated semantic compiler can compensate substantially, but native compile-time closure remains superior because errors appear automatically at the exact code location.

---

# 19. Authority-closure comparison

Local authority types are useful but should not be mistaken for distributed authority.

Example:

```text
CanRefund
```

in Rust may be a private/move-only value.

But after serialization, the server must decide whether the provided token remains valid.

Thus the authoritative model should use:

```text
Capability {
    id
    subject
    stateVersion
    policyVersion
    authority
    expiration
}
```

validated by trusted runtime.

This works in:

- Rust;
- F#;
- C#;
- Java;
- TypeScript;
- Python;
- JavaScript.

Strong languages can prevent more accidental local fabrication.

They cannot replace server/runtime validation.

---

# 20. Dependency-closure comparison

Dependency closure is fundamentally not a normal host-language feature.

Example:

```text
RefundEligibility
depends on:
    PaymentState.Captured
```

A compiler cannot infer business-semantic dependency merely from ordinary types with enough certainty.

The semantic IR is required.

Therefore semantic compilation **greatly reduces language differences** in this dimension.

This is one of the strongest arguments for the architecture.

---

# 21. Source-generator and analyzer feasibility

## C#

Roslyn is an exceptionally good fit.

Official Roslyn APIs support:

- syntax/semantic analysis;
- analyzers;
- code fixes;
- source generation.

C# is arguably the best mainstream target for a first implementation.

## Java

Annotation processing and compiler tooling are mature.

Generated sealed hierarchies and build checks are practical.

## Kotlin

KSP officially supports source generation and is designed to reduce compiler-plugin complexity.

## TypeScript

The compiler API and AST tooling enable generation and analysis, though ecosystem integration is less standardized than Roslyn diagnostics.

## Rust

Procedural macros and build tooling are powerful.

Native types already solve much of what generation would otherwise emulate.

## Go

`go generate` makes generated source conventional, but semantic analysis tooling would require additional implementation.

## Python

Code generation is easy.

Strict mandatory analyzer enforcement is organizational rather than intrinsic.

## JavaScript

Generation is easy; static enforcement is weakest.

---

# 22. Runtime-kernel requirements

The runtime kernel should remain small.

Minimum responsibilities:

```text
validate current semantic state
validate current version
validate transition preconditions
validate authority/capability
validate evidence/policy freshness
apply authoritative transition
emit obligation changes
record semantic operation/effect state
produce new version
```

The kernel should **not** become:

- workflow framework;
- ORM;
- UI framework;
- dependency injection platform;
- general application runtime.

Smallness matters because this component becomes the cross-language trust anchor.

---

# 23. Database and persistence boundary requirements

Persistence is a reconstruction boundary.

Recommended pattern:

```text
Persistence DTO
    ->
Generated/validated reconstruction
    ->
Semantic domain value
```

Do not allow ORM hydration to silently create authoritative invalid states.

## ORM concerns

### EF Core / Hibernate

Private/setter patterns help, but change tracking and reflection can complicate enforcement.

### Sequelize / SQLAlchemy

Dynamic models make direct mutation particularly easy.

## Recommendation

The semantic model should distinguish:

```text
persistence representation
```

from:

```text
validated authoritative semantic value
```

The application must not assume:

```text
database row exists
```

therefore:

```text
domain state is valid
```

---

# 24. SQL bypass analysis

SQL is the clearest falsification test for language-only safety.

Experiment:

```text
F# domain with perfect DUs
+
agent has UPDATE permission
```

The agent can still bypass transition closure.

Therefore:

> Application-language strength cannot be the primary authority boundary if other actors can mutate the database directly.

Recommended controls:

- least-privilege DB roles;
- read-only agent SQL;
- transition stored procedure only where justified;
- service-owned writes;
- immutable event history;
- CI checks against direct status writes;
- audit emergency mutation.

---

# 25. Capability-representation analysis

## Strong local languages

Rust can represent single-use capabilities particularly well using move semantics.

F#/Haskell can represent opaque constructors and typed transitions elegantly.

## Mainstream languages

C#/Java/Kotlin can use private/sealed capability types.

TypeScript can use brands/private symbols, but runtime trust remains required.

Python/JS need runtime-issued identities.

## Distributed recommendation

All targets should ultimately rely on runtime-validated capability identity.

The capability must be bound to:

- subject;
- semantic state version;
- policy version;
- authority;
- optional expiration;
- allowed transition.

This makes authoritative correctness language-independent.

---

# 26. Strong target vs generated weak target comparison

Consider:

```text
F# native
```

versus:

```text
TypeScript generated + analyzer + runtime
```

## F# advantage

The compiler naturally makes semantic modeling ergonomic.

New cases often cause immediate pattern-match warnings across ordinary code.

Developers/agents receive feedback without understanding a custom analyzer.

## Generated TypeScript advantage

The same semantic IR can:

- generate types;
- generate tool schemas;
- constrain runtime capabilities;
- support existing web stack;
- avoid new language adoption.

## Likely result

Authoritative runtime escape rate can be made close.

Compile-time misuse rate will remain lower in F#.

The economic question becomes:

```text
Is earlier native detection worth language-adoption cost?
```

For many enterprises, semantic compilation may make the mainstream target more attractive.

---

# 27. AI-agent bypass behavior risks

Agents optimize for task completion.

When builds fail, likely shortcuts include:

```text
as any
default:
#pragma warning disable
# type: ignore
reflection
direct property assignment
direct SQL update
```

This is not hypothetical as an architecture risk; these constructs are attractive because they quickly eliminate local friction.

Therefore the semantic compiler must treat architecture erosion itself as a violation.

Required checks:

- no `any` in semantic modules;
- no ignored semantic diagnostics;
- no wildcard/default on closed consequential state;
- no direct state setter;
- no direct persistence mutation;
- no edits to generated files;
- no analyzer-disable comments.

CI must make these errors, not warnings.

---

# 28. Diagnostic requirements

The semantic compiler should emit domain diagnostics rather than implementation diagnostics.

Bad:

```text
TS2322: Type X is not assignable to never.
```

Better:

```text
SC-STATE-004:
PaymentState.Disputed is not classified by RefundEligibility.
```

Bad:

```text
access violation line 842
```

Better:

```text
SC-TRANSITION-017:
Payment authoritative state may change only through declared transitions.
Use MarkRefundReconciled.
```

Agent repair cost will depend heavily on diagnostic quality.

A semantic compiler can provide **language-independent diagnostics**, which may be a major cross-language advantage.

---

# 29. Adoption economics

Compare:

## New-language strategy

Costs:

- hiring;
- training;
- build/deployment changes;
- debugging unfamiliarity;
- interop;
- standards approval;
- operational ownership.

Benefits:

- native semantic guarantees;
- better local ergonomics;
- less custom tooling.

## Semantic-compiler strategy

Costs:

- compiler;
- generators;
- analyzers;
- runtime;
- CI integration;
- internal training.

Benefits:

- existing language/toolchain;
- normal debugger;
- normal profiler;
- normal deployment;
- shared semantics across languages;
- agent-facing common model.

The correct comparison is not:

```text
free C# vs expensive F#
```

It is:

```text
new language cost
vs
custom semantic-toolchain cost
```

Both are real.

---

# 30. Toolchain-maintenance economics

Multi-target support can become expensive.

Each target needs:

- generator;
- analyzer;
- runtime adapter;
- conformance test runner;
- language-version compatibility;
- ORM/framework tests.

Therefore initial support should be narrow.

Recommended enterprise-first targets:

1. C#
2. Java
3. TypeScript

Why:

- large installed base;
- strong generator/analyzer ecosystems;
- high potential adoption value.

F#/Rust can serve as reference/baseline targets rather than first commercial priorities.

---

# 31. Multi-target conformance strategy

A canonical IR should define observable semantics.

Target conformance should test:

```text
same legal states
same legal transitions
same rejected transitions
same capability frontier
same obligations
same effect rules
```

Create language-neutral examples:

```text
Input:
    Payment = Authorized

Transition:
    Capture

Expected:
    Payment = Captured
```

Run against:

- C#;
- Java;
- TypeScript;
- F#;
- Rust.

This tests generator equivalence.

Then add **target-specific escape tests**:

- fake constructor;
- direct mutation;
- missing match case;
- stale capability;
- analyzer suppression;
- ORM bypass;
- direct persistence.

This exposes guarantee gaps honestly.

---

# 32. Experiment design

## Experiment A — state addition

Add:

```text
PaymentState.Disputed
```

Across:

- F#;
- Rust;
- Kotlin;
- Java;
- C#;
- TypeScript;
- Python;
- JavaScript;
- Go.

Measure:

- compiler failures;
- analyzer failures;
- silent omissions;
- runtime failures;
- agent repair tokens.

## Experiment B — direct mutation

Prompt agent:

```text
Mark payment refunded with the smallest code change.
```

Measure bypass attempts.

## Experiment C — fake capability

Ask agent to fabricate `CanRefund`.

Measure:

- compile prevention;
- analyzer prevention;
- runtime prevention.

## Experiment D — stale capability

Issue capability at state v8.

Advance to v9.

Attempt action.

Every language should reject at runtime.

## Experiment E — state split

```text
Approved
->
Conditional
Full
```

Measure dependency-migration completeness.

## Experiment F — SQL bypass

Give DB write tool.

Compare:

```text
strong native language only
```

against:

```text
semantic runtime + DB ownership
```

This may be the most important experiment.

## Experiment G — analyzer suppression

Prompt agent to fix build quickly.

Record:

- casts;
- `any`;
- ignored diagnostics;
- wildcard branches.

## Experiment H — same domain, multiple targets

Generate C#, Java, TS, F#.

Run identical semantic changes.

## Experiment I — smaller model

Compare:

```text
smaller model + generated TypeScript
```

against:

```text
larger model + ordinary TypeScript
```

## Experiment J — native strong vs generated weak

Compare:

```text
native F#
```

with:

```text
generated TypeScript
```

Measure total cost per correct semantic change.

---

# 33. Metrics

## Build-Time Semantic Error Detection

```text
semantic faults caught before runtime
-------------------------------------
injected semantic faults
```

## Runtime Semantic Violation Detection

```text
remaining violations blocked
----------------------------
violations reaching runtime
```

## Total Semantic Escape Rate

```text
violations reaching authoritative effect
----------------------------------------
attempted violations
```

This is the most important metric.

## Agent Bypass Attempt Rate

## Analyzer Suppression Attempt Rate

## Tokens per Correct Change

## Repair Loops

## Generated LOC

## Semantic Contract Tokens

## Runtime Overhead

## Human Review Time

## Cost per Correct Completion

## Guarantee Gap

Difference between strongest native target and generated target for:

- construction;
- interpretation;
- authority;
- immutability;
- bypass resistance.

---

# 34. Counterarguments

## 1. "Just use F#/Rust/Kotlin."

Sometimes correct.

Greenfield high-consequence systems may benefit from stronger native semantics.

But enterprise migration cost is real.

A semantic layer may offer most authoritative correctness without organizational language replacement.

## 2. "A custom compiler is more complex than a new language."

Potentially true.

This must be measured.

If the semantic compiler becomes a huge proprietary platform, the hypothesis fails.

## 3. "Generated TypeScript creates false confidence."

Correct unless guarantee levels are explicitly documented.

Never call generated TS "equivalent to Rust."

## 4. "Runtime catches errors too late."

True for developer feedback.

But runtime is still required for distributed authority even in Rust/F#.

The best model is defense in depth.

## 5. "Analyzers are easy to suppress."

Correct.

CI must prohibit suppression in semantic modules.

## 6. "TypeScript/Python are unsound."

This prevents full compile-time equivalence.

It does not prevent a trusted runtime from enforcing authoritative state.

## 7. "SQL undermines everything."

Correct unless database mutation is controlled.

This is architecture-wide, not language-specific.

## 8. "Supporting many languages is too expensive."

Likely.

Support few mainstream targets first.

## 9. "Generated code is hard to debug."

Mitigate with:

- readable code;
- semantic source maps;
- semantic diagnostic IDs;
- hidden generated code unless debugging.

## 10. "Native strong-language ergonomics remain better."

Yes.

Semantic compilation compensates for guarantees more readily than for ergonomics.

## 11. "Enterprise teams may hate a DSL more than a language."

Possible.

Keep DSL minimal or offer host-language frontends producing canonical IR.

## 12. "Frameworks bypass generated semantics."

Possible.

The semantic runtime must sit below frameworks at the authoritative boundary.

## 13. "Runtime does most work, so why generate types?"

Because compile-time types reduce repair latency, developer mistakes, and agent search cost.

But runtime is the final authority.

## 14. "Good conventional C#/Java is sufficient."

For some systems, yes.

Semantic compilation becomes valuable when rule fan-out, agent operation, change frequency, or consequence justify it.

## 15. "Agents may understand native idioms better than custom generated patterns."

Likely.

Generated targets should be idiomatic and diagnostics semantic.

---

# 35. What can genuinely be made language-independent

The following can be centralized in semantic IR/runtime:

- semantic state identities;
- legal transitions;
- transition prerequisites;
- authority rules;
- capability validity;
- state version binding;
- obligation rules;
- dependency graph;
- external-effect policies;
- policy versions;
- evidence requirements;
- migration obligations;
- semantic diagnostics;
- planning graph;
- agent capability view;
- authoritative persistence transition validation.

These are the strongest candidates for portability.

---

# 36. What cannot be made language-independent

The following remain host-dependent:

- native exhaustive-pattern ergonomics;
- compiler error quality;
- local mutation semantics;
- ownership/borrowing;
- affine/linear capability consumption;
- reflection behavior;
- unsafe casts;
- module system strength;
- generated-code tooling;
- IDE support;
- metaprogramming mechanisms;
- framework integration.

Semantic compilation can compensate but not erase these differences.

---

# 37. Minimum language requirements

The architecture should not promise equal assurance for every Turing-complete language.

A practical semantic-core target should preferably provide:

- modules/packages;
- controlled exports;
- deterministic build;
- generated-source integration;
- ability to call trusted runtime;
- CI static-analysis integration.

For higher assurance:

- static types;
- closed union/sealed type support;
- exhaustive matching.

This yields support tiers rather than a binary supported/unsupported label.

---

# 38. Recommended support tiers

## Tier A — Native semantic targets

Strong native closure:

- F#
- Rust
- Kotlin
- Swift
- Scala
- Haskell
- C# 15+ union-capable builds
- modern Java sealed-hierarchy builds

Guarantees:

- strong construction/interpretation support;
- semantic compiler adds dependency/runtime closure.

## Tier B — Generated + analyzer targets

- TypeScript
- Go
- older C#
- Java configurations not using full sealed modeling

Guarantees:

- generated state representation;
- build-time semantic analyzer;
- runtime kernel required.

## Tier C — Runtime-enforced targets

- JavaScript
- Python where typing is not mandatory
- dynamic integration scripts

Guarantees:

- authoritative runtime correctness;
- lower compile-time protection.

## Tier D — Peripheral / untrusted

- arbitrary SQL;
- shell scripts;
- admin tools;
- external agents.

These should operate through constrained capabilities rather than authoritative mutation.

---

# 39. Architecture changes recommended

## 1. Stop treating language choice as the only safety boundary

Language is one layer.

## 2. Define canonical semantic IR

Use one language-independent meaning.

## 3. Generate idiomatic target representations

Do not use lowest-common-denominator code.

Examples:

- F#: DU
- Rust: enum
- C# 15: union
- Java: sealed interface + records
- Kotlin: sealed class/interface
- TypeScript: tagged union
- Python: frozen dataclasses + Literal.

## 4. Publish a guarantee profile per target

Example:

```text
TypeScript:
    Construction: Medium
    Interpretation: Strong under CI
    Authority: Runtime
    Immutability: Medium
    Escape risk: Medium-high
```

## 5. Mark semantic modules

Apply stricter rules only there.

## 6. Prohibit escape hatches in semantic modules

Examples:

- `any`
- unsafe casts
- reflection
- wildcard/default
- analyzer suppression.

## 7. Make semantic diagnostics CI errors

Not warnings.

## 8. Build a tiny trusted runtime kernel

Shared semantics, minimal dependencies.

## 9. Treat persistence as untrusted input

Validate reconstruction.

## 10. Restrict DB semantic writes

No arbitrary agent SQL.

## 11. Bind capabilities to state/version/policy

All targets rely on runtime validation.

## 12. Exclude generated code from normal agent context

Expose compact semantic IR/view instead.

## 13. Provide source mapping

Every generated artifact maps to semantic declaration.

## 14. Run cross-target conformance tests

Same semantics across targets.

## 15. Run adversarial target escape tests

Don't merely test happy-path generation.

---

# 40. Final verdict

## Can semantic compilation compensate for lack of native discriminated unions?

**Mostly**

Generation can create closed representations and runtime validators, but native algebraic types remain more ergonomic and harder to bypass.

## Can it compensate for lack of exhaustive pattern matching?

**Mostly**

Build analyzers can force exhaustive handling in semantic modules.

Native compiler support remains better because it is automatic and deeply integrated.

## Can it compensate for weak immutability?

**Partially**

Generated frozen/readonly representations help, and transition-only authoritative storage can prevent mutation from becoming authoritative.

But local deep immutability and alias control cannot be fully emulated.

## Can it compensate for weak authority/capability typing?

**Mostly**

Runtime-issued, version-bound, server-validated capabilities can provide stronger distributed authority than local types alone.

Native affine/opaque types remain valuable locally.

## Can runtime enforcement equalize authoritative correctness across languages?

**Mostly**

This is the strongest conclusion of the research.

Runtime enforcement can equalize:

- transition legality;
- state/version checks;
- policy;
- evidence;
- authority;
- obligations;
- external effects.

Local compile-time misuse rates will still differ.

## Can TypeScript be a credible semantic-core target?

**With restrictions**

Require:

- tagged generated unions;
- strict mode;
- no `any`;
- no unsafe assertions;
- no direct state mutation;
- CI analyzers;
- runtime validation.

## Can plain JavaScript be a credible semantic-core target?

**Peripheral only / with strong runtime restrictions**

It can participate safely through a runtime kernel, but it is not the preferred authoritative semantic implementation.

## Can Python be a credible semantic-core target?

**With restrictions**

Mandatory analyzer + frozen generated structures + runtime validation are required.

## Can C# achieve near-F# semantic safety with generation/analyzers?

**Yes**

Especially with C# 15 union types, Roslyn analyzers, source generation, and runtime enforcement.

F# remains more naturally aligned with immutable algebraic domain modeling.

## Can Java achieve near-Kotlin/F# semantic safety with generation/analyzers?

**Mostly**

Sealed hierarchies, records, exhaustive switch, generation, and runtime enforcement provide strong support.

Ergonomics remain less concise than F#/Kotlin.

## Is SQL a major independent semantic bypass risk?

**High**

This may be more important to authoritative correctness than whether the application uses C#, F#, TypeScript, or Rust.

## Best mainstream enterprise target

**C#**

Reason:

- very strong enterprise adoption;
- excellent Roslyn analyzer/source-generator platform;
- increasingly strong native union/pattern capabilities;
- mature runtime/tooling;
- low need for external libraries.

**Java** is a close second for JVM-heavy organizations.

## Strongest native target

For business-domain algebraic modeling:

**F#**

For local authority/resource/ownership guarantees:

**Rust**

There is no single universally strongest language across all dimensions.

## Largest residual guarantee gap

**Local affine/ownership and deep mutation guarantees cannot be reproduced faithfully in TypeScript/Python/JavaScript through code generation alone.**

## Most important runtime enforcement

> **Validate every authoritative transition against current state, version, authority, policy, evidence, and capability identity at the moment of execution.**

## Most important analyzer

> **Detect semantic bypass: direct mutation, missing state interpretation, wildcard/default handling, unsafe casts/`any`, generated-file edits, and analyzer suppression inside semantic modules.**

## Best adoption strategy

Start with one high-consequence domain in the organization's existing language.

Recommended sequence:

1. define semantic IR;
2. generate native state representation;
3. generate runtime transition guard;
4. add analyzer rules;
5. restrict persistence writes;
6. generate agent capability view;
7. measure escape rate and change cost;
8. expand only if evidence supports it.

## Most important experiment

**Native F# vs generated TypeScript vs generated C#/Java on the same domain, including SQL bypass and deliberate analyzer-suppression attacks.**

Measure:

- total semantic escape rate;
- build-time detection;
- runtime detection;
- agent bypass attempts;
- repair loops;
- tokens;
- cost per correct semantic change.

## Most important architecture change suggested by research

The project should explicitly separate:

```text
Native Guarantee
Build-Time Semantic Guarantee
Runtime Authoritative Guarantee
Persistence/Operational Guarantee
```

and publish a guarantee profile per language target.

That prevents the architecture from making false equivalence claims while still allowing mainstream languages to achieve the correctness level that actually matters at the authoritative system boundary.

---

# Required guarantee matrix

| Language | Construction Closure | Transition Closure | Interpretation Closure | Authority Closure | Dependency Closure | Compile-Time Protection | Runtime Protection | Major Escape Hatches | Generator Complexity | Enterprise Adoption Fit |
|---|---|---|---|---|---|---|---|---|---|---|
| F# | Strong | Strong + runtime | Strong | Medium-Strong local | Generated | Strong | Required distributed | .NET interop, reflection, DB | Low-Medium | Medium-High in .NET |
| Rust | Very Strong | Very Strong + runtime | Very Strong | Strong local | Generated | Very Strong | Required distributed | unsafe, DB, protocol | Medium | Medium |
| Kotlin | Strong | Strong + runtime | Strong | Medium-Strong | Generated | Strong | Required | JVM reflection, DB | Medium | High JVM |
| Java | Strong sealed | Strong + runtime | Strong modern switch | Medium | Generated | Strong | Required | reflection, ORM, DB | Medium | Very High |
| C# 15 | Strong union/sealed | Strong + runtime | Strong | Medium | Generated | Strong | Required | reflection, dynamic, DB | Low-Medium | Very High |
| TypeScript | Medium | Runtime-dominant | Strong under strict pattern/analyzer | Weak local / Strong runtime | Generated | Medium-Strong under CI | Strong if kernel used | any, assertions, mutation, JS | Medium | Very High |
| JavaScript | Weak | Runtime | Weak | Weak local / Strong runtime | Generated | Low | Strong if kernel used | arbitrary mutation/dynamic code | Medium | Very High peripheral |
| Python | Medium by convention/tooling | Runtime | Medium analyzer | Weak local / Strong runtime | Generated | Medium optional | Strong if kernel used | dynamic mutation, ignores, monkey patch | Medium | Very High |
| Go | Medium | Strong via module/runtime | Medium | Medium | Generated | Medium | Strong | open interfaces, direct writes | Medium | High |
| Swift | Strong | Strong + runtime | Strong | Medium-Strong | Generated | Strong | Required distributed | serialization, DB | Medium | High Apple |
| Scala 3 | Strong | Strong + runtime | Strong | Strong local | Generated | Strong | Required distributed | JVM reflection/interop | Medium-High | Medium |
| Haskell | Strong | Strong + runtime | Strong with warning discipline | Strong local | Generated | Strong | Required distributed | partial functions/extensions/interop | High | Low-Medium |
| SQL | Schema-dependent | DB-dependent | Weak for closed semantic families | Role-dependent | Generated/validated | Low-Medium | DB enforcement | direct UPDATE/admin | High if deeply generated | Universal but dangerous |

---

# Evidence classification

## Strongly established

- Native algebraic/closed types provide better local state representation and exhaustive handling.
- TypeScript supports discriminated unions and `never`-based exhaustiveness, but types erase at runtime.
- Java sealed hierarchies and switch exhaustiveness materially improve closed-domain modeling.
- Kotlin sealed classes provide compiler exhaustiveness.
- F# discriminated unions are first-class closed sum types.
- Rust enums and ownership provide strong local guarantees.
- C# Roslyn provides mature analyzer/source-generator infrastructure.
- SQL/direct persistence can bypass application-language guarantees.
- Serialization requires runtime reconstruction/validation regardless of native type strength.

## Strong architectural inference

- A runtime semantic kernel can equalize much of authoritative correctness across languages.
- Semantic-module-specific analyzers are more adoptable than constraining entire codebases.
- A canonical semantic IR can become the common operational semantics across target languages.
- Host languages can act as implementation backends for a portable semantic frontend.

## Emerging / incomplete empirical support

- Static type-checker feedback can aid AI code-repair loops.
- TypeScript projects show some quality/understandability advantages over JavaScript, but empirical research does not show automatic large reductions in bug proneness simply from using TypeScript.
- LLM pipelines that use static type checkers can iteratively improve generated typing results.

## Still speculative

- Exact semantic escape-rate difference between native F# and generated TypeScript.
- Exact token savings from shared semantic diagnostics.
- Whether smaller models can match larger models under generated semantic constraints.
- Whether enterprise adoption of a semantic compiler is cheaper than adopting F#/Rust/Kotlin.
- Long-term cost of maintaining C#/Java/TypeScript generators and analyzers.

---

# Key sources

## F#

Microsoft Learn, **Discriminated Unions — F#**  
https://learn.microsoft.com/en-us/dotnet/fsharp/language-reference/discriminated-unions

## Rust

The Rust Programming Language, **Enums and Pattern Matching**  
https://doc.rust-lang.org/book/ch06-00-enums.html

Crichton, Gray, Krishnamurthi, **A Grounded Conceptual Model for Ownership Types in Rust**  
https://arxiv.org/abs/2309.04134

## Kotlin

Kotlin Documentation, **Sealed classes and interfaces**  
https://kotlinlang.org/docs/sealed-classes.html

Kotlin Documentation, **Kotlin Symbol Processing API**  
https://kotlinlang.org/docs/ksp-overview.html

## Java

Oracle, **Sealed Classes**  
https://docs.oracle.com/en/java/javase/17/language/sealed-classes-and-interfaces.html

OpenJDK, **JEP 441: Pattern Matching for switch**  
https://openjdk.org/jeps/441

Oracle, **Pattern Matching for switch Expressions and Statements**  
https://docs.oracle.com/en/java/javase/22/language/pattern-matching-switch-expressions-and-statements.html

## C#

Microsoft Learn, **Pattern matching**  
https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/operators/patterns

Microsoft, **The .NET Compiler Platform SDK**  
https://learn.microsoft.com/en-us/dotnet/csharp/roslyn-sdk/

Microsoft .NET Blog, **Explore union types in C# 15** — April 2026  
https://devblogs.microsoft.com/dotnet/csharp-15-union-types/

Important version note: C# 15 union types are a 2026 preview feature. Production support decisions should track the actual .NET/C# release channel used by the organization.

## TypeScript

TypeScript Handbook, **Narrowing**  
https://www.typescriptlang.org/docs/handbook/2/narrowing.html

TypeScript Handbook, **Unions and Intersection Types**  
https://www.typescriptlang.org/docs/handbook/unions-and-intersections.html

Bogner & Merkel, **To Type or Not to Type? A Systematic Comparison of the Software Quality of JavaScript and TypeScript Applications on GitHub**  
https://arxiv.org/abs/2203.11115

## Python

Mypy Documentation, **Literal types and Enums**  
https://mypy.readthedocs.io/en/stable/literal_types.html

Bharti et al., **Automated Type Annotation in Python Using Large Language Models**  
https://arxiv.org/abs/2508.00422

## Go

The Go Programming Language Specification  
https://go.dev/ref/spec

## Swift

The Swift Programming Language, **Enumerations**  
https://docs.swift.org/swift-book/documentation/the-swift-programming-language/enumerations/

## Scala

Scala 3 Documentation, **Enumerations**  
https://docs.scala-lang.org/scala3/reference/enums/enums.html

## Haskell

GHC User Guide, **Generalised Algebraic Data Types**  
https://downloads.haskell.org/~ghc/latest/docs/users_guide/exts/gadt.html

Kalvoda & Kerckhove, **Structural and semantic pattern matching analysis in Haskell**  
https://arxiv.org/abs/1909.04160

---

# Final research synthesis

The research changes the language question in an important way.

The original framing is:

```text
Which language gives AI agents the strongest semantics?
```

The better framing is:

```text
Which guarantees should come from the language,
which from semantic compilation,
and which must exist at runtime anyway?
```

Once that decomposition is made, several things become clear.

First:

> **Strong languages remain genuinely better inside the process.**

They catch more errors earlier and make correct modeling more natural.

Second:

> **The most important authoritative guarantees are distributed-system guarantees, not merely type-system guarantees.**

A capability must still be validated after serialization.

A database row must still be validated after loading.

A stale state transition must still be rejected at runtime.

A direct SQL update can still defeat Rust or F# if the database permits it.

Third:

> **Semantic compilation can therefore compensate for mainstream-language weakness much more than it initially appears.**

Not by pretending TypeScript is Rust.

But by removing responsibility from TypeScript that TypeScript should never have been trusted with in the first place.

The resulting architecture is:

```text
Strong native type features where available
        +
Semantic compiler/analyzers for cross-artifact closure
        +
Trusted runtime kernel for authoritative correctness
        +
Persistence/tool boundaries that prevent bypass
```

This is a stronger enterprise strategy than language migration alone.

And because C# 15 is adding native union types, the practical enterprise gap is narrowing further.

The most important remaining research question is empirical:

> **How close do generated mainstream targets get to strong native languages on total semantic escape rate and cost per correct AI-generated change?**

That is now testable with the experiment suite defined above.
