State-Constrained Architecture — Semantic Closure and Exhaustiveness
====================================================================

This note captures the follow-up exploration of exhaustiveness enforcement
and why it matters for AI-maintained state-constrained systems.

The key question is not merely:

    Does a language have discriminated unions?

The more important question is:

    When the state model contains N possible cases,
    does the language/toolchain force every consequential interpretation
    of that state to account for all N cases?

If programmers or AI agents must simply remember every condition,
much of the safety value of explicit state modeling is lost.


1. Exhaustiveness Is a First-Class Requirement
===============================================

Consider:

    PaymentState =
        Authorized
        Captured
        Refunded

and code that interprets it:

    Authorized -> ...
    Captured   -> ...
    Refunded   -> ...

Now add:

    Voided

The desired behavior is not merely:

    Voided can now be represented.

The desired behavior is:

    Every important place that assumed the old three-case universe
    becomes mechanically visible.

Ideally the compiler/toolchain says:

    This match/switch is now incomplete.

This converts state evolution from a repository-search problem into
a deterministic repair problem.

Without exhaustiveness:

    Agent adds new state
        ->
    Agent must remember/search for every affected conditional
        ->
    Some interpretations may be missed
        ->
    Semantic drift can accumulate

With exhaustiveness:

    Agent adds new state
        ->
    Compiler identifies incomplete interpretations
        ->
    Agent repairs explicit failures
        ->
    Compiler acts as a semantic checklist


2. Important F# Nuance
======================

F# is very strong at this because discriminated unions define a closed case set
and pattern matching understands the entire union.

However, incomplete pattern matching is typically surfaced as a compiler warning,
not universally as an unconditional hard error.

For this architecture, the build should treat incomplete DU matching warnings
as build failures.

Therefore the desired F# profile is:

    closed DU
    +
    exhaustive pattern warning
    +
    warnings-as-errors policy

The important property is still present:
the compiler knows the case universe and can detect missing interpretations.


3. Language Comparison
======================

The architectural question is:

    Can the compiler/toolchain force exhaustive interpretation
    of a closed state family?

General practical picture:

Rust
----

Native enums + match.

Missing cases are hard compiler errors.

Strength:

    Excellent.

Adding a state forces existing exhaustive matches to be reconsidered.


Swift
-----

Enums with associated values + exhaustive switch.

Missing cases are compiler errors.

Strength:

    Excellent.


Java
----

Modern Java sealed classes/interfaces plus pattern matching switch
can provide compiler-checked exhaustive handling.

Example conceptual family:

    sealed interface PaymentState
        permits Authorized, Captured, Refunded

A switch over that sealed family can be checked for completeness.

Strength:

    Excellent when sealed hierarchies and modern switch expressions
    are used correctly.


Kotlin
------

Sealed classes/interfaces plus when expressions provide strong exhaustiveness.

Example:

    sealed interface PaymentState

    Authorized
    Captured
    Refunded

A when expression over the sealed hierarchy can require every case.

Strength:

    Excellent.


F#
--

Discriminated unions provide direct semantic closure.

Compiler detects incomplete pattern matches.

For this architecture, incomplete-match warnings should be fatal.

Strength:

    Excellent with build policy.


Scala 3
-------

Enums/sealed hierarchies and compiler exhaustivity checking provide
strong support.

Strength:

    Excellent.


Haskell
-------

ADTs provide closed state families.

Incomplete pattern matches are normally warnings,
but build policy can promote them to errors.

Strength:

    Excellent with warning policy.


C# 14
-----

C# can model state families using sealed records/classes:

    abstract record PaymentState

    sealed record Authorized : PaymentState
    sealed record Captured   : PaymentState
    sealed record Refunded   : PaymentState

But historically C# has not had the same strong compiler knowledge
that a class hierarchy represents the complete state universe.

Therefore ordinary class-hierarchy switches are weaker than F#/Rust/Swift/
modern Java/Kotlin for semantic closure.

Strength:

    Moderate-to-strong with generated patterns/analyzers.

Useful supplements:

    Roslyn analyzers
    generated exhaustive visitors
    warning policies
    generated state families


C# 15 Preview
-------------

Preview C# work introduces union types and closed hierarchies with
compiler-supported exhaustiveness.

If these features stabilize substantially as designed,
C# becomes much stronger for this architecture.

Potential strength:

    Excellent once stable and verified.


TypeScript
----------

Tagged/discriminated unions are very useful.

Example:

    type PaymentState =
        | { kind: "authorized" }
        | { kind: "captured" }
        | { kind: "refunded" }

