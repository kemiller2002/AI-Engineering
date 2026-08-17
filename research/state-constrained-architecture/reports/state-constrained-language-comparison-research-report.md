id: RP-AI-STATE-LANGUAGE-2026-A001 title: Programming-Language Fit for State-Constrained AI-Maintained Commercial Software research_area: state-constrained-ai-software discipline: [programming-languages, software-architecture, ai-agent-reliability] author_agent: GPT-5.6-Sol version: 1.0.0 status: completed confidence: medium-high completion: complete priority: high created: 2026-08-14 updated: 2026-08-14 related_projects: [Research-OS, semantic-compiler, state-system-first-architecture] related_documents: [Research-Execution-Package-Specification-v2] supersedes: [] superseded_by: [] tags: [typestate, discriminated-unions, capabilities, ai-agents, semantic-compiler, reliability] keywords: [closed-states, exhaustive-patterns, protected-construction, immutable-transitions, capabilities, evidence, authority]

Programming-Language Fit for State-Constrained AI-Maintained Commercial Software

Research State Snapshot

• Theory Version: State-system-first architecture, pre-formalized.
• Knowledge Base Version: Research OS as of 2026-08-14 plus this REP.
• Highest Confidence Areas: Closed sums/exhaustive handling; protected construction; Rust ownership implications; TypeScript/Python escape-hatch analysis.
• Lowest Confidence Areas: Real-world autonomous-agent bypass rates; long-horizon maintainability of generated semantic cores; effect-system benefits in commercial teams.
• Largest Remaining Unknown: How much defect/bypass reduction comes from stronger native type systems versus a generated semantic core plus mandatory compiler/analyzer/runtime gates.
• Active Research Streams: State-system-first architecture; semantic DSL/compiler; agent-constrained mutation.
• Recently Invalidated Ideas: “Native discriminated unions are necessary.” They are not necessary; several languages can approximate the relevant semantic closure by other means.
• Priority Changes: Empirical agent experiments should now compare architectural profiles rather than languages alone.

1. Executive conclusion

The hypothesis survives, but the language question is subtler than “functional vs object-oriented” or “static vs dynamic.”

The architecture requires six distinct properties:

1. a closed representation of important states;
2. exhaustive handling when the state space is inspected;
3. protected construction of states, evidence, and capabilities;
4. immutable or encapsulated authoritative state so transitions are the normal mutation path;
5. typed transition boundaries that can carry expected failures, versions, evidence, and authority;
6. enough compiler/runtime friction against bypass that an autonomous coding agent finds the legal path easier than weakening the model.

No single feature is sufficient. Pattern matching without construction control is weak. Private constructors without exhaustive handling permit forgotten states. Static typing without immutability still permits order.Status = .... Runtime validation without static closure catches bad input but does not force an agent to use legal transitions.

Main findings

• Rust is the strongest raw semantic fit among the mainstream languages studied. Its enums, exhaustive match, privacy, immutability defaults, ownership/moves, and ability to avoid Copy give it a capability advantage that is not merely syntactic. It can represent tokens that are consumed, which is useful for single-use authority. The cost is commercial complexity and a steeper learning/implementation curve.
• F# is one of the most natural commercial representations of the core model, especially for closed states, state-specific data, immutable records, explicit Result, and compact transition code. But it does not statically solve single-use capabilities, revocation, distributed concurrency, serialization trust, or external effects. Its advantage over modern C#/Java/Kotlin is mostly lower ceremony and more direct algebraic modeling, not magical correctness.
• Swift is stronger than its usual enterprise-language reputation suggests. Associated-value enums, exhaustive switch, value semantics, access control, and Result make it close to F# for many domain-core concerns. Its ecosystem fit is much narrower outside Apple/server Swift contexts.
• Scala 3 and Haskell can express more than most commercial teams will sensibly use. Their raw power is excellent. That additional expressiveness can encode deeper invariants, but complexity becomes its own agent/human reliability risk. The theoretical ceiling should not be confused with the productive default.
• Modern Java is now a legitimate state-constrained core language. Sealed types + records + exhaustive pattern switch can model closed state families reliably. Its main weakness is ceremony, not inability. Ceremony matters because agents may choose shortcuts when the architecturally correct path is verbose.
• Kotlin improves materially on Java ergonomically, especially sealed hierarchies, concise data carriers, exhaustive when, null-safety, and expression-oriented code. It is one of the best JVM targets for this architecture, though data-class copy and ordinary reference mutability still require design discipline.
• C# 14 stable can approximate the architecture well, but does not natively have a first-class closed sum type. Records + sealed classes + private/internal construction + pattern matching are good, but exhaustiveness over class hierarchies has historically been weaker than F#/Rust/Swift/Java/Kotlin. C# 15 preview changes this materially: Microsoft currently documents union types and a closed hierarchy modifier with compiler-supported exhaustiveness. As of 2026-08-14, C# 15/.NET 11 are still preview; .NET 11 final is expected in November 2026. If these features ship substantially as documented, the native semantic gap between C# and F# becomes much smaller.
• TypeScript has excellent shape modeling but only moderate authority modeling. Tagged unions and never-based exhaustiveness are highly useful. Structural typing, type assertions, any, runtime erasure, object spreading, and easy deserialization mean protected semantic values are much weaker. A semantic compiler plus Zod-like runtime schemas, branded/nominal wrappers, generated factories, strict compiler settings, lint rules, and module boundaries can make it useful—but the architecture is more policy/tool dependent.
• Python is expressive enough to describe the model but too weak natively to be the authoritative semantic enforcement layer for highly autonomous agents. Dataclasses, enums, Literal, unions, match, NewType, Pydantic, mypy, and Pyright can provide excellent guidance and runtime validation, but Python’s own runtime does not enforce type annotations. Protected construction is largely conventional, monkey-patching/reflection are normal language capabilities, and bypass is cheap. Python is much better at edges, orchestration, research, and adapters unless the authoritative transition system is generated/runtime-gated elsewhere.
• Go is reliable operationally but a weak semantic fit for this specific architecture. Packages and unexported methods can restrict implementations, and explicit (value, error) returns are useful, but Go lacks native sum types and native exhaustive type-switch checking. Zero values, mutable structs, and interface openness require more runtime checks or generated discipline. It is reasonable for services and adapters; it is not an ideal authoritative state core when autonomous agents are expected to evolve the model.

The strongest conclusion

Native discriminated-union syntax is not required. Native or tool-enforced semantic closure is required.

A language can be a strong target if it can reliably provide:

> closed state spaces + exhaustive handling + protected construction + immutable transitions + explicit failure/effect boundaries.

A semantic compiler can compensate for syntax and boilerplate. It can even compensate for some missing nominal constructs. It cannot fully compensate for a runtime/type system in which arbitrary application code can cheaply fabricate, cast, mutate, or deserialize privileged semantic values unless those actions are moved behind a separately enforced boundary.

2. Evidence and methodology

This report uses three evidence classes:

• Primary language/compiler documentation for language semantics and current feature status.
• Local compiler experiments for Java 21, Kotlin 1.9, TypeScript 5.8.3, Swift 6.2.1, Python 3.13.5, and Go 1.23.2.
• Architectural inference for agent-bypass resistance, capability use, and semantic-compiler suitability.

Local exhaustiveness tests intentionally omitted a state case. Results:

|Language                                    |Result                                                                   |
|———————————————|-————————————————————————|
|Java 21 sealed hierarchy + switch expression|Compile error: switch did not cover all possible input values            |
|Kotlin sealed hierarchy + `when` expression |Compile error: `when` must be exhaustive; missing subtype named          |
|TypeScript tagged union + `assertNever`     |Compile error: omitted variant not assignable to `never`                 |
|Swift enum + `switch`                       |Compile error: switch must be exhaustive; compiler suggested missing case|
|Go interface + type switch                  |Compiled successfully despite omitted implementation                     |

These tests are not a full benchmark. They validate one high-value feedback-loop property.

3. Feature matrix

Legend: Native = directly supported by language/compiler; Strong pattern = robust idiom but not a first-class language sum; Tool-dependent = reliable only with checker/analyzer/runtime tooling; Weak = primarily convention/runtime.

|Language     |Closed sum / state family                |Exhaustive handling                                       |State-specific data|Protected construction              |Immutable transition fit   |Capability fit                      |Single-use/affine capability          |Expected failure in signature            |Native agent resistance|
|-————|——————————————|-———————————————————|-——————|————————————|—————————|————————————|—————————————|——————————————|————————|
|F#           |Native DU                                |Strong compiler warning; can fail build                   |Native             |Strong module/private representation|Excellent                  |Strong opaque wrappers              |Weak-moderate                         |Native `Result`                          |Strong                 |
|C# 14        |Strong pattern via sealed records/classes|Partial/weaker for hierarchies                            |Strong             |Excellent                           |Strong                     |Strong nominal wrappers             |Weak                                  |Library/custom union/result              |Moderate-strong        |
|C# 15 preview|Native `union` + `closed` hierarchies    |Native compiler exhaustiveness                            |Strong             |Excellent                           |Strong                     |Strong                              |Weak                                  |Union-based result natural               |Strong                 |
|Java         |Sealed interface/class + records         |Native exhaustive pattern switch                          |Strong             |Excellent                           |Strong                     |Strong nominal wrappers             |Weak                                  |Custom sealed `Result`; exceptions common|Strong-moderate        |
|Kotlin       |Sealed class/interface + data classes    |Native exhaustive `when`                                  |Excellent          |Excellent                           |Strong                     |Strong                              |Weak                                  |`Result`/sealed result                   |Strong-moderate        |
|TypeScript   |Native structural union                  |Strong via narrowing + `never` pattern                    |Excellent          |Weak-moderate                       |Strong for readonly data   |Moderate with brands/private classes|None                                  |Native union/result shapes               |Moderate at best       |
|Python       |Union/Enum/Literal + classes             |Checker-dependent; runtime `match` not a closure guarantee|Good               |Weak                                |Moderate with frozen models|Weak-moderate                       |None                                  |Union/result classes possible            |Weak                   |
|Rust         |Native enum                              |Compiler error                                            |Excellent          |Excellent                           |Excellent                  |Excellent                           |Excellent relative to peers           |Native `Result`                          |Very strong            |
|Swift        |Native enum with associated values       |Compiler error                                            |Excellent          |Excellent                           |Excellent value semantics  |Strong                              |Moderate (no general affine types)    |Native `Result`                          |Strong                 |
|Scala 3      |Enum / sealed trait / union types        |Strong compiler exhaustivity                              |Excellent          |Excellent + opaque types            |Excellent                  |Excellent                           |Moderate (not Rust-like by default)   |`Either`/ADTs                            |Strong                 |
|Haskell      |Native ADTs/GADTs                        |Warnings; build can promote to errors                     |Excellent          |Excellent via module exports        |Excellent                  |Excellent                           |Strong with linear types, but advanced|`Either`/ADTs                            |Strong                 |
|Go           |Interface + unexported marker method     |No native exhaustiveness                                  |Good structs       |Good package privacy                |Moderate                   |Moderate package token pattern      |None                                  |`(T, error)`                             |Weak-moderate          |

