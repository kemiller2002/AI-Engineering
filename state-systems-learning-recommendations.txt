State Systems Learning Recommendations
====================================

Purpose
-------
This reading and website list is aimed at learning state systems well enough to reason about:
- finite state machines
- statecharts
- state transitions
- guards and invariants
- domain modeling
- event-driven systems
- formal verification
- model checking
- agent-oriented software where AI proposes transitions inside a constrained state system

The broader goal is not just to learn "the State pattern," but to understand how systems can be designed so that invalid states and illegal transitions are difficult or impossible to express.


BOOKS
=====

1. Practical UML Statecharts in C/C++
   Author: Miro Samek

   Why read it:
   - Strong introduction to real state-machine modeling.
   - Covers finite state machines, hierarchical state machines, events, transitions, and implementation.
   - Useful even if you do not care about C or C++.
   - Helps bridge the gap between abstract state diagrams and executable software.

   Focus on:
   - states
   - events
   - transitions
   - guards
   - entry/exit behavior
   - hierarchical state machines
   - state explosion


2. Modeling and Verification Using UML Statecharts
   Author: Doron Drusinsky

   Why read it:
   - Moves beyond merely implementing state machines.
   - Connects statecharts to formal verification.
   - Introduces ideas around temporal behavior, runtime monitoring, and checking behavioral properties.

   Especially relevant for:
   - determining whether forbidden states are reachable
   - verifying that required transitions eventually occur
   - reasoning about system behavior over time


3. Domain-Driven Design
   Author: Eric Evans

   Why read it:
   - Not specifically a state-machine book.
   - Teaches how software models should represent the actual domain.
   - Important because a state model is only useful if its states and transitions correspond to meaningful business concepts.

   Connection to agent systems:
   The goal should not merely be:
       StateA -> StateB

   It should be:
       PaidOrder -> Refund -> RefundedOrder

   The state system should encode the meaning of the domain.


4. Domain-Specific Languages
   Author: Martin Fowler

   Why read it:
   - Useful if state transitions eventually become a specification language for agents.
   - Explores ways to build languages that express domain concepts directly.
   - Fowler uses state machines as an important DSL example.

   Long-term relevance:
   A future agent-oriented system may use a small language describing:
   - valid states
   - valid transitions
   - capabilities
   - guards
   - evidence requirements


5. Designing Event-Driven Systems
   Author: Ben Stopford

   Why read it:
   - Helps move from individual state machines to distributed/event-driven systems.
   - Useful for thinking about systems where state evolves from a history of events.
   - Particularly relevant when auditability matters.

   Agent connection:
   Instead of storing only:
       current_state = Approved

   the system could retain:
       Submitted
       -> Reviewed
       -> ApprovalRequested
       -> ApprovalReceived
       -> Approved

   This gives an agent and an auditor evidence for why the current state exists.


6. Practical TLA+
   Author: Hillel Wayne

   Why read it:
   - Probably one of the most important books for the agent-state-system idea.
   - Teaches formal specification and model checking.
   - Helps reason about all possible behaviors rather than just individual test cases.

   Important questions TLA+ encourages:
   - Can this forbidden state ever be reached?
   - Can payment happen twice?
   - Can the system deadlock?
   - Is there a path that bypasses approval?
   - Does every accepted order eventually reach a terminal state?


If reading only three books initially
-------------------------------------
Recommended sequence:

1. Practical UML Statecharts in C/C++ — Miro Samek
2. Domain-Driven Design — Eric Evans
3. Practical TLA+ — Hillel Wayne

This progression teaches:

how state machines work
    ->
how state represents domain meaning
    ->
how to mathematically reason about all possible state transitions


WEBSITES AND ONLINE RESOURCES
=============================

1. Statecharts.dev

   Best use:
   Start here.

   Why:
   - Clear conceptual explanations of state machines and statecharts.
   - Good treatment of hierarchy, events, transitions, and state explosion.
   - Helps establish the vocabulary before implementation details get in the way.

   Topics to learn:
   - state
   - event
   - transition
   - guard
   - action
   - hierarchical states
   - concurrent/orthogonal states
   - history states


