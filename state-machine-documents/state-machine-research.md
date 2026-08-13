State-Constrained Architecture for AI-Native Software

Core Thesis

Most commercial software was designed for human developers working inside systems that tolerate ambiguity.

Developers are expected to understand unwritten conventions, infer business rules from surrounding code, remember which states are valid, know which transitions are legal, and exercise judgment when the software itself does not enforce those constraints.

That model works imperfectly for humans.

It may work much worse for autonomous AI agents.

AI agents are probabilistic systems. They generate plausible interpretations and plausible code. When they operate inside loosely constrained software, they must repeatedly infer the hidden semantic model of the system.

The problem is therefore not simply that AI agents sometimes generate incorrect code.

The deeper problem is that traditional software gives incorrect assumptions too many places to survive.

A different architectural approach is needed:

AI agents should operate inside explicitly modeled state systems where legal behavior, transitions, evidence requirements, and capabilities are mechanically constrained.

The AI proposes intent.

The surrounding system determines whether that intent is legal.

⸻

1. Why Existing Commercial Software Is Expensive for Agents

A conventional commercial codebase frequently represents domain concepts loosely.

For example:

order.Status = OrderStatus.Paid;

This is easy for a human developer to write.

But the code itself may not answer:

* Was the order previously submitted?
* Was payment actually captured?
* Can an order be paid twice?
* Who authorized the payment?
* What evidence proves payment occurred?
* Is payment allowed in the current state?
* Does changing this field trigger any required effects?
* Can this state subsequently be cancelled?
* What transitions are valid from here?

The answers often exist elsewhere:

* tests
* documentation
* database constraints
* comments
* business logic
* tribal knowledge
* API behavior
* code-review conventions

An AI agent therefore has to reconstruct the actual domain model from scattered evidence.

That costs:

* context tokens
* repository searches
* tool calls
* test runs
* repair cycles
* human review
* execution time

The apparent problem may look like model inefficiency.

The underlying problem is frequently semantic ambiguity in the software environment.

⸻

2. The Historical Tradeoff

Commercial software has traditionally optimized for developer throughput.

Instead of writing:

type DraftOrder = ...
type SubmittedOrder = ...
type PaidOrder = ...
type ShippedOrder = ...

with transitions such as:

submit : DraftOrder -> SubmittedOrder
pay :
    SubmittedOrder ->
    Payment ->
    Result<PaidOrder, PaymentError>
ship :
    PaidOrder ->
    Shipment ->
    ShippedOrder

developers frequently use:

order.Status = OrderStatus.Paid;

The second approach is faster to write.

Historically, the additional correctness provided by richer state modeling often did not justify the perceived ceremony.

The bargain was approximately:

Keep the model flexible and rely on developers, testing, reviews, documentation, and discipline to maintain correctness.

AI changes the economics.

For humans:

more explicit types
        ↓
more code
        ↓
more friction

For agents:

more explicit types
        ↓
more constraints
        ↓
smaller search space
        ↓
more deterministic feedback
        ↓
less ambiguity

AI also removes much of the historical cost of boilerplate because agents can generate repetitive type definitions, transition functions, validation structures, and tests cheaply.

This creates an important inversion:

Techniques previously considered too verbose for human development may become economically attractive for machine-generated software.

⸻

3. The Central Role of State

The architecture should be designed around state systems.

A state system answers:

1. What states are valid?
2. What transitions are possible?
3. Under what conditions is each transition legal?
4. What evidence is required?
5. Who or what is allowed to request the transition?
6. What effects occur because of the transition?
7. What invariants must remain true afterward?

Instead of:

Requirements
    ↓
Classes
    ↓
Methods
    ↓
Mutable data
    ↓
Tests try to catch mistakes

use:

Domain
    ↓
States
    ↓
Legal transitions
    ↓
Guards and invariants
    ↓
Capabilities
    ↓
Effects
    ↓
Implementation

The state model becomes part of the specification.

⸻

4. State and Types Are Related but Different