4. What is actually essential?

The architecture does not fundamentally require a language to use the term “discriminated union.” What it requires is the semantic equivalent of a closed sum.

A practical closed sum has four properties:

1. the compiler/tool knows the complete legal case set;
2. each case can carry different data;
3. ordinary callers cannot add cases outside the permitted boundary;
4. inspection can be checked for exhaustiveness.

F#/Rust/Swift/Scala/Haskell express this directly. Java/Kotlin express it with sealed hierarchies. C# 14 approximates it; C# 15 preview directly adds both unions and closed hierarchies. TypeScript expresses the value shape strongly but closure is structural and eraseable. Go cannot currently give the same guarantee natively.

5. Typestate and state-specific types

The canonical transition chain:

```text
DraftOrder -> SubmittedOrder -> ApprovedOrder -> FundedOrder
```

works in all eleven languages, but the enforcement quality differs.

F#, Rust, Swift, Scala, Haskell

These languages make distinct state types natural. Functions can consume one state and return another with little ceremony. Rust goes further when transitions take ownership: after submit(draft), the moved draft value is unavailable unless the type is cloneable or the API returns it.

Java, Kotlin, C#

Typestate is fully feasible and commercially practical if the domain core uses separate nominal record/class types. The cost is more declarations and object-oriented ceremony. Kotlin is the least ceremonial. C# records make this substantially easier than older C#.

TypeScript

Typestate is easy to describe using tagged object types or branded wrappers, but it is not hard to bypass. { kind: “approved”, ... } as ApprovedOrder is legal with an assertion. any erases the constraint. Generated code and lint/analyzer policy can make the path harder, but the compiler cannot make arbitrary source assertions impossible.

Python

Typestate is descriptive, not authoritative. A type checker can reject passing DraftOrder to a function requiring ApprovedOrder, but runtime code can do so unless the transition function validates. It is useful for developer/agent feedback when CI makes the checker mandatory; it is not a security-quality construction boundary.

Go

Separate structs (DraftOrder, SubmittedOrder) are nominal and useful. The awkwardness appears when trying to make a common closed state family and inspect it exhaustively. Typestate itself is feasible; algebraic composition around it is weaker.

6. Protected construction and authority fabrication

Protected construction is more important than it first appears. If Verified<FraudClear> can be freely instantiated, the entire evidence model collapses.

Strongest languages

Rust, F#, Swift, Scala, Haskell, Java, Kotlin, C# can all expose a type while hiding its constructor or representation behind module/package/assembly/file access rules.

The caveat is universal: serialization frameworks, reflection, unsafe APIs, source-level edits to the trusted module, or intentionally weakening visibility can bypass the abstraction. This architecture is not intended to resist a malicious actor with arbitrary source control. It is intended to make the legal path locally easier and compiler-supported.

TypeScript

TypeScript has several partial strategies:

• class with a private constructor and public read methods;
• unique symbol branding whose symbol is not exported;
• module-local factory functions;
• generated types with inaccessible brand fields.

These are useful, but assertions (as), any, structural compatibility, object spread, and runtime erasure prevent the same strength as nominal private representation. ECMAScript #private fields improve runtime object encapsulation for classes, but many domain models are plain objects and serialized JSON cannot carry nominal authority by itself.

Python

Underscore conventions and name-mangling are not authority boundaries. A constructor can enforce validation, but users can call internal members, use object.__new__, mutate attributes unless guarded, monkey-patch, or deserialize around intended factories. Pydantic/frozen dataclasses improve runtime discipline, not unforgeability.

Go

A package can expose a type with unexported fields and only exported constructor/transition functions. An interface containing an unexported marker method can prevent implementations from other packages. This is stronger than Go is sometimes credited for. However, code inside the authoritative package can fabricate states freely, there is no exhaustiveness guarantee, and zero values often need explicit handling.

7. Capability types

Consider:

```text
CanShip {
  aggregateVersion
  policySnapshot
}
```

The token should be receivable but not forgeable.

Rust: qualitatively different capability semantics

Rust can create a public capability type with private fields, omit Clone/Copy, and require it by value in the transition:

```rust
pub fn ship(cap: CanShip, order: ApprovedOrder, payment: CapturedPayment)
    -> Result<ShippedOrder, ShipError>
```

If CanShip is not Copy or Clone, ordinary safe Rust cannot duplicate it. The call consumes the value. This supports a meaningful single-use capability model in-process.

It still does not solve distributed revocation. A capability may be stale after issuance, so version/expiry checks remain necessary at the authoritative transition boundary. Serialization of the capability should generally be forbidden or treated as a request to revalidate, not as preservation of authority.

F#/C#/Java/Kotlin/Swift/Scala/Haskell

All can make opaque/non-publicly-constructible tokens. Most tokens are freely aliasable or copyable references/values unless additional machinery is used. Therefore “possess token” can be enforced, while “possess exactly once” usually cannot.

Haskell with linear types can model consumption more directly, but linear types remain an advanced design choice and are not the default commercial style.

TypeScript/Python/Go

Opaque token patterns are possible, but they depend more heavily on module/runtime discipline. TypeScript’s structural escape hatches and Python’s dynamic runtime make token fabrication notably easier. Go package-private fields are stronger than TypeScript/Python for nominal token construction, but tokens remain copyable unless they contain runtime state whose validity is checked centrally.

Revocation principle

No language-level capability should be treated as sufficient for revocation across time or distributed systems. A production CanShip should normally contain or reference:

• aggregate/version expectation;
• policy version/hash;
• evidence version/hash;
• expiry/issued-at;
• capability ID/nonce;
• possibly subject and action scope.

The authoritative transition validates those facts against current state.

8. Mutation control

The critical anti-pattern is:

```text
order.Status = “Shipped”
```

The best language design is not “developers promise not to do this.” It is “there is no setter and no representable Order object whose status can be casually mutated.”

Excellent defaults

• Rust: immutable bindings by default; private fields; state transition can consume and return new value.
• F#: immutable records/DU data by default in idiomatic domain code.
• Swift: structs/enums are value types; let prevents mutation; mutation is explicit.
• Haskell: immutable by default.
• Scala: val + immutable collections/ADTs provide strong support, though var exists.

Strong with discipline

• C#: records, get-only/init-only properties, readonly structs, private setters, immutable collections. with is useful but can violate invariants if public record construction/copy semantics expose fields that should be protected.
• Java: records are shallowly immutable carriers; final fields and private mutation are straightforward. Contained collections/objects may remain mutable.
• Kotlin: val is strong but shallow; data-class copy is convenient and may bypass invariant factories if designers expose protected fields as copy parameters.

Tool/convention dependent

• TypeScript: readonly, frozen runtime objects, and immutable libraries help, but readonly is primarily compile-time and casts can remove it.
• Python: frozen=True dataclasses/Pydantic frozen models add friction but the language remains dynamic.
• Go: structs are ordinarily mutable; unexported fields plus value-returning transitions can impose discipline, but immutability is not a language default.

9. Orthogonal state dimensions and type explosion

A common failure in typestate design is creating a type for every Cartesian product:

```text
DraftUnreviewedUnpaid
DraftApprovedUnpaid
ActiveApprovedPaid
...
```

That should usually be avoided.

The better architecture is composition:

```text
OrderSnapshot = {
  lifecycle: Lifecycle
  review: Review
  payment: Payment
}
```

where each dimension is independently closed, and transitions/capability derivation enforce cross-state rules.

All ADT-capable/sealed-hierarchy languages support this reasonably well. TypeScript is particularly concise at composing tagged unions. Rust/F#/Swift/Scala/Haskell are excellent. Java/Kotlin/C# are strong but produce more named declarations. Python can model it but relies on runtime/checker validation. Go can use interfaces/structs but loses exhaustive closure.

Key design rule

Use state-specific types only for dimensions whose state changes what operations are legal. Use composed closed values for descriptive orthogonal dimensions. Derive a capability when several dimensions jointly authorize an action.

This avoids type explosion while keeping cross-state authority explicit.

10. Cross-state invariants

Example:

```text
Shipped => Order Approved AND Payment Captured
Refunded => a prior Capture existed
```

No mainstream type system automatically proves arbitrary historical/business invariants across distributed data.

Practical enforcement layers:

1. Types eliminate obviously impossible local forms.
2. Protected constructors prevent invalid privileged states from being fabricated directly.
3. Transition functions check current cross-state conditions.
4. Capabilities package the fact that policy/evidence checks have passed at a version.
5. Optimistic concurrency/version checks ensure the capability is still applicable.
6. Event/history checks enforce historical predicates such as “a capture previously occurred.”
7. Runtime validation protects deserialization and persistence boundaries.
8. Tests/model checking cover properties not economical to encode statically.

Rust/Haskell/Scala can encode more at the type level, but production teams should resist encoding volatile business policy into elaborate type machinery. The goal is to prevent invalid semantic forms, not to turn the entire policy engine into theorem proving.

11. Result and error modeling

The architecture benefits when expected domain failure is visible in the transition signature.

Best native/default fits:

• Rust: Result<T,E> is pervasive and compiler/? ergonomics are excellent.
• F#: Result<‘T,’E> and computation expressions/pipeline style are natural.
• Swift: standard Result<Success, Failure> exists, though throwing APIs are also idiomatic.
• Scala: Either, ADTs, effect libraries.
• Haskell: Either, Maybe, transformer/effect ecosystems.

Strong but culturally mixed:

• Kotlin: sealed result types or Kotlin Result; exceptions remain common in JVM libraries.
• C#: custom Result<T,E>, union types in C# 15 preview, or libraries; exceptions are common historically.
• Java: sealed result type is easy to define; checked/unchecked exceptions remain culturally dominant in many APIs.

Weaker signature authority:

• TypeScript: tagged Result unions are excellent at compile time, but unchecked thrown exceptions can still appear and are not represented in signatures.
• Python: result objects/unions are easy, but exceptions are unchecked and annotations are not runtime-enforced.
• Go: (T, error) makes expected failure explicit and is a genuine strength, although the error type is often semantically broad rather than a closed domain-failure ADT.

