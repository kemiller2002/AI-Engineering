Research Outline: State-Constrained Architecture for AI-Native Software

Purpose

This document maps the major areas to explore around the hypothesis that AI agents should operate inside explicitly modeled state systems rather than directly mutating loosely constrained software.

> **Core hypothesis:** Probabilistic agents become safer, cheaper, and more reliable when consequential behavior is expressed through explicit state, typed transitions, evidence, provenance, capabilities, guards, and invariants that can be checked independently of the agent.

> **Broader question:** How should software architecture change when primary implementers and operators may increasingly be probabilistic AI agents rather than humans?

────────

1. Foundational Theory

1.1 Define the Core Problem

Explore:

• Why existing commercial software is difficult for agents to reason about.
• How implicit business semantics create agent cost.
• How assumptions become embedded in code.
• How later agents inherit prior assumptions as apparent truth.
• How semantic drift differs from ordinary technical debt.
• Whether agent productivity can increase architectural entropy.
• Whether explicit constraints reduce cumulative semantic drift.

Questions:

• What exactly is the failure mode we are trying to prevent?
• Is the primary problem incorrect generation, incorrect interpretation, or assumption accumulation?
• How much of current agent cost comes from reconstructing implicit semantics?
• How does agent reasoning differ from human maintenance of legacy systems?

1.2 Define State Precisely

Explore:

• State as authoritative system representation.
• State versus ordinary data.
• State versus derived values.
• State versus truth about the external world.
• Observable versus hidden state.
• Persistent versus transient state.
• Local versus distributed state.

Candidate rule:

> A value is meaningful state when its current value changes what behavior is legally possible next.

1.3 Define Transition Precisely

Explore:

• State mutation versus explicit transition.
• Transition as the only legal mechanism for changing authoritative state.
• Inputs and outputs.
• Transition failure.
• Atomicity.
• Idempotency.
• Reversible, compensatable, and irreversible transitions.
• Transition versioning.

Core principle:

> **Authoritative state should not be set directly. It should be transitioned.**

1.4 Define Guards

Explore:

• Preconditions.
• Pure guard evaluation.
• Guard composition.
• Guard failure reasons.
• Dynamic and temporal guards.
• Evidence-dependent guards.
• Capability-dependent guards.

Questions:

• Which checks belong in guards versus types?
• Which guards can be static?
• Which must remain runtime checks?

1.5 Define Invariants

Explore:

• Local and global invariants.
• Cross-aggregate invariants.
• Temporal invariants.
• Safety and liveness properties.
• Structural and business invariants.

Questions:

• Which invariants belong in types?
• Which require property testing?
• Which require model checking?
• Which require external verification?

────────

2. Canonical Primitives

Determine whether the following are sufficient as the smallest useful model.

1. State — what the system currently represents as true.
2. Transition — a legal state change.
3. Guard — a condition controlling whether a transition may occur.
4. Invariant — a property that must remain true.
5. Claim — a proposition the system may reason about.
6. Evidence — information supporting, contradicting, or invalidating a claim.
7. Capability — authority to request, authorize, or perform a transition.
8. Effect — an interaction with the external world.
9. Event — an immutable record that something happened.

Cross-cutting concepts:

• Actor.
• Provenance.

Questions:

• Are any of these redundant?
• Are any primitives missing?
• Which concepts should instead be compositions of others?

────────

3. Cross-Cutting Concepts

3.1 Actors

Explore:

• Humans.
• AI agents.
• Services.
• Organizations.
• External systems.
• Identity versus authority.
• Delegation.
• Temporary authority.
• Revocation.

Principle:

> **Actor identity should not imply capability.**

3.2 Provenance

Explore:

• Source.
• Actor.
• Timestamp.
• Evidence.
• Derivation.
• Version.
• Rationale.
• Confidence.
• Validity period.
• Reassessment triggers.

Questions:

• What provenance must always be retained?
• What can be compressed?
• How should provenance survive migrations?
• How should agents query provenance?

────────

4. Multiple Kinds of State

4.1 Domain State

Examples:

```text
Draft
Submitted
UnderReview
Approved
Funded
```

Explore:

• Domain lifecycle.
• Aggregate state.
• Terminal states.
• Reopened states.
• Composite state.

4.2 Epistemic State

Possible states:

```text
Unknown
Reported
Assumed
Inferred
Verified
Contradicted
Invalidated
```

Explore:

• What does the system know?
• How strongly does it know it?
• Who established that knowledge?
• What evidence supports it?
• What invalidates it?
• Can knowledge degrade?
• Can verification expire?

Principle:

> **Time and repetition do not increase epistemic authority. Evidence does.**

4.3 Execution State

Possible states:

```text
Planned
Requested
InProgress
Succeeded
Failed
OutcomeUnknown
```

Explore:

• Retries.
• Idempotency.
• Uncertain outcomes.
• Partial failure.
• Timeouts.
• Compensation.
• Reconciliation.

Principle:

> **Unknown outcome must not be collapsed into failure.**

────────

5. Claims and Evidence

5.1 Claim Model

Explore:

• Identity and scope.
• Ownership.
• Versioning.
• Dependencies.
• Validity period.
• Contradiction.
• Supersession.

5.2 Evidence Model

Explore:

• Supporting evidence.
• Contradictory evidence.
• Invalidated evidence.
• Expired evidence.
• Derived evidence.
• Human evidence.
• Machine-generated evidence.
• External evidence.

5.3 Evidence Dependency Graph

Model:

```text
Evidence
   ↓
Claim
   ↓
Decision
   ↓
Transition
```

Questions:

• What happens when evidence is invalidated?
• Which claims require reassessment?
• Which transitions become illegal?
• Which decisions should reopen?
• Can dependency propagation be automated?

────────

6. Capability Systems

6.1 Capability as Authority

Explore:

• Typed capabilities.
• Scoped capabilities.
• Time-limited capabilities.
• Delegated capabilities.
• Revocable capabilities.
• Human-only capabilities.
• Agent-limited capabilities.

6.2 Capability Creation

Explore:

• Trusted constructors.
• Private constructors.
• Service-generated capabilities.
• Human approval.
• External verification.
• Cryptographic proof.
• Attested evidence.

Question:

> How do we prevent an agent from manufacturing the value needed to satisfy a constraint?

6.3 Capability Composition

Explore:

• Multiple required capabilities.
• Separation of duties.
• Two-person rules.
• Human + machine approval.
• Escalation.
• Emergency authority.
• Temporary exceptions.

────────

7. Effects and the Outside World

7.1 Effect Separation

Preserve the distinction:

```text
Domain transition
!=
External effect
```

Examples:

• Charge payment.
• Send message.
• Deploy software.
• Call API.
• Modify an external record.

7.2 Effect State

Explore:

```text
NotStarted
Requested
InProgress
Succeeded
Failed
OutcomeUnknown
```

Questions:

• When should domain state transition?
• Before or after effect verification?
• How are uncertain effects reconciled?
• How are duplicate effects prevented?

7.3 Compensation

Explore:

• Undoable changes.
• Compensatable changes.
• Irreversible changes.
• Sagas.
• Reconciliation workflows.
• Human escalation.

────────

8. Event Systems

8.1 Event Versus Transition

```text
Transition = permitted operation
Event = immutable fact that occurred
```

8.2 Event History

Explore:

• Auditability.
• Ordering.
• Replay.
• Versioning.
• Historical reconstruction.
• Causation.
• Correlation.
• Provenance.

8.3 Event Sourcing

Questions:

• Should state be stored or derived?
• Where is event sourcing valuable?
• Where is it unnecessary complexity?
• Does event history improve agent reasoning?
• Does it reduce assumption inheritance?

────────

9. Types as State Constraints

9.1 State as Value

Example:

```fsharp
type OrderState =
    | Draft
    | Submitted
    | Paid
```

Explore strengths and limitations.

9.2 State as Type

Example:

```text
DraftOrder
SubmittedOrder
PaidOrder
```

Explore:

