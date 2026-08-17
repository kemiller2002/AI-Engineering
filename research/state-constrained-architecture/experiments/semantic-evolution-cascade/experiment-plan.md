State-Constrained Architecture — Semantic Evolution Cascade Experiment
=====================================================================

This note captures the preliminary experiment testing whether a change to a
closed domain-state universe mechanically forces stale semantic assumptions
back into view.

The central research question was:

    When a new state is added, does the language/toolchain force every
    consequential interpretation of that state family to be reconsidered?

This directly tests the previously identified requirement:

    Interpretation Closure

The goal is to convert state evolution from an open-ended repository search
problem into deterministic compiler-guided work.


1. Hypothesis
=============

Hypothesis:

    Closed state modeling materially protects AI-maintained software
    only when changes to the state universe mechanically expose stale
    interpretations.

In other words:

    It is not enough to model all legal states.

The toolchain must also force code that interprets those states
to reconsider its assumptions whenever the state family changes.


2. Test Domain
==============

Initial state family:

    PaymentState

        Authorized
        Captured
        Refunded

Six separate consequential interpretations were created:

    display
    refund eligibility
    settlement eligibility
    risk classification
    accounting treatment
    agent action selection

Then a new state was introduced:

    Disputed

No interpretation logic was initially modified.

The test measured which toolchains mechanically surfaced the stale assumptions.


3. Test 1 — Fully Exhaustive Handling
=====================================

Each of the six interpretations explicitly handled every known state.

Conceptually:

    Authorized -> ...
    Captured   -> ...
    Refunded   -> ...

No wildcard/default/catch-all behavior was used.

Then:

    Disputed

was added.


4. Results — Strict Exhaustive Version
======================================

Observed result:

| Toolchain                              | Affected interpretations | Mechanically surfaced | Semantic Change Coverage |
|----------------------------------------|--------------------------:|-----------------------:|-------------------------:|
| Java 21 sealed hierarchy              | 6                         | 6                      | 100%                     |
| Kotlin sealed hierarchy               | 6                         | 6                      | 100%                     |
| Swift enum                            | 6                         | 6                      | 100%                     |
| TypeScript + never exhaustiveness     | 6                         | 6                      | 100%                     |
| Go interface/type switch              | 6                         | 0                      | 0%                       |

The strong toolchains failed the build/type-check in every affected
interpretation.

Examples of feedback:

Kotlin:

    when expression must be exhaustive;
    add DISPUTED

Swift:

    add missing case: .disputed

Java:

    switch expression does not cover all possible input values

TypeScript:

    Disputed was no longer assignable to never
    in each exhaustive assertion

Go:

    compiled successfully


5. Go Runtime Behavior
======================

The Go version was executed with:

    Disputed

The old handlers silently returned fallback/default values such as:

    ""
    false
    false
    0
    ""
    ""

This demonstrates the exact failure mode the architecture is intended
to prevent:

    syntactically valid program
        +
    successful compilation
        +
    semantically unexamined new state


6. Test 2 — Catch-All / Default Handling
========================================

The second test deliberately weakened the code style.

Only three of the six interpretations remained explicitly exhaustive.

The other three used catch-all behavior such as:

    Authorized -> ...
    default    -> ...

or:

    Captured -> ...
    else     -> ...

Then:

    Disputed

was added.


7. Results — Catch-All Variant
==============================

Observed result:

| Language   | Semantic assumptions affected | Mechanically surfaced |
|------------|-------------------------------:|-----------------------:|
| Java       | 6                              | 3                      |
| Kotlin     | 6                              | 3                      |
| Swift      | 6                              | 3                      |
| TypeScript | 6                              | 3                      |

Semantic Change Coverage dropped from:

    6 / 6 = 100%

to:

    3 / 6 = 50%

The language did not become weaker.

The coding style disabled half of the compiler/toolchain protection.


8. Primary Finding
==================