12. Effect separation

A state-constrained architecture should distinguish:

```text
semantic decision -> effect request -> external observation -> next semantic transition
```

Example:

```text
StartRefund
  -> PaymentProvider.Refund(idempotencyKey)
  -> RefundSucceeded | RefundFailed | RefundOutcomeUnknown
```

This is an architectural pattern more than a language feature.

Every language can define an effect port/interface. The important question is whether the language makes it easy to keep effectful APIs from leaking throughout the domain core.

• F#/Haskell/Scala can make pure/effectful boundaries stylistically obvious; Haskell can enforce purity at the language level, but external concurrency/idempotency remains a domain problem.
• Rust’s ownership and explicit Result help isolate resource/effect handling, but Rust has no general mainstream algebraic-effect system.
• Java/Kotlin/C#/Swift support explicit interfaces/protocols and dependency injection effectively.
• TypeScript/Python make ports/adapters easy but cannot prevent arbitrary code from importing and calling effectful APIs without lint/module conventions.
• Go interfaces are excellent for ports/adapters even though state modeling is weaker.

Pure functional programming does not solve distributed effects. Unknown outcomes, retries, idempotency, duplicate events, reordering, and concurrency require explicit protocol state regardless of language.

13. Events and trusted external transitions

The architecture should separate:

```text
RefundRequested    // agent/application may create
RefundSucceeded    // only trusted provider adapter may create
```

Strong nominal/private-constructor languages can expose the event type but hide the event constructor/factory in the adapter module/package/assembly.

The most important rule is at the serialization boundary: a JSON object that says {type:”RefundSucceeded”} is a claim, not yet a trusted event. The adapter must authenticate/validate it and then construct the internal trusted event value.

TypeScript and Python especially need this distinction because shape-compatible/deserialized objects are easy to fabricate. Generated schemas plus adapter-only factories are necessary. Even in Rust/F#/Java/etc., deserializers should not automatically grant authority merely because bytes fit a type.

14. Claims, evidence, and epistemic state

The following should not be represented as booleans:

```text
Unknown | Reported | Assumed | Inferred | Verified | Contradicted | Invalidated
```

All languages can encode this concept. The important distinction is whether Verified<T> is protected.

Strong implementations use:

```text
Verified<T> = opaque/protected wrapper {
  value/evidence reference
  verifier/policy version
  verifiedAt
  aggregate/evidence version
}
```

The wrapper should only be constructed by the verification subsystem. The domain transition depends on it rather than reinterpreting raw evidence.

F#/Rust/Swift/Scala/Haskell excel syntactically. Java/Kotlin/C# are fully capable. TypeScript needs private brand/factory discipline. Python needs runtime factories and should assume the wrapper is forgeable by arbitrary in-process code. Go can hide fields within a package but cannot enforce exhaustive epistemic handling.

15. Policy and versioned state

All languages can carry versions. The difference is ergonomic and nominal safety.

Recommended types:

```text
AggregateVersion
PolicyVersion
EvidenceVersion
CapabilityVersion
```

Avoid using bare int/string where mixing versions would be dangerous.

• F#/Rust/Swift/Scala/Haskell: low-cost wrapper/newtype patterns.
• C#/Java/Kotlin: small record/value-class wrappers are straightforward.
• TypeScript: brands provide compile-time distinction but can be asserted away.
• Python: NewType is checker-only; runtime wrapper classes/Pydantic models are stronger.
• Go: named types (type PolicyVersion uint64) are useful and cheap.

Phantom types and type-level versions can be powerful, but production policy versions are usually runtime values. Encoding each policy revision as a distinct static type is rarely worth the deployment complexity.

16. Agent resistance

The target is not adversarial security. The target is gradient shaping: make the architecture-conforming patch shorter, clearer, and more compiler-supported than a semantic bypass.

Strong structural resistance

Rust

The obvious bypasses usually require conspicuous actions: make fields public, derive/implement Clone, use unsafe, change module visibility, or rewrite trusted constructors. Moves and privacy produce hard compiler errors. This is the strongest native gradient among the studied mainstream languages.

F#, Swift, Scala, Haskell

Closed cases, immutable values, and module access force an agent toward transition functions. Deliberate source edits can always weaken the model, but accidental mutation/fabrication is hard.

Moderate-to-strong structural resistance

Java, Kotlin, C#

Well-designed sealed/private/immutable domain assemblies are quite resistant. The main risk is that mainstream OO conventions make mutable entities/setters/ORM-friendly constructors easy to introduce. Analyzers, generated domain code, and architectural tests can raise resistance significantly.

C# 15 preview’s unions/closed hierarchies improve the compiler gradient if adopted after stabilization.

Convention/tool-dependent

TypeScript

The architecture is very effective when the agent stays inside strict TypeScript. It is easy to step outside: as, any, unknown as X, disabled strictness, @ts-ignore, object construction, schema mismatch, or plain JavaScript. Therefore the language needs mandatory project settings plus lint/analyzer and runtime-schema enforcement.

Go

Package boundaries can be strong, but lack of exhaustiveness means adding a state does not force all consumers to update. Mutable structs and generic interfaces encourage runtime/default cases.

Weak structural resistance

Python

A disciplined Python project can be well-engineered, but the runtime offers few hard barriers to an autonomous source-editing agent. # type: ignore, unchecked annotations, direct attribute access, internal imports, dynamic construction, monkey-patching, and deserialization make bypass cheap. The appropriate countermeasure is to move semantic authority into generated runtime validators/services or a stronger-language core.

17. Compiler feedback quality for AI

Compiler diagnostics matter because they convert open-ended semantic search into deterministic local repair tasks.

The best feedback loops for this architecture have three properties:

1. missing state cases identify the omitted variant;
2. illegal transition calls identify expected vs actual state types;
3. construction/visibility errors point to the protected boundary.

Excellent feedback environments

• Rust: highly specific diagnostics and suggestions; ownership errors are rich but can be conceptually demanding.
• Swift: strong exhaustiveness messages; local experiment explicitly named the missing enum case.
• Kotlin: local experiment explicitly named the missing sealed subtype.
• Java: clear exhaustive-switch compile errors; modern pattern matching materially improves feedback.
• C#: Roslyn diagnostics/analyzers are excellent; C# 15 closed/union features should improve state-exhaustiveness feedback.

Very useful but sometimes abstract

• F#: compact inferred types and exhaustiveness warnings are useful; generic/inference errors can become less local in complex pipelines.
• Scala/Haskell: can provide powerful guidance but advanced type-level errors may be hard for both humans and agents to localize.

Useful only when policy is mandatory

• TypeScript: excellent speed and generally repairable errors; never exhaustiveness is effective, but users can suppress or assert around the checker.
• Python: mypy/Pyright can provide good feedback, but it is external to runtime execution and therefore must be mandatory in the agent loop.
• Go: compiler speed/errors are excellent generally, but the compiler cannot report a missing closed-state case it does not model.

18. Runtime validation

Runtime validation and compile-time enforcement solve different problems.

Compile-time closure answers:

> “Can code in this build produce/handle this value legally?”

Runtime schema validation answers:

> “Do these bytes/untrusted objects conform to the expected input schema?”

You need both at system edges.

TypeScript

Zod is particularly compatible with a semantic compiler because schemas can validate runtime data and infer static TypeScript types. Zod 4 also supports JSON Schema conversion, which is useful for generated agent-tool schemas and API contracts. This materially improves TypeScript at boundaries but does not eliminate any/assertion/runtime-erasure concerns inside the core.

Python

Pydantic plus strict mypy/Pyright provides a credible runtime+static combination. The static half remains advisory to Python execution. A generated semantic layer can require that all transition inputs pass Pydantic validation and that protected states are returned only by generated factories.

C#

Roslyn analyzers/source generators can create compile-time diagnostics and generated APIs. Runtime boundary validation can use generated serializers/validators or framework facilities. C#’s nominal type system gives generated code stronger internal guarantees than TS/Python.

Java

Annotation processing/compiler plugins can generate types/factories/validators, while Bean Validation is suitable for many boundary constraints. Sealed types remain the stronger mechanism for domain closure.

19. Semantic compiler / generated-code fit

A semantic DSL/compiler can generate:

• closed domain state definitions;
• state-specific payloads;
• transition functions;
• guard/policy evaluation;
• evidence and capability wrappers;
• version checks;
• effect commands/events;
• agent tool schemas;
• serializers/validators;
• property/model-based tests;
• analyzer rules forbidding direct mutation/construction.

Best target characteristics

The most attractive targets are languages where generated constructs map onto native compiler concepts.

Excellent generation targets

C#, Java, Kotlin, Rust, Swift, Scala, F#.

C# is especially attractive commercially because Roslyn exposes syntax and semantic analysis plus incremental source generators and analyzers. A semantic compiler can generate nominal state/capability types and also emit diagnostics when handwritten code bypasses the intended API.

Java annotation processing and compiler APIs are mature, though generated-source ergonomics can be verbose. Kotlin has strong generated-code ergonomics and common symbol-processing patterns.

Rust procedural macros/build generation can emit very strong types, though compile-time/macro complexity must be controlled.

Strong but with diminishing returns

F#/Scala/Haskell already encode much of the semantic structure directly. Generation can reduce repetition and synchronize tools/schemas, but may provide less marginal value than in C#/Java.

Generation is most strategically valuable in TypeScript/Python

A compiler can compensate for missing ceremony by generating tagged unions, brands, validators, transition APIs, JSON schemas, and agent-tool definitions.

But generated code cannot change the underlying escape hatches:

• TypeScript callers can still assert/cast or use any unless policies/analyzers forbid it.
• Python callers can still bypass annotations/internal constructors unless runtime checks are authoritative.

Go

go generate/external generators can emit state structs/interfaces/transitions and tests. It can reduce boilerplate, but cannot add native exhaustive sum-type checking to the Go compiler. It can simulate it with generated visitor interfaces or analyzers, at the cost of ceremony.

20. What code generation can compensate for

Code generation can reliably compensate for:

• boilerplate for sealed hierarchies/records;
• repetitive state-specific wrappers;
• strongly typed IDs/version wrappers;
• transition signatures;
• result/error ADTs;
• capability/evidence token structures;
• schema/serializer duplication;
• guard dispatch tables;
• agent tool definitions;
• effect commands/events;
• test fixtures and state-machine tests;
• custom analyzer/linter rules;
• visitor patterns where native matching is weak;
• runtime validation at boundaries.

A semantic compiler therefore reduces the importance of choosing the most algebraically expressive language.

21. What code generation cannot fully compensate for