A switch can use a never-based exhaustive check.

Example conceptually:

    default:
        assertNever(state)

Adding a new union case then produces a type-check error.

However the protection depends on the coding pattern and project discipline.

An agent can weaken it through:

    default branches
    type assertions
    any
    @ts-ignore / similar suppression
    non-strict compiler settings

Strength:

    Good inside a constrained profile.

Less structurally resistant than nominal closed languages.


Python
------

Python can represent closed-looking unions through:

    Enum
    Literal
    Union
    dataclasses
    class hierarchies

Static checkers such as mypy/Pyright can provide some exhaustive analysis.

But Python runtime execution does not enforce annotations,
and exhaustiveness depends heavily on external tooling and configuration.

Strength:

    Weak-to-moderate for authoritative enforcement.

Useful for guidance, but not equivalent to compiler-native closure.


Go
--

Go can simulate a restricted state family through interfaces and
unexported marker methods.

Example conceptually:

    type PaymentState interface {
        paymentState()
    }

This can provide some construction restriction.

But a type switch can omit a valid implementation and still compile.

Therefore Go may achieve partial construction closure
without interpretation closure.

Strength:

    Weak for exhaustive semantic interpretation.


4. Four Forms of Semantic Closure
=================================

A state model is not safe merely because valid states are enumerated.

Construction Closure
--------------------

Only legal state variants can be created.

Example:

    PaymentState can only be:
        Authorized
        Captured
        Refunded

This prevents arbitrary values from becoming authoritative state.


Transition Closure
------------------

Authoritative state can only change through declared transitions.

Avoid:

    order.Status = "Shipped"

Prefer:

    Ship(order, capability)


Interpretation Closure
----------------------

Whenever code interprets a closed state,
the full state universe must be accounted for.

If:

    Chargeback

is added, every consequential interpretation that relied on the old state set
must be forced to reconsider its behavior.

This is especially important for AI maintenance.


Authority Closure
-----------------

Protected states, evidence, capabilities, and trusted events
cannot be freely fabricated.

Example:

    Verified<FraudClear>

must not be constructible by arbitrary application code.


5. Proposed Semantic Closure Model
==================================

The architecture should explicitly define:

    SEMANTIC CLOSURE

1. Construction Closure

    Only declared semantic states/claims/capabilities can be constructed.

2. Transition Closure

    Only declared transitions can change authoritative state.

3. Interpretation Closure

    Every consequential interpretation of a closed state family
    must account for the complete family.

4. Authority Closure

    Protected states, evidence, capabilities, and trusted events
    cannot be freely fabricated.


6. Why Interpretation Closure Matters for AI
=============================================

Traditional maintenance often relies on:

    search repository
    remember related branches
    recognize conventions
    understand historical context

AI agents also perform repository search,
but missed semantic dependencies are a major source of drift.

Interpretation closure changes the problem.

Instead of:

    "Find every place that might care about the new state."

the compiler can say:

    "These specific state interpretations are no longer complete."

That moves work from:

    probabilistic semantic discovery

to:

    deterministic compiler-guided repair


7. Wildcard / Default Cases Are a Major Escape Hatch
=====================================================

Even languages with excellent exhaustive matching can lose much of the benefit
if code routinely uses catch-all handlers.

Example:

    match payment with
    | Captured -> CanRefund
    | _        -> CannotRefund

Suppose the original states were:

    Authorized
    Captured
    Refunded

Then later add:

    Chargeback

The catch-all silently interprets Chargeback as:

    CannotRefund

without forcing anyone to reconsider whether that semantic assumption is correct.

The compiler sees the match as complete.

But semantically, the code has hidden a future state decision.


8. Consequential State Families Should Avoid Catch-Alls
=======================================================

For important closed state families, prefer:

    Authorized -> CannotRefund
    Captured   -> CanRefund
    Refunded   -> CannotRefund

Then adding:

    Chargeback

forces reconsideration.

Working rule:

    Wildcard/default handlers should be forbidden for consequential
    closed state families unless the semantic specification explicitly
    declares that all remaining cases are intentionally equivalent.


9. Explicitly Declared Grouping Is Different From a Wildcard
============================================================

Sometimes several states genuinely share the same behavior.

That should be expressible explicitly.

For example:

    Authorized | Refunded -> CannotRefund

is semantically better than:

    _ -> CannotRefund

because the intended equivalence is visible.

If:

    Chargeback

is later added, it is not silently absorbed.