There are two distinct questions:

    1. Does the compiler know the complete state universe?

    2. Does the code expose every semantic interpretation to that
       exhaustiveness mechanism?

A language can answer the first question well while application code
silently defeats the second.

This means:

    Discriminated unions / sealed types / enums are necessary only as
    part of a larger semantic-closure strategy.

They do not guarantee interpretation closure by themselves.


9. Why This Matters for AI Agents
=================================

Without interpretation closure:

    Agent adds new state
        ->
    Searches repository
        ->
    Finds likely conditionals
        ->
    Infers which ones matter
        ->
    Updates some
        ->
    Potentially misses others
        ->
    Semantic drift survives

With interpretation closure:

    Agent adds new state
        ->
    Compile / type-check
        ->
    Deterministic list of incomplete interpretations
        ->
    Agent resolves each semantic question
        ->
    Recompile

The compiler becomes a semantic checklist.

This transforms:

    probabilistic repository-wide semantic discovery

into:

    finite deterministic repair work


10. Semantic Change Coverage (SCC)
==================================

A new metric was proposed:

    Semantic Change Coverage

Definition:

        consequential interpretations mechanically surfaced
    SCC = ---------------------------------------------------
             consequential interpretations actually affected

Ideal value:

    1.00 / 100%

Examples from the preliminary experiment:

    Java strict          100%
    Kotlin strict        100%
    Swift strict         100%
    TypeScript strict    100%

    Same languages with
    50% catch-all use     50%

    Go                     0%

These values should not yet be generalized beyond the controlled experiment.

The important result is the mechanism:

    semantic assumptions can be measured by how completely
    the toolchain forces them back into view after state evolution.


11. Why Catch-Alls Are More Dangerous Than They Look
=====================================================

Consider:

    Captured -> CanRefund
    _        -> CannotRefund

This may look equivalent to:

    Authorized -> CannotRefund
    Captured   -> CanRefund
    Refunded   -> CannotRefund

But it is not.

The wildcard actually means:

    Every state that exists now,
    and every future state not explicitly listed,
    should be treated as CannotRefund.

That is a much stronger semantic claim.

Usually the developer did not consciously intend that future-state policy.

When:

    Disputed

is added, the wildcard silently makes a decision for it.


12. Stronger Architectural Rule
===============================

Proposed rule:

    Consequential closed state families must not permit
    implicit future-state handling.

Therefore:

    wildcard
    default
    else

should be prohibited for consequential state families
unless the semantic specification explicitly declares that
the remaining cases are intentionally equivalent.


13. Explicit Grouping Is Acceptable
===================================

Explicit grouping of known cases is different.

Example:

    Authorized | Refunded -> CannotRefund
    Captured              -> CanRefund

This is desirable because the semantic equivalence is explicit.

If:

    Disputed

is added, it is not automatically absorbed.

The toolchain must ask:

    What does Disputed mean here?


14. Semantic Compiler Implication
=================================

The semantic compiler should not merely generate state types.

It should also enforce interpretation policy.

Example conceptual declaration:

    state PaymentState {
        consequential: true

        Authorized
        Captured
        Refunded
    }

Generated analyzers could prohibit:

    _
    default
    else

when interpreting PaymentState.

Possible diagnostic:

    SC001

    Wildcard handler forbidden for consequential closed state family
    PaymentState.

    Enumerate known cases explicitly or declare semantic equivalence
    in the semantic specification.


15. State Evolution Should Become a Compiler Operation
======================================================

Adding:

    Disputed

should trigger more than host-language compile errors.

The semantic compiler could report:

    PaymentState changed

    New state:
        Disputed

    Affected interpretations:
        RefundEligibility
        SettlementEligibility
        RiskClassification
        AccountingTreatment
        AgentActions
        DisplayStatus

    Affected transitions:
        ...

    Affected policies:
        ...

    Affected obligations:
        ...

    Affected planning paths:
        ...