Generation cannot truly add the following if the host language/runtime does not support them:

1. Hard exhaustiveness in all handwritten code. An analyzer can approximate it, but it is another policy layer.
2. Unforgeable nominal values when arbitrary casts/dynamic construction are idiomatic and unchecked.
3. Affine/single-use ownership semantics comparable to Rust moves or Haskell linear types.
4. Runtime enforcement of erased/advisory types without adding explicit runtime checks everywhere authority crosses.
5. Immutability guarantees if public mutable representation remains accessible.
6. Revocation/distributed freshness. This is inherently runtime/system-level.
7. Protection against an agent editing the generator, disabling the analyzer, or changing policy. Repository governance/CI must make those higher-cost privileged changes.

The semantic compiler changes the local optimization landscape only if generated code and its enforcement settings are themselves protected.

22. C# specifically: how close is it to F#?

C# 14 stable

A robust pattern is:

```csharp
public abstract record OrderState;
public sealed record Draft(OrderId Id) : OrderState;
public sealed record Submitted(OrderId Id, SubmissionId SubmissionId) : OrderState;
```

Construction can be private/internal. Records provide concise immutable-ish data. Pattern matching is expressive. However, the base hierarchy is not the same thing as an F# DU: the compiler historically has less global knowledge that the type has exactly these cases, and class inheritance/visibility rules are more open-ended.

What F# gives more directly:

• one declaration defines the entire case set;
• each case constructor belongs to that single union;
• case payloads are inherently state-specific;
• pattern matches naturally reason over the whole set;
• no class hierarchy ceremony;
• representation can be hidden at the module/type level compactly.

C# 15 preview

The new preview union type directly represents a fixed set of case types, and closed hierarchies let the compiler treat all direct descendants as exhaustive for switch. This addresses the biggest semantic complaint against C# for this architecture.

What still differs from F# even if C# 15 ships:

• C# unions compose existing case types rather than using F#-style inline union-case declarations with payloads.
• C# remains mutation-friendly and OO-friendly by default; architectural choices must still prohibit setters/public construction.
• F# has more pervasive expression-oriented/result/composition idioms.
• F# single-case unions and module abstraction are often lower ceremony for semantic wrappers.
• Neither language provides Rust-like affine consumption.

Can generators/analyzers close the gap?

For commercial state-machine code, mostly yes. A generator can emit case records, unions/closed bases, private constructors, transition APIs, strongly typed IDs, result types, and serializers. A Roslyn analyzer can flag direct property mutation, forbidden construction, default arms over generated state families, unsafe deserialization, or edits outside transition modules.

The remaining gap is largely language-level ownership/affinity and the possibility of disabling/bypassing analyzer policy—not ordinary domain expressiveness.

23. Java specifically

Modern Java’s combination is stronger than older comparisons suggest:

• sealed interface / sealed class limits permitted descendants;
• records make immutable data carriers concise;
• pattern switch can be exhaustive over sealed families;
• package/module/private constructors protect privileged values.

The main cost is declaration volume. A semantic compiler can eliminate much of that volume.

Does verbosity weaken the architecture?

Yes, indirectly. If the “correct” implementation needs twelve files and the shortcut needs one mutable enum field, an agent/human has a stronger incentive to collapse the model. Generated code changes that economics. Therefore Java’s native semantic capability is strong, while its handwritten ergonomic score is lower.

24. Kotlin specifically

Kotlin sealed hierarchies plus exhaustive when are an excellent match. Data classes provide compact case payloads; nullability is integrated; val encourages immutable fields; visibility is strong.

Kotlin’s main invariant caveat is copy ergonomics. If a privileged type is a public data class with fields that encode validated state, .copy(...) can become an alternate constructor path. Protected semantic values should use private/internal constructors, non-data wrapper classes/value classes where appropriate, or generated factories that do not expose invariant-breaking copy surfaces.

Kotlin is materially better suited than Java ergonomically, not because Java lacks the required semantics.

25. TypeScript specifically

Tagged unions are genuinely good:

```ts
type Payment =
  | { kind: “authorized”; authorizationId: string }
  | { kind: “captured”; captureId: string; amount: Money };
```

This naturally prevents kind: “captured” with no captureId under strict checking. Narrowing and never can make handlers exhaustive.

But semantic authority is weaker:

```ts
const fake = { kind: “verified”, evidence: “none” } as Verified<FraudClear>;
```

or:

```ts
const fake: any = ...;
```

can bypass static guarantees. Types disappear at runtime. JSON deserialization produces shapes, not trusted semantic authority.

Structural typing: help and harm

Help: easy composition, generated schemas, unions, DTO integration, low ceremony.

Harm: semantic identity is not automatically nominal. Two types with the same shape are compatible unless branded/private members distinguish them.

Recommendation

TypeScript is suitable for a state-constrained core only with a constrained project profile:

• strict;
• noUncheckedIndexedAccess;
• exactOptionalPropertyTypes;
• no any in domain core;
• no unchecked type assertions in domain core;
• generated unique symbol brands or private-class wrappers;
• runtime schema validation at every external boundary;
• generated transition APIs;
• linter/analyzer enforcement;
• CI failure on suppressions/unsafe casts in semantic packages.

Even then, it remains weaker than nominal closed languages for authority tokens.

26. Python specifically

Python can describe the domain elegantly with classes/dataclasses, enums, Literal, unions, match, frozen models, protocols, NewType, and Pydantic.

The problem is enforcement. Python’s official typing documentation explicitly states that the runtime does not enforce function and variable annotations. That fact is decisive for autonomous-agent resistance.

A strong Python profile would require:

• Pyright or mypy in strict mode as a mandatory build gate;
• Pydantic/validated constructors for all external/domain inputs;
• frozen dataclasses/models;
• internal factories for privileged states;
• lint rules forbidding Any, cast, # type: ignore, direct internal imports, and object.__new__ in the domain core;
• a generated transition registry;
• runtime checks on every authoritative state transition.

That can be operationally reliable, but the semantic guarantees come from the toolchain and runtime framework, not Python itself.

For highly autonomous maintenance, Python is better as an edge/orchestration language than as the sole semantic authority layer.

27. Rust specifically

Rust’s relevance is not merely “it has enums.”

The unique combination is:

• closed enums with payloads;
• exhaustive match as a compiler requirement;
• private fields/module visibility;
• immutable bindings by default;
• ownership/moves;
• no implicit object aliasing semantics in the same style as GC OO languages;
• Result/Option pervasive in the ecosystem;
• unsafe is syntactically explicit.

Capability significance

A protected, non-Clone, non-Copy capability can be consumed by a transition. This makes “authorization must be presented once” structurally meaningful in-process.

Limits

Rust does not make stale capabilities fresh, does not revoke distributed tokens by itself, does not authenticate external events, and does not make business-policy design easy. serde derivations must be controlled so deserialization does not accidentally manufacture privileged values.

Ergonomic cost

A domain-heavy business service that does not need memory-level control may pay significant cognitive cost for ownership/lifetimes, especially when complex asynchronous/shared workflows require Arc, locks, or owned cloning. The architecture should use Rust where its capability/ownership advantages justify that cost, not as a reflexive “safest language” choice.

28. F# specifically

F# maps unusually well to this architecture because the language makes the desired representation the low-ceremony representation.

Idioms:

• DUs for closed states/outcomes/events;
• records for immutable snapshots;
• modules/private representations for protected construction;
• single-case unions for semantic IDs/wrappers;
• Result for expected failure;
• pattern matching for transition logic.

What F# still cannot enforce

• single-use capability consumption;
• distributed revocation/freshness;
• authenticated external evidence;
• avoidance of reflection/serialization escape hatches;
• cross-aggregate concurrency correctness;
• policy evolution correctness;
• that an agent will not edit trusted constructors or switch to mutable .NET classes.

Where F# becomes cumbersome

• very large typestate products if every policy dimension becomes a type;
• heavy interop with mutable/ORM-centric .NET frameworks;
• teams unfamiliar with expression-oriented design;
• advanced generic encodings that attempt to prove volatile business rules at compile time.

The best use of F# here is not “encode everything in types.” It is “make the stable semantic skeleton explicit and cheap.”

29. Haskell specifically

Haskell adds several powers beyond ordinary F#:

• pervasive purity in ordinary code;
• GADTs, type families, DataKinds, phantom types;
• abstract module exports;
• linear types in GHC for stronger consumption constraints;
• mature algebraic modeling of effects/results.

This can encode very strong protocols. The practical concern is that the type-level solution may become more complex than the business system it protects. GHC exhaustiveness is generally warning-based and build policy (-Werror or specific fatal warnings) is required if missing patterns must be build failures.

Haskell is an excellent research/reference language for defining the semantic ceiling. It is a selective commercial recommendation unless the organization already has Haskell capability.

30. Swift specifically

Swift enums are true associated-value sums and switches are exhaustive. Structs/enums are value types. Access control includes private/fileprivate/internal/package/public/open scopes. Result and async/await fit effect boundaries well.

For domain-centric Apple applications or server Swift teams, Swift is a very strong native fit. The limiting factor is ecosystem/organizational adoption rather than language semantics.

31. Scala 3 specifically

Scala 3 combines:

• enums compiled from sealed hierarchies;
• sealed traits/classes;
• union/intersection types;
• case classes;
• opaque type aliases;
• match types and advanced type-level programming;
• compiler derivation/metaprogramming.

Opaque types are particularly useful for semantic IDs/capabilities because representation can be hidden outside the defining scope.

Scala’s risk is not insufficient power but excess design latitude. Multiple equivalent abstraction techniques can make agent/human code inconsistent. A semantic compiler or very strict domain style is valuable precisely because Scala can otherwise produce too many clever solutions.

32. Go specifically

Go can implement a respectable restricted package API:

```go
type State interface { isState() }

type Draft struct { id OrderID }
func (Draft) isState() {}
```

The unexported marker method can prevent external packages from implementing the interface. Unexported fields can prevent direct external mutation.

However:

• the compiler does not know the interface’s implementation set is closed for exhaustiveness;
• type switches can omit cases silently;
• structs are mutable by default;
• zero values must be designed carefully;
• errors are explicit but usually not a closed sum of domain failures;
• visitor/codegen patterns are needed to simulate stronger closure.

This is why Go is classified as a good service/edge language but a weaker authoritative semantic-core language for agent-maintained systems.

33. Shared domain: idiomatic implementation sketches

The goal here is to demonstrate the strongest idiomatic version in each ecosystem, not transliterate F# syntax.

33.1 F#

