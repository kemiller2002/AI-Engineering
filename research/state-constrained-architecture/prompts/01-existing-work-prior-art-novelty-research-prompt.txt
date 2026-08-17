AI RESEARCH MISSION — ARE WE REINVENTING EXISTING WORK?
=======================================================

ROLE
====

Act as a combined programming-languages researcher, formal-methods researcher,
distributed-systems researcher, software-architecture researcher, AI-agent
systems researcher, security/capability-systems researcher, workflow/planning
researcher, and empirical software-engineering researcher.

Your task is to determine whether the architecture described below is:

1. genuinely novel,
2. mostly a recombination of established ideas,
3. substantially equivalent to an existing framework or research tradition,
4. weaker than existing approaches in important ways,
5. or potentially valuable specifically because it unifies known mechanisms
   for AI-operated software.

Do not try to validate the idea. Try to locate its intellectual ancestors and
strongest competitors. Be skeptical. If an existing system already does
80–100% of this, say so clearly. If the novelty lies mostly in composition,
integration, or application to AI agents, say that clearly. Do not use novelty
as a synonym for value.

======================================================================
1. ARCHITECTURE UNDER INVESTIGATION
======================================================================

The proposed architecture is built around explicit semantic control of
consequential software behavior.

Core ideas:

- Important domain state is explicit.
- Legal transitions are explicit.
- Invalid or illegal states should be difficult or impossible to represent.
- Consequential interpretations of closed state families should be exhaustive.
- Agents request legal transitions rather than directly mutating authoritative state.
- Authoritative state has one semantic owner.
- Cross-module interaction occurs through transitions, trusted events,
  capabilities, obligations, semantic contracts, and coordinators.
- Capabilities expose only actions currently legal.
- Capabilities may be bound to state versions, evidence versions, policy
  versions, freshness constraints, and authority.
- Obligations expose unresolved work that must be satisfied, waived, escalated,
  or otherwise resolved.
- Claims have epistemic status such as Unknown, Reported, Assumed, Inferred,
  Supported, Verified, Contradicted, and Invalidated.
- Evidence supports or challenges claims.
- External effects explicitly represent success, failure, and outcome unknown.
- OutcomeUnknown removes unsafe retry capability and may create a
  reconciliation obligation.
- Mutually incompatible concurrent actions may be serialized through a small
  coordination aggregate.
- Important state changes preserve provenance: prior state, resulting state,
  evidence, actor, authority, policy snapshot, versions, and timestamp.
- Policies are versioned.
- Historical transitions remain attributable to the policy version under which
  they were legal.
- Semantic changes should mechanically expose stale assumptions through
  compiler errors, analyzer diagnostics, generated tests, dependency impact
  reports, and semantic migration requirements.
- State splits and merges require explicit semantic redistribution.
- Consequential wildcard/default handling should be prohibited unless
  equivalence is explicitly declared.
- Semantic dependency closure means every consequential semantic dependency is
  machine-visible and traversable.
- Durable semantic modules own authoritative state.
- Product orchestration and current product hypotheses remain replaceable.
- Agents may receive current verified state, available capabilities,
  outstanding obligations, missing prerequisites, relevant evidence, and the
  legal transition graph.
- The same semantic specification may generate runtime guards, state types,
  capabilities, obligations, agent tools, tests, planning graphs, policy impact
  reports, documentation, and analyzers.

Possible long-term characterization:

    a semantic compiler for agent-operated software

======================================================================
2. MAIN RESEARCH QUESTION
======================================================================

What existing fields, systems, languages, frameworks, papers, standards, and
research traditions already solve all or part of this problem?

Build a lineage map.

Do not ask merely "Is there something similar?"

Ask:

- Which specific mechanism came from where?
- Which existing systems already have stronger formal guarantees?
- Which existing fields already combine several of these ideas?
- Which parts appear genuinely uncommon?
- Is AI-agent integration the primary novelty?
- Is the semantic compiler concept already present under another name?

======================================================================
3. REQUIRED AREAS TO INVESTIGATE
======================================================================

At minimum investigate:

1. Typestate
2. Behavioral types
3. Session types
4. Protocol types
5. Algebraic data types / discriminated unions
6. Statecharts
7. Hierarchical state machines
8. Petri nets
9. Colored Petri nets
10. Workflow engines
11. BPMN / business process modeling
12. Process calculi
13. Actor systems
14. Event sourcing
15. CQRS
16. DDD aggregates
17. Domain events
18. Sagas / process managers
19. Capability-based security
20. Object-capability systems
21. Authorization policy engines
22. Policy-as-code systems
23. Deontic logic
24. Obligation policy systems
25. BDI agents
26. Automated planning
27. STRIPS / PDDL
28. HTN planning
29. State-space planning
30. MDPs / POMDPs
31. Action masking
32. Tool/action-space restriction in LLM agents
33. Formal verification
34. TLA+
35. Alloy
36. PlusCal
37. Model checking
38. Refinement types
39. Dependent types
40. Effect systems
41. Linear types
42. Affine types
43. Ownership systems
44. Rust-style ownership/capability patterns
45. Proof-carrying code
46. Design by contract
47. Hoare logic
48. Preconditions/postconditions/invariants
49. Rule engines
50. Decision tables
51. Truth-maintenance systems
52. Belief revision systems
53. Epistemic logic
54. Knowledge provenance
55. Data lineage
56. Evidence-based reasoning systems
57. Event-condition-action systems
58. Distributed transaction theory
59. Idempotency/reconciliation patterns
60. Exactly-once / uncertain-outcome systems
61. Software product lines
62. Feature models
63. Modular architecture / information hiding
64. Ports and adapters
65. Clean architecture
66. Modular monoliths
67. Semantic APIs / semantic contracts
68. Agent tool protocols
69. Agent planning frameworks
70. AI coding-agent context/retrieval systems

======================================================================
4. PRIMITIVE-BY-PRIMITIVE LINEAGE MAP
======================================================================

For each proposed primitive:

    Subject
    State
    StateFamily
    StateCase
    Transition
    Guard / Requirement
    Invariant
    Claim
    EpistemicState
    Evidence
    Capability
    Obligation
    Effect
    EffectOutcome
    Event
    Authority
    Policy
    Coordinator
    Provenance
    SemanticDependency
    SemanticMigration

identify:

- closest historical/research equivalent
- strongest existing implementation tradition
- important differences
- whether our primitive is redundant
- whether our primitive is weaker
- whether our primitive adds useful composition

Do not group these too coarsely.

======================================================================
5. SEMANTIC CLOSURE
======================================================================

The architecture currently distinguishes:

1. Construction Closure
   Only declared semantic states can be constructed.

2. Transition Closure
   Authoritative state can only change through declared transitions.

3. Interpretation Closure
   Consequential interpretations of a closed state family must account for the
   full current state universe.

4. Authority Closure
   Protected evidence, states, capabilities, and trusted events cannot be
   freely fabricated.

5. Dependency Closure
   Every consequential semantic dependency is machine-visible.

Investigate whether these five dimensions already exist as a combined concept
in the literature. If not, identify separate antecedents.

Ask whether "Semantic Closure" is a useful synthesis or merely new terminology.

======================================================================
6. STATE EVOLUTION AND SEMANTIC MIGRATION
======================================================================

Investigate prior work on schema/model evolution where a state is added,
removed, split, merged, renamed, or reinterpreted and dependent rules must be
revisited.

Look at:

- database schema evolution
- protocol evolution
- type evolution
- API evolution
- model-driven engineering
- software product-line evolution
- ontology evolution
- graph schema evolution
- workflow evolution
- business-process migration

Central question:

    Is there existing work that forces every dependent semantic interpretation
    to be explicitly redistributed when a state is split?

Example:

    Approved

becomes:

    ConditionallyApproved
    FullyApproved

Existing dependencies on Approved must not automatically apply to both.

Find the closest existing concept.

======================================================================
7. CAPABILITIES
======================================================================

Research capabilities deeply.

Proposed capability semantics:

    CanShip is not merely permission.

It may encode proof that:

    Order state was Approved
    Payment state was Captured
    Customer was Verified
    Fraud evidence was fresh
    Policy version P was applicable

at specific versions.

The capability may become stale if those versions change.

Ask whether this is best understood as:

- object capability
- bearer capability
- lease
- optimistic concurrency token
- typestate witness
- proof object
- dependent pair
- refinement witness
- revocable authority token
- affine/linear resource
- some combination

Compare with:

- affine/linear resources
- single-use tokens
- revocable capabilities
- cryptographic macaroons
- OAuth/scoped tokens
- object capabilities
- proof-carrying authorization

======================================================================
8. OBLIGATIONS
======================================================================

Proposed duality:

    Capabilities = what MAY happen.
    Obligations = what MUST be resolved.

Obligation definition:

    A versioned, attributable requirement for some condition to be resolved,
    satisfied, waived, escalated, or otherwise handled because of state,
    evidence, policy, or an event.

Investigate:

- deontic logic
- obligation policies
- compliance systems
- workflow task models
- BDI agents
- business rules
- norm-governed multi-agent systems
- policy languages
- incident/remediation systems

