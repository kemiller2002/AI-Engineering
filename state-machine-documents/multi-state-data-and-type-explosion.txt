Multi-State Data and Type Explosion in State-Constrained Architecture
======================================================================

Problem
-------

A major challenge in state-constrained software is how to represent objects that have multiple independent or partially independent state dimensions.

A simple lifecycle is easy to model with types:

    DraftOrder
    SubmittedOrder
    PaidOrder
    ShippedOrder

But real commercial objects often have several state dimensions at once.

Example:

    Lifecycle:
        Draft
        Active
        Closed

    Review:
        Unreviewed
        Approved
        Rejected

    Payment:
        Unpaid
        Paid
        Refunded

If every possible combination becomes its own type, the number of types grows as the Cartesian product:

    3 × 3 × 3 = 27 possible combinations

Add more state dimensions and the model quickly becomes impractical.

This creates a central design question:

    How do we preserve machine-enforced state constraints without creating an enormous number of types?


Naive Approach: One Type Per Full Combination
---------------------------------------------

A naive design might create:

    DraftUnreviewedUnpaidOrder
    DraftApprovedUnpaidOrder
    DraftApprovedPaidOrder
    ActiveApprovedPaidOrder
    ActiveApprovedRefundedOrder
    ClosedApprovedRefundedOrder
    ...

This is not commercially practical.

Problems include:

- combinatorial type explosion
- difficult naming
- difficult migrations
- excessive boilerplate
- hard-to-understand APIs
- difficult agent reasoning
- brittle refactoring
- repeated data structures
- difficulty adding a new independent state dimension


Orthogonal State Dimensions
---------------------------

A better approach is to represent independent state dimensions independently.

In F#:

    type Lifecycle =
        | Draft
        | Active
        | Closed

    type ReviewState =
        | Unreviewed
        | Approved of Approval
        | Rejected of Rejection

    type PaymentState =
        | Unpaid
        | Paid of Payment
        | Refunded of Refund

    type Order = {
        Lifecycle : Lifecycle
        Review : ReviewState
        Payment : PaymentState
    }

This avoids creating all combinations manually.

This idea corresponds closely to "orthogonal regions" in statecharts.

Instead of one enormous state machine:

    ActiveApprovedPaid
    ActiveApprovedUnpaid
    ActiveRejectedPaid
    ...

we model separate state machines:

    Lifecycle:
        Draft -> Active -> Closed

    Review:
        Unreviewed -> Approved
                   -> Rejected

    Payment:
        Unpaid -> Paid -> Refunded

The object is therefore the composition of several state dimensions.


The Tradeoff
------------

Orthogonal state dimensions reduce type explosion, but they reintroduce another problem:

Some combinations may be representable even though they are invalid.

For example:

    Lifecycle = Draft
    Review = Approved
    Payment = Refunded

may be structurally constructible even if the domain says it should never happen.

Therefore the central design problem becomes:

    Which relationships should be enforced at the type level,
    and which should be enforced through guards and invariants?


Likely Split: Primary State vs Secondary State
----------------------------------------------

A promising strategy is to encode only major behavioral state into distinct types.

Example:

    DraftOrder
    ActiveOrder
    ClosedOrder

Then keep secondary or orthogonal states as values inside those types.

For example:

    type ActiveOrder = {
        Review : ReviewState
        Payment : PaymentState
    }

This creates a hierarchy of enforcement.

    Major behavioral state
        -> type-level enforcement

    Orthogonal secondary state
        -> discriminated union / state value

    Relationships among dimensions
        -> guards and invariants

This avoids a combinatorial explosion while still allowing the compiler to enforce the most important lifecycle boundaries.


How to Decide What Becomes a Type
---------------------------------

A state dimension is a strong candidate for type-level encoding when it substantially changes:

- which operations are legal
- which data must exist
- which capabilities can be issued
- which invariants apply
- which transitions are possible
- which external effects are permitted

For example:

    DraftOrder

and:

    PaidOrder

may deserve separate types because payment fundamentally changes what can happen next.

By contrast, a secondary review status may be better represented as a discriminated union if it does not justify a new structural object type.


Cross-State Invariants
----------------------

Relationships between independent state dimensions should be expressed as explicit invariants.

Examples:

    Refunded implies a successful payment previously occurred.

    Approved implies review completed.

    Closed implies no new payment transitions may begin.

    Shippable implies:
        Lifecycle = Active
        AND Review = Approved
        AND Payment = Paid

These invariants should not live only in comments.

Possible enforcement mechanisms include:

- type constraints
- transition guards
- domain validation
- property-based testing
- model checking
- generated state specifications


Derived State
-------------

Another major source of unnecessary state explosion is storing values that should actually be derived.

Example:

    IsReadyToShip =
        Lifecycle = Active
        AND
        Review = Approved
        AND
        Payment = Paid

If "ready to ship" has no independent lifecycle, it should probably not be represented as another authoritative state.

Do not automatically create:

    ReadyToShipState

Instead derive it from authoritative state.

This reduces:

- duplicated state
- synchronization errors
- invalid combinations
- type count
- agent ambiguity

A useful principle is:

    If a state can be deterministically calculated from authoritative state
    and does not have an independent lifecycle,
    prefer deriving it rather than storing it.


Four Useful Categories of State
-------------------------------

A useful working taxonomy is:

1. Primary State

   The major lifecycle state.

   Often appropriate for type-level encoding.

   Examples:

       DraftOrder
       ActiveOrder
       ClosedOrder


2. Orthogonal State

   An independent state dimension.

   Usually represented as a discriminated union or equivalent value.

   Examples:

       ReviewState
       PaymentState
       VerificationState