A state is something that is true about the system.

A type describes which values can legally exist and what operations are available for them.

A simple state representation might be:

type OrderState =
    | Draft
    | Submitted
    | Paid
    | Shipped

Here:

Draft
Paid
Shipped

are values.

Their type is:

OrderState

This is already stronger than:

let status : string = “paid”

because invalid values cannot be constructed accidentally.

But the type system can go further.

⸻

5. Encoding State Into Types

Instead of one type containing a state field, important states can become different types:

type DraftOrder = private {
    Items : Item list
}
type SubmittedOrder = private {
    Items : Item list
    SubmittedAt : DateTime
}
type PaidOrder = private {
    Items : Item list
    SubmittedAt : DateTime
    PaymentId : PaymentId
}

Transitions then become functions between types:

submit :
    DraftOrder ->
    SubmittedOrder
pay :
    SubmittedOrder ->
    Payment ->
    Result<PaidOrder, PaymentError>
ship :
    PaidOrder ->
    Shipment ->
    ShippedOrder

Now:

DraftOrder
    ↓ submit
SubmittedOrder
    ↓ pay
PaidOrder
    ↓ ship
ShippedOrder

is both a state machine and a type-level encoding.

The compiler can reject:

ship SubmittedOrder

because ship requires PaidOrder.

The agent does not have to remember the rule.

The program structure enforces it.

⸻

6. Three Levels of State Modeling

Level 1 — State as Unconstrained Data

type Order = {
    Status : string
}

Possible invalid values include:

“banana”
“paidd”
“whatever”

Correctness depends heavily on convention.

⸻

Level 2 — State as a Closed Set

type OrderState =
    | Draft
    | Submitted
    | Paid
    | Shipped

Now impossible state names cannot be represented.

⸻

Level 3 — State Encoded Into the Type System

DraftOrder
SubmittedOrder
PaidOrder
ShippedOrder

Now operations can state exactly which state they accept.

This begins to make illegal transitions unrepresentable.

⸻

7. The Fundamental Agent Architecture

Current agent architectures often look like:

Agent
  |
  +— shell
  +— database
  +— GitHub
  +— deploy
  +— email

The agent receives broad capabilities and a prompt telling it to behave correctly.

That is fundamentally permissive.

A state-constrained architecture looks different:

Current State
      ↓
Legal Transitions
      ↓
Agent selects or proposes one
      ↓
Guards
      ↓
Evidence requirements
      ↓
Capability check
      ↓
Executor performs action
      ↓
Verification
      ↓
New State

The agent no longer directly mutates the world.

It requests a transition.

This leads to a foundational rule:

Agents should not mutate important state directly. They should request typed state transitions.

⸻

8. Separation of Responsibilities

A reliable autonomous architecture should separate these roles.

AI Agent

Determines what it believes should happen.

It proposes intent.

State Machine

Determines whether the requested transition exists and is legal from the current state.

Guard / Invariant Engine

Determines whether required conditions hold.

Capability System

Determines whether the requesting actor has authority.

Executor

Performs the actual effect.

Verifier

Determines whether the intended effect occurred.

Evidence System

Records the basis for the resulting state.

The AI should not simultaneously be:

* proposer
* judge
* executor
* verifier
* source of truth

That creates circular trust.

⸻

9. Three Important Kinds of State

Domain State

What is true in the business domain.

Example:

Draft
→ Submitted
→ UnderReview
→ Approved
          ↘ Rejected

⸻

Execution State

What stage an operation or agent task occupies.

Example:

Planned
→ Validated
→ Authorized
→ Executing
→ Verified
→ Completed

A system could make:

Planned → Completed

illegal.

⸻

Knowledge or Epistemic State

What the system actually knows.

This may be especially important for AI.

Possible states:

Unknown
Assumed
Inferred
Verified

An assumption should not silently become a fact merely because it survived in the system.

A richer representation might be:

type Knowledge<‘a> =
    | Unknown
    | Assumed of value:’a * rationale:Rationale
    | Inferred of value:’a * evidence:Evidence list
    | Verified of value:’a * evidence:Evidence list