Ask:

- Is capability + obligation as an agent control surface already established?
- Are there formal systems that expose both permissions and duties?
- Do any expose them dynamically from current state and policy?

======================================================================
9. EPISTEMIC STATE AND EVIDENCE
======================================================================

Investigate whether the architecture's explicit epistemic states correspond to
existing formalisms.

Candidate states:

    Unknown
    Reported
    Assumed
    Inferred
    Supported
    Verified
    Contradicted
    Invalidated

Compare with:

- epistemic logic
- belief revision
- truth-maintenance systems
- provenance systems
- evidence theory
- Bayesian belief
- Dempster-Shafer
- argumentation frameworks
- scientific workflow provenance
- clinical evidence systems

Important principle:

    Time and repetition do not increase epistemic authority.
    Evidence does.

Ask:

- Is this already captured formally elsewhere?
- Are confidence and provenance being mixed incorrectly?
- Should epistemic state be a lattice rather than a simple state machine?
- What stronger existing models should replace the current formulation?

======================================================================
10. EFFECT OUTCOME UNKNOWN
======================================================================

Investigate:

    Success
    Failure
    OutcomeUnknown

as a first-class effect model.

Compare with:

- distributed transaction theory
- uncertain commits
- two generals problem
- network partitions
- retry semantics
- idempotency
- reconciliation
- sagas
- payment transaction systems
- at-least-once delivery
- exactly-once claims
- failure detectors

Ask:

- Is OutcomeUnknown already a standard concept under another name?
- Should every consequential external effect expose this state?
- When is binary success/failure sufficient?
- Are there stronger models of partial/uncertain effects?

======================================================================
11. COORDINATORS AND CONCURRENCY
======================================================================

Proposed concept:

    Two actions may each be individually legal against the same snapshot but
    mutually incompatible if executed concurrently.

Example:

    Ship
    Refund

Possible solution:

    Open -> Shipping | Refunding | Holding

Compare with:

- locks
- compare-and-swap
- serializable transactions
- sagas
- process managers
- reservation systems
- escrow
- actor mailboxes
- synchronization protocols
- linearizability

Ask whether the coordinator is a true semantic primitive or simply conventional
concurrency control that should remain an implementation technique.

======================================================================
12. PLANNING
======================================================================

The proposed semantic model may generate plans.

Example:

Goal:
    CanShip

Missing:
    PaymentCaptured

Legal producer:
    CapturePayment

Then:
    CapturePayment -> CanShip -> Ship

Compare with:

- STRIPS
- PDDL
- HTN planning
- graph search
- goal regression
- backward chaining
- rule engines
- dependency solvers
- build systems
- workflow engines
- BDI planning
- planning under uncertainty

Important question:

    Does the semantic compiler become a planning domain model?

If yes:

- Is this simply PDDL/STRIPS expressed as business semantics?
- What does our model add?
- Do evidence, authority, policy version, capabilities, obligations, external
  uncertainty, and provenance materially differentiate it?
- Does an existing planner already handle all of these?

======================================================================
13. AGENT WORLD MODEL AND ACTION SPACE
======================================================================

Investigate whether exposing:

    current verified state
    legal transitions
    capabilities
    obligations
    missing prerequisites
    evidence
    policy snapshot

is equivalent to known agent-environment representations.

Compare with:

- BDI belief/desire/intention models
- MDP state/action models
- POMDP belief state
- tool graphs
- affordance models
- action masking
- world models
- constrained agents

Also research current LLM systems that dynamically expose tools, mask illegal
actions, select tools from dependency graphs, infer missing prerequisites, or
narrow tool inventories based on state.

Determine whether the agent-facing portion is already independently emerging.

======================================================================
14. SEMANTIC COMPILER
======================================================================

Investigate prior systems where one semantic/model source generates:

    runtime code
    validation
    tests
    documentation
    workflow logic
    planning models
    APIs
    policy enforcement
    analyzers

Compare with:

- model-driven engineering
- executable specifications
- DSLs
- code generation
- language workbenches
- state-machine compilers
- protocol compilers
- schema compilers
- policy compilers
- formal-specification code generation

Question:

    Is "semantic compiler" meaningfully distinct, or is this model-driven
    engineering / executable specification applied to AI-operated systems?

======================================================================
15. TRUSTED SPECIFICATION BOUNDARY
======================================================================

The proposed architecture separates:

Tier 1:
    semantic specification / legality

Tier 2:
    trusted deterministic implementations

Tier 3:
    probabilistic agents

Agents may propose semantic changes but cannot silently redefine Tier 1.

