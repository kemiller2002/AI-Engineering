Prior-Art and Novelty Assessment

1. Executive verdict

The architecture in the research mission is not primarily a new collection of primitives. Nearly every individual mechanism has substantial prior art. Typestate already models state-dependent legal operations; session and protocol types constrain legal interaction sequences; DDD aggregates and actor systems establish semantic ownership; capability systems encode authority; UCON combines authorizations, obligations, conditions, mutability, and ongoing control; planning systems model states, prerequisites, actions, and goals; truth-maintenance and provenance systems track claims and reasons; formal methods model invariants and transitions; model-driven engineering generates implementation artifacts from models; and recent AI-agent research is independently converging on deterministic enforcement of agent actions. (IEEE Xplore)

The architecture is nevertheless not obviously equivalent to one established system.

The strongest interpretation is:

It is a synthesis of behavioral typing, usage control, domain modeling, planning, provenance, formal methods, distributed-systems safety, and model-driven engineering, organized specifically around a trusted semantic substrate for probabilistic software agents.

That synthesis is considerably more interesting than a claim that “explicit states” or “legal transitions” are novel.

The most defensible research hypothesis is therefore system-level composition:

Can one executable semantic model simultaneously become the application’s legality model, agent action surface, planning domain, policy boundary, provenance model, change-impact graph, testing oracle, and source of generated implementation artifacts?

I did not find an established system that clearly combines all of those functions.

The second potentially important contribution is economic rather than conceptual:

Does making semantics machine-visible reduce the amount of repository reconstruction, context retrieval, probabilistic reasoning, failed tool use, and repair work required by AI agents?

That hypothesis has preliminary plausibility because current coding-agent research identifies context selection itself as a substantial unresolved problem. ContextBench found agents retrieve considerably more context than they ultimately use, while LongCodeBench shows large-context code reasoning degrades markedly as relevant context grows. Neither result proves the proposed architecture reduces cost, but both establish the problem the architecture claims to attack. (arXiv)

My present conclusion:

Do not position this as a new state-modeling formalism.

Position it, provisionally, as:

an executable semantic control architecture for probabilistic software agents.

The word semantic is doing genuine work here because the system attempts to unify domain meaning rather than merely control execution order.

⸻

2. What the proposed architecture actually is

The research specification describes a trusted deterministic layer between probabilistic actors and consequential domain state.

The layer describes:

* authoritative domain state;
* its legal evolution;
* invariants and transition requirements;
* who or what has authority;
* evidence supporting consequential claims;
* policy versions;
* capabilities representing currently legal actions;
* obligations representing unresolved required work;
* external-effect uncertainty;
* concurrency constraints;
* provenance;
* semantic dependencies;
* model-evolution consequences.

Agents do not freely mutate authoritative state. They perceive a constrained semantic environment and request transitions that the trusted layer can permit, deny, explain, or defer.

This means the architecture is better understood as several existing research traditions meeting at one execution boundary than as an extension of classical state machines.

⸻

3. Historical lineage

A rough intellectual lineage looks like this:

1960s–1970s — state, authority, verification, planning

Petri nets formalized concurrent state-transition systems. Capability systems established authority through possession of unforgeable references. Hoare logic and related formal methods established preconditions, postconditions, and invariants. STRIPS represented planning problems through world state, action prerequisites, and effects.

1980s — state-dependent types and belief maintenance

Strom and Yemini’s 1986 typestate work explicitly extended types with state so that legal operations could vary with program state and be checked statically. Truth-maintenance systems recorded the justifications behind beliefs and revised dependent beliefs when assumptions changed. (IEEE Xplore)

1990s — behavioral protocols, rational agents, formal specifications

Session-type research formalized interaction protocols. BDI systems separated beliefs, desires, and intentions. Formal specification technologies such as TLA+ provided mathematical descriptions of actions and system behaviors. (Springer)

1990s–2000s — workflow, domain architecture, model-driven engineering

Petri-net-based workflow systems, BPMN, DDD, event sourcing, model-driven engineering, schema evolution, and executable models moved explicit behavior into enterprise software engineering.