• Legal transitions as functions.
• Private constructors.
• Impossible states.
• Compiler enforcement.
• Exhaustive matching.

9.3 Typestate and Advanced Techniques

Explore:

• Typestate.
• Phantom types.
• Generic state parameters.
• Session types.
• Linear types.
• Ownership types.
• Affine types.

Questions:

• Which techniques are commercially practical?
• Which are too difficult for typical teams?
• Which are disproportionately useful for agents?

────────

10. Language Comparison

Explore how the canonical model maps into:

F#

• Discriminated unions.
• Pattern matching.
• Private constructors.
• Result.
• Option.
• Units of measure.
• Immutability.
• .NET interoperability.

C#

• Records.
• Sealed hierarchies.
• Pattern matching.
• Nullable references.
• Private/internal constructors.
• Result libraries.
• Roslyn analyzers.
• Source generators.

TypeScript

• Tagged unions.
• never exhaustive checks.
• Zod.
• Runtime schema validation.
• Readonly data.
• Branded types.
• State-machine libraries.
• JavaScript-runtime limitations.

Python

• Pydantic.
• dataclasses.
• Enum.
• Literal.
• Protocol.
• mypy.
• pyright.
• frozen models.
• Runtime-validation limits.

Rust

• Enums.
• Ownership.
• Borrowing.
• Newtypes.
• Typestate.
• Traits.
• Result.
• Capability-like ownership.

Haskell

• Algebraic data types.
• Purity.
• Explicit effects.
• Typeclasses.
• GADTs.
• State/effect modeling.
• Complexity tradeoffs.

Additional Languages

• Java.
• Kotlin.
• Scala.
• OCaml.

────────

11. Retrofitting Existing Commercial Systems

11.1 Minimal-Change Retrofit

Explore progression:

• Strings to enums.
• Enums to tagged unions.
• Centralized transitions.
• Eliminate direct mutation.
• Add guards.
• Add provenance.
• Add capabilities around high-risk operations.

11.2 Constraint Maturity Model

Candidate levels:

```text
Level 0 — Implicit
Level 1 — Enumerated
Level 2 — Explicit transitions
Level 3 — State-aware types
Level 4 — Guarded capabilities
Level 5 — Verified
```

Explore:

• Cost per level.
• Risk reduction per level.
• Organizational readiness.
• Language-specific ceilings.
• Legacy compatibility.

11.3 Assessment Dimensions

Possible dimensions:

• State explicitness.
• Transition explicitness.
• Invalid-state resistance.
• Mutation control.
• Evidence modeling.
• Provenance.
• Capability enforcement.
• Invariant coverage.
• Agent-boundary safety.
• Formal verification.

────────

12. Semantic Constraint Density

Develop the idea:

> **Semantic Constraint Density = the proportion of important domain semantics that are mechanically enforced rather than left implicit.**

Spectrum:

```text
Low constraint
- comments
- prompts
- tribal knowledge
- conventions

Medium constraint
- tests
- schemas
- validators
- enums
- centralized transitions

High constraint
- state-specific types
- private constructors
- capabilities
- invariants
- property tests
- model checking
```

Questions:

• Can this be measured?
• Is it predictive of agent performance?
• Can it become a consulting diagnostic?

────────

13. Agent Failure Taxonomy

Define precise failure classes.

Assumption Introduction

Agent invents behavior not required by the specification.

Assumption Inheritance

Later agent treats a previous assumption as authoritative.

Semantic Drift

Implementation progressively diverges from intended domain semantics.

Invalid Transition

Agent creates a path that should not exist.

Constraint Weakening

Agent loosens a type, guard, invariant, capability, or test.

Capability Fabrication

Agent manufactures authorization or evidence.

Epistemic Collapse

Agent treats unknown, inferred, or assumed information as verified.

Effect Misclassification

Agent treats uncertain execution as success or failure without evidence.

Provenance Loss

Agent destroys the explanation for why a state exists.

State Explosion

Architecture becomes unusably complex through combinatorial state modeling.

────────

14. Assumption Debt

Define:

> **Assumption debt = implementation behavior whose semantic authority exceeds the evidence that originally justified it.**

