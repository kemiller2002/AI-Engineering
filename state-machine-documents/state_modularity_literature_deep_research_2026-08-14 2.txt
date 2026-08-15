LITERATURE-ONLY DEEP RESEARCH
STATE-CONSTRAINED MODULARITY, SEMANTIC CONTEXT, AND AI AGENT COST
Date: 2026-08-14

SCOPE
=====

This report evaluates the hypothesis described in the supplied research mission without
running new experiments. It relies on published software-engineering, programming-language,
formal-methods, and AI-agent literature. The purpose is to determine which links in the
hypothesis are already supported, which are plausible inferences, which are contradicted or
qualified by existing evidence, and which remain genuinely open.

CENTRAL HYPOTHESIS
==================

The proposed causal chain is:

    explicit ownership of consequential state
        -> stronger semantic module boundaries
        -> more mechanically identifiable dependencies
        -> smaller minimum sufficient agent context
        -> less probabilistic repository exploration
        -> fewer tokens/tool calls/repair loops
        -> lower cost per correct completion

The literature does NOT establish this chain end-to-end.

It does, however, provide substantial evidence for several individual links and identifies
important conditions under which the chain is likely to fail.

======================================================================
1. EXECUTIVE VERDICT
======================================================================

The strongest literature-supported conclusion is:

    STRUCTURED, DETERMINISTIC, TASK-RELEVANT SOFTWARE REPRESENTATIONS
    can make AI coding agents more efficient and more reliable.

This is supported by repository graphs, static dependency analysis, code localization,
program slicing, context compression, constrained decoding, compiler feedback, and recent
agent-context studies.

The literature does NOT yet justify the narrower claim:

    STATE-CONSTRAINED MODULARITY IS ITSELF THE CAUSE OF LOWER AGENT COST.

State ownership is one plausible way of generating high-quality semantic structure.
It may be a particularly useful one because it can encode facts that ordinary code graphs
often do not capture: who owns authority, which transitions are legal, what evidence is
required, which capabilities permit an action, and which obligations remain after an
uncertain effect.

But the strongest alternative hypothesis is serious:

    Much or most of the benefit may be achievable using good static analysis,
    repository indexing, dependency graphs, localization models, and context-management
    systems WITHOUT reorganizing the software around explicit state ownership.

Therefore the research thesis should be narrowed to:

    Does state-derived semantic structure contain materially useful information that
    existing code-level structural retrieval cannot recover cheaply and reliably?

If yes, the architecture has an independent AI-economics argument.
If no, the token/cost benefit belongs mainly to retrieval engineering.

======================================================================
2. CLASSICAL MODULARITY SUPPORTS THE ARCHITECTURAL PREMISE
======================================================================

Parnas's 1972 information-hiding paper argues that decomposition should be based on hiding
design decisions likely to change rather than merely dividing execution steps.

This matters because the proposed semantic-module concept is fundamentally an
information-hiding claim:

    consumers should need the public state/transition contract,
    not the implementation that realizes it.

The classical literature therefore supports:

    strong interface boundaries can reduce the amount of information another component
    must know.

It does NOT establish:

    an LLM will need fewer tokens.

That transfer from human/program verification modularity to LLM context efficiency must
be separately justified.

Related modular verification work strengthens the architectural premise. Separation logic
and compositional verification exist specifically to make reasoning about large systems
local: prove facts about a component using a bounded portion of the system and compose
those facts into global guarantees.

This is conceptually close to Minimum Sufficient Semantic Context.

The analogy is legitimate at the level of information dependency:

    local proof/reasoning is possible when interfaces expose sufficient guarantees.

The analogy becomes speculative when translated into:

    fewer language-model tokens.

======================================================================
3. TYPESTATE AND SESSION-TYPE LITERATURE SUPPORT ACTION-SPACE REDUCTION
======================================================================

Typestate-oriented programming represents objects not only by nominal type but by their
current state, with state-specific operations and transitions.

The key result relevant to this research is not merely "state machines are good."

It is:

    legality can be moved out of informal programmer reasoning and into a machine-checkable
    representation.

Work on typestate and behavioral types shows that programs can be checked for protocol
conformance. Some compositional typestate work explicitly notes that an object's
implementation can be modified independently when its public behavioral interface does
not change.

Session types provide a parallel body of evidence for communication protocols:
legal interaction sequences can be made explicit and type checked.