2000s — usage control and stronger authorization

UCON integrated authorization, obligations, conditions, mutable attributes, and continuing decisions. Proof-carrying authorization allowed authorization decisions to depend on mechanically checkable proofs. (ACM Digital Library)

2010s — provenance and contextual capabilities

W3C PROV standardized provenance relationships among entities, activities, and agents. Macaroons demonstrated attenuable credentials with contextual caveats. (W3C)

2025–2026 — agent enforcement

Recent AI-agent research now explicitly intercepts proposed tool calls, validates them against formal or deterministic policies, uses state checks to constrain actions, or simulates mutations against world-state invariants before allowing execution. (arXiv)

That last development is important: the “agent proposes, deterministic system validates” concept should no longer be treated as novel.

⸻

4. Primitive-by-primitive lineage

Proposed primitive	Strongest antecedent	Assessment
Subject	security principals, actors, DDD entities	Established
State	transition systems, statecharts, Petri nets	Established
StateFamily	ADTs, sealed classes, sum types	Established
StateCase	algebraic datatype constructor	Established
Transition	automata, typestate, Petri nets, planning actions	Established
Guard / Requirement	design-by-contract, planning preconditions, guards	Established
Invariant	formal methods, Hoare logic, DDD aggregates	Established
Claim	knowledge representation / belief systems	Established
EpistemicState	epistemic logic/TMS/provenance	Existing ideas, proposed representation questionable
Evidence	provenance, argumentation, proof systems	Established
Capability	capability security / proof-carrying authorization	Established
Obligation	deontic logic/UCON/workflow	Established
Effect	effect systems/workflow/distributed actions	Established
EffectOutcome	distributed systems	Established
Event	event sourcing/process calculi	Established
Authority	access control/capability systems	Established
Policy	policy-as-code/UCON/XACML	Established
Coordinator	actors/transactions/reservations/process managers	Established
Provenance	W3C PROV/event sourcing	Established
SemanticDependency	build systems/MDE/knowledge dependency graphs	Established concept, unusual scope
SemanticMigration	metamodel/ontology/schema evolution	Established field, proposed strictness unusual

The primitive novelty is consequently low.

The potentially unusual piece is not any row. It is the dependency graph connecting the rows.

⸻

5. Semantic Closure

The five closures proposed in the mission are useful, but they should currently be treated as a synthesis rather than as a new formal theory.

Construction Closure

Only declared semantic states can be constructed.

Antecedents: algebraic data types, sealed hierarchies, refinement types, smart constructors, dependent types.

This is old and often more strongly enforced by programming-language type systems.

Transition Closure

Authoritative state changes only through declared transitions.

Antecedents: typestate, protocol types, DDD aggregate boundaries, actors, workflow engines.

Again, established.

Interpretation Closure

Consequential interpretations must account for every member of a closed state universe.

The most direct language antecedent is exhaustive pattern matching over algebraic data types.

This component is powerful precisely because many mainstream application architectures fail to preserve it across persistence, rules, policies, UI decisions, APIs, and agents.

Authority Closure

Protected semantic facts or authorities cannot simply be fabricated.

This maps strongly to capability security, abstract data types, module boundaries, proof objects, cryptographic authorization, and trusted computing bases.

Dependency Closure

Consequential dependencies must be mechanically discoverable.

This resembles build-system dependency graphs, type dependency analysis, model-driven engineering traceability, ontology dependency analysis, and impact analysis.

The degree of closure being proposed is stronger than typical enterprise systems.

Verdict on “Semantic Closure”

I found no clear evidence that these exact five dimensions exist as one established named theory.

The term is therefore potentially useful as a taxonomy.

It should not yet be described as a newly discovered property of computation.

⸻

6. Typestate and behavioral types

Typestate is among the closest intellectual ancestors.

Strom and Yemini described typestate as an extension of type in which the operations legally applicable to an object depend on its current state. Later typestate-oriented work describes exactly this relationship: mutable state changes the set of legal operations. (IEEE Xplore)

That corresponds directly to:

current state → available operations

and therefore to an important portion of the proposed capability model.

Where typestate is stronger:

* compile-time enforcement;
* formal reasoning about legal operation sequences;
* invalid usage can become unrepresentable program text;
* systems with linear/affine ownership can control aliasing and duplication far more rigorously.

Where the proposed architecture is broader:

Typestate normally does not model an enterprise action as something contingent simultaneously on:

* multiple aggregates;
* authority;
* external evidence;
* freshness;
* policy versions;
* obligations;
* uncertain effects;
* provenance;
* AI-visible affordances.

This distinction should be preserved.

Do not reinvent typestate inside the semantic compiler where the implementation language can provide it.

Use it.

⸻

7. Session and protocol types

Session types specify communication protocols and legal interaction sequences, with foundational work dating to Honda and later Honda, Vasconcelos, and Kubo. (Springer)

They are significantly stronger than the proposed architecture for verifying communication behavior between cooperating parties.

They are especially relevant if transitions cross modules or services.

However, they mostly answer:

What messages may these participants exchange, and in what sequence?

They do not naturally answer the full business-semantic question:

Given current domain state, evidence, authority, policy, historical provenance and unresolved obligations, what may happen next?

Session types should therefore be a substrate or implementation technique rather than a competing whole architecture.

⸻

8. DDD, aggregates, event sourcing and CQRS

The proposed rule:

one semantic owner per authoritative state

has no strong novelty claim.

It strongly resembles:

* aggregate ownership in DDD;
* actor ownership;
* encapsulation;
* service-owned data;
* information hiding.

Event sourcing also provides an obvious lineage for:

* prior state;
* event;
* actor;
* resulting state;
* historical reconstruction.

The new contribution would have to be that ownership participates in a machine-generated semantic dependency and agent-capability system, not ownership itself.

This is important for startup pivotability.

Ordinary strong modularity can already make systems substantially replaceable. The proposed architecture must demonstrate that explicit semantic ownership materially improves pivot cost beyond good DDD/hexagonal/modular-monolith practice.

That remains an empirical hypothesis.

⸻

9. Capability security

The proposed CanShip concept is not merely conventional authorization.

It resembles a hybrid of:

* object capability;
* proof object;
* refinement witness;
* proof-carrying authorization;
* contextual credential;
* optimistic concurrency token;
* lease;
* revocable authority;
* possibly affine resource.

Macaroons are particularly relevant because they demonstrate contextual restrictions—“caveats”—attached to delegated authority. (Google Research)

Proof-carrying authorization is even closer conceptually: authority is established through mechanically checkable evidence sufficient to prove that an access is permitted. (Carnegie Mellon University ECE)

Therefore:

CanShip should not be described as a newly invented capability concept.

The potentially useful innovation is that such a witness is automatically generated from business-state proofs and exposed to both deterministic code and agents.

A plausible formalization is:

Capability = authority + proof/witness + version binding + contextual caveats.

That is much stronger than treating a capability as a Boolean permission.

⸻

10. Obligations and deontic systems

This area substantially weakens an originality claim.

The 2004 UCONABC model explicitly integrates:

* Authorizations;
* oBligations;
* Conditions;
* continuity;
* mutability.

It also models state transitions resulting from usage decisions. (ACM Digital Library)

This is extremely close to the proposed dual control surface:

Capabilities = what MAY happen.
Obligations = what MUST be resolved.

XACML also includes obligations associated with authorization decisions. (OASIS Open)

Therefore, capability + obligation is not primitive novelty.

The research opportunity is narrower:

Can permissions and obligations become first-class, dynamically generated agent affordances derived from domain semantics rather than merely security-policy outputs?

That appears much less common.

⸻

11. Workflow, BPMN, statecharts and Petri nets

Workflow systems are an obvious falsification candidate.

Van der Aalst’s work explicitly describes workflow management as making process logic explicit so software can control, monitor, and analyze business processes, and uses Petri nets to verify workflow correctness. (Eindhoven University Research Portal)

BPMN is the established standard notation for business-process models. (OMG)