Explore:

• How assumptions enter code.
• How they spread.
• How they become tests.
• How they become APIs.
• How they become domain types.
• How they become architecture.

Candidate metric:

```text
Assumption Propagation Depth

0 — isolated
1 — reused once
2 — multiple downstream dependencies
3 — encoded in tests or APIs
4 — embedded in domain model
5 — broadly institutionalized
```

────────

15. Agent Interfaces

15.1 Tool Exposure

Compare:

```text
Agent receives all tools
```

versus:

```text
Agent receives only legal transitions
```

15.2 Dynamic Transition Exposure

Model:

```text
Current state
    ↓
Runtime computes legal transitions
    ↓
Only those operations are exposed
```

Questions:

• Does this reduce hallucinated actions?
• Does it reduce prompt complexity?
• Does it reduce tool-selection cost?
• Does it improve planning?

15.3 Transition Rejection

Design machine-readable reasons:

• Invalid source state.
• Missing evidence.
• Missing capability.
• Failed guard.
• Invariant violation.
• Stale state.
• Conflicting transition.
• Outcome unknown.

────────

16. Agent Planning

Explore the shift from:

```text
Unconstrained tool selection
```

to:

```text
Planning over a state-transition graph
```

Questions:

• Can planning become graph search?
• Can legal paths be generated deterministically?
• Can costs be attached to transitions?
• Can risk be attached?
• Can reversible paths be preferred?
• Can planning be separated from execution?

────────

17. Risk and Reversibility

Transition Risk Classes

Explore:

• Low consequence.
• Medium consequence.
• High consequence.
• Irreversible.

Reversibility

Possible categories:

```text
Reversible
Compensatable
Irreversible
```

Questions:

• Should evidence requirements scale with irreversibility?
• Should capability requirements scale with consequence?
• Should uncertain state block irreversible transitions?

────────

18. State-System Composition

Multiple Machines

Possible interacting machines:

• Domain state.
• Evidence state.
• Execution state.
• Approval state.
• Agent-task state.
• External-service state.

Composition Patterns

Explore:

• Events between machines.
• Shared claims.
• Capabilities.
• Hierarchical states.
• Orthogonal states.
• Parent/child relationships.

State Explosion

Explore mitigation:

• Orthogonal regions.
• Hierarchical statecharts.
• Independent aggregates.
• Product types.
• Derived state.
• Event-driven coupling.

────────

19. Distributed State

Explore:

• Authoritative state.
• Observed state.
• Replicated state.
• Cached state.
• Pending state.
• Conflicting state.
• Eventually consistent state.
• Reconciliation state.

Questions:

• What does current state mean in a distributed system?
• Can an agent act on stale state?
• How should stale assumptions be detected?
• How should conflicting state be resolved?

────────

20. State Versioning and Evolution

Explore:

• Adding states.
• Removing states.
• Renaming states.
• Splitting states.
• Merging states.
• Changing guards.
• Changing invariants.
• Changing capability requirements.
• Historical interpretation.
• Persisted-state migration.

Questions:

• How do old events remain meaningful?
• How does old provenance remain interpretable?
• How should agents reason across schema versions?

────────

21. Formal Methods

Property-Based Testing

Explore:

• Generated transition sequences.
• Invariant checking.
• Shrinking failing paths.
• Impossible-state testing.

Model Checking

Explore:

• TLA+.
• Alloy.
• PlusCal.
• Statechart verification.
• Reachability.
• Deadlocks.
• Safety.
• Liveness.

Proof and Types

Explore:

• Refinement types.
• Dependent types.
• Proof-carrying code.
• Proof-carrying transitions.
• Session types.

────────

22. Proof-Carrying Transitions

Explore transition requests containing justification:

```text
TransitionRequest
    state
    desired transition
    evidence
    capability
    proof / attestation
```

Questions:

• What counts as proof?
• Can proofs be generated automatically?
• Can AI propose proof objects?
• Can external services sign evidence?

────────

23. Trusted Specification Boundary

Critical questions:

• Which artifacts define authoritative behavior?
• Can agents modify them?
• Can agents propose changes but not apply them?
• Who approves invariant changes?
• Who approves capability changes?
• How are tests prevented from becoming the only source of truth?

Possible hierarchy:

```text
Agent-generated implementation
        ↓
State model
        ↓
Invariants
        ↓
Capability policy
        ↓
Trusted specification boundary
```

Core question:

> Who is allowed to change the rules that constrain the agent?

────────

24. Repository Architecture

Explore explicit separation:

```text
/domain
    states
    transitions
    claims
    evidence
    invariants
    capabilities

/application
    orchestration
    use-cases

/infrastructure
    databases
    APIs
    external systems

/tests
    transition tests
    property tests
    model checks
```

Questions:

• Should agents have different write permissions by directory?
• Should domain constraints require separate review?
• Should generated implementation be separated from authoritative specification?

────────

25. State-System DSL

Explore a compact specification language.

Example:

```text
state Submitted
state UnderReview
state Approved

transition Review:
    Submitted -> UnderReview

transition Approve:
    UnderReview -> Approved
    requires VerifiedIdentity
    requires AssignedReviewer
```

Potential generated artifacts:

• F# types.
• C# records.
• TypeScript tagged unions.
• Python models.
• Transition APIs.
• Guards.
• Agent tools.
• Diagrams.
• Documentation.
• Property tests.
• Model-checker specifications.

Key question:

> Can domain semantics be defined once and projected into multiple implementation languages?

────────

26. Generated Agent Interfaces

If state specification is authoritative, explore generation of:

• Agent tool schemas.
• Allowed-transition lists.
• Transition descriptions.
• Required evidence.
• Rejection reasons.
• Capability requirements.
• Planning graphs.

Goal:

> Make the state model the source of truth for both humans and agents.

────────

27. Compiler and Analyzer Integration

Explore:

• Roslyn analyzers.
• TypeScript ESLint rules.
• mypy plugins.
• Rust lints.
• F# analyzers.
• Static checks for direct mutation.
• Static checks for transition bypass.
• Static checks for provenance loss.
• Generated constraint checks.

────────

28. Human Developer Ergonomics

Explore:

• Acceptable extra code.
• Understandable patterns.
• Abstraction resistance.
• Code generation.
• Debugging.
• Visualization.
• Migration pain.
• Training burden.

────────

29. AI Developer Ergonomics

Explore:

• Compiler-feedback quality.
• Context requirements.
• Type-signature usefulness.
• Transition discoverability.
• Repair loops.
• Generated documentation.
• Machine-readable errors.
• Naming stability.
• Code locality.

Central question:

> What makes architecture easy for agents to reason about without making it unpleasant for humans?

────────

30. Economics

Explore:

• Upfront modeling cost.
• Boilerplate cost.
• Token savings.
• Reduced repair cycles.
• Reduced human review.
• Reduced production incidents.
• Reduced context retrieval.
• Reduced semantic drift.
• Migration cost.

Potential economic thesis:

> **Move semantic reasoning from expensive probabilistic inference into cheap deterministic verification.**

────────

31. Consulting and Training

Assessment Offering

Possible flow:

```text
Current architecture
    ↓
State / transition inventory
    ↓
Constraint maturity score
    ↓
Agent-risk analysis
    ↓
Target retrofit level
    ↓
Implementation roadmap
```

Language-Specific Training

C#

• Records.
• State-specific models.
• Result types.
• Pattern matching.
• Analyzers.
• Transition APIs.

TypeScript

• Tagged unions.
• never.
• Zod.
• Readonly models.
• Transition services.
• Runtime boundary validation.

Python

• Pydantic.
• Enum/Literal.
• mypy/pyright.
• Frozen models.
• Transition services.
• Architectural compensation for weak runtime enforcement.

F#

• Discriminated unions.
• Private constructors.
• Result.
• Pattern matching.
• State-specific types.
• Domain modeling.

Migration Playbooks

Explore:

• Greenfield.
• Legacy monolith.
• Microservices.
• AI-enabled existing systems.
• Regulated systems.
• High-risk workflows.