Operations can then require different levels of evidence.

For example:

Display suggestion
    accepts Assumed<X>
Forecast
    requires Inferred<X>
Execute payment
    requires Verified<X>

⸻

10. Assumption Drift

One of the most serious long-term risks in agent-generated software is cumulative assumption drift.

The sequence can look like:

Original requirement
      ↓
Agent makes assumption A
      ↓
A survives compilation and tests
      ↓
A becomes code
      ↓
Agent #2 reads the code
      ↓
Agent #2 interprets A as intended architecture
      ↓
Agent #2 creates assumption B based on A
      ↓
Agent #3 builds on A + B
      ↓
Emergent architecture

No individual change necessarily appears obviously wrong.

Each agent may behave locally rationally.

The problem is cumulative semantic drift.

This already occurs with human-built legacy systems.

Agents accelerate it because they can generate and propagate internally consistent changes much faster.

⸻

11. Why Agent Productivity Can Increase Architectural Entropy

Human development contains natural friction:

* meetings
* code review
* limited coding throughput
* disagreements
* institutional memory
* developers asking why something works a certain way

Those mechanisms are imperfect, but they slow propagation.

Agents remove much of that friction.

An agent can generate hundreds of coherent changes from one incorrect premise.

Therefore:

AI does not merely increase the rate of code generation. It can increase the rate at which assumptions become institutionalized.

Higher development velocity can therefore produce lower system trustworthiness unless constraints increase at the same time.

⸻

12. Types Interrupt the Assumption Chain

Suppose a domain says:

type Application =
    | Submitted of SubmittedApplication
    | UnderReview of ReviewedApplication
    | Approved of ApprovedApplication
    | Rejected of RejectedApplication

and approval requires:

approve :
    ReviewedApplication ->
    VerifiedApproval ->
    ApprovedApplication

An agent may believe that a submitted application can immediately become approved.

But there is no legal transition:

SubmittedApplication
        ↓
ApprovedApplication

The incorrect assumption has nowhere to go unless the agent deliberately changes the domain model itself.

That is a much stronger failure boundary.

Instead of relying on the agent to understand the architecture:

The architecture refuses to absorb certain misunderstandings.

⸻

13. Types Alone Are Not Enough

An agent could potentially satisfy a type constraint by manufacturing the required value.

For example:

VerifiedApproval(...)

Therefore important state types should often use private constructors or capability-based creation.

The only path to:

VerifiedApproval

might be:

Approval Service
      ↓
Authenticated human action
      ↓
Evidence recorded
      ↓
VerifiedApproval

Now the chain becomes:

Evidence
    ↓
Verification
    ↓
Typed capability
    ↓
Legal transition
    ↓
New state

The AI operates inside this chain instead of bypassing it.

⸻

14. Provenance Must Be First-Class

Important state should not merely store its current value.

It should retain why the system believes it.

For example:

CustomerEligible
Knowledge State:
Inferred
Derived From:
Rule R17
Evidence E92
Evidence E107
Created By:
Agent A41
Confidence:
0.82
Valid As Of:
2026-08-13
Reassessment Trigger:
Eligibility rules change

Future agents then encounter more than:

eligible = true

They encounter the epistemic history of the state.

This dramatically improves machine reasoning.

⸻

15. Time Does Not Increase Authority

A critical principle follows:

Time and repetition do not increase epistemic authority. Evidence does.

An assumption should remain an assumption until evidence changes its classification.

This prevents:

Assumed
    ↓
Repeated
    ↓
Copied
    ↓
Treated as fact

The system should require explicit transitions such as:

Assumed
    ↓ evidence added
Inferred
    ↓ verification
Verified

⸻

16. State, Provenance, and Evidence Together

The complete model therefore has at least five important dimensions:

STATE
What is true?
TRANSITIONS
What may legally change?
CAPABILITIES
Who may request the change?
PROVENANCE
Why is the current state believed?
EPISTEMIC STATE
How strongly is it known?