Investigate prior work on:

- reference monitors
- trusted computing bases
- safety kernels
- policy decision points
- policy enforcement points
- control/data plane separation
- verified kernels
- proof-carrying code

Ask:

- Is the semantic specification effectively a reference monitor?
- Is the runtime a policy enforcement point?
- Is there an established security architecture that maps directly?

======================================================================
16. MODULARITY AND STARTUP PIVOTABILITY
======================================================================

Proposed module rule:

    one semantic owner per authoritative state.

Other modules may observe, request transitions, consume events, and depend on
contracts but may not directly mutate the state.

Compare with:

- DDD aggregate ownership
- actor ownership
- database ownership
- object encapsulation
- information hiding
- microservice data ownership
- capability discipline

Also compare the durable/provisional/experimental distinction with:

- software product lines
- feature models
- variability management
- evolutionary architecture
- hexagonal architecture
- clean architecture
- modular monoliths
- DDD
- information hiding

Ask whether state-constrained semantic modularity adds material pivotability
beyond strong ordinary modularity.

======================================================================
17. LANGUAGE-LEVEL ANTECEDENTS
======================================================================

Compare how the architecture maps into:

    Rust
    F#
    Haskell
    Scala
    Swift
    Kotlin
    Java
    C#
    TypeScript

Focus on:

- ADTs
- sealed types
- exhaustive pattern matching
- phantom types
- GADTs
- refinement types
- dependent types
- typestate patterns
- ownership
- affine/linear types
- modules
- visibility

Ask:

- Which parts need a semantic compiler because ordinary language typing cannot
  express them?
- Which parts are already better handled by existing type systems?

======================================================================
18. WHERE EXISTING APPROACHES ARE STRONGER
======================================================================

Create a section titled exactly:

    WHERE EXISTING APPROACHES ARE STRONGER THAN THE PROPOSED ARCHITECTURE

For each feature, identify any prior system that gives stronger guarantees.

Do not hide these cases.

Example:

    Rust affine ownership may provide stronger non-duplication guarantees than
    generated capability wrappers.

======================================================================
19. WHERE THE PROPOSED ARCHITECTURE IS BROADER
======================================================================

Identify where existing approaches intentionally solve narrower problems.

Example:

    typestate may constrain protocol state but not capture policy snapshots,
    obligations, evidence provenance, or agent tool exposure.

Be precise.

======================================================================
20. COMBINATION NOVELTY
======================================================================

Distinguish:

A. Primitive novelty
    Is any core primitive actually new?

B. Combination novelty
    Is the combination unusual?

C. System novelty
    Is compiling one specification into runtime enforcement + agent world model
    + planning + impact analysis unusual?

D. Application novelty
    Is applying these ideas specifically to AI-maintained/AI-operated
    commercial software new?

E. Economic novelty
    Is treating semantic structure as context/action-space compression for
    reducing AI inference cost new?

======================================================================
21. BUILD AN OVERLAP MATRIX
======================================================================

Create a table.

Rows:
    proposed architecture concepts

Columns:
    Typestate
    Session Types
    DDD
    Event Sourcing
    CQRS
    Sagas
    Capability Security
    Deontic/Policy Systems
    Workflow/BPMN
    STRIPS/PDDL
    BDI
    TLA+
    Alloy
    Effect Systems
    Model-Driven Engineering
    AI Tool Graphs
    Other strong matches discovered

Use:
    Full
    Strong
    Partial
    Weak
    None

For every Full or Strong entry, explain why.

======================================================================
22. SYSTEM-LEVEL COMPARISON
======================================================================

Find actual systems, frameworks, languages, standards, or research projects
that combine multiple relevant features.

For each report:

    name
    origin
    year
    current status
    purpose
    primitives
    guarantees
    workflow model
    policy model
    capability model
    planning model
    evidence/provenance model
    agent integration
    code generation
    semantic evolution support

Rank similarity to the proposed architecture.

======================================================================
23. SEARCH FOR TERMINOLOGY WE MAY BE MISSING
======================================================================

Search beyond the terminology used here.

Candidate terms:

    executable domain model
    behavioral contract system
    protocol-aware policy engine
    normative multi-agent system
    capability-aware workflow
    stateful reference monitor
    executable ontology
    semantic state machine
    policy-guided planning
    proof-carrying workflow
    typed workflow
    stateful authorization
    dynamic authorization
    usage control
    trust management
    semantic orchestration

Find unfamiliar terminology that may better describe the architecture.

======================================================================
24. AI-SPECIFIC PRIOR ART
======================================================================