A workflow engine can already represent:

* current process state;
* allowed next activities;
* prerequisites;
* human tasks;
* timers;
* compensation;
* exceptions.

This is substantial overlap.

But workflow is usually process-centric.

Your proposed model is semantic-state-centric.

That difference matters.

An Order can have meaningful state even when no particular workflow instance is currently executing. Multiple products and workflows can operate against the same durable semantics.

That is one reason not to reduce the architecture to BPMN.

⸻

12. Planning, STRIPS, PDDL and BDI

This part is mostly established theory.

PDDL represents planning models through domain predicates, actions, state and goals; modern variants support richer temporal and resource semantics. (Springer)

The proposed example:

CapturePayment → CanShip → Ship

is essentially planning over preconditions and effects.

The semantic compiler does become a planning-domain generator if transitions can be interpreted as actions and desired semantic conditions as goals.

That is not a weakness.

It means PDDL-style research should be adopted rather than reinvented.

BDI adds another close analogy: beliefs describe the agent’s informational view of the world, desires its objectives, and intentions its committed actions/plans. (BSTU Neuro Lab)

Where the proposed architecture differs is that the world model is authoritative rather than merely internal to the agent.

That distinction is valuable:

The LLM should not decide what the world is.

The system should tell it.

⸻

13. Epistemic state and evidence

This is one area where I recommend changing the architecture.

The sequence:

Unknown → Reported → Assumed → Inferred → Supported → Verified

looks intuitively appealing but may be too linear.

Truth-maintenance systems have tracked beliefs and their justifications since the 1970s, including dependency-driven revision when supporting beliefs change. (IJCAI)

AGM belief revision provides a mature formal tradition for changing belief sets in response to new information. (PhilPapers)

W3C PROV separately models the entities, activities and agents involved in producing information, explicitly because provenance informs trust and reliability assessments. (W3C)

These traditions suggest separating at least three dimensions:

provenance

Where did the claim come from?

support

What evidence or arguments support or contradict it?

epistemic judgment

What is the system currently justified in asserting?

For example, “reported” describes provenance, while “verified” describes an evaluation. They are not necessarily mutually exclusive states.

A claim could simultaneously be:

* originally reported by a customer;
* supported by document A;
* contradicted by sensor B;
* not independently verified.

That is not naturally one state.

Recommendation

Replace the simple epistemic state machine with something closer to a small epistemic lattice or evidence graph.

This is one of the most important architectural changes suggested by prior art.

⸻

14. Effect outcome uncertainty

Success | Failure | OutcomeUnknown is conceptually correct but not new.

Distributed systems have always faced the ambiguity created when:

1. a caller sends an operation;
2. the receiver may perform it;
3. communication fails before acknowledgement returns.

The caller then cannot infer execution from the absence of a response.

The useful architectural move is not inventing OutcomeUnknown.

It is forcing application semantics to acknowledge it.

For consequential effects, that could be extremely valuable because ordinary APIs frequently collapse transport failure into apparent operation failure.

The proposed response is sound:

OutcomeUnknown should generally prevent naive retry unless the operation is independently idempotent or reconcilable.

It may create:

ReconciliationRequired.

That is a good application-level synthesis of established distributed-systems knowledge.

⸻

15. Formal methods: TLA+, Alloy and model checking

Formal methods are stronger than the architecture wherever true mathematical verification is required.

TLA+ models states, actions, invariants and temporal behavior and supports model checking/proofs for concurrent and distributed systems. (Leslie Lamport’s Home Page)

The proposed architecture should not compete with TLA+.

Instead, the semantic specification could potentially generate or project formal models for selected consequential parts.

That leads to an important design principle:

The semantic compiler should orchestrate stronger formalisms rather than recreate weaker versions of them.

The same applies to Alloy, refinement types, proof assistants, session types, linear types and language-native exhaustiveness.

⸻

16. Model-driven engineering and executable specifications

“Semantic compiler” has significant prior-art risk.

Model-driven engineering already uses higher-level models as authoritative inputs from which implementation artifacts, transformations, validation and other models can be produced.