These interact:

             Evidence
                │
                ▼
          Knowledge State
                │
                ▼
Current State ───────→ Legal Transitions
                           │
                    Capability Check
                           │
                           ▼
                    Agent Proposal
                           │
                           ▼
                       Executor
                           │
                           ▼
                      Verification
                           │
                           ▼
                      New Evidence
                           │
                           ▼
                       New State

⸻

17. Clarity as a State System

Clarity is naturally compatible with this architecture.

A decision can move through states such as:

SignalDetected
    ↓
DecisionDefined
    ↓
PostureAssigned
    ↓
EvidenceEvaluated
    ↓
ReadyToCommit
    ↓
Committed
    ↓
Executing
    ↓
OutcomeObserved
    ↓
LearningCaptured

With additional transitions such as:

Committed
    ↓
ReassessmentRequired

or:

Validated
    ↓
New Contradictory Evidence
    ↓
Reopened

⸻

18. Decision Posture as Transition Policy

Decision posture should not merely be a label.

It should alter transition requirements.

For example:

FAST
Defined
→ Postured
→ Committed
→ Acting

A strategic decision may require:

STRATEGIC
Defined
→ Postured
→ EvidenceThresholdMet
→ OwnerConfirmed
→ FailureConditionsDefined
→ ReassessmentTriggersDefined
→ ReadyToCommit
→ Committed

This turns Clarity from advisory guidance into executable governance.

⸻

19. Clarity as a Platform

The Clarity platform can be built around a state engine.

Core components:

State Engine

Tracks current decision state and legal next transitions.

Decision Record

Stores:

* posture
* owner
* evidence
* assumptions
* rationale
* commitments
* failure conditions
* reassessment triggers
* outcomes

Transition Log

Records every significant state change.

Guard Engine

Determines whether transition prerequisites are satisfied.

UI

Shows:

* current decision state
* missing prerequisites
* unresolved evidence
* permitted next transitions
* transition history
* reason for blocked transitions

⸻

20. Transition-Oriented APIs

The API should not allow arbitrary state mutation.

Avoid:

PATCH /decision/123
{
  “status”: “committed”
}

Prefer:

POST /decisions/123/transitions/commit

The engine determines whether the transition is legal.

This lets humans, AI agents, integrations, and automation all interact through the same model.

Human ─────┐
Agent ─────┼──→ Transition Request
API ───────┤
Automation ┘
                 ↓
          Clarity State Engine
                 ↓
        Guards + Evidence + Authority
                 ↓
             Accept / Reject

The durable asset becomes the decision-state model rather than merely the UI.

⸻

21. HelixNote as a State System

HelixNote fits the architecture particularly well because medical information contains uncertainty, provenance, temporal change, and conflicting evidence.

HelixNote should not merely store static medical facts.

It should track the state of:

* symptoms
* observations
* labs
* diagnostic hypotheses
* diagnoses
* medications
* treatments
* clinical questions
* medical claims

⸻

22. Clinical Knowledge State

A medical hypothesis should not simply be:

Sjogren’s = negative

It might instead have a lifecycle:

Suspected
→ Tested
→ EvidenceConflict
→ NotEstablished

Evidence can accompany each transition.

This preserves ambiguity instead of flattening it.

⸻

23. Separate Evidence From Interpretation

A lab result such as:

Cortisol: 8.2

is evidence.

A statement such as:

Possible adrenal insufficiency

is an interpretation.

They should not be represented as the same kind of object.

Likewise:

Patient reports symptom

is different from:

Clinician observes symptom

which is different from:

Test supports condition

which is different from:

Clinician diagnoses condition

which is different from:

AI infers condition

The architecture should preserve those distinctions.

⸻

24. Clinical State Examples

Symptom

Reported
→ Observed
→ Persistent
→ Improving
→ Resolved
→ Recurred

Medication

Proposed
→ Prescribed
→ Started
→ DoseChanged
→ Effective
→ Ineffective
→ AdverseEffect
→ Discontinued