3. Derived State

   Computed from authoritative state.

   Usually should not be persisted independently.

   Examples:

       IsReadyToShip
       CanSubmit
       NeedsReview


4. Ephemeral Execution State

   Temporary state of an operation or external effect.

   Examples:

       Requested
       InProgress
       Succeeded
       Failed
       OutcomeUnknown


Capabilities as an Alternative to More Types
--------------------------------------------

A particularly promising technique is to avoid representing every legal combination as a type.

Instead, derive capabilities from the current combination of state dimensions.

For example:

    Order
      +
    Lifecycle
      +
    ReviewState
      +
    PaymentState
        |
        v
    capability evaluation
        |
        +-> CanApprove
        +-> CanRefund
        +-> CanShip

Then an operation could require a capability:

    ship :
        CanShip ->
        Order ->
        Shipment ->
        Result<Order, ShipError>

The system only creates `CanShip` when all relevant conditions are satisfied.

For example:

    CanShip exists only when:

        Lifecycle = Active
        Review = Approved
        Payment = Paid

This avoids needing a type named:

    ActiveApprovedPaidOrder

while still preventing arbitrary shipping.


Why Capability Derivation Is Important
--------------------------------------

Capability-based legality may solve one of the biggest scalability problems in state-constrained design.

Instead of encoding every valid combination into a distinct type:

    state combination -> new type

we can use:

    stable structural state -> type

    independent dimensions -> state values

    currently legal operation -> derived capability

This creates a potentially scalable rule:

    Types represent stable structural states.

    Orthogonal unions represent independent state dimensions.

    Invariants coordinate dimensions.

    Capabilities represent temporarily legal operations derived from current state.


Example
-------

Suppose an order has:

    Lifecycle = Active
    Review = Approved
    Payment = Paid

The runtime evaluates:

    deriveCapabilities(order)

and produces:

    CanShip
    CanRefund

but not:

    CanApprove
    CanPay

The agent does not need to reason from scratch about which actions are legal.

The runtime can expose only:

    Ship
    Refund

because those are the capabilities currently available.

This also connects directly to agent tool exposure.

Instead of giving an AI agent every operation:

    Submit
    Approve
    Reject
    Pay
    Refund
    Ship
    Cancel
    Reopen

the runtime could expose only the operations supported by currently derived capabilities.

This reduces both:

- the state-type explosion problem
- the agent-action search-space problem


Possible Combined Architecture
------------------------------

A scalable object model may therefore look like:

    Primary structural type
            |
            v
    Orthogonal state dimensions
            |
            v
    Cross-state invariants
            |
            v
    Derived capabilities
            |
            v
    Legal transitions
            |
            v
    Effects / events
            |
            v
    New state

Example:

    ActiveOrder
        |
        +-- Review = Approved
        +-- Payment = Paid
        +-- Fulfillment = Waiting
        |
        v
    deriveCapabilities
        |
        +-- CanShip
        +-- CanRefund
        |
        v
    Agent requests Ship
        |
        v
    runtime verifies CanShip
        |
        v
    Shipment effect
        |
        v
    ShipmentSucceeded event
        |
        v
    updated order state


Research Questions
------------------

This area needs explicit exploration.

Key questions include:

1. Which state dimensions deserve distinct types?

2. Which should remain discriminated unions or equivalent state values?

3. How many primary type-level states can a commercial system tolerate before complexity outweighs the benefit?

4. When should cross-state legality be represented by:
   - types
   - guards
   - invariants
   - capabilities
   - property tests
   - model checking

5. Can capabilities reliably replace combinatorial state types?

6. How should capabilities be created and revoked?

7. Should capabilities be ephemeral values?

8. Can capabilities be serialized, or should they exist only inside trusted runtime boundaries?

9. How should multiple orthogonal state machines communicate?

10. How should statecharts and hierarchical states map into typed code?

11. How should agents discover currently legal capabilities?

12. Should the runtime dynamically expose agent tools based on derived capabilities?

13. How should invalid combinations be detected in persisted or imported data?

14. How should state migrations work when new dimensions are introduced?

15. How do we avoid turning cross-state invariant logic into another hidden, centralized rules engine?

16. When should a derived value become a real state because it develops an independent lifecycle?

17. Can a DSL generate:
    - orthogonal state types
    - cross-state invariants
    - capability derivation
    - transition APIs
    - agent tools
    - property tests

18. What patterns work best in:
    - F#
    - C#
    - TypeScript
    - Python
    - Rust
    - Haskell

19. Does capability derivation reduce agent context requirements?

20. Does capability-based action exposure reduce agent mistakes?


Working Design Principle
------------------------

A useful preliminary principle is:

    Do not create one type for every possible combination of state.

Instead:

    Use types for stable, behavior-changing structural states.

    Use orthogonal state values for independent dimensions.

    Use derived state when a value can be computed.

    Use guards and invariants to coordinate dimensions.

    Use capabilities to represent operations that are currently legal.

This may provide the balance between:

    strong machine-enforced semantics

and:

    commercially manageable type complexity.


Potential Importance
--------------------

This is not merely an implementation detail.

If state-constrained architecture is going to work in real commercial systems, it must solve the multi-state problem without producing:

- hundreds of types
- unreadable APIs
- migration nightmares
- excessive ceremony
- developer resistance

The capability approach may be particularly important because it shifts the model from:

    represent every valid state combination

to:

    represent stable state,
    then derive what actions are legal now.

That is likely much more scalable.

It also aligns naturally with autonomous agents:

    The agent does not need to understand every theoretically possible state combination.

    It needs to understand the current state and the legal transitions available from it.

That may be one of the central architectural ideas required to make state-constrained software practical for AI-native development.