Metamodel/model co-evolution research explicitly studies what happens when modeling languages change and dependent models must migrate. A substantial literature exists around automated and semi-automated co-evolution. (ScienceDirect)

Therefore:

one specification generates runtime code, tests and documentation

is not novel.

The defensible distinction is the nature of the model.

Traditional MDE usually treats the model as a software-development abstraction.

Here the specification is proposed as an ongoing trusted operational boundary for probabilistic actors.

That is substantially more interesting.

I would retain “semantic compiler” as an engineering description, but never imply that compilation from models is new.

⸻

17. Semantic evolution and migration

There is considerable prior art.

Metamodel/model co-evolution asks how dependent models are migrated when their governing metamodel evolves. (ScienceDirect)

Ontology evolution similarly studies propagation of model changes into dependent artifacts. Work on ontology-query migration explicitly identifies queries impacted by ontology changes and provides explanations for their invalidation. (researchgate.net)

That comes remarkably close to the proposed:

semantic change mechanically exposes stale assumptions.

The more specific rule:

Approved → ConditionallyApproved | FullyApproved

and old interpretations must explicitly redistribute rather than automatically inheriting meaning

is still interesting.

Ordinary schema migrations often preserve structure automatically when they can.

Your proposed rule intentionally introduces semantic friction.

That may be a valuable innovation in software engineering:

ambiguity created by semantic refinement should become an explicit engineering obligation rather than be resolved through implicit inheritance.

I did not find a well-established cross-stack implementation discipline that enforces this everywhere—from source code through policies, agent tools, workflow logic and planning.

This deserves focused research.

⸻

18. Modularity and pivotability

The architecture does not invalidate conventional modularity. It depends on it.

One semantic owner per authoritative state is close to:

* information hiding;
* aggregate ownership;
* actor ownership;
* service-owned data.

The hypothesized startup advantage comes from something more subtle.

If durable domain semantics are isolated from current product orchestration, then a pivot may replace:

* workflows;
* interfaces;
* orchestration;
* customer journeys;
* temporary product rules;

while preserving:

* customer identities;
* payments;
* evidence;
* authority;
* durable business states;
* domain transitions.

That is plausible.

But the appropriate baseline is excellent modular architecture, not a bad monolith.

Otherwise an experiment would exaggerate the benefit.

⸻

19. Current AI-agent prior art

This area is moving rapidly.

Recent systems have already crossed several conceptual boundaries in the proposal.

A 2025 company-policy enforcement approach compiles policy documents into deterministic guards associated with agent tools and enforces those guards before execution. (arXiv)

Agent-C enforces temporal constraints and state checks over agent actions rather than trusting prompts alone. (arXiv)

A 2026 solver-aided approach translates operational policy into formal constraints and intercepts tool calls before execution. (arXiv)

PhantomPolicy/Sentinel goes still further: it treats an agent action as a proposed mutation to organizational world state, simulates the resulting graph state, and validates structural invariants before allowing it. (arXiv)

Autoformalization research is now compiling prompts, tool descriptions and natural-language policies into Cedar policy definitions. (arXiv)

This means the following claims are already weak:

* deterministic guards around agents;
* formal policy enforcement for tool calls;
* state-dependent agent action validation;
* compiling policy into guards;
* proposed-action interception;
* world-state-grounded action checking.

Your differentiation therefore has to happen above this layer.

⸻

20. Strongest existing systems/traditions discovered

The closest traditions are not one product but a cluster.

1. UCON / usage control

Closest to capabilities + obligations + conditions + mutable state.

2. Typestate / behavioral typing

Closest to state-dependent legal operations and transition legality.

3. STRIPS/PDDL

Closest to prerequisites, actions, reachable goals and generated plans.

4. DDD aggregates / actors

Closest to single semantic state ownership.

5. TLA+ / formal transition systems

Strongest for rigorous state/action/invariant reasoning.

6. Model-driven engineering

Closest to generating multiple artifacts from one authoritative model.

7. Truth-maintenance + provenance