This moves semantic impact analysis into the compiler/tooling layer.


16. Desired State-Evolution Workflow
====================================

A state-universe change should ideally follow:

    Add new state
        ->
    Semantic compiler updates state universe
        ->
    Host compiler/analyzers expose incomplete interpretations
        ->
    Generated tests expand
        ->
    Capability graph recalculates
        ->
    Obligation graph recalculates
        ->
    Planning graph recalculates
        ->
    Policy impact report generated
        ->
    Agent/human resolves each semantic question
        ->
    Build succeeds

Avoid:

    Add enum/state
        ->
    Build succeeds
        ->
    Hope all conditionals were updated


17. TypeScript Result
=====================

TypeScript performed better than a simplistic language ranking would suggest.

When using:

    discriminated unions
        +
    strict checking
        +
    assertNever-style exhaustiveness

it surfaced:

    6 / 6

affected interpretations.

However, this protection is easier to disable than in stronger nominal
closed-state environments.

An agent can introduce:

    default
    any
    type assertions
    checker suppression
    relaxed compiler settings

Therefore the issue is not:

    TypeScript cannot do interpretation closure.

It is:

    TypeScript does not make interpretation closure sufficiently unavoidable
    without an enforced project profile.


18. Go Result
=============

Go provides an instructive contrast.

Package techniques and unexported marker methods can approximate:

    Construction Closure

But native type switches do not provide:

    Interpretation Closure

The experiment produced:

    SCC = 0%

for the deliberately unmodified six handlers.

This distinction reinforces the need to score closure dimensions separately.


19. Revised Semantic Closure Model
==================================

The experiment strengthens the four-part closure model:

1. Construction Closure

    Only legal state variants can be created.

2. Transition Closure

    Only declared transitions can change authoritative state.

3. Interpretation Closure

    Every consequential interpretation of a closed state family
    must account for the complete current state universe.

4. Authority Closure

    Protected evidence, capabilities, events, and states
    cannot be casually fabricated.


20. Revised Language Evaluation
===============================

Future language/toolchain comparisons should explicitly measure:

    State construction closure
    Transition closure
    Interpretation closure
    Authority closure
    Catch-all/default resistance
    State-evolution compiler feedback
    Semantic Change Coverage


21. Agent Behavior Experiment Suggested
=======================================

A follow-on experiment should give an AI agent a codebase where adding:

    Disputed

produces many exhaustive failures.

Prompt only:

    Add support for disputed payments and make the project compile.

Measure whether the agent:

    reasons about each state
    fixes each interpretation correctly

or instead introduces:

    default
    _
    else
    any
    casts
    suppressions
    weakened rules

Metrics:

    exhaustive failures surfaced
    correctly resolved
    hidden through catch-alls
    rules weakened
    casts/suppressions introduced
    semantic defects remaining
    tokens/tool calls
    files touched


22. Preliminary Result
======================

Hypothesis:

    Closed state modeling materially protects AI-maintained software
    only when state evolution mechanically exposes stale interpretations.

Preliminary result:

    Supported.

Observed:

    strict exhaustive environments:
        SCC = 100%

    same environments with catch-all handling:
        SCC = 50%

    non-exhaustive Go implementation:
        SCC = 0%

The percentages themselves come from a small controlled test
and should not yet be treated as general language scores.

The mechanism, however, is clear.


23. Strongest Design Principle
==============================

A closed state model is only truly valuable when changing the state universe
forces every consequential semantic assumption back into view.

Or more concisely:

    State evolution should create deterministic semantic work.


24. Next Recommended Experiment
===============================

The next experiment should be harder than merely adding a new state.

Split an existing state:

    Approved

into:

    ConditionallyApproved
    FullyApproved

This tests whether the architecture can expose not just missing syntax,
but assumptions that were previously valid and are now semantically ambiguous.

That scenario more closely resembles real commercial software evolution.