────────

32. Clarity Application

Explore Clarity as:

> **A stateful decision system where decisions progress through governed transitions backed by evidence.**

Areas:

• Decision state.
• Evidence state.
• Ownership state.
• Commitment state.
• Reassessment state.
• Learning state.
• Decision posture as transition policy.
• Reassessment triggers.
• Decision provenance.
• Agent-supported decision analysis.

────────

33. HelixNote Application

Explore HelixNote as:

> **A system for tracking the state of medical knowledge rather than flattening medical information into static facts.**

Areas:

• Symptom state.
• Treatment state.
• Lab state.
• Diagnostic-hypothesis state.
• Clinical-claim state.
• Evidence state.
• Contradictory evidence.
• Provenance.
• Temporal relationships.
• AI inference versus clinician-established state.

────────

34. Research Operating System Application

Explore:

• Research-question state.
• Evidence-collection state.
• Claim state.
• Hypothesis state.
• Verification state.
• Contradiction state.
• Reassessment.
• Research completion.
• Source provenance.

────────

35. Organizational Governance

Explore state-based governance patterns such as:

```text
Proposal
→ Evaluating
→ EvidenceSufficient
→ Authorized
→ Committed
→ Executing
→ Verified
```

Areas:

• Approval.
• Authority.
• Escalation.
• Stop-work.
• Reassessment.
• Investigations.
• Policy exceptions.
• Postmortems.
• Learning records.

────────

36. Security Implications

Explore:

• Least privilege.
• Capability-based security.
• Agent sandboxing.
• Dynamic tool exposure.
• Privilege escalation.
• Constraint tampering.
• Evidence spoofing.
• Replay.
• State forgery.
• Event forgery.

────────

37. Safety Implications

Explore:

• High-consequence transitions.
• Human approval boundaries.
• Reversibility.
• Uncertain evidence.
• Stale information.
• Conflicting evidence.
• Safe failure states.
• Escalation.

────────

38. Observability

Explore:

• Transition logs.
• Rejected transitions.
• Failed guards.
• Capability denials.
• Evidence changes.
• Epistemic downgrades.
• Agent proposals.
• Effect outcomes.
• Reconciliation.

Questions:

• What should operations see?
• What should agents see?
• What should auditors see?

────────

39. Explainability

Example:

```text
Current state:
UnderReview

Requested transition:
Approve

Rejected because:
- identity verification missing
- reviewer capability expired
```

Questions:

• Can explanations be deterministic?
• Can agents use rejection reasons to repair plans?
• Can users understand why transitions are blocked?

────────

40. What Should Not Be State

Important counterbalance.

Candidate rule:

Do not model a value as state unless at least one is true:

• It changes what operations are legal.
• It changes required evidence.
• It changes required authority.
• It changes invariant interpretation.
• It changes future lifecycle behavior.

Goal:

> Avoid state-system overengineering.

────────

41. Failure Modes of the Approach

Explore:

• Excessive type complexity.
• State explosion.
• Difficult migrations.
• Rigid models.
• Over-formalization.
• Excessive boilerplate.
• Poor developer adoption.
• False confidence from type safety.
• Type-correct semantic errors.
• Agent constraint weakening.
• Stale specifications.

────────

42. Competing and Related Architectural Approaches

Compare with:

• Traditional object-oriented domain models.
• Event sourcing.
• Actor systems.
• Workflow engines.
• BPMN.
• Statecharts.
• Domain-Driven Design.
• Functional core / imperative shell.
• Capability-based security.
• Formal specification.
• Policy engines.
• Rule engines.

Question:

> Which parts are genuinely new, and which are a synthesis of existing ideas specifically adapted for AI agents?

────────

43. Terminology to Develop

Possible terms:

• State-constrained architecture.
• Agent-safe architecture.
• Semantic constraint density.
• Assumption debt.
• Assumption inheritance.
• Semantic drift.
• Epistemic state.
• Transition authority.
• Constraint boundary.
• Proof-carrying transition.
• Agent inheritance.
• Semantic stability under autonomous accumulation.