Closest to evidence-backed claims and semantic dependency invalidation.

8. Current deterministic agent guards

Closest to the trusted boundary between probabilistic intent and consequential action.

No one of these is equivalent to the entire proposal.

⸻

21. WHERE EXISTING APPROACHES ARE STRONGER THAN THE PROPOSED ARCHITECTURE

Rust/linear/affine type systems

Stronger at enforcing ownership, uniqueness and non-duplication.

Typestate

Stronger when operation legality can be proved statically inside a single program.

Session types

Stronger for communication-protocol correctness.

TLA+/Alloy/model checking

Stronger for verifying state-space properties mathematically.

Dependent/refinement types

Stronger for encoding proofs into program types.

Petri nets

Stronger for formal concurrency/process analysis.

PDDL/planning systems

Stronger and vastly more mature for plan search.

Truth-maintenance/belief revision

Stronger for formal dependency-driven changes to beliefs.

W3C PROV

More mature and interoperable for generic provenance.

UCON

More established theoretically for authorization + obligations + conditions + mutable usage state.

The architecture should compose these ideas where possible instead of creating reduced internal approximations.

⸻

22. Where the proposed architecture is broader

Typestate knows legal operations but normally not enterprise evidence.

UCON knows usage authorization and obligations but does not define the whole business domain.

PDDL knows action prerequisites but not necessarily authority, provenance or organizational policy.

TLA+ can model virtually all of it abstractly but is not an application runtime architecture or agent affordance system.

DDD supplies ownership but not formal transition closure.

MDE generates artifacts but does not inherently protect an operational system from probabilistic actors.

Provenance tracks origins but not legal actions.

Agent guards control tools but usually do not serve as the application’s entire semantic model.

The proposal’s breadth is therefore real.

⸻

23. What appears genuinely unusual

The strongest unusual combination I found is:

One authoritative semantic model drives both deterministic application enforcement and the probabilistic agent’s observable world/action model.

In other words, the same semantics potentially answer both:

Application question

Is this transition legal?

and:

Agent question

What can I legally do now, what must still be resolved, and what would make the desired action possible?

That coupling is more consequential than “state machine for AI.”

A second unusual aspect is:

semantic model evolution deliberately creates mechanical obligations when meaning changes.

A third is:

external-effect uncertainty feeds back into capability generation.

Example:

PaymentOutcomeUnknown

could mechanically remove:

CanRetryPayment

and create:

MustReconcilePayment.

That integrates distributed-systems uncertainty with planning and agent affordances in a particularly coherent way.

⸻

24. What appears to be renamed prior art

These claims should be avoided:

“Legal transitions” are new — typestate, transition systems, workflow, planning.

“Capabilities” are new — capability systems.

“Obligations” are new — deontic systems/UCON/XACML.

“Claims backed by evidence” are new — TMS/provenance/argumentation.

“Explicit effects” are new — effect systems and distributed systems.

“State ownership” is new — actors/DDD/information hiding.

“Semantic compiler” is wholly new — substantial MDE/executable-spec ancestry.

“Agent requests are checked before execution” is new — already active 2025–2026 research.

⸻

25. Overlap matrix

Legend: F = Full, S = Strong, P = Partial, W = Weak, – = little direct overlap

Concept	Typestate	Session	DDD	UCON	Workflow	PDDL	BDI	TLA+	MDE	Agent Guards
Explicit state	F	S	S	S	F	F	P	F	S	S
Legal transitions	F	F	P	P	F	F	P	F	S	S
State ownership	W	W	F	W	P	–	–	–	S	–
Invariants	P	P	S	P	P	P	W	F	S	S
Capabilities	P	W	W	S	W	W	W	W	W	S
Obligations	–	–	W	F	S	P	P	P	P	P
Evidence	–	–	W	P	W	W	S	P	P	P
Provenance	–	–	S	P	S	–	W	P	S	P
Planning	W	W	W	W	S	F	S	P	P	S
Policy	W	W	P	F	P	P	P	P	S	F
Effect uncertainty	–	P	P	P	S	P	P	F	P	P
Semantic migration	W	W	P	W	P	W	W	W	F	–
Agent action masking	–	–	–	P	P	P	P	–	–	F
Artifact generation	W	P	W	W	P	P	W	W	F	P