2. Stately / XState Documentation

   Best use:
   Turn the concepts into executable and visual models.

   Why:
   - Excellent visual approach to state machines.
   - XState provides a practical implementation model.
   - Useful even if the eventual implementation language is F#, Haskell, Rust, or something purpose-built.

   Exercise:
   Model simple workflows visually:
   - order lifecycle
   - approval workflow
   - software deployment
   - user authentication
   - agent task execution


3. Game Programming Patterns — State Chapter
   Author: Robert Nystrom

   Best use:
   A very accessible explanation of why state machines are useful in actual software.

   Why:
   - Minimal formalism.
   - Good intuitive explanation.
   - Demonstrates why behavior becomes difficult when state is represented as scattered flags and conditionals.

   Particularly useful for understanding the transition from:

       if walking && !jumping && !ducking ...

   to an explicit state model.


4. Learn TLA+

   Best use:
   Move from state-machine implementation into formal reasoning.

   Important topics:
   - finite state machines
   - actions
   - next-state relations
   - invariants
   - nondeterminism
   - concurrency
   - temporal properties
   - model checking

   Key conceptual shift:

   Normal programming asks:
       What should the program do next?

   State-system thinking asks:
       Given this state, what are all possible next states?

   Formal specification then asks:
       Which of those states must never be reachable?


RECOMMENDED LEARNING ORDER
==========================

Stage 1 — State fundamentals
----------------------------
Use:
- Statecharts.dev
- Game Programming Patterns: State
- Practical UML Statecharts in C/C++

Learn:
- What a state actually is
- Events versus commands
- Legal transitions
- Guards
- Actions/effects
- Terminal states
- Why scattered Boolean flags create invalid combinations


Stage 2 — Statecharts
---------------------
Use:
- Statecharts.dev
- Stately / XState
- Samek

Learn:
- Hierarchical states
- Nested states
- Orthogonal/concurrent states
- History
- State explosion
- Composition

Build several state machines visually.


Stage 3 — Domain state
----------------------
Use:
- Domain-Driven Design
- Domain-Specific Languages

Learn to ask:
- What states actually exist in the domain?
- Which transitions have business meaning?
- Which states should be impossible?
- What evidence is required for a transition?

Example:

Instead of:

    Order.Status = "Paid"

prefer a model resembling:

    UnpaidOrder
        |
        | PaymentAccepted
        v
    PaidOrder


Stage 4 — Events and history
----------------------------
Use:
- Designing Event-Driven Systems

Learn:
- Events as facts
- State derived from event history
- Auditability
- Event sourcing
- Distributed state
- Eventual consistency

Think about the distinction between:
- "the current state"
and
- "the evidence explaining how the system arrived there"


Stage 5 — Formal state-transition systems
-----------------------------------------
Use:
- Practical TLA+
- Learn TLA+
- Modeling and Verification Using UML Statecharts

Learn:
- invariants
- safety properties
- liveness properties
- reachability
- deadlocks
- nondeterminism
- model checking
- temporal reasoning


CORE CONCEPTS TO MASTER
=======================

State
-----
A condition of the system that determines what behavior is currently valid.

A state should often mean more than stored data.


Event
-----
Something that has happened.

Examples:
- PaymentReceived
- ApprovalGranted
- BuildCompleted


Command
-------
A request for something to happen.

Examples:
- ChargeCustomer
- RequestApproval
- DeployBuild

Commands can fail.
Events represent facts that already occurred.


Transition
----------
A legal movement from one state to another.


Guard
-----
A condition that must be satisfied before a transition is legal.


Action / Effect
---------------
Work that happens as part of a transition or because a transition occurred.


Invariant
---------
A property that must always remain true.

Examples:
- Refund amount can never exceed captured payment.
- A deployed build must have passed tests.
- An approved request must have an approver.


Hierarchical State
------------------
A state containing substates.

Useful for controlling complexity.


Orthogonal State
----------------
Independent state dimensions that can evolve concurrently.


Reachability
------------
Whether some state can be reached through any legal sequence of transitions.


Safety Property
---------------
Something bad must never happen.

Example:
A deployment without approval must never occur.


Liveness Property
-----------------
Something good must eventually happen.

Example:
Every accepted order must eventually be fulfilled or cancelled.


AGENT-ORIENTED CONNECTION
=========================

The core hypothesis to explore is:

AI agents may become substantially more reliable when they do not directly mutate the world. Instead, they propose typed state transitions inside a system that mechanically determines which transitions are legal.