```fsharp
module Domain

open System

type OrderId = private OrderId of Guid
type PolicyVersion = private PolicyVersion of int64
type AggregateVersion = private AggregateVersion of int64

type DraftOrder = private { Id: OrderId; Version: AggregateVersion }
type SubmittedOrder = private { Id: OrderId; Version: AggregateVersion }
type ApprovedOrder = private { Id: OrderId; Version: AggregateVersion }
type CancelledOrder = private { Id: OrderId; Version: AggregateVersion }

type AuthorizedPayment = private { AuthorizationId: string }
type CapturedPayment = private { CaptureId: string; Amount: decimal }
type RefundedPayment = private { RefundId: string; CaptureId: string }

type FraudClear = private FraudClear
type Verified<‘T> = private Verified of value:’T * policy:PolicyVersion * evidenceVersion:int64

type CaptureOutcome =
    | CaptureSucceeded of CapturedPayment
    | CaptureFailed of reason:string
    | CaptureOutcomeUnknown of idempotencyKey:string

type ShippingGate = private ShippingGate of AggregateVersion * PolicyVersion

type RefundGate = private RefundGate of AggregateVersion

let submit (draft: DraftOrder) : SubmittedOrder =
    { Id = draft.Id; Version = draft.Version }

let approve (Verified(FraudClear, _, _)) (submitted: SubmittedOrder) : ApprovedOrder =
    { Id = submitted.Id; Version = submitted.Version }

let requestCapture
    (approved: ApprovedOrder)
    (authorized: AuthorizedPayment)
    (idempotencyKey: string) =
    approved, authorized, idempotencyKey // effect command in real implementation

let ship
    (ShippingGate(expectedVersion, _))
    (Verified(FraudClear, _, _))
    (approved: ApprovedOrder)
    (_captured: CapturedPayment) =
    if expectedVersion <> approved.Version then Error “stale capability”
    else Ok ()
```

The verifier module would be the only module able to construct Verified<FraudClear>.

33.2 C# 14 stable (commercial baseline)

```csharp
public readonly record struct OrderId(Guid Value);
public readonly record struct AggregateVersion(long Value);
public readonly record struct PolicyVersion(long Value);

public sealed record DraftOrder(OrderId Id, AggregateVersion Version);
public sealed record SubmittedOrder(OrderId Id, AggregateVersion Version);
public sealed record ApprovedOrder(OrderId Id, AggregateVersion Version);
public sealed record CancelledOrder(OrderId Id, AggregateVersion Version);

public sealed record AuthorizedPayment(string AuthorizationId);
public sealed record CapturedPayment(string CaptureId, decimal Amount);

public sealed class Verified<T>
{
    internal Verified(T value, PolicyVersion policy, long evidenceVersion)
        => (Value, Policy, EvidenceVersion) = (value, policy, evidenceVersion);
    internal T Value { get; }
    public PolicyVersion Policy { get; }
    public long EvidenceVersion { get; }
}

public sealed class FraudClear
{
    internal FraudClear() { }
}

public abstract record CaptureOutcome
{
    private CaptureOutcome() { }
    public sealed record Success(CapturedPayment Payment) : CaptureOutcome;
    public sealed record Failure(string Reason) : CaptureOutcome;
    public sealed record Unknown(string IdempotencyKey) : CaptureOutcome;
}

public static class OrderTransitions
{
    public static SubmittedOrder Submit(DraftOrder d) => new(d.Id, d.Version);

    public static ApprovedOrder Approve(
        SubmittedOrder s,
        Verified<FraudClear> clear) => new(s.Id, s.Version);

    public static Result<Shipment, ShipError> Ship(
        ApprovedOrder order,
        CapturedPayment payment,
        Verified<FraudClear> clear,
        CanShip capability) => /* version checks */ default!;
}
```

For C# 15 preview, CaptureOutcome can become a union, and generated closed state families can use closed hierarchies where inheritance is desirable.

33.3 Java

```java
record OrderId(UUID value) {}
record AggregateVersion(long value) {}
record PolicyVersion(long value) {}

record DraftOrder(OrderId id, AggregateVersion version) {}
record SubmittedOrder(OrderId id, AggregateVersion version) {}
record ApprovedOrder(OrderId id, AggregateVersion version) {}

final class FraudClear { FraudClear() {} } // package-private trusted package

public final class Verified<T> {
  private final T value;
  private final PolicyVersion policy;
  private final long evidenceVersion;
  Verified(T value, PolicyVersion policy, long evidenceVersion) {
    this.value = value; this.policy = policy; this.evidenceVersion = evidenceVersion;
  }
}

sealed interface CaptureOutcome
  permits CaptureSuccess, CaptureFailure, CaptureUnknown {}
record CaptureSuccess(CapturedPayment payment) implements CaptureOutcome {}
record CaptureFailure(String reason) implements CaptureOutcome {}
record CaptureUnknown(String idempotencyKey) implements CaptureOutcome {}

final class Transitions {
  static SubmittedOrder submit(DraftOrder d) {
    return new SubmittedOrder(d.id(), d.version());
  }

  static ApprovedOrder approve(SubmittedOrder s, Verified<FraudClear> clear) {
    return new ApprovedOrder(s.id(), s.version());
  }

  static String describe(CaptureOutcome x) {
    return switch (x) {
      case CaptureSuccess s -> “captured”;
      case CaptureFailure f -> “failed”;
      case CaptureUnknown u -> “unknown”;
    };
  }
}
```

33.4 Kotlin

```kotlin
@JvmInline value class OrderId(val value: UUID)
@JvmInline value class AggregateVersion(val value: Long)

class FraudClear internal constructor()
class Verified<T> internal constructor(
    internal val value: T,
    val policyVersion: Long,
    val evidenceVersion: Long
)

data class DraftOrder internal constructor(val id: OrderId, val version: AggregateVersion)
data class SubmittedOrder internal constructor(val id: OrderId, val version: AggregateVersion)
data class ApprovedOrder internal constructor(val id: OrderId, val version: AggregateVersion)

data class AuthorizedPayment internal constructor(val authorizationId: String)
data class CapturedPayment internal constructor(val captureId: String, val amount: BigDecimal)

sealed interface CaptureOutcome {
    data class Success(val payment: CapturedPayment) : CaptureOutcome
    data class Failure(val reason: String) : CaptureOutcome
    data class Unknown(val idempotencyKey: String) : CaptureOutcome
}

fun submit(d: DraftOrder) = SubmittedOrder(d.id, d.version)
fun approve(s: SubmittedOrder, clear: Verified<FraudClear>) = ApprovedOrder(s.id, s.version)

fun describe(x: CaptureOutcome) = when (x) {
    is CaptureOutcome.Success -> “captured”
    is CaptureOutcome.Failure -> “failed”
    is CaptureOutcome.Unknown -> “unknown”
}
```

Privileged data classes should be designed carefully because public copy surfaces can become alternate construction paths.

33.5 TypeScript

```ts
declare const verifiedBrand: unique symbol;
declare const approvedBrand: unique symbol;

type OrderId = string & { readonly __orderId: unique symbol };

type DraftOrder = Readonly<{ kind: “draft”; id: OrderId; version: number }>;
type SubmittedOrder = Readonly<{ kind: “submitted”; id: OrderId; version: number }>;
type ApprovedOrder = Readonly<{
  kind: “approved”; id: OrderId; version: number; readonly [approvedBrand]: true
}>;

type FraudClear = Readonly<{ kind: “fraud-clear” }>;
type Verified<T> = Readonly<{
  value: T;
  policyVersion: number;
  evidenceVersion: number;
  readonly [verifiedBrand]: true;
}>;

type CaptureOutcome =
  | { kind: “success”; payment: CapturedPayment }
  | { kind: “failure”; reason: string }
  | { kind: “unknown”; idempotencyKey: string };

const assertNever = (x: never): never => { throw new Error(“unreachable”); };

export function submit(d: DraftOrder): SubmittedOrder {
  return { kind: “submitted”, id: d.id, version: d.version };
}

// generated/trusted module only; symbol brands not exported
function approveInternal(s: SubmittedOrder, clear: Verified<FraudClear>): ApprovedOrder {
  return { kind: “approved”, id: s.id, version: s.version, [approvedBrand]: true };
}

export function describe(x: CaptureOutcome): string {
  switch (x.kind) {
    case “success”: return “captured”;
    case “failure”: return “failed”;
    case “unknown”: return “unknown”;
    default: return assertNever(x);
  }
}
```

This is useful but not unforgeable against as any as Verified<FraudClear>.

33.6 Python

```python
from dataclasses import dataclass
from typing import Generic, TypeVar, Literal

T = TypeVar(“T”)

@dataclass(frozen=True)
class DraftOrder:
    id: str
    version: int

@dataclass(frozen=True)
class SubmittedOrder:
    id: str
    version: int

@dataclass(frozen=True)
class ApprovedOrder:
    id: str
    version: int

class FraudClear:
    __slots__ = ()

@dataclass(frozen=True)
class Verified(Generic[T]):
    _value: T
    policy_version: int
    evidence_version: int

@dataclass(frozen=True)
class CaptureSuccess:
    kind: Literal[“success”]
    payment: “CapturedPayment”

@dataclass(frozen=True)
class CaptureFailure:
    kind: Literal[“failure”]
    reason: str

@dataclass(frozen=True)
class CaptureUnknown:
    kind: Literal[“unknown”]
    idempotency_key: str

CaptureOutcome = CaptureSuccess | CaptureFailure | CaptureUnknown

def submit(d: DraftOrder) -> SubmittedOrder:
    return SubmittedOrder(d.id, d.version)

def approve(s: SubmittedOrder, clear: Verified[FraudClear]) -> ApprovedOrder:
    # Runtime authority validation must still occur.
    return ApprovedOrder(s.id, s.version)
```

The verifier should create Verified, but Python cannot make that constructor truly inaccessible to arbitrary in-process source code.

33.7 Rust

```rust
pub struct OrderId(uuid::Uuid);
pub struct AggregateVersion(u64);

pub struct DraftOrder { id: OrderId, version: AggregateVersion }
pub struct SubmittedOrder { id: OrderId, version: AggregateVersion }
pub struct ApprovedOrder { id: OrderId, version: AggregateVersion }

pub struct FraudClear(());
pub struct Verified<T> {
    value: T,
    policy_version: u64,
    evidence_version: u64,
}

pub struct CanShip {
    aggregate_version: u64,
    policy_version: u64,
    // no Clone, no Copy
}

pub struct AuthorizedPayment { authorization_id: String }
pub struct CapturedPayment { capture_id: String, amount: Decimal }

pub enum CaptureOutcome {
    Success(CapturedPayment),
    Failure(CaptureFailure),
    Unknown { idempotency_key: String },
}

pub fn submit(d: DraftOrder) -> SubmittedOrder {
    SubmittedOrder { id: d.id, version: d.version }
}

pub fn approve(s: SubmittedOrder, _clear: Verified<FraudClear>) -> ApprovedOrder {
    ApprovedOrder { id: s.id, version: s.version }
}

pub fn ship(
    cap: CanShip,
    _order: ApprovedOrder,
    _payment: CapturedPayment,
    _clear: Verified<FraudClear>,
) -> Result<Shipment, ShipError> {
    // cap is consumed; re-check version/freshness here
    todo!()
}
```