No column is full across the architecture.

That is the key system-level result.

⸻

26. Combination novelty

Primitive novelty

Low.

Combination novelty

Medium to high.

Many pairings already exist:

* states + legal actions;
* permissions + obligations;
* models + generators;
* states + planning;
* provenance + evidence;
* policy + agent guards.

The unusual feature is the breadth of the composition around one authoritative model.

⸻

27. AI-specific novelty

Medium.

The core safety pattern is already clearly emerging:

probabilistic agent proposes → deterministic layer validates.

But I found much less evidence of systems giving agents a unified interface containing:

* authoritative current semantic state;
* dynamically available capabilities;
* unresolved obligations;
* missing prerequisites;
* evidence/provenance;
* policy version;
* transition graph;
* uncertainty state;

all generated from the same specification used by runtime application code.

That appears to remain a promising differentiator.

⸻

28. Economic/context-compression novelty

This may actually be the most interesting research program.

Coding agents face a contextual-reconstruction problem.

ContextBench’s 2026 evaluation of 1,136 tasks reports substantial differences between context explored and context ultimately useful, and observes a tendency toward high recall rather than precision. (arXiv)

LongCodeBench demonstrates that large context availability itself does not solve repository reasoning: performance can decline dramatically as context length grows. (arXiv)

These findings support the premise:

more context is not equivalent to better semantic understanding.

But they do not prove:

explicit state architecture reduces total agent cost.

That remains to be experimentally established.

A good economic thesis is therefore:

Semantic structure may function as lossy-looking but meaning-preserving context compression: instead of presenting all artifacts from which rules might be inferred, present the authoritative conclusions and the dependencies needed for the current decision.

That is a far stronger and more testable claim than “AI likes state machines.”

⸻

29. Major risks

Risk 1 — accidental reinvention of formal methods

Building custom versions of typestate, planning, provenance and authorization would create weaker versions of mature systems.

Risk 2 — semantic-model bureaucracy

If every business fact requires elaborate modeling, teams could spend more effort maintaining semantics than they save through agent efficiency.

Risk 3 — the authoritative-model problem

Someone still has to encode the correct semantics.

The architecture moves ambiguity out of runtime reasoning and into specification work. That is beneficial only if specification cost is lower than repeated reconstruction/error cost.

Risk 4 — false closure

A system may appear formally constrained while important behavior escapes through:

* SQL;
* external APIs;
* manual database modifications;
* integration code;
* analytics jobs;
* legacy systems.

Closure must therefore be architectural, not merely syntactic.

Risk 5 — state explosion

Cross-products of many explicit state families can become unmanageable.

The architecture must preserve modular local state rather than construct one giant global state machine.

Risk 6 — policy/domain coupling

Not every policy rule belongs permanently inside durable domain semantics.

Policy must remain versioned and replaceable.

Risk 7 — overclaiming the AI benefit

Action restriction almost certainly reduces illegal action possibilities.

Whether it reduces total tokens or dollars significantly remains unproved.

⸻

30. Recommended terminology changes

I would avoid making state machine the umbrella term.

It understates the architecture.

I would also avoid suggesting that capability alone means the proposed richer witness.

Possible vocabulary:

Semantic state model

for domain semantics.

Semantic transition

for consequential state change.

Verified capability

or conditioned capability

for state/evidence/policy/version-bound authority.

Resolution obligation

for required unresolved work.

Semantic dependency graph

for machine-visible consequences.

Semantic migration

remains a useful term.

Semantic kernel

for the trusted deterministic runtime.

Semantic compiler

for the build-time generation layer.

Agent affordance surface

for dynamically exposed legal actions and obligations.

A possible whole-system description:

Executable semantic architecture

or:

Semantic control architecture

The latter emphasizes what is genuinely different from a workflow DSL.

⸻

31. Research we should adopt rather than reinvent