Instead of:

    Agent
      |
      +-- database()
      +-- shell()
      +-- deploy()
      +-- github()

consider:

    Current State
         |
         v
    Legal Transitions
         |
         v
    Agent selects transition
         |
         v
    Guard / invariant / capability checks
         |
         v
    Runtime executes transition
         |
         v
    Evidence generated
         |
         v
    New State


The agent proposes intent.

The state machine determines legality.

The capability system determines authority.

The executor performs the action.

The verifier determines whether the expected transition actually occurred.


THREE TYPES OF STATE WORTH EXPLORING
====================================

1. Domain State
---------------
What is currently true about the business/domain.

Example:

    Draft
      ->
    Submitted
      ->
    UnderReview
      ->
    Approved / Rejected


2. Execution State
------------------
What stage an operation or agent task is in.

Example:

    Planned
      ->
    Validated
      ->
    Authorized
      ->
    Executing
      ->
    Verified
      ->
    Completed


3. Knowledge / Epistemic State
------------------------------
What the system actually knows.

Possible model:

    Unknown
    Assumed
    Inferred
    Verified

This distinction may be particularly important for AI.

An agent should not be allowed to treat:

    "I think the tests passed"

as equivalent to:

    "The test runner produced verified evidence that the tests passed."


A POSSIBLE LONG-TERM DESIGN PRINCIPLE
=====================================

Agents should not mutate the world directly.

They should request typed state transitions.

The system should decide:
- whether the transition exists
- whether its prerequisites are satisfied
- whether the agent possesses the required capability
- whether required evidence exists
- whether invariants remain true

This turns the programming language/runtime into part of the agent-governance system.


LANGUAGE CONNECTION
===================

F#, Haskell, Rust, and related strongly typed languages are interesting because their type systems can encode portions of the state model.

Example:

    DraftOrder
        ->
    SubmittedOrder
        ->
    PaidOrder
        ->
    FulfilledOrder

instead of:

    Order {
        status: string
    }

The first representation greatly reduces the number of meaningless states the agent can create.

F# is particularly interesting as an experimental language because it provides:
- discriminated unions
- exhaustive pattern matching
- immutable values by default
- Option
- Result
- private constructors
- strong type inference
- units of measure
- functional composition
- access to the .NET ecosystem

Haskell pushes further toward purity and explicit effects.

However, the larger idea is not simply "use Haskell" or "use F#."

The larger idea is:

    Make legal system behavior structurally explicit,
    and use deterministic machinery to reject invalid agent behavior.


PRACTICAL STUDY EXERCISES
=========================

Exercise 1: Order Lifecycle
---------------------------
Model:

    Draft
    Submitted
    Paid
    Shipped
    Delivered
    Cancelled
    Refunded

Identify:
- legal transitions
- illegal transitions
- guards
- terminal states
- invariants


Exercise 2: Deployment Workflow
-------------------------------
Model:

    CodeChanged
    Built
    Tested
    Reviewed
    Approved
    Deployable
    Deployed

Try to construct a path where unapproved code gets deployed.

Then change the model so no such path exists.


Exercise 3: Agent Knowledge
---------------------------
Model information as:

    Unknown
    Assumed
    Inferred
    Verified

Create operations that explicitly require Verified information.

Example:

    deploy :
        VerifiedBuild ->
        VerifiedTests ->
        VerifiedApproval ->
        Deployment


Exercise 4: Model Checking
--------------------------
Once comfortable with TLA+, model the deployment workflow.

Ask the model checker:

    Is there any possible execution where
    Deployed = TRUE
    and
    Approved = FALSE?

That is the bridge from ordinary software architecture into formally constrained agent behavior.


SUMMARY PATH
============

Fastest useful path:

1. Statecharts.dev
2. Game Programming Patterns — State
3. Stately / XState
4. Practical UML Statecharts in C/C++
5. Domain-Driven Design
6. Learn TLA+
7. Practical TLA+
8. Modeling and Verification Using UML Statecharts
9. Designing Event-Driven Systems
10. Domain-Specific Languages


The important conceptual progression is:

state
  ->
transitions
  ->
statecharts
  ->
domain meaning
  ->
events
  ->
invariants
  ->
formal state-transition systems
  ->
model checking
  ->
agent-constrained execution