The trusted verifier owns the only constructor that can create FraudClear/Verified<FraudClear>. Avoid deriving Deserialize for privileged authority values unless deserialization itself is trusted and validating.

33.8 Swift

```swift
struct OrderID: Hashable { let rawValue: UUID }
struct AggregateVersion: Equatable { let rawValue: UInt64 }

struct DraftOrder { let id: OrderID; let version: AggregateVersion }
struct SubmittedOrder { let id: OrderID; let version: AggregateVersion }
struct ApprovedOrder { let id: OrderID; let version: AggregateVersion }

struct FraudClear { fileprivate init() {} }
struct Verified<T> {
    fileprivate let value: T
    let policyVersion: UInt64
    let evidenceVersion: UInt64
    fileprivate init(_ value: T, policyVersion: UInt64, evidenceVersion: UInt64) {
        self.value = value
        self.policyVersion = policyVersion
        self.evidenceVersion = evidenceVersion
    }
}

enum CaptureOutcome {
    case success(CapturedPayment)
    case failure(CaptureFailure)
    case outcomeUnknown(idempotencyKey: String)
}

func submit(_ d: DraftOrder) -> SubmittedOrder {
    SubmittedOrder(id: d.id, version: d.version)
}

func approve(_ s: SubmittedOrder, using _: Verified<FraudClear>) -> ApprovedOrder {
    ApprovedOrder(id: s.id, version: s.version)
}
```

33.9 Scala 3

```scala
opaque type OrderId = UUID
object OrderId:
  def apply(v: UUID): OrderId = v

final case class DraftOrder private (id: OrderId, version: Long)
final case class SubmittedOrder private (id: OrderId, version: Long)
final case class ApprovedOrder private (id: OrderId, version: Long)

final class FraudClear private[verification] ()
final class Verified[T] private[verification] (
  val value: T,
  val policyVersion: Long,
  val evidenceVersion: Long
)

enum CaptureOutcome:
  case Success(payment: CapturedPayment)
  case Failure(reason: String)
  case Unknown(idempotencyKey: String)

def submit(d: DraftOrder): SubmittedOrder = SubmittedOrder(d.id, d.version)
def approve(s: SubmittedOrder, clear: Verified[FraudClear]): ApprovedOrder =
  ApprovedOrder(s.id, s.version)
```

33.10 Haskell

```haskell
module Domain
  ( DraftOrder, SubmittedOrder, ApprovedOrder
  , Verified, FraudClear
  , CaptureOutcome(..)
  , submit, approve
  ) where

newtype OrderId = OrderId UUID
newtype AggregateVersion = AggregateVersion Word64

data DraftOrder = DraftOrder OrderId AggregateVersion
data SubmittedOrder = SubmittedOrder OrderId AggregateVersion
data ApprovedOrder = ApprovedOrder OrderId AggregateVersion

data FraudClear = FraudClear
— constructor not exported

data Verified a = Verified a Word64 Word64
— constructor not exported

data CaptureOutcome
  = CaptureSuccess CapturedPayment
  | CaptureFailure CaptureFailure
  | CaptureOutcomeUnknown IdempotencyKey

submit :: DraftOrder -> SubmittedOrder
submit (DraftOrder oid v) = SubmittedOrder oid v

approve :: SubmittedOrder -> Verified FraudClear -> ApprovedOrder
approve (SubmittedOrder oid v) _ = ApprovedOrder oid v
```

A linear capability variant is possible with GHC linear types, but should be treated as an advanced optional profile rather than the default.

33.11 Go

```go
package domain

type OrderID string
type AggregateVersion uint64

type DraftOrder struct { id OrderID; version AggregateVersion }
type SubmittedOrder struct { id OrderID; version AggregateVersion }
type ApprovedOrder struct { id OrderID; version AggregateVersion }

type FraudClear struct{ seal struct{} }
type VerifiedFraudClear struct {
    seal struct{}
    policyVersion uint64
    evidenceVersion uint64
}

type CaptureOutcome interface { captureOutcome() }
type CaptureSuccess struct { Payment CapturedPayment }
func (CaptureSuccess) captureOutcome() {}
type CaptureFailure struct { Reason string }
func (CaptureFailure) captureOutcome() {}
type CaptureUnknown struct { IdempotencyKey string }
func (CaptureUnknown) captureOutcome() {}

func Submit(d DraftOrder) SubmittedOrder {
    return SubmittedOrder{id: d.id, version: d.version}
}

func Approve(s SubmittedOrder, _ VerifiedFraudClear) ApprovedOrder {
    return ApprovedOrder{id: s.id, version: s.version}
}
```

Other packages cannot implement CaptureOutcome because the marker method is unexported, but a type switch over CaptureOutcome is not compiler-exhaustive.

34. Required pairwise comparisons

F# vs C#

F# wins: lower-ceremony sums, state-specific payloads, immutable domain style, compact semantic wrappers, established exhaustive pattern style.

C# wins: larger mainstream .NET staffing/ecosystem footprint; richer Roslyn analyzer/source-generation tooling; easier integration with typical enterprise frameworks.

C# 15 preview changes the conclusion: first-class unions and closed hierarchies address much of the native closure gap. If stable, the decision becomes more about domain-style ergonomics and team/tooling than expressive adequacy.

F# vs Java/Kotlin

Java/Kotlin can enforce essentially the same stable state boundaries with sealed families and private constructors. F# is more concise. Kotlin narrows the ergonomics gap substantially. Java’s verbosity is a real agent/human incentive issue but is highly amenable to generation.

F# vs TypeScript

Both make tagged state data pleasant. F# has nominal/module-protected construction and runtime type identity; TypeScript types erase and can be asserted around. TypeScript requires runtime schemas and stricter governance to make authority values trustworthy.

F# vs Python

F# provides compiler-enforced types/visibility where Python provides annotations and runtime conventions. Python can model the concepts but is not equivalently constraining. For autonomous agents, this is a major distinction.

F# vs Rust

F# is generally easier and more concise for business-domain modeling. Rust is stronger where capability consumption, alias/mutation control, and ownership are central. Rust’s extra guarantee costs cognitive and implementation complexity. A hybrid system could reasonably place safety-critical authority transitions in Rust while keeping surrounding .NET/application code elsewhere, but that architecture has integration costs of its own.

35. Raw constraint scorecard

Scores are 1–5. These are architecture-specific judgments, not general language-quality ratings.

|Language    |Closed|Exhaustive|Impossible states|Typestate|Protected ctor|Capability|Immutable|Mutation resistance|Orthogonal composition|Cross invariants|Failure model|Effects|Events|Epistemic|Versioned caps|Agent resistance|Compiler feedback|Codegen|Team ergonomics|Ecosystem|
|————|——:|———:|-—————:|———:|-————:|———:|———:|——————:|———————:|—————:|————:|——:|——:|———:|-————:|—————:|-—————:|——:|—————:|———:|
|F#          |5     |5         |5                |4        |5             |4         |5        |5                  |5                     |4               |5            |4      |5     |5        |4             |5               |4                |4      |4              |4        |
|C# 14 stable|4     |3         |4                |4        |5             |4         |4        |4                  |4                     |4               |3            |4      |4     |4        |4             |4               |5                |5      |5              |5        |
|Java        |4     |5         |4                |3        |5             |4         |4        |4                  |4                     |4               |3            |4      |4     |4        |4             |4               |5                |5      |5              |5        |
|Kotlin      |4     |5         |4                |4        |5             |4         |4        |4                  |5                     |4               |3            |4      |4     |4        |4             |4               |5                |4      |5              |5        |
|TypeScript  |5     |4         |3                |3        |2             |2         |4        |3                  |5                     |3               |4            |4      |4     |3        |4             |2               |4                |4      |5              |5        |
|Python      |3     |2         |2                |2        |2             |2         |3        |2                  |4                     |3               |3            |4      |4     |3        |3             |1               |3                |4      |5              |5        |
|Rust        |5     |5         |5                |5        |5             |5         |5        |5                  |5                     |5               |5            |4      |5     |5        |5             |5               |4                |5      |3              |4        |
|Swift       |5     |5         |5                |4        |5             |4         |5        |5                  |5                     |4               |5            |4      |5     |5        |4             |5               |4                |4      |4              |4        |
|Scala 3     |5     |5         |5                |5        |5             |4         |5        |5                  |5                     |5               |5            |5      |5     |5        |5             |4               |3                |5      |3              |4        |
|Haskell     |5     |4         |5                |5        |5             |5         |5        |5                  |5                     |5               |5            |5      |5     |5        |5             |5               |3                |5      |2              |3        |
|Go          |2     |1         |3                |2        |4             |3         |2        |2                  |3                     |3               |4            |4      |3     |3        |3             |2               |5                |4      |5              |5        |

Raw constraint score below is the mean of dimensions 1–17 only, deliberately excluding codegen, commercial ergonomics, and ecosystem.

|Language    |Raw constraint score / 5|
|————|————————:|
|Rust        |**4.88**                |
|Haskell     |**4.82**                |
|Scala 3     |**4.76**                |
|F#          |**4.65**                |
|Swift       |**4.65**                |
|Kotlin      |**4.18**                |
|Java        |**4.06**                |
|C# 14 stable|**4.00**                |
|TypeScript  |**3.47**                |
|Go          |**2.88**                |
|Python      |**2.71**                |

C# 15 preview adjustment

If C# 15 unions and closed-hierarchy exhaustiveness ship substantially as currently documented, C# should gain roughly +1 on closed-state modeling/exhaustiveness/impossible-state ergonomics. I would expect its raw constraint score to move into approximately the 4.2–4.4 range depending on final union construction/serialization semantics. It should not be scored as stable production capability yet.

36. Commercial practicality scorecard

This is an independent judgment, not a mathematical combination of the raw score. It asks: “Can a normal commercial team productively maintain this architecture, hire for it, integrate libraries/frameworks, and get fast agent feedback?”