Use existing work for:

* ADTs and exhaustive matching;
* typestate;
* refinement and dependent typing where available;
* capability security;
* proof-carrying authorization;
* UCON/deontic concepts;
* planning algorithms;
* Petri-net/process analysis;
* TLA+/Alloy model checking;
* W3C PROV concepts;
* truth-maintenance dependency ideas;
* established concurrency control;
* metamodel/model co-evolution.

The project becomes stronger when it openly says:

these are our foundations.

⸻

32. Where new implementation research is justified

Several areas do appear sufficiently unintegrated to justify original implementation.

A. Semantic dependency closure across artifacts

One model change mechanically identifies affected:

* code;
* policies;
* guards;
* agent tools;
* plans;
* tests;
* migrations;
* documentation.

B. Explicit state-split redistribution

Prevent semantic refinements from silently inheriting old interpretations.

C. Capabilities as generated versioned witnesses

Generate legal actions from state + authority + evidence + policy + freshness.

D. Obligations as a first-class agent interface

Expose “what must be resolved” just as directly as “what may be done.”

E. Uncertain-effect capability suppression

Translate distributed-system uncertainty automatically into new legal-action surfaces.

F. Semantic model → planning domain

Generate planner-compatible representations directly from application semantics.

G. Semantic model → agent tool surface

Only expose presently meaningful actions rather than giving an agent a static tool catalog.

H. Context-compression measurement

This is the clearest empirical research opportunity.

Compare:

Repository inference

versus:

semantic interface + repository fallback

and measure:

* tokens;
* context retrieved;
* files opened;
* model turns;
* tool calls;
* repair loops;
* wall-clock time;
* semantic defects;
* human intervention;
* cost per correct completion.

That experiment would tell us more about commercial value than another theoretical novelty argument.

⸻

33. Final verdict

Primitive novelty:
Low

Combination novelty:
High

System-level novelty:
Medium–High

AI-agent application novelty:
Medium–High

Economic/context-optimization novelty:
Medium–High, but currently unvalidated

Risk of reinventing an existing system:
Medium

Most similar existing approach:
No single equivalent found. The closest conceptual combination is UCON + typestate/behavioral types + DDD aggregates + planning + model-driven engineering + deterministic agent-policy enforcement.

Strongest prior art we should build on:
UCON/usage control, typestate, capability security/proof-carrying authorization, TLA+/formal transition systems, PDDL planning, truth-maintenance/provenance, and model/metamodel co-evolution.

Most defensible differentiator:
A single executable semantic specification that simultaneously determines domain legality, agent affordances, obligations, planning prerequisites, policy enforcement, provenance, dependency impact, and generated runtime artifacts.

Weakest originality claim:
That explicit states, legal transitions, capabilities, obligations, or deterministic agent guards are individually novel.

Most important architecture change suggested by prior art:
Replace the linear EpistemicState concept with a richer separation of provenance, evidence/support, contradiction, and epistemic judgment, probably represented as an evidence/dependency graph or lattice rather than a simple state machine.

⸻

Bottom line

The research changes how I would frame the project.

The interesting idea is not:

“Software should use explicit state machines so AI behaves better.”

Too much of that already exists, and the statement substantially undersells what you are building.

The stronger proposition is:

Probabilistic agents should operate against an executable semantic environment rather than reconstruct software meaning from implementation artifacts.

That environment tells them what the world currently means, what actions are legal, what remains unresolved, why those conclusions hold, and how goals can legally be reached.

The deterministic application runtime and the probabilistic agent then share one semantic authority.

That is where I currently see the real research program.

And it leads directly into the economic hypothesis:

The architecture may convert recurring inference into reusable structure.

If that is true, the value is not merely that the agent makes fewer mistakes. It means semantic modeling becomes a form of precomputed reasoning: pay humans/compiler infrastructure once to make meaning explicit, rather than paying models repeatedly to infer approximately the same meaning on every task.

That claim is not established by prior literature.

It is testable.

And at this stage, it looks more defensible—and potentially more commercially significant—than a claim of primitive architectural novelty.