These literatures strongly support:

    explicit protocols reduce the number of semantically valid actions.

They do NOT establish that an LLM generates fewer tokens or requires less context.

However, recent LLM code-generation work begins to connect these ideas.

Type-constrained code generation (2025) uses type-system information during generation.
It reports more than a 50% reduction in compilation errors and improvements in functional
correctness across synthesis, translation, and repair tasks.

Generative compilation (2026) similarly uses compiler feedback on partial programs and
reports fewer non-compiling outputs and improved functional correctness.

This is strong adjacent evidence for:

    deterministic semantic constraints can remove invalid branches from probabilistic
    generation.

It makes the "action-space reduction" hypothesis considerably stronger than it was if
supported only by classical programming-language theory.

But again, these papers constrain TYPE correctness, not domain transition legality.

======================================================================
4. CAPABILITIES SUPPORT THE AUTHORITY-BOUNDARY IDEA
======================================================================

Object-capability systems encode authority in explicit references/capabilities rather than
allowing ambient access to resources.

Their relevance is structural:

    possession of a capability determines which actions are possible.

This matches the proposed agent architecture in which an agent should receive authority to
request legal transitions rather than arbitrary mutation rights.

Capability literature supports the principle that explicit authority boundaries improve
reasoning about who can affect what.

This has an important implication for AI agents:

    a capability is not merely documentation for the agent;
    it can be an executable restriction on the agent's possible effects.

That can lower risk even if it does not reduce inference tokens.

This distinction matters economically. An architectural mechanism can be valuable because
it makes mistakes impossible or recoverable even if model inference cost is unchanged.

======================================================================
5. THE AI REPOSITORY LITERATURE STRONGLY SUPPORTS SELECTIVE CONTEXT
======================================================================

GraphCoder, DraCo, STALL+, RepoGraph, LocAgent, CodeScout, SeeRepo, and related systems
share a recurring result:

    source-code structure and dependency information improve repository localization
    and/or code generation.

GraphCoder uses control-flow and dependence relations in a code-context graph and reports
improvements over retrieval baselines.

DraCo uses extended data-flow analysis and reports improvements in code exact match and
identifier F1.

STALL+ finds that file-level static dependency information is particularly useful in
repository-level completion and that static analysis and RAG can be complementary.

These findings validate an important premise:

    semantic relevance is not well approximated by physical proximity or lexical
    similarity alone.

This directly supports the proposed move from "files near this file" to
"things consequentially related to this state/transition."

But it also creates the central competing explanation:

    maybe ordinary static/data-flow graphs already provide enough structure.

The state-based architecture must outperform or complement these representations to claim
a unique economic effect.

======================================================================
6. MORE CONTEXT IS NOT BETTER
======================================================================

Several recent results directly challenge the common assumption that expanding context
windows eliminates the need for architectural context selection.

"Context Length Alone Hurts LLM Performance Despite Perfect Retrieval" reports substantial
performance degradation as context grows even when relevant evidence is perfectly
retrieved.

LongCodeBench likewise reports large performance drops in long-context coding tasks.

"The Limits of Long-Context Reasoning in Automated Bug Fixing" reports that successful
agent trajectories are often relatively short, while long single-shot contexts perform
poorly even when relevant files are deliberately included.

The implication is strong:

    nominal context-window capacity is not equivalent to usable reasoning capacity.

Therefore an architecture that enables reliable context exclusion can have a correctness
benefit, not merely an input-price benefit.

This validates the focus on Minimum Sufficient Semantic Context rather than maximum context.

======================================================================
7. A STRONGER RESULT: MUCH OF THE SURROUNDING SOURCE MAY BE UNNECESSARY
======================================================================

"What Context Does a Coding Agent Actually Need to Act?" (2026) is particularly relevant.

The study separates localization from action. With the edit location fixed, it varies how
much surrounding code is supplied.

Its results suggest:

    the source being edited contains much of the actionable signal;
    surrounding context often contributes less than expected;
    compressed context can match whole-file performance at a fraction of the token volume.

The paper also reports that natural-language summaries of edited code are poor substitutes
for source code.

This produces two important conclusions for the state-modularity thesis.

POSITIVE:

    Once the correct semantic/implementation location is known, the agent may need very
    little unrelated implementation.

NEGATIVE:

    semantic summaries alone may not be sufficient to replace the actual implementation
    being changed.