Lab

Ordered
→ Collected
→ Resulted
→ Reviewed
→ Interpreted

Diagnostic Hypothesis

Unknown
→ Suspected
→ Supported
→ Conflicted
→ Established
or
→ Refuted

⸻

25. AI Should Propose Clinical Transitions

The AI should not directly rewrite medical truth.

Instead:

AI interprets evidence
        ↓
AI proposes state transition
        ↓
Clinical rules + provenance + evidence requirements
        ↓
Accepted or rejected

For example:

Requested:
Suspected → Established
Rejected:
No clinician diagnosis
Conflicting evidence remains
Required diagnostic criteria incomplete

Or:

Suggested:
Suspected → Supported
Basis:
Three supporting observations
One contradictory lab
No documented clinician diagnosis

That creates a safer clinical reasoning system.

⸻

26. Temporal State Matters

Medicine is inherently longitudinal.

Instead of:

fatigue = true

HelixNote should preserve change:

Severe
→ Persistent
→ Improved
→ Recurred

along with timestamps and evidence.

Similarly:

Medication dose increased
        ↓
Symptom improvement observed four days later

The system can record temporal association without converting it automatically into:

Medication caused improvement

That remains an inference until supported.

⸻

27. Shared Architecture Across Products

Clarity and HelixNote appear different on the surface.

But underneath:

Clarity tracks the state of decisions.

HelixNote tracks the state of medical knowledge.

Both need to preserve:

* what is currently believed
* what is unresolved
* what evidence exists
* what changed
* why it changed
* who changed it
* what transitions are legal next
* what events should cause reassessment

This suggests a common architectural substrate.

⸻

28. An Agent-Native Runtime

The broader architecture may eventually look like:

                 DOMAIN MODEL
                      │
                      ▼
                STATE SYSTEM
                      │
        ┌─────────────┼─────────────┐
        ▼             ▼             ▼
     Guards       Evidence      Capabilities
        │             │             │
        └─────────────┼─────────────┘
                      ▼
              Legal Transitions
                      │
                      ▼
                   Agent
              proposes transition
                      │
                      ▼
                  Executor
                      │
                      ▼
                 Verifier
                      │
                      ▼
                   Event
                      │
                      ▼
              New State + Evidence

This could become the foundation for multiple products rather than a pattern implemented independently each time.

⸻

29. Design Principle for New Systems

For new software, particularly software expected to use autonomous agents, begin with:

1. What are the meaningful domain states?
2. Which transitions between them are legal?
3. What guards control those transitions?
4. What invariants must always remain true?
5. What evidence establishes the current state?
6. What level of knowledge certainty is required?
7. What capability is required to request each transition?
8. What executor is allowed to cause the real-world effect?
9. How is the result independently verified?
10. What evidence or event should trigger reassessment?

Only after those questions are answered should implementation structure become the focus.

⸻

30. What This Changes About AI Development

The goal is not:

Make the model intelligent enough that it never makes a mistake.

That is probably unrealistic.

The goal is:

Construct an environment in which mistakes have fewer places to survive.

The AI becomes a powerful search and reasoning mechanism.

Deterministic systems become the constraints and judges.

AI
= proposes
Types
= constrain representation
State system
= constrains behavior
Capabilities
= constrain authority
Compiler
= rejects structural violations
Formal model
= rejects invalid state paths
Tests
= validate examples and behavior
Verifier
= confirms real-world outcomes
Evidence
= preserves why the state is believed

That is a much more robust division of labor.

⸻

31. Central Principle

The central architectural idea can be stated simply:

Do not ask probabilistic agents to preserve correctness through discipline when deterministic systems can make correctness structural.

And the corresponding implementation principle is:

Agents propose typed transitions over explicitly modeled state. They do not arbitrarily mutate the system.

That may provide a foundation not only for agent-safe code generation, but for decision systems, medical knowledge systems, workflow engines, autonomous research, governance, and any other domain where assumptions can compound over time.