The compiler/tooling must ask what Chargeback means.

Therefore:

    explicit grouping of known cases
        GOOD

    unknown future catch-all
        DANGEROUS


10. Semantic Compiler / Analyzer Implication
============================================

The semantic compiler should know which state families are consequential.

For generated or protected domain code it should enforce:

    no wildcard/default case over closed semantic state families

unless:

    default semantics are explicitly declared in the specification

Possible analyzer errors:

    SC001:
    Wildcard handler forbidden for closed state family PaymentState.

    Explicitly enumerate cases or declare semantic equivalence
    in the state specification.


11. State Evolution as a Compile-Time Event
===========================================

Adding a state should be treated as a semantic schema change.

Example:

    PaymentState:
        Authorized
        Captured
        Refunded

changes to:

    PaymentState:
        Authorized
        Captured
        Refunded
        Chargeback

The compiler/toolchain should then identify:

    incomplete handlers
    transition guards that rely on the old state family
    capability derivations
    obligation rules
    planning paths
    generated tests
    policy dependencies
    serialization schemas
    documentation/state diagrams


12. Desired State-Evolution Workflow
====================================

A safe evolution path should look like:

    Add new state
        ->
    Semantic compiler updates state universe
        ->
    Build identifies incomplete interpretations
        ->
    Generated tests expand
        ->
    Planning/capability graphs are recalculated
        ->
    Policy impact is reported
        ->
    Agent/human resolves every semantic question
        ->
    Build succeeds

Not:

    Add enum value
        ->
    Build succeeds
        ->
    Hope every if/switch was updated


13. Difference Between Modeling and Enforcement
===============================================

A language may let developers represent a closed state family
without forcing exhaustive interpretation.

That is only partial safety.

The architecture should distinguish:

    Can I MODEL the state?

from:

    Does the toolchain ENFORCE complete interpretation of it?

Examples:

Go:
    can approximate closed construction
    cannot natively force exhaustive type-switch handling

TypeScript:
    models tagged unions well
    can provide exhaustive handling
    but only when the never-style pattern and strict profile are used

Python:
    can describe the states
    external type checker may guide handling
    runtime itself does not provide the same enforcement


14. Revised Language Evaluation Criteria
========================================

Future language research should separately score:

1. State construction closure
2. Transition closure
3. Interpretation/exhaustiveness closure
4. Authority construction closure
5. Catch-all/default resistance
6. State-evolution compiler feedback

A language with excellent state syntax but weak interpretation closure
should not receive a high overall semantic-closure rating.


15. Revised Agent-Safe Language Profile
=======================================

Agent-Safe Level 1
------------------

Explicit states and explicit transitions.


Agent-Safe Level 2
------------------

Must include:

    closed state families
    compiler/checker-enforced exhaustiveness
    protected construction
    immutable authoritative state
    explicit expected failures

Additional requirement:

    incomplete semantic matches must fail the build


Agent-Safe Level 3
------------------

Must include:

    opaque capabilities
    protected evidence/Verified<T>
    version-bound authority
    effect/outcome separation
    trusted event construction

Additional recommendation:

    catch-all handlers forbidden on consequential state families


Agent-Safe Level 4+
-------------------

Includes stronger capability consumption,
runtime freshness/revocation,
and repository/agent governance.


16. Strong Design Principle
===========================

A closed state model is only truly valuable if evolution of that model
forces reconsideration of every consequential interpretation of the state.

This is stronger than:

    Use discriminated unions.

It means:

    The state universe must be closed,
    and changing that universe must mechanically expose stale assumptions.


17. AI-Specific Design Goal
===========================

The goal is not merely:

    prevent invalid syntax

or:

    create prettier types

The goal is:

    turn semantic change into deterministic work.

When a state changes:

    compiler errors
    generated analyzer failures
    policy impact reports
    generated tests

should tell the agent where meaning must be reconsidered.

The agent should not have to remember the entire semantic dependency graph.


18. Current Conclusion
======================

Discriminated unions are valuable because they often provide two things at once:

    closed state construction
    exhaustive interpretation

But the syntax itself is not the fundamental requirement.

The fundamental requirement is:

    semantic closure

especially:

    interpretation closure

A language/toolchain is a strong fit for state-constrained AI-maintained software
when it can make all of these true:

    only legal states can be constructed
    only legal transitions can change state
    every consequential state interpretation is exhaustive
    protected authority cannot be casually fabricated

And when the state universe evolves:

    the compiler/toolchain forces every affected semantic assumption
    back into view.