────────

44. Core Research Questions

1. Does explicit state modeling reduce agent semantic errors?
2. Do typed transitions reduce invalid behavior?
3. Does provenance reduce assumption inheritance?
4. Does epistemic state reduce false certainty?
5. Do capability boundaries reduce unauthorized effects?
6. Does constrained architecture reduce agent context requirements?
7. Does constrained architecture reduce repair loops?
8. Does constrained architecture degrade more slowly under repeated AI modification?
9. Which language features matter most?
10. Which retrofit patterns create the most value for existing systems?
11. How much constraint is enough?
12. When does additional constraint become counterproductive?
13. How should agents interact with state systems?
14. How should constraint systems themselves be governed?
15. Can a common state DSL generate both implementation and agent interfaces?

────────

45. Preliminary Principles

These remain hypotheses until refined.

1. Authoritative state should be transitioned, not directly assigned.
2. Agents should propose consequential transitions rather than mutate the world directly.
3. Legality, authority, evidence, and verification should be evaluated independently of the probabilistic agent.
4. Unknown, assumed, inferred, and verified information should not be interchangeable.
5. Time and repetition do not increase epistemic authority; evidence does.
6. Important capabilities and verified values should not be freely constructible.
7. External effects need explicit execution state, including unknown outcomes.
8. Important state changes should preserve provenance.
9. Constraints should progressively move from prose and convention into mechanically enforceable structures.
10. The agent being constrained should not be able to silently weaken the constraint system.

────────

46. Suggested Exploration Order

Phase 1 — Canonical Theory

Focus:

• State.
• Transition.
• Guard.
• Invariant.
• Claim.
• Evidence.
• Capability.
• Effect.
• Event.
• Actor.
• Provenance.

Goal:
Create stable definitions and relationships.

Phase 2 — Composition

Focus:

• Domain state.
• Epistemic state.
• Execution state.
• Multi-machine composition.
• Hierarchy.
• Orthogonal states.
• State explosion.
• Distributed state.

Goal:
Understand how the primitives behave in realistic systems.

Phase 3 — Language Expression

Focus:

• F#.
• C#.
• TypeScript.
• Python.
• Rust.
• Haskell.

Goal:
Determine minimum practical patterns for each ecosystem.

Phase 4 — Agent Runtime

Focus:

• Dynamic transition exposure.
• Capability enforcement.
• Transition rejection.
• Agent planning.
• Effect execution.
• Verification.
• Provenance.

Goal:
Define an agent-oriented runtime architecture.

Phase 5 — Formalization

Focus:

• Property testing.
• Model checking.
• TLA+.
• Statecharts.
• Proof-carrying transitions.
• Trusted specification boundary.

Goal:
Determine how far correctness can be mechanically checked.

Phase 6 — Retrofit and Consulting

Focus:

• Constraint maturity model.
• Semantic constraint density.
• Language-specific playbooks.
• Migration strategy.
• Training.
• Assessment.

Goal:
Turn the research into practical adoption paths.

Phase 7 — Product Applications

Focus:

• Clarity.
• HelixNote.
• Research Operating System.
• Governance.
• Agent-native workflow infrastructure.

Goal:
Use real products to pressure-test the conceptual model.

────────

47. Long-Term Architectural Possibility

```text
Human intent
    ↓
Domain state specification
    ↓
States + transitions + invariants
    ↓
Evidence + capability model
    ↓
Generated typed interfaces
    ↓
Agent-visible legal transitions
    ↓
Agent proposes action
    ↓
Deterministic runtime validates
    ↓
Effect executor
    ↓
Independent verification
    ↓
Immutable event + provenance
    ↓
New authoritative state
```

At that point, the programming language is no longer merely a medium for implementation.

It becomes one layer of a broader control system designed to keep probabilistic agents inside mechanically understandable boundaries.

────────

Central Research Goal

> **Determine how much semantic responsibility can be moved out of probabilistic agent reasoning and into deterministic, machine-verifiable software structure without making commercial software prohibitively difficult to build or evolve.**