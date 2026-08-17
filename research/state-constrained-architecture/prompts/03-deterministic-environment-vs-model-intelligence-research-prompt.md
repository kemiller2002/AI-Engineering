AI RESEARCH MISSION 03 — DETERMINISTIC ENVIRONMENTS VS MODEL INTELLIGENCE
================================================================================

ROLE
====

Act as a combined:

- AI-agent systems researcher
- programming-languages researcher
- compiler researcher
- formal-methods researcher
- program-synthesis researcher
- software-verification researcher
- AI inference-cost researcher
- empirical software-engineering researcher

Your task is to investigate whether a stronger deterministic software
environment can reduce how much intelligence, context, and probabilistic
reasoning an AI agent needs.

The central hypothesis is:

    Some work currently performed by large language models can be moved into
    deterministic infrastructure such as:

        compilers
        type systems
        semantic analyzers
        capability derivation
        policy engines
        model checkers
        runtime guards
        generated tests
        dependency graphs
        constraint solvers

If that is true, then:

    smaller/cheaper models operating inside a highly constrained environment

may sometimes achieve equal or better semantic correctness than:

    larger/more expensive models operating inside a permissive environment.

Do NOT assume this hypothesis is true.

Be skeptical.

The goal is to determine:

    what kinds of reasoning can be externalized,
    what cannot,
    what the cost tradeoff is,
    and whether stronger deterministic infrastructure can materially reduce
    total cost per correct agent completion.


======================================================================
1. PRIMARY RESEARCH QUESTION
======================================================================

Does moving software knowledge and legality checks from probabilistic model
reasoning into deterministic infrastructure reduce the model capability
required to complete software tasks correctly?

Measure whether stronger environments reduce:

    input tokens
    output tokens
    reasoning tokens if observable
    model calls
    repository searches
    files read
    failed attempts
    compiler/test repair loops
    semantic defects
    human intervention
    total cost per correct completion


======================================================================
2. CORE COMPARISON
======================================================================

Compare environments along two independent axes.

MODEL CAPABILITY

    small / inexpensive
    medium
    frontier / expensive

ENVIRONMENT STRENGTH

    weak
    conventional
    compiler-guided
    state-constrained
    semantic-compiler-guided


Example matrix:

                        Weak Env    Compiler Env    Semantic Env
    Small Model             A           B              C
    Medium Model            D           E              F
    Frontier Model          G           H              I


The key questions:

    Can C outperform G?

    Can F match I at much lower cost?

    Does H outperform G enough to justify deterministic tooling?

    Where does environment strength stop compensating for weaker models?


======================================================================
3. DEFINE "ENVIRONMENT STRENGTH"
======================================================================

Do not use this term vaguely.

Define explicit levels.


Level 0 — Permissive Repository
-------------------------------

Characteristics:

    mutable domain objects
    broad APIs
    implicit business rules
    conventional tests
    little static enforcement
    agent must infer semantics


Level 1 — Conventional Typed Environment
----------------------------------------

Characteristics:

    static typing
    normal compiler diagnostics
    ordinary unit/integration tests
    enums/classes
    standard module boundaries


Level 2 — Compiler-Constrained Semantic State
---------------------------------------------

Characteristics:

    closed state families
    exhaustive handling
    protected construction
    explicit transitions
    immutable authoritative state
    warnings-as-errors where necessary


Level 3 — State-Constrained Runtime
-----------------------------------

Adds:

    capabilities
    version-bound authority
    evidence
    policy
    obligations
    effect outcomes
    runtime legality checks


Level 4 — Semantic Compiler Environment
---------------------------------------

Adds:

    machine-visible semantic dependencies
    generated impact reports
    semantic migration validation
    generated planning graph
    generated tests
    agent-specific semantic context
    dynamic capability exposure


Level 5 — Verified / Formally Checked Environment
------------------------------------------------

Possible additions:

    model checking
    refinement proofs
    theorem proving
    SMT/constraint solving
    protocol verification

Do not assume higher levels are always economically worthwhile.


======================================================================
4. WHAT DOES THE MODEL CURRENTLY HAVE TO REASON ABOUT?
======================================================================

List the semantic work an AI coding/operational agent often performs.

Examples:

    infer possible states
    infer legal transitions
    infer invariants
    identify authoritative code path
    infer prerequisite relationships
    infer whether a tool is currently legal
    infer whether external retry is safe
    infer which state interpretations need updating
    search for all consequences of a domain change
    infer policy applicability
    infer who has authority
    infer whether evidence is current
    decide which failures are expected
    distinguish unknown outcome from failure


For each category ask:

    Can this be encoded deterministically?

    Can it be partially encoded?

    Must it remain probabilistic?


======================================================================
5. REASONING EXTERNALIZATION MAP
======================================================================

Create a map:

Task / reasoning function
    ->
possible deterministic substitute
    ->
strength of substitution
    ->
remaining model reasoning


Example:

Find every interpretation affected by adding a state
    ->
exhaustive compiler checking + semantic dependency graph
    ->
strong substitution
    ->
model still decides correct semantics for each new case


Another:

Determine whether ShipOrder is legal
    ->
capability derivation/runtime policy engine
    ->
very strong substitution
    ->
model chooses whether shipping is desirable among legal options


Another:

Understand ambiguous product requirement
    ->
no deterministic substitute
    ->
weak substitution
    ->
model/human must reason


======================================================================
6. COMPILER-IN-THE-LOOP RESEARCH
======================================================================

Research current and foundational work on:

    compiler-guided code generation
    compiler-in-the-loop agents
    iterative compilation
    compile-feedback repair
    type-directed code generation
    program synthesis with compiler feedback
    test-guided program repair
    verifier-guided synthesis


Look for empirical measures:

    task success
    compile success
    token use
    iterations
    smaller-model performance
    repair rate
    cost


Central question:

    How much model capability can ordinary compiler feedback replace?


======================================================================
7. STATIC ANALYSIS AS EXTERNAL REASONING
======================================================================

Research:

    linters
    static analyzers
    abstract interpretation
    dataflow analysis
    control-flow analysis
    taint analysis
    exhaustiveness analysis
    ownership analysis
    effect analysis
    dead-code/reachability analysis


Ask:

    Which classes of agent reasoning can static analysis perform more cheaply
    and reliably than an LLM?


======================================================================
8. TYPE SYSTEMS AS SEARCH-SPACE REDUCTION
======================================================================

Investigate whether stronger typing helps AI generation by reducing the valid
program search space.

Compare:

    dynamically typed
    nominally typed
    closed algebraic types
    refinement types
    linear/affine types
    dependent types


Do not assume stronger types always help.

Potential counter-costs:

    harder compiler errors
    more boilerplate
    more repair iterations
    larger generated signatures
    unfamiliar type-level concepts


Ask:

    Is there an optimal level of type-system strength for AI agents?


======================================================================
9. EXHAUSTIVENESS AS DETERMINISTIC MEMORY
======================================================================

Investigate the idea:

    compiler exhaustiveness can function as external memory for the agent.

Example:

PaymentState:

    Authorized
    Captured
    Refunded

Add:

    Disputed

Compiler surfaces every exhaustive interpretation that is now incomplete.

Instead of requiring the model to remember/search for all cases, the compiler
provides a deterministic checklist.

Study:

    whether this reduces repository search
    whether it reduces missed updates
    whether it reduces token usage
    whether it increases repair iterations
    whether agents defeat it with wildcard/default cases


======================================================================
10. SEMANTIC DEPENDENCY GRAPHS
======================================================================

Compare:

Agent approach:

    search repository for things related to Approved

against:

Semantic environment:

    dependency graph says:
        CanFund
        CanShip
        FundingPolicy
        FundingPlan
        ApprovalDisplay

Research analogous systems:

    program slicing
    change-impact analysis
    dependency graphs
    build graphs
    incremental compilation
    traceability systems
    model-driven engineering


Question:

    Can semantic dependency graphs replace a meaningful amount of repository
    exploration?


======================================================================
11. RUNTIME GUARDS AS ERROR PREVENTION
======================================================================

A model may decide on an invalid action.

A strong runtime can reject it deterministically.

Compare:

A. Model must reason correctly before acting.

B. Model proposes action; runtime enforces legality.

Measure:

    invalid actions attempted
    invalid actions executed
    repair cost
    repeated failures
    tokens spent understanding rejection


Ask:

    Does runtime rejection reduce the need for larger models,
    or merely shift cost into retry loops?


======================================================================
12. CAPABILITIES AS DETERMINISTIC LEGALITY
======================================================================

Investigate whether exposing only currently legal capabilities removes
significant reasoning from the model.

The runtime answers:

    MAY this happen?

The model answers:

    SHOULD I choose it?

Measure whether this separation reduces:

    tool-selection complexity
    prompt instructions
    invalid actions
    model size requirements


======================================================================
13. OBLIGATIONS AS DETERMINISTIC WORK DISCOVERY
======================================================================

Open-ended agent:

    "Figure out what needs attention."

Obligation-driven agent:

    O-17 ReconcileRefund
    O-18 RefreshFraudEvidence
    O-19 ResolveConditionalApproval

Research whether explicit obligations can replace model reasoning about:

    what work exists
    what remains unresolved
    what completion means


This may reduce autonomous exploration substantially.


======================================================================
14. DETERMINISTIC PREREQUISITE DISCOVERY
======================================================================

Compare:

Agent reasoning:

    "What must happen before shipping?"

against:

Semantic system:

    Ship blocked:
        PaymentCaptured missing

    Legal producer:
        CapturePayment

Research:

    backward chaining
    planning
    dependency solvers
    build systems
    workflow engines
    rule engines


Question:

    Can prerequisite discovery become a deterministic graph operation rather
    than an LLM reasoning task?


======================================================================
15. GENERATED TESTS AS CHEAP VERIFICATION
======================================================================

Investigate whether generated semantic tests can reduce model validation burden.

Examples:

    every legal transition accepted
    every illegal transition rejected
    every state family handled exhaustively
    agent tool exposure iff runtime capability exists
    obligations have satisfaction paths
    policy changes preserve required paths


Ask:

    Does generated testing reduce the need for the model to reason about
    correctness itself?


======================================================================
16. MODEL CHECKING / FORMAL METHODS
======================================================================

Research stronger deterministic techniques:

    TLA+
    Alloy
    SMT solvers
    model checking
    theorem proving
    refinement types
    dependent types


Compare:

    cost to specify
    cost to run
    learning complexity
    defects found
    model reasoning displaced


Question:

    Is formal verification economically justified only for the semantic core?

This may support:

    small verified/constrained core
        +
    large ordinary implementation shell


======================================================================
17. TRUSTED CORE HYPOTHESIS
======================================================================

Investigate:

    small deterministic trusted semantic core

surrounded by:

    flexible ordinary code
    probabilistic agents


This resembles:

    microkernels
    reference monitors
    safety kernels
    trusted computing bases


Potential principle:

    Put legality into the smallest possible trusted deterministic layer.

Ask whether this architecture minimizes both:

    verification burden

and:

    agent reasoning burden.


======================================================================
18. MODEL INTELLIGENCE VS ENVIRONMENT INFORMATION
======================================================================

Distinguish:

    intelligence

from:

    information availability.

A larger model may perform better because it can reconstruct hidden semantics.

A smaller model may perform equally well if those semantics are made explicit.

Research whether benchmark gains from larger models sometimes reflect better
context reconstruction rather than fundamentally superior planning.


======================================================================
19. SMALLER MODEL SUBSTITUTION
======================================================================

This is a central economic hypothesis.

Compare:

    frontier model + conventional repository

against:

    smaller model + semantic environment


Metrics:

    correctness
    tokens
    model calls
    retries
    latency
    total cost


Define:

    Model Substitution Ratio

Possible formulation:

    cheapest model achieving target semantic correctness
    under each environment


======================================================================
20. MODEL CAPABILITY THRESHOLD
======================================================================

For a fixed task suite, find the minimum model tier that achieves:

    90%
    95%
    99%

semantic correctness.

Compare across environment strengths.

Example:

Environment A:

    requires frontier model for 95%

Environment B:

    medium model reaches 95%

This would be stronger evidence than modest token savings.


======================================================================
21. WHERE DETERMINISM CANNOT SUBSTITUTE
======================================================================

Actively identify tasks that still require strong probabilistic reasoning.

Examples:

    ambiguous requirements
    product design
    architecture tradeoffs
    interpreting incomplete human intent
    novel algorithm design
    debugging unknown root causes
    balancing multiple legal options
    generating explanatory prose
    forming hypotheses
    deciding whether semantic model itself is wrong


The architecture should not pretend to eliminate these.


======================================================================
22. COMMITMENT VS EXPLORATION
======================================================================

Test the principle:

    Exploration should be permissive.
    Commitment should be constrained.


Exploration:

    brainstorm
    search
    infer
    simulate
    propose


Commitment:

    mutate authoritative state
    execute payment
    approve deployment
    establish verified claim
    modify policy


Research whether this boundary maps to existing:

    safety architectures
    reference monitors
    decision support
    human-in-the-loop systems
    sandboxing


======================================================================
23. ERROR ECONOMICS
======================================================================

A stronger environment may produce more immediate failures:

    compiler errors
    analyzer failures
    rejected transitions


This may look inefficient.

But compare with delayed failures:

    production defect
    incorrect payment
    semantic regression
    duplicate external effect


Measure:

    cheap deterministic failure

versus:

    expensive downstream failure


Potential metric:

    Detection Cost per Prevented Semantic Defect


======================================================================
24. REPAIR LOOP ECONOMICS
======================================================================

A concern:

    stronger compilers create more repair loops.

Investigate whether:

    more short deterministic repair loops

are still cheaper than:

    fewer initial errors but more hidden semantic defects.


Record:

    number of loops
    tokens per loop
    semantic defects remaining
    total cost per correct completion


======================================================================
25. ERROR MESSAGE QUALITY
======================================================================

Deterministic feedback only helps if agents can interpret it.

Research:

    compiler diagnostic quality
    structured diagnostics
    machine-readable errors
    code actions
    semantic identifiers


Compare:

    raw compiler text

against:

    structured agent feedback:

        SC300
        Migration incomplete
        CAP-CAN-SHIP unresolved


Hypothesis:

    agent-oriented deterministic diagnostics may amplify the benefit.


======================================================================
26. DIAGNOSTIC COMPRESSION
======================================================================

A compiler may know thousands of facts but only return the relevant violation.

This could function as information compression.

Compare:

    reading 20 source files to discover a rule

versus:

    diagnostic:
        PaymentState.Disputed unhandled in RefundEligibility


Measure tokens saved.


======================================================================
27. SEMANTIC COMPILER AS CONTEXT GENERATOR
======================================================================

The semantic compiler may provide:

    relevant state
    legal transitions
    impacted dependencies
    blocked reasons
    obligations


This means it is not just enforcing correctness.

It may actively generate the minimum context the agent needs.

Investigate whether this creates a compounded benefit:

    deterministic enforcement
        +
    context compression


======================================================================
28. TOOL-CALL REDUCTION
======================================================================

If deterministic systems answer:

    what is legal?
    what is missing?
    what depends on this?
    what must be resolved?

the model may need fewer:

    grep/search calls
    file reads
    database queries
    test runs


Measure total tool calls, not only tokens.


======================================================================
29. HUMAN REVIEW REDUCTION
======================================================================

Investigate whether deterministic guarantees can reduce human review burden.

Example:

Human no longer needs to verify:

    all PaymentState cases were updated

because compiler guarantees it.

Human still reviews:

    whether new business semantics are correct.


Potential benefit:

    shift humans from completeness checking to judgment.


======================================================================
30. SEMANTIC DEFECT SURVIVAL
======================================================================

Measure which errors can survive each environment.

Examples:

Weak environment:

    invalid state
    missing case
    unauthorized action
    stale capability
    duplicate effect


Strong environment:

    may still permit:
        wrong business rule
        wrong semantic specification
        incorrect evidence
        poor optimization choice


Create a defect-survival matrix.


======================================================================
31. SINGLE POINT OF SEMANTIC FAILURE
======================================================================

A serious counterargument:

    if the semantic specification is wrong, generated enforcement,
    tests, tools, and planning may all be consistently wrong.

This creates:

    correlated failure

Investigate mitigation:

    independent validation
    review
    model checking
    differential tests
    executable examples
    provenance
    policy review
    specification mutation testing


======================================================================
32. FALSE CONFIDENCE RISK
======================================================================

Strong deterministic infrastructure may cause agents/humans to assume:

    "If it compiles, it is correct."

Research how to prevent this.

Distinguish:

    structural correctness

from:

    semantic correctness

from:

    product correctness.


======================================================================
33. ENVIRONMENT CONSTRUCTION COST
======================================================================

Include the cost of building:

    semantic models
    analyzers
    code generators
    constraints
    tests
    runtime guards
    policy models


Question:

    At what agent volume / system lifespan does this investment break even?


======================================================================
34. MARGINAL COST CURVE
======================================================================

Hypothesis:

    stronger semantic architecture has higher initial cost
    but lower marginal cost per future agent task.

Model:

    Total Cost(N) =
        EnvironmentConstruction
        +
        N * AverageAgentTaskCost
        +
        DefectCost


Compare environments over:

    N = 10
    100
    1,000
    10,000
    100,000 tasks


======================================================================
35. LONGITUDINAL BENEFIT
======================================================================

The environment may become more valuable over time because:

    semantic knowledge accumulates
    compiler rules remain reusable
    dependency graph improves
    model context remains bounded


Or it may become more expensive because:

    semantic model grows
    rules become complex
    migrations accumulate


Research both possibilities.


======================================================================
36. TASK CLASSES
======================================================================

Test separately:

A. Local implementation task
B. State addition
C. State split
D. Policy change
E. External effect change
F. Cross-module change
G. Bug fix
H. Refactor
I. Product pivot
J. Operational agent task


Environment strength may help some task types much more than others.


======================================================================
37. EXPERIMENT — SAME MODEL, DIFFERENT ENVIRONMENT
======================================================================

Fix model.

Compare:

    weak repository
    compiler-guided repository
    semantic environment


Measure:

    completion rate
    tokens
    tool calls
    repairs
    semantic defects


This isolates environment effect.


======================================================================
38. EXPERIMENT — SAME ENVIRONMENT, DIFFERENT MODEL
======================================================================

Fix environment.

Run:

    small model
    medium model
    frontier model


Measure marginal value of model capability.


======================================================================
39. EXPERIMENT — CROSSOVER POINT
======================================================================

Find where:

    smaller model + strong environment

matches or beats:

    larger model + weak environment.


This crossover is the most economically interesting result.


======================================================================
40. EXPERIMENT — REMOVE ONE DETERMINISTIC FEATURE
======================================================================

Ablate:

    exhaustiveness
    capabilities
    obligations
    semantic dependency graph
    generated tests
    runtime version checks


Measure which features actually contribute.

Do not assume the whole architecture is necessary.


======================================================================
41. EXPERIMENT — ERROR INJECTION
======================================================================

Inject known semantic mistakes.

Examples:

    omit state case
    illegal transition
    stale version
    duplicate external effect
    wrong authority
    unresolved obligation
    state split without dependency redistribution


Measure:

    which environment detects it
    detection latency
    tokens spent
    human effort


======================================================================
42. EXPERIMENT — AMBIGUOUS REQUIREMENT
======================================================================

Provide an intentionally ambiguous feature request.

Question:

    Does deterministic structure help the agent recognize missing semantics?

Or:

    does it simply force the agent to make unsupported decisions in more places?

This is important because constraints cannot manufacture missing product truth.


======================================================================
43. EXPERIMENT — SPECIFICATION BUG
======================================================================

Intentionally put a wrong rule in the semantic specification.

Measure whether:

    agents detect it
    generated tests reinforce it
    humans catch it
    formal checks expose inconsistency


This tests the single-source-of-truth downside.


======================================================================
44. ECONOMIC METRICS
======================================================================

Record:

    input tokens
    output tokens
    cached tokens
    reasoning tokens if available
    model price
    tool calls
    compile/test cycles
    wall-clock time
    human intervention
    semantic correctness


Primary metrics:

    Tokens Per Correct Completion
    Dollars Per Correct Completion
    Tool Calls Per Correct Completion
    Human Minutes Per Correct Completion


======================================================================
45. ENVIRONMENT LEVERAGE RATIO
======================================================================

Propose a metric:

    correctness gain or cost reduction
    ----------------------------------
    incremental environment cost


Or develop a better one.

Goal:

    quantify how much agent performance is purchased by deterministic
    infrastructure.


======================================================================
46. MODEL SUBSTITUTION SAVINGS
======================================================================

If a strong environment allows a cheaper model, calculate:

    cost(frontier, weak)
        -
    cost(smaller, strong)


Include:

    environment amortization
    additional compiler/tool calls
    token differences


======================================================================
47. CACHING
======================================================================

Strong semantic context may be stable and cacheable.

But diagnostics may be dynamic.

Measure:

    stable semantic prefix
    cached token percentage
    dynamic context

Compare cost after caching.


======================================================================
48. COUNTERARGUMENTS
======================================================================

Actively test:

1. Frontier models already reason well enough that constraints provide little
   economic value.

2. Strong environments produce too many repair loops.

3. Semantic compiler construction cost dominates savings.

4. Models struggle with advanced type systems.

5. Environment feedback increases context instead of reducing it.

6. Tests/compiler errors encourage agents to patch symptoms rather than reason.

7. Wrong specifications create correlated failures.

8. Strong constraints reduce useful exploration.

9. Smaller models still cannot understand ambiguous requirements.

10. Context retrieval, not semantic reasoning, dominates cost.

11. Tool latency dominates token cost.

12. Modern prompt caching reduces input-token savings.

13. A simpler analyzer/test approach yields most benefits without a semantic
    compiler.

14. Human review remains necessary, reducing economic gains.

15. The strongest benefits apply only to high-consequence systems.


======================================================================
49. PRIOR ART TO INVESTIGATE
======================================================================

Research:

    compiler-in-the-loop LLMs
    verifier-guided code generation
    program repair
    type-directed synthesis
    proof-guided synthesis
    constraint-guided decoding
    grammar-constrained generation
    formal methods + LLMs
    model checking + LLMs
    static analysis + LLMs
    test-driven agents
    SWE agents with compiler feedback
    small models with external tools
    neuro-symbolic systems
    symbolic reasoning systems
    tool-augmented language models
    reference-monitor architectures
    safety kernels


======================================================================
50. REQUIRED SOURCE QUALITY
======================================================================

Prefer:

    primary research papers
    official benchmark reports
    language/compiler documentation
    formal methods literature
    reproducible experiments


For each important claim:

    identify what is measured
    identify model(s)
    identify task type
    identify whether cost/tokens were measured
    identify whether result generalizes


======================================================================
51. REQUIRED OUTPUT
======================================================================

Produce:

1. Executive verdict
2. Theory of deterministic-environment substitution
3. Reasoning externalization map
4. Compiler-in-the-loop evidence
5. Static-analysis evidence
6. Type-system evidence
7. Runtime-guard evidence
8. Formal-methods evidence
9. Planning/prerequisite evidence
10. Capability/obligation implications
11. Semantic dependency/context implications
12. Smaller-model evidence
13. Model/environment crossover analysis
14. Task-class differences
15. Repair-loop economics
16. Human-review implications
17. Single-source-of-truth risks
18. Counterarguments
19. Experiment design
20. Ablation plan
21. Economic model
22. Break-even analysis
23. What is empirically supported
24. What remains theoretical
25. Architecture changes suggested by evidence
26. Final verdict


======================================================================
52. FINAL VERDICT FORMAT
======================================================================

Answer:

Can deterministic environments improve agent correctness?
    Strong evidence / Moderate evidence / Weak evidence / No evidence

Can they reduce required model capability?
    Strong evidence / Moderate evidence / Weak evidence / No evidence

Can they reduce token usage?
    Strong evidence / Moderate evidence / Weak evidence / No evidence

Can they reduce total cost per correct completion?
    Strong evidence / Moderate evidence / Weak evidence / No evidence

Can a smaller model + strong environment outperform a larger model + weak environment?
    Demonstrated / Plausible / Unclear / Unlikely

Most externalizable reasoning category:
    ...

Least externalizable reasoning category:
    ...

Most valuable deterministic mechanism:
    ...

Biggest economic opportunity:
    ...

Biggest architectural risk:
    ...

Most important missing experiment:
    ...

Likely break-even condition:
    ...


======================================================================
53. RESEARCH STANDARD
======================================================================

Be skeptical.

Do not equate more compiler errors with worse productivity.

Do not equate stronger typing with lower cost without evidence.

Do not assume smaller models can replace larger models universally.

Do not ignore environment construction and maintenance costs.

Do not assume deterministic checks can resolve ambiguous business meaning.

Do not count a constraint as useful merely because it catches an error;
measure whether it improves cost per correct completion.

The central question is:

    How much probabilistic reasoning can be removed from the model and replaced
    with deterministic software structure before additional environment
    complexity costs more than it saves?