Search current work on:

    agent operating systems
    constrained AI agents
    AI policy enforcement
    verified agent actions
    typed agent tools
    capability-limited agents
    tool graphs
    world models
    symbolic planning for LLMs
    formal methods for LLM agents
    runtime verification of agents
    agent action verification
    agent state machines
    policy-aware agents
    safe tool calling

Determine whether any project already exposes:

    current state
    legal actions
    obligations
    prerequisites
    evidence
    policy

as a unified agent interface.

======================================================================
25. FALSIFICATION QUESTIONS
======================================================================

Try to falsify claims of novelty.

Ask:

1. Could this simply be DDD + typestate + sagas + policy-as-code?
2. Could it simply be a workflow engine with richer metadata?
3. Could it simply be a planning domain with access control?
4. Could it simply be a model-driven architecture tool?
5. Could it simply be a reference monitor around LLM tools?
6. Could capability + obligation already be standard in normative agents?
7. Could epistemic state be better modeled by existing truth-maintenance or
   belief systems?
8. Could semantic migration already exist in ontology/model evolution?
9. Could agent action masking provide the main AI benefit without the broader
   architecture?
10. Could ordinary modularity plus good retrieval provide most of the context
    savings without semantic compilation?

======================================================================
26. VALUE EVEN IF NOT NOVEL
======================================================================

If the architecture is mostly a recombination, investigate whether the
combination may still be valuable because existing mechanisms are usually
fragmented across:

    language type systems
    workflow engines
    authorization systems
    planners
    observability
    prompts
    tool descriptions

Ask:

- Would unifying them under one semantic model reduce integration drift?
- Is that enough to justify a research/product program without primitive novelty?

======================================================================
27. SOURCE QUALITY
======================================================================

Prefer:

    original research papers
    foundational papers
    official specifications
    language documentation
    standards
    authoritative books
    official project documentation

For technical claims, prefer primary sources.

For each important claim:

    provide citation
    publication year
    explain exactly what the source supports

Do not cite a source merely because its title sounds related.

Research both foundational history and current work through the present date.

======================================================================
28. REQUIRED OUTPUT
======================================================================

Produce:

1. Executive verdict
2. One-paragraph description of the proposed architecture
3. Historical lineage
4. Primitive-by-primitive lineage map
5. Five semantic-closure dimensions compared to prior work
6. Typestate / behavioral-type comparison
7. Session/protocol-type comparison
8. DDD / aggregate / event-sourcing comparison
9. Capability-security comparison
10. Obligation / deontic / normative-system comparison
11. Workflow/BPMN/statechart/Petri-net comparison
12. Planning/STRIPS/PDDL/BDI comparison
13. Epistemic-state/evidence comparison
14. Distributed-effect uncertainty comparison
15. Formal-methods comparison
16. Model-driven engineering / executable-spec comparison
17. Semantic evolution/migration comparison
18. Modularity/pivotability comparison
19. Current AI-agent/tool-graph comparison
20. Strongest existing systems discovered
21. Where prior work is stronger
22. Where the proposed architecture is broader
23. What appears genuinely unusual
24. What appears to be renamed prior art
25. Overlap matrix
26. Combination-novelty assessment
27. AI-specific novelty assessment
28. Economic/context-compression novelty assessment
29. Major risks
30. Recommended terminology changes
31. Research areas we should adopt rather than reinvent
32. Research areas where a new implementation may be justified
33. Final verdict

======================================================================
29. FINAL VERDICT FORMAT
======================================================================

End with:

Primitive novelty:
    Low / Medium / High

Combination novelty:
    Low / Medium / High

System-level novelty:
    Low / Medium / High

AI-agent application novelty:
    Low / Medium / High

Economic/context-optimization novelty:
    Low / Medium / High

Risk of reinventing an existing system:
    Low / Medium / High

Most similar existing approach:
    ...

Strongest prior art we should build on:
    ...

Most defensible differentiator:
    ...

Weakest originality claim:
    ...

Most important architecture change suggested by prior art:
    ...

======================================================================
30. RESEARCH STANDARD
======================================================================

Be adversarial toward novelty claims.

Do not reward new terminology.
Do not treat integration as primitive invention.
Do not assume AI makes an old architecture new.

At the same time, do not dismiss a system merely because its primitives are
established. Valuable systems often integrate previously separate ideas around
a new operating environment.

The central question is:

    What, if anything, is actually new or unusually valuable about combining
    explicit state ownership, transition legality, capabilities, obligations,
    evidence, policy, effect uncertainty, semantic dependency closure,
    semantic migration, planning, and constrained AI-agent actions under one
    executable semantic model?