Therefore the architecture should probably aim for:

    compact semantic contract
        +
    actual source for the target implementation

rather than attempting to replace source entirely with semantic IR.

======================================================================
8. STRUCTURE CAN REDUCE COST — BUT CAN ALSO INCREASE IT
======================================================================

SeeRepo (2026) provides direct evidence that structural repository representations can
reduce interaction cost while maintaining or improving resolution accuracy in several
configurations.

This supports the context-compression theory.

However, RepoGraph and deterministic-anchoring work reveal the opposite possibility.

RepoGraph sometimes adds graph context and improves correctness while increasing tokens.

"How Much Static Structure Do Code Agents Need?" reports that lightweight structural
annotations can improve localization, shorten trajectories, and reduce run-to-run
variance while increasing input tokens by roughly 10%.

This is a crucial correction to the original economic model.

The relevant quantity is not:

    tokens in initial prompt

It is:

    total cost required to reach a correct result.

A small amount of extra deterministic context can be economically beneficial if it prevents
multiple rounds of uncertain exploration.

Thus:

    minimal context != optimal context.

The better target is:

    MINIMUM EXPECTED COST CONTEXT

or:

    MINIMUM SUFFICIENT EXECUTION CONTEXT

where context is justified if its expected reduction in exploration/failure exceeds its
token cost.

======================================================================
9. AGENT COST APPEARS TO BE DOMINATED BY EXPLORATION WASTE
======================================================================

"How Do AI Agents Spend Your Money?" (2026) analyzes trajectories from eight frontier
models on SWE-bench Verified.

Its findings are highly relevant:

    agentic coding tasks consume vastly more tokens than ordinary code chat/reasoning;
    input tokens dominate;
    token consumption is highly stochastic;
    identical task types can vary enormously in total consumption;
    spending more tokens does not reliably produce higher accuracy.

The paper reports variation of up to roughly 30x in total tokens across runs on the same
task.

This implies that the research should focus less narrowly on static context compression.

The larger opportunity may be:

    reducing uncertainty in the trajectory.

Explicit state/module semantics could contribute by telling the agent:

    where authority lives
    which transitions exist
    which dependencies matter
    which actions are illegal
    what evidence remains missing

If those facts prevent search and failed edits, the economic gain can be much larger than
the token size of the semantic contract itself.

AgentDiet provides further support for this view. It reduces redundant trajectory context
and reports approximately 39.9%-59.7% lower input-token consumption and 21.1%-35.9% lower
total computational cost while maintaining performance in its tested settings.

The lesson is:

    trajectory management is already a proven cost lever.

State architecture must demonstrate that it reduces trajectory entropy, not merely prompt
length.

======================================================================
10. REPOSITORY INSTRUCTION FILES ARE COUNTEREVIDENCE TO "MORE EXPLICIT = BETTER"
======================================================================

"Evaluating AGENTS.md" (2026) reports that repository-level context files can increase
agent exploration, testing, reasoning, and total cost by more than 20% without showing the
simple benefit their advocates might expect.

This is highly relevant.

It falsifies the naive version of the hypothesis:

    writing down more architectural knowledge makes agents cheaper.

Why might explicit context hurt?

    it consumes tokens;
    it adds candidate facts to reason about;
    it can make agents over-explore;
    it may be redundant with source;
    it may be stale or overly general;
    it may apply repository-wide when the task is local.

Therefore semantic state information should not become another AGENTS.md.

The strongest implementation would make it:

    generated
    task sliced
    authoritative
    executable/checkable
    compact

The distinction is between PASSIVE DOCUMENTATION and ACTIVE SEMANTIC STRUCTURE.

======================================================================
11. EXECUTABLE CONSTRAINTS ARE MORE PROMISING THAN PROSE
======================================================================

Recent work such as ContextCov converts natural-language agent instructions into executable
checks enforced through AST analysis, runtime command interception, and architectural
validators.

This aligns closely with the proposed direction.

The economic implication is important:

    a rule checked by the environment does not have to be perfectly remembered and
    probabilistically obeyed by the model.

This creates a possible context-elimination mechanism.

Suppose a repository has 100 architectural restrictions.

PASSIVE approach:
    put all 100 restrictions in the prompt.

EXECUTABLE approach:
    enforce all 100 mechanically;
    tell the agent only the restrictions relevant to the current failed/proposed action.

The second architecture could reduce both prompt size and cognitive branching.

This is one of the strongest literature-supported paths from architecture to token
reduction.

======================================================================
12. FORMAL METHODS PROVIDE THE DEEPEST THEORETICAL SUPPORT
======================================================================

Separation logic, behavioral contracts, assume-guarantee reasoning, and compositional
verification all address a fundamental scaling problem:

    proving the whole system at once is intractable.

Their solution is to expose sufficient contracts at boundaries so components can be
reasoned about locally.

This is almost exactly the desired semantic property for AI context slicing.

The theoretical parallel is:

FORMAL VERIFICATION:
    replace global implementation knowledge with local assumptions/guarantees.

PROPOSED AGENT ARCHITECTURE:
    replace global repository knowledge with local semantic contracts and implementation.

The literature therefore strongly supports the POSSIBILITY of local semantic sufficiency.

But an LLM differs from a theorem prover.

A theorem prover can trust a formally proved interface.
An LLM may still inspect hidden implementation because it is uncertain, because tests fail,
or because the task requires non-contractual properties such as style, performance, or
historical conventions.

Therefore state contracts can reduce semantic context only for the properties they actually
capture.

======================================================================
13. THE BIGGEST ASSUMPTION: DOMAIN STATE IS THE RIGHT PARTITION
======================================================================

This is not established.

A repository has multiple overlapping dependency structures:

    call dependencies
    type dependencies
    data-flow dependencies
    build dependencies
    configuration dependencies
    persistence dependencies
    deployment dependencies
    security dependencies
    domain-state dependencies
    temporal/protocol dependencies
    organizational conventions

A state-derived module graph captures only some of these.

For domain-heavy transactional software, state authority may correspond closely to
consequential behavior.

For:

    numerical software
    compilers
    rendering engines
    machine-learning pipelines
    transformation libraries
    infrastructure code

state ownership may be a weak organizing principle.

Therefore the architecture should not claim universal applicability.

A more defensible theory is:

    State ownership is a high-value semantic partition for software in which correctness
    is substantially determined by lifecycle, workflow, authorization, obligations, and
    domain transitions.

This includes much enterprise software.

It does not include all software.

======================================================================
14. CROSS-MODULE POLICY MAY RECREATE GLOBAL COUPLING
======================================================================

The architecture assumes that module-local state ownership creates localization.

But business rules often depend on conjunctions:

    ship if customer verified
        AND order approved
        AND payment captured
        AND risk accepted
        AND inventory allocated.

The state may be separately owned, but the policy is inherently cross-module.

If many important transitions depend on many foreign claims, the semantic dependency graph
becomes dense.

Then the architecture has moved coupling from:

    implementation coupling

to:

    policy/contract coupling.

That may still be an improvement because the coupling is explicit and compact.

But it does not eliminate coupling.

This is where the hypothesis must be carefully worded:

    state-constrained modularity may COMPRESS coupling rather than remove it.

That is a stronger and more realistic claim.

======================================================================
15. STATE EXPLOSION IS A REAL RISK
======================================================================

Formal state-based methods have long faced state-space growth problems.

Compositional verification, abstraction, and behavioral types exist partly because global
state products become difficult to reason about.

If each domain concern becomes another orthogonal state family and cross-product conditions
are materialized explicitly, the semantic model can become larger than the source-level
logic it replaces.

The architecture therefore needs:

    orthogonal state families
    hierarchical states where appropriate
    derived claims instead of cross-product states
    compositional contracts
    localized policy
    lazy dependency expansion

A monolithic state machine would likely destroy the context advantage.

The research thesis should be about:

    state ownership + compositional semantic contracts

not:

    one giant state machine.

======================================================================
16. EVENT SOURCING IS A USEFUL WARNING
======================================================================

Event sourcing is not the same architecture, but its empirical literature is informative
because it makes state change unusually explicit.

An empirical characterization based on 19 event-sourced systems and 25 engineers identifies
real challenges:

    event/schema evolution
    steep learning curve
    tooling limitations
    projection rebuilding
    privacy concerns

This challenges the idea that explicit state history is free.

Any break-even analysis for state-constrained software must include:

    modeling cost
    migration cost
    tooling
    schema evolution
    training
    governance

The architecture can be economically superior for agents while still being economically
inferior overall if these costs are high.

======================================================================
17. STRONG LANGUAGES MAY MATTER, BUT NOT FOR THE SIMPLE REASON ASSUMED
======================================================================

STALL+ observes that static-analysis integration behaves differently in Java and Python
because static dependencies are easier to recover in statically structured languages.

This supports the idea that language choice changes how cheaply repository semantics can
be extracted.

Type-constrained generation and generative compilation further show that richer compiler
semantics can directly constrain AI generation.

The important mechanism is not:

    weak languages are bad.

It is:

    recoverable semantics reduce uncertainty.

A dynamic language can compensate using:

    schemas
    runtime contracts
    generated metadata
    tests
    architectural validators
    explicit semantic IR.

A strongly typed language can still have poor architectural boundaries and enormous
implicit domain coupling.

Therefore:

    language semantics and architecture are separate axes.

The strongest system likely combines both.

======================================================================
18. SMALLER-MODEL SUBSTITUTION IS PLAUSIBLE BUT NOT VALIDATED FOR THIS ARCHITECTURE
======================================================================

CodeScout (2026) reports that specialized small localization models can outperform much
larger general models on some repository-localization measures.

This provides evidence for a broader principle:

    better representation/task specialization can compensate for model size.

It does not prove that a state-constrained module will let a cheap coding model replace a
frontier coding model end-to-end.

Still, this remains one of the most economically important hypotheses.

Why?

Reducing context on the same expensive model creates linear token savings.

Moving a task from a frontier model to a much cheaper model can create a multiplicative
cost change.

The literature supports pursuing this hypothesis, but not claiming it yet.

======================================================================
19. LONGITUDINAL MAINTAINABILITY REMAINS OPEN
======================================================================

SWE-CI (2026) evaluates coding agents across long-term repository evolution and reports that
state-of-the-art models still struggle to sustain code quality over extended change
sequences.

This validates the concern that one-shot SWE-bench success is not enough.

It does NOT show that state ownership prevents architectural erosion.

Classical modularity theory suggests it might.

The AI-agent literature has not yet established it.

Therefore the longitudinal hypothesis remains genuinely open:

    explicit state ownership may make architectural erosion easier to detect and prevent
    because illegal cross-boundary mutations can be mechanically rejected.

That is plausible but unsourced as an empirical outcome.

======================================================================
20. REVISED CAUSAL MODEL
======================================================================

The original causal model should be revised.

ORIGINAL:
    state architecture -> smaller context -> cheaper agents

BETTER:
    executable semantic structure
        ->
    deterministic localization + explicit authority + constrained actions
        ->
    less probabilistic exploration + fewer illegal attempts
        ->
    smaller effective trajectory
        ->
    lower expected cost per correct completion

State ownership is one mechanism for producing executable semantic structure.

This revised formulation is better supported by the literature.

======================================================================
21. HYPOTHESIS ASSESSMENT
======================================================================

H1:
"Explicit state ownership improves modularity."

Assessment:
    MODERATELY SUPPORTED BY ADJACENT THEORY.

Information hiding, typestate, behavioral interfaces, capabilities, separation logic, and
compositional verification support the mechanisms.

No literature located directly compares state-owned commercial architecture against
equivalent conventional architecture on standard modularity metrics.

H2:
"Explicit semantic boundaries reduce required agent context."

Assessment:
    STRONGLY PLAUSIBLE, INDIRECTLY SUPPORTED.

Repository-structure, dependency-retrieval, and context-minimization research strongly
supports selective structure.

The unique value of state-derived structure is unproven.

H3:
"Smaller context improves agent correctness."

Assessment:
    SUPPORTED WITH IMPORTANT QUALIFICATIONS.

Long-context research shows that more context can hurt.
But too little context also fails.
Correctly selected context is the important variable.

H4:
"Explicit constraints reduce agent errors."

Assessment:
    STRONGLY SUPPORTED IN ADJACENT LLM LITERATURE.

Type-constrained generation, compiler-guided generation, formal verification, and executable
guardrails all support this.

Domain-state transition constraints specifically remain untested.

H5:
"State-constrained architecture lowers token consumption."

Assessment:
    UNPROVEN.

There is strong evidence that better localization and trajectory compression can lower
tokens.

There is also evidence that structural metadata can INCREASE tokens.

The architecture must reduce trajectory cost, not merely add semantics.

H6:
"State-constrained architecture lowers total cost per correct task."

Assessment:
    PLAUSIBLE BUT UNPROVEN.

Agent-cost literature shows large waste and variance, so there is room for improvement.

Architecture-specific savings have not been measured.

H7:
"State-constrained architecture enables smaller models."

Assessment:
    PLAUSIBLE, HIGH-VALUE, UNPROVEN.

Specialized localization models provide adjacent support.

H8:
"State ownership prevents AI-induced architectural decay."

Assessment:
    THEORETICALLY PLAUSIBLE, EMPIRICALLY OPEN.

======================================================================
22. WHAT WOULD MOST DAMAGE THE THESIS, BASED ON EXISTING LITERATURE?
======================================================================

The thesis becomes weak if any of these are generally true:

1. STATIC ANALYSIS ALREADY RECOVERS THE SAME DEPENDENCIES.

   Then state architecture adds implementation cost without creating unique agent context.

2. DOMAIN POLICY FAN-OUT IS DENSE.

   Then semantic slices approach repository-wide context.

3. CONTRACTS BECOME PASSIVE DOCUMENTATION.

   AGENTS.md-style evidence suggests they can increase cost rather than reduce it.

4. THE AGENT STILL NEEDS HIDDEN IMPLEMENTATION.

   Compact interfaces cannot replace code when behavior depends on performance,
   side effects, conventions, or implementation-specific bugs.

5. STATE MODELING CREATES MORE SEMANTIC SURFACE THAN IT HIDES.

   State explosion and duplicated metadata can erase context savings.

6. MODEL COST FALLS FASTER THAN MIGRATION COST.

   Pure token savings can become economically irrelevant.

7. TOOL/TEST COST DOMINATES INFERENCE.

   Then token optimization is not the primary economic lever.

8. MOST TASKS ARE CROSS-CUTTING.

   Local semantic ownership then provides little task-level isolation.

======================================================================
23. WHAT WOULD MAKE THE THESIS STRONGER WITHOUT NEW EXPERIMENTS?
======================================================================

The literature already suggests several architectural refinements.

A. DO NOT SEND ALL SEMANTICS TO THE MODEL.

Store rich semantics mechanically; project only task-relevant facts.

B. MAKE SEMANTICS EXECUTABLE.

Prefer compiler/type/validator enforcement over prose instructions.

C. SEPARATE AUTHORITY FROM KNOWLEDGE.

The agent should not need to read every rule to be prevented from violating it.

D. DISTINGUISH LOCAL CONTRACT FROM IMPLEMENTATION.

Give the agent:
    compact contract for neighbors
    full implementation for the target

E. USE LAZY EXPANSION.

Long-context literature strongly supports short focused reasoning steps over large static
contexts.

F. TREAT STRUCTURE AS A LOCALIZATION INDEX.

The semantic graph should first answer:
    "where must I look?"

not:
    "here is everything the system knows."

G. OPTIMIZE EXPECTED TRAJECTORY COST, NOT INITIAL PROMPT TOKENS.

A 500-token contract that prevents a 20,000-token exploration loop is a win.

======================================================================
24. THE MOST IMPORTANT SYNTHESIS
======================================================================

The most defensible novel idea is not:

    state machines compress code.

It is:

    EXPLICIT SEMANTIC AUTHORITY CAN TURN SOME REPOSITORY DISCOVERY FROM
    PROBABILISTIC SEARCH INTO DETERMINISTIC GRAPH TRAVERSAL.

That is important.

Today an agent may ask:

    Where is payment status actually controlled?
    Can this field be changed here?
    What else assumes Captured?
    What happens after a timeout?
    Which module has authority?
    What recovery action remains legal?

In conventional software those answers may require:

    grep
    call tracing
    database inspection
    test reading
    historical inference
    repeated tool calls

In a sufficiently explicit architecture those could become indexed facts:

    Payment owns PaymentLifecycle
    Captured -> PartiallyRefunded is legal through RefundPartial
    RefundPartial requires RefundCapability
    RefundPartial emits PaymentRefunded
    ShipmentPolicy observes PaymentClaim
    Timeout -> OutcomeUnknown
    OutcomeUnknown creates ReconcileRefund obligation

If those facts are authoritative and generated from executable semantics, they can replace
some probabilistic repository exploration.

That is the literature-supported bridge between software architecture and inference
economics.

======================================================================
25. FINAL LITERATURE-ONLY VERDICT
======================================================================

The research hypothesis survives serious challenge, but in a narrower and stronger form.

SUPPORTED:
    selective context is beneficial;
    long context can hurt;
    repository structure improves localization;
    deterministic anchors reduce exploration variance;
    executable constraints reduce invalid generation;
    agent trajectories contain substantial token waste;
    local/compositional reasoning is a well-established software-design principle.

NOT SUPPORTED:
    state machines automatically reduce tokens;
    state ownership is uniquely better than static dependency graphs;
    semantic modules necessarily reduce total context;
    stronger typing alone solves agent cost;
    smaller modules automatically mean smaller semantic context;
    architectural explicitness by itself lowers cost.

PLAUSIBLE AND IMPORTANT:
    explicit state ownership may encode domain-level dependencies that code graphs cannot
    cheaply infer;
    capabilities and transition interfaces may reduce action-space entropy;
    obligations may reduce ambiguity after uncertain effects;
    task-specific semantic projections may replace large amounts of exploratory context;
    these mechanisms may allow smaller models or fewer repair loops.

MAJOR RISK:
    semantic contracts become another verbose documentation layer.

BEST REVISED CLAIM:

    State-constrained modular architecture may reduce AI-agent execution cost when it
    converts consequential domain dependencies, authority, and legal actions from
    information the model must probabilistically discover into compact,
    machine-generated, mechanically enforceable structure.

That claim is consistent with the current literature.

The still-unvalidated portion is whether state ownership supplies enough UNIQUE semantic
information beyond modern code graphs and static analysis to justify its additional
engineering cost.

That is the real boundary between an interesting architecture and an economically
important one.

======================================================================
PRIMARY / HIGH-VALUE LITERATURE CONSULTED
======================================================================

CLASSICAL SOFTWARE / PROGRAMMING LANGUAGES

- D. L. Parnas (1972), "On the Criteria To Be Used in Decomposing Systems into Modules,"
  Communications of the ACM.
- O'Hearn / Reynolds / separation-logic literature on local reasoning.
- Typestate-Oriented Programming (Aldrich et al., 2009).
- Deadlock-Free Typestate-Oriented Programming (Padovani, 2018).
- Multiparty session-type / communicating-automata literature.
- Object-capability security literature.
- Behavioral contracts and modular verification literature.

AI SOFTWARE ENGINEERING / CONTEXT

- GraphCoder (2024).
- DraCo: Dataflow-Guided Retrieval Augmentation for Repository-Level Code Completion (2024).
- STALL+: Static Analysis for Repository-Level Code Completion (2024).
- Agentless: Demystifying LLM-Based Software Engineering Agents (2024).
- RepoGraph (2024/2025).
- Context Length Alone Hurts LLM Performance Despite Perfect Retrieval (2025).
- LongCodeBench (2025).
- AgentDiet / Reducing Cost of LLM Agents with Trajectory Reduction (2025/2026).
- Evaluating AGENTS.md (2026).
- LLM Agents Can See Code Repositories / SeeRepo (2026).
- How Do AI Agents Spend Your Money? (2026).
- The Limits of Long-Context Reasoning in Automated Bug Fixing (2026).
- What Context Does a Coding Agent Actually Need to Act? (2026).
- How Much Static Structure Do Code Agents Need? (2026).
- Code Isn't Memory: A Structural Codebase Index Inside a Coding Agent (2026).
- CodeScout (2026).
- SWE-CI (2026).
- SWE-ContextBench (2026).

CONSTRAINT / VERIFICATION

- Type-Constrained Code Generation with Language Models (2025).
- Generative Compilation: On-the-Fly Compiler Feedback as AI Generates Code (2026).
- ContextCov: Executable Constraints from Agent Instructions (2026).
- Lean4Agent (2026).

ARCHITECTURAL COUNTEREVIDENCE / COST

- Empirical characterization of event-sourced systems and schema evolution (2021).
- Repository instruction/context-file studies showing additional context can increase cost.

EVIDENCE QUALITY NOTE
=====================

The classical programming-language and software-modularity sources include peer-reviewed
ACM/PL literature. A significant portion of the fast-moving 2025-2026 AI-agent evidence is
available as arXiv/preprint work and should not be treated as equivalent in evidentiary
weight to mature peer-reviewed literature. The convergence of results across independent
papers is informative, but architecture-specific causal claims still require caution.