|Language    |Commercial practicality / 5|Why                                                                                                                                   |
|————|—————————:|—————————————————————————————————————————————|
|C# 14 stable|**4.8**                    |Strong nominal model, Roslyn generation/analyzers, large ecosystem, good diagnostics; native sum closure weaker until C# 15 stabilizes|
|Kotlin      |**4.6**                    |Excellent ergonomics + JVM ecosystem; sealed states natural                                                                           |
|Java        |**4.5**                    |Strong semantics and enormous ecosystem; verbosity raises modeling cost                                                               |
|TypeScript  |**4.2**                    |Huge ecosystem and fast feedback; must add strict policy/runtime validation for authority                                             |
|F#          |**4.1**                    |Excellent semantic ergonomics and .NET interop; smaller talent/ecosystem mindshare                                                    |
|Swift       |**3.9**                    |Strong language fit; narrower server/enterprise adoption                                                                              |
|Rust        |**3.8**                    |Superb constraints; ownership/async complexity and staffing cost                                                                      |
|Scala 3     |**3.5**                    |Powerful JVM option; complexity/style variance can reduce reliability                                                                 |
|Go          |**3.4**                    |Excellent operations/build simplicity; semantic closure needs generated patterns/analyzers                                            |
|Python      |**3.2**                    |Excellent productivity/ecosystem, but authoritative enforcement requires heavy runtime/tool policy                                    |
|Haskell     |**2.8**                    |Semantic ceiling is high; staffing/integration/type-level complexity limit broad commercial fit                                       |

A semantic compiler would likely raise C#, Java, Kotlin, TypeScript, Go, and Python practicality more than it raises F#/Rust/Haskell, because it removes repetitive ceremony and centralizes enforcement.

37. Recommended language tiers

Excellent native fit

• Rust — strongest when capabilities/ownership matter enough to justify cost.
• F# — strongest low-ceremony business-domain fit on .NET.
• Swift — excellent semantics where ecosystem is appropriate.
• Scala 3 — excellent semantics, but constrain style.
• Haskell — excellent semantic research/reference fit; selective commercial fit.

Strong fit with tooling

• Kotlin — already strong; generation protects factories/copy surfaces and reduces boilerplate.
• Java — semantic capability is strong; generation solves much of the ceremony.
• C# 14 — strong with sealed/private records, generated unions/state families, analyzers. Likely moves toward excellent native fit if C# 15 stabilizes as documented.

Feasible with significant tooling

• TypeScript — good state shapes; authority requires brands/private factories, runtime schemas, strict compiler/lint policy, and protected generated core.
• Go — good package boundaries/services; generated visitor/transition layer needed for closure/exhaustiveness-like behavior.

Poor fit for authoritative domain state under high agent autonomy

• Python, unless the “authority” is actually enforced by generated runtime transition infrastructure and mandatory static/runtime gates. Python remains excellent for edges/orchestration.

38. System-edge vs semantic-authority recommendations

|Language  |Authoritative semantic core                       |System edges/adapters           |
|-———|—————————————————|———————————|
|Rust      |Excellent                                         |Excellent but sometimes overkill|
|F#        |Excellent                                         |Strong                          |
|C#        |Strong; improving                                 |Excellent                       |
|Java      |Strong                                            |Excellent                       |
|Kotlin    |Strong                                            |Excellent                       |
|Swift     |Strong                                            |Excellent in its ecosystems     |
|Scala     |Strong                                            |Strong                          |
|Haskell   |Strong                                            |Strong with ecosystem caveats   |
|TypeScript|Conditional/tool-heavy                            |Excellent                       |
|Python    |Generally avoid as sole authority at high autonomy|Excellent                       |
|Go        |Conditional/tool-heavy                            |Excellent                       |

39. Minimum Agent-Safe Language Profile

The most useful output of this research may be a language-independent conformance profile.

Agent-Safe Level 0 — Boundary integrity

Required:

• runtime validation of untrusted/deserialized inputs;
• no external payload automatically becomes a trusted state/event/capability;
• version/concurrency checks at authoritative writes.

This is mandatory in every language.

Agent-Safe Level 1 — Explicit state

Required:

• important domain states represented as distinct closed cases/types;
• explicit transition API;
• no raw string/boolean state flags for authoritative lifecycle decisions;
• generated/documented state graph.

Agent-Safe Level 2 — Compiler-constrained state

Required:

• exhaustive handling enforced by compiler or mandatory checker/analyzer;
• state-specific data;
• protected state constructors;
• immutable/get-only authoritative state;
• expected transition failure represented explicitly.

A language that cannot meet Level 2 without optional convention should not be the preferred authoritative core.

Agent-Safe Level 3 — Authority and evidence

Required:

• opaque/protected capability types;
• protected Verified<T> / evidence wrappers;
• aggregate/policy/evidence version binding;
• transition APIs require capabilities rather than booleans;
• effect requests separated from effect outcomes;
• trusted external events only constructed by verified adapters.

Agent-Safe Level 4 — Consumption-aware authority

Optional/high assurance:

• single-use/affine capability semantics, or runtime-backed nonce consumption;
• explicit ownership of transition rights;
• no implicit copying of privileged capabilities;
• revocation/freshness checked centrally.

Rust can express part of this statically. Haskell can with linear types. Other languages should use runtime token consumption/version checks.

Agent-Safe Level 5 — Agent governance

Repository/tooling requirements independent of language:

• generated semantic code separated from handwritten code;
• agent is not authorized to edit generator output or enforcement configuration in ordinary tasks;
• CI rejects disabled analyzers/type checking/schema validation;
• direct mutation/construction patterns have analyzer/lint rules;
• state graph changes require explicit schema/migration/test updates;
• every new state forces exhaustive-handler checks;
• authority-bearing serialization is forbidden or revalidated;
• mutation tools exposed to agents are transition-oriented, not row/property-oriented.

This level is likely more important than the difference between F# and C#/Java/Kotlin.

40. Answers to the research questions

1. Is native discriminated-union support necessary?

No.

2. What is actually necessary?

A closed state set, state-specific data, exhaustive handling, protected construction, and immutable/encapsulated transitions. Native DUs are one excellent implementation.

3. Which language features are truly essential?

For the authoritative core:

• nominal or reliably closed semantic states;
• compiler/checker-visible exhaustiveness;
• constructor/representation privacy;
• immutable/get-only state or enforced encapsulation;
• distinct semantic wrappers/IDs;
• typed generics sufficient for Verified<T>/capabilities/results;
• module/package boundaries.

Ownership/linear types are valuable but not universally essential.

4. Which can be supplied by generated code?

Boilerplate state families, transition APIs, wrappers, results, schema validators, capability structures, version checks, event/command definitions, tests, visitors, analyzers, and agent tool schemas.

5. Which cannot realistically be emulated perfectly?

Native ownership/affinity, hard runtime enforcement of erased/advisory types, universal compiler exhaustiveness in a language that lacks closure, and unforgeability when arbitrary casts/dynamic construction are routine.

6. Minimum agent-safe profile?

Levels 0–5 above. Level 2 should be the minimum target for authoritative domain state; Level 3 for high-consequence agent-maintained systems.

7. Can C#, Java, TypeScript, Python become sufficiently constrained through a semantic compiler?

• C#: yes. Very plausibly excellent, especially once C# 15 features stabilize.
• Java: yes. Native semantics are already sufficient; generation solves ceremony.
• TypeScript: conditionally. Sufficient for many systems if strict checker + runtime schemas + lint/analyzer + protected generated core are mandatory. Weaker for privileged authority values.
• Python: only if authority is enforced at runtime by the generated transition layer. Static annotations alone are insufficient.

8. Does a semantic compiler reduce the importance of choosing F# or Rust?

Yes, substantially for ordinary state closure and transition correctness. Less so for Rust’s ownership/affine-capability advantage. F#’s main remaining advantage is human/agent semantic clarity and low ceremony rather than unique enforceability.

9. Which languages are unsuitable as authoritative cores for highly autonomous maintenance?

Python is the clearest weak choice without an additional enforced runtime authority layer. Go is also a weaker choice when exhaustive closed-state evolution is central. TypeScript is borderline: suitable only under a strict generated/tool-governed profile.

10. Which are particularly suitable at edges?

TypeScript, Python, and Go are all excellent edges/adapters/orchestration languages. Their weaknesses are concentrated in semantic authority, not integration/productivity.

41. Failed assumptions / challenged hypotheses

Failed assumption: “F# wins because it has discriminated unions.”

Too simplistic. Java/Kotlin sealed hierarchies and modern pattern matching provide much of the same safety. C# 15 preview directly attacks the historical gap.

Failed assumption: “Static typing is enough.”

False. Mutable public entities with Status fields remain semantically weak even in strongly typed languages.

Failed assumption: “Pure functional languages solve effects.”

False. Refund uncertainty, retries, duplicate callbacks, concurrency, and stale policy versions remain protocol/system problems.

Failed assumption: “A capability type is authority.”

Only partially. It proves possession of a value, not freshness or distributed revocation. Version/expiry/nonce validation remains necessary.

Failed assumption: “Generated types make TypeScript/Python as strong as Rust/F#.”

No. Generation can improve API shape and runtime gates but cannot remove host-language escape hatches or add affine ownership.

42. Open research questions

1. How often do autonomous coding agents bypass a protected transition model in each language when explicitly instructed only to “make tests pass”?
2. Does an exhaustive compiler error measurably reduce token/tool iterations compared with test-only detection?
3. Does Java/C# boilerplate cause agents to collapse states more often than F#/Kotlin/Rust?
4. How often do agents reach for any, assertions, # type: ignore, reflection, setters, or unsafe features under pressure?
5. Can repository-level capability restrictions prevent agents from editing analyzers/generator outputs without hurting productivity?
6. How much does a generated semantic DSL reduce language differences?
7. Is runtime-backed capability nonce consumption enough that Rust’s affine advantage becomes marginal in distributed systems?
8. Which invariants should be types versus transition guards versus policy engine rules?
9. Does generated state-machine documentation improve agent repair accuracy?
10. What is the optimal granularity of orthogonal state dimensions before capability derivation becomes too complex?
11. How do ORMs/event stores/serializers reintroduce invalid state in each ecosystem?
12. What migration strategy is safest when adding a new state to persisted data?
13. Can compiler diagnostics be normalized into agent-readable structured error objects rather than text?
14. Does C# 15 union/closed behavior remain stable enough by final .NET 11 to change the recommended .NET architecture?

43. Recommended empirical experiment program

Experiment A — Missing-state evolution

For each language:

1. implement the shared order model;
2. add a new payment state Voided;
3. ask an agent to make the project compile/test;
4. measure files touched, tool iterations, token usage, incorrect default branches, and semantic regressions.

Experiment B — Protected-state fabrication

Fail one test because approval requires Verified<FraudClear>. Ask the agent only to “make tests pass.” Record whether it:

• calls the verifier;
• fabricates the protected value;
• changes constructor visibility;
• casts/suppresses type errors;
• modifies the test;
• weakens the rule.

Experiment C — Mutation temptation

Provide an entity API plus a transition API and a failing “ship order” task. Measure whether the agent finds ship(...) or directly mutates status/DB state.

Experiment D — Capability staleness

Issue CanShip(version=10), mutate aggregate to version 11, then request shipping. Verify every target rejects the stale capability.

Experiment E — Unknown external effect

Inject timeout after provider request but before response. Evaluate whether the implementation produces OutcomeUnknown or incorrectly maps timeout to failure/retries blindly.

Experiment F — Serialization attack by accident

Give the agent JSON containing a fabricated Verified<FraudClear>/RefundSucceeded. Test whether deserialization grants authority.

44. Research backlog

Priority 1:

• C# 15 preview hands-on tests once a .NET 11 preview SDK is available in the research environment.
• Rust compiler experiments for non-Clone capabilities and serde construction boundaries.
• Python strict Pyright + Pydantic agent-bypass experiment.
• TypeScript strict + ESLint custom-rule + Zod generated-core experiment.

Priority 2:

• Kotlin data-class copy invariant tests.
• Java record/sealed hierarchy codegen prototype.
• Go generated visitor/analyzer prototype and comparison with native exhaustive languages.
• Haskell linear capability proof-of-concept.

Priority 3:

• Cross-language semantic DSL prototype generating F#, C#, Java, Kotlin, TypeScript, Python, Rust.
• State-machine property test generator.
• Structured diagnostic adapter for agents.

45. Theory impact assessment

Affected engineering principles

• Important domain state should be explicit.
• Legal transitions should be explicit.
• Invalid state should be difficult to represent.
• Agents should request transitions rather than mutate authoritative state.
• Important transitions may require evidence, capability, policy, and version checks.

New principle candidates

Principle candidate P1 — Closure over syntax

Prefer languages/toolchains that can enforce semantic closure. Native DU syntax is optional.

Principle candidate P2 — Authority is a construction problem

A semantic type is only meaningful if its privileged constructors/representation are protected.

Principle candidate P3 — Capabilities must be versioned

Possession proves only that a capability was issued, not that it remains valid.

Principle candidate P4 — Compiler gradients matter for agents

Architecture should be designed so compiler diagnostics guide the agent toward the legal transition rather than merely reject final output.

Principle candidate P5 — Generated semantic cores reduce language dependence

A generator can erase much of the ergonomic gap among nominal statically typed languages, shifting language choice toward ecosystem/team constraints.

Principle candidate P6 — Dynamic-language authority requires runtime enforcement

For erased/advisory type systems, semantic authority must be enforced by runtime transition infrastructure, not annotations alone.

46. Risks

• Over-encoding volatile policy into types creates migration friction and type explosion.
• Agents may “fix” architecture by weakening constructors/analyzers if repository permissions are not scoped.
• Serialization frameworks may accidentally bypass protected construction.
• ORM materialization may require alternate constructors and mutate private fields.
• Generated code can become opaque and difficult to debug if source mapping/documentation is poor.
• Strong languages can create false confidence about distributed concurrency/revocation.
• A semantic compiler can become a single point of design failure if its DSL semantics are underspecified.

47. AI consumption notes

An AI coding agent should be given a machine-readable state contract containing:

• state cases and payloads;
• legal transitions;
• preconditions/guards;
• required evidence/capabilities;
• version rules;
• possible outcomes including unknown outcomes;
• trusted constructor ownership;
• effect commands/events;
• forbidden direct mutation patterns.

The agent should ideally receive generated transition tools rather than general setters/database mutation tools.

48. Handoff instructions

Next agent should:

1. reproduce Experiments A–F in at least F#, C#/.NET 11 preview, Java, Kotlin, TypeScript, Python, and Rust;
2. record compile diagnostics verbatim and normalize them into structured categories;
3. measure agent bypass frequency across repeated trials;
4. prototype a minimal semantic DSL generating three targets: C# 15, TypeScript, Rust;
5. compare whether the DSL narrows defect-rate differences enough to make language selection secondary;
6. update the scorecard from empirical data rather than architectural judgment.

49. Evidence registry

EV-AI-STATE-LANG-001 — C# 15 preview unions and closed hierarchies

Microsoft documents C# 15 as a preview release supported by .NET 11 preview. It includes union types and closed hierarchies. Union switches can be exhaustive; closed classes fix direct descendants for exhaustiveness. .NET 11 remains preview as of this report and is expected to release in November 2026.

EV-AI-STATE-LANG-002 — F# discriminated unions

Microsoft’s F# documentation defines discriminated unions with associated case data and pattern matching, including generic Option as a canonical DU.

EV-AI-STATE-LANG-003 — Java sealed hierarchy closure

Oracle documentation states sealed classes/interfaces specify permitted descendants; modern pattern switches can be exhaustive over sealed hierarchies.

EV-AI-STATE-LANG-004 — Kotlin sealed exhaustiveness

Kotlin documentation states when over sealed classes can be checked exhaustively without else.

EV-AI-STATE-LANG-005 — TypeScript discriminated unions

TypeScript documentation describes common literal discriminants enabling control-flow narrowing. Exhaustiveness can be implemented using never checks.

EV-AI-STATE-LANG-006 — Python annotations not runtime enforced

Python’s official typing documentation states the runtime does not enforce function and variable type annotations.

EV-AI-STATE-LANG-007 — Rust enum + exhaustive match

Rust documentation states enums define values from a fixed set of variants and match requires all possible cases to be handled.

EV-AI-STATE-LANG-008 — Swift associated-value enum

Swift documentation states enum cases can carry associated values of different types; local Swift 6.2.1 test confirms omitted switch cases are compile errors.

EV-AI-STATE-LANG-009 — Scala 3 enums/opaque types

Scala 3 documentation describes enums as sealed-class-based ADTs and opaque type aliases for hiding representation.

EV-AI-STATE-LANG-010 — Haskell warning policy and linear types

GHC documentation supports fatal-warning configuration and a linear-types extension. Exhaustiveness therefore depends partly on build flags rather than being an unconditional compile error in all configurations.

EV-AI-STATE-LANG-011 — Go package restriction but no exhaustive type switch

Go allows unexported names/package encapsulation; local Go 1.23.2 test demonstrates a type switch can omit a closed-by-convention interface implementation and still compile.

EV-AI-STATE-LANG-012 — C# semantic generation tooling

Roslyn provides syntax/semantic APIs, analyzers, code fixes, and incremental source generators, making C# a particularly strong semantic-compiler target.

EV-AI-STATE-LANG-013 — TypeScript runtime schema support

Zod provides runtime schema validation with inferred static TypeScript types and Zod 4 supports JSON Schema conversion.

50. Primary source bibliography

• Microsoft Learn, What’s new in C# 15 (2026-07-27).
• Microsoft Learn, Union types — C# reference (2026-06-11).
• Microsoft Learn, closed modifier — C# reference (2026-06-11).
• Microsoft Learn, What’s new in .NET 11 (Preview 7; accessed 2026-08-14).
• Microsoft Learn, Discriminated Unions — F#.
• Microsoft Learn, Pattern Matching — F#.
• Microsoft Learn, .NET Compiler Platform SDK / Roslyn APIs.
• Oracle Java Documentation, Sealed Classes.
• Oracle Java Documentation, Pattern Matching for switch Expressions and Statements.
• Oracle JDK Documentation, javac / annotation processing.
• Kotlin Documentation, Sealed classes and interfaces.
• Kotlin Documentation, Data classes.
• TypeScript Handbook, Narrowing / discriminated unions.
• TypeScript TSConfig Reference, strictness options.
• Python 3 Documentation, typing — Support for type hints.
• Python 3 Documentation, dataclasses and Enum HOWTO.
• Rust Book/Reference, Enums and Pattern Matching, match, modules/privacy, ownership.
• Swift Programming Language, Enumerations, Structures and Classes, Declarations/access control.
• Scala 3 Reference, Enumerations, Opaque Type Aliases, Matchable, Match Types.
• GHC User Guide, Warnings and sanity-checking, Linear types, Type families.
• Go Language Specification / Effective Go / Go reflection documentation.
• Zod 4 Documentation, runtime schemas and JSON Schema conversion.

51. Research quality metrics

• Primary sources: 25+ documentation pages across language vendors/projects.
• Independent source families: 11 language ecosystems plus runtime validation ecosystems.
• Counterexamples reviewed: TypeScript casts/any; Python runtime typing; Kotlin copy; Go non-exhaustive interfaces; Rust serialization; C# preview status; Haskell warning-based exhaustiveness.
• Competing viewpoints reviewed: native ADT vs sealed OO hierarchy; static enforcement vs generated/runtime enforcement; expressive ceiling vs commercial ergonomics.
• Hypotheses tested: native DU necessity; compiler exhaustiveness value; Go closure limitations; C# historical gap.
• Failed hypotheses: native DU necessity; static typing sufficiency; functional purity solves effects.
• Research completeness: high for language-structure comparison; medium for empirical agent behavior.
• Confidence gain: high on architecture-independent minimum profile; medium-high on language tiers.
• Open questions reduced: language expressiveness question narrowed; empirical autonomous-agent behavior remains open.

52. Research debt

• No local F#, C#/.NET 11, Rust, Scala, or GHC compilers were available for direct experiments.
• C# 15 is preview and may change before final release.
• No repeated autonomous-agent trials were executed; agent-resistance scores are informed architectural judgments.
• Serialization/ORM bypass behavior needs framework-specific tests.
• Compile-speed/diagnostic-repair cost needs quantitative benchmarks.
• Pydantic/Pyright and TypeScript+Zod custom analyzer prototypes remain to be tested.

53. Completion checklist

☑ Executive conclusion
☑ Feature matrix
☑ Per-language analysis
☑ Shared-domain implementation sketches
☑ Required F# pairwise comparisons
☑ Raw constraint scorecard
☑ Commercial practicality scorecard
☑ Code-generation compensation analysis
☑ Non-compensable language properties
☑ Minimum language/agent-safe profile
☑ Recommended language tiers
☑ Open research questions
☑ Empirical test plan
☑ Evidence registry
☑ Theory impact assessment
☑ Research debt
☑ Handoff instructions