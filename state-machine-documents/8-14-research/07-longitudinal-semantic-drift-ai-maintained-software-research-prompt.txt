AI RESEARCH MISSION 07 — LONGITUDINAL SEMANTIC DRIFT IN AI-MAINTAINED SOFTWARE
=================================================================================

ROLE
====

Act as a combined:

- AI-agent systems researcher
- software-maintenance researcher
- software-architecture researcher
- technical-debt researcher
- program-comprehension researcher
- software-evolution researcher
- formal-methods researcher
- empirical software-engineering researcher
- AI inference-cost researcher

Your task is to investigate whether AI-maintained software is especially
vulnerable to longitudinal semantic drift, and whether explicit semantic
authority can reduce that drift over repeated changes.

Do not assume the hypothesis is true.

Be skeptical and evidence-driven.

The central hypothesis is:

    AI agents may amplify accidental implementation assumptions because later
    agents often cannot reliably distinguish:

        intentional domain semantics
        historical implementation accidents
        temporary workarounds
        stale tests
        copied assumptions
        incidental database structure
        prior AI guesses

As these artifacts survive, later agents may interpret them as authoritative
truth.

This may create a compounding process:

    ambiguous requirement
        ->
    plausible implementation assumption
        ->
    persisted code/test/schema
        ->
    later agent treats artifact as truth
        ->
    new dependent implementation
        ->
    assumption becomes harder to distinguish and remove

The proposed architecture attempts to interrupt this process by preserving
semantic authority outside incidental implementation.

Potential mechanisms:

    explicit state ownership
    explicit legal transitions
    semantic contracts
    provenance
    epistemic state
    semantic dependency closure
    explicit migrations
    exhaustive interpretation
    versioned policy
    generated impact analysis
    protected authoritative state
    obligations for unresolved semantic work


======================================================================
1. PRIMARY RESEARCH QUESTION
======================================================================

Does repeated AI-driven maintenance cause software semantics to drift away from
original or intended business meaning more quickly than conventional human-led
maintenance?

If so:

    What mechanisms cause the drift?

    Is the effect actually stronger for AI agents?

    How can it be measured?

    Can explicit semantic structure reduce it?

    Does reduced drift also reduce long-term token/context cost?


======================================================================
2. DEFINE SEMANTIC DRIFT
======================================================================

Develop a precise definition.

Candidate:

    Semantic drift is the accumulation of system behavior, rules, assumptions,
    dependencies, or representations that diverge from currently intended
    domain meaning without an explicit, reviewed semantic decision.

Examples:

    old temporary status becomes permanent business rule
    duplicated validation logic diverges
    workaround becomes API contract
    test encodes outdated interpretation
    database column meaning changes informally
    AI introduces fallback behavior that later code depends on
    obsolete product assumption survives after pivot


Distinguish semantic drift from:

    ordinary code churn
    architecture drift
    technical debt
    defect accumulation
    requirements change
    intentional evolution


======================================================================
3. INTENTIONAL CHANGE VS DRIFT
======================================================================

A system changing meaning is not automatically drifting.

Example:

    business intentionally changes refund policy

is:

    semantic evolution

not:

    semantic drift


Drift occurs when change becomes embedded without explicit semantic decision or
without corresponding dependency updates.

Develop criteria for distinguishing:

    intended evolution
    accidental reinterpretation
    stale dependency
    implementation artifact


======================================================================
4. AI-SPECIFIC MECHANISM
======================================================================

Investigate whether AI agents create a distinctive risk because they infer
intent from artifacts.

Possible process:

    Agent sees code
        ->
    code appears internally consistent
        ->
    agent assumes behavior is intentional
        ->
    agent preserves or extends it


Humans may also do this.

Question:

    Is this actually an AI-specific effect,
    or simply normal software archaeology accelerated by automation?

Do not overclaim.


======================================================================
5. ARTIFACT AUTHORITY CONFUSION
======================================================================

Potential agent mistake:

    "This test exists, therefore this is the business rule."

But test may represent:

    obsolete behavior
    accidental implementation
    bug regression
    temporary workaround


Likewise:

    database field
    endpoint
    comment
    enum
    branch
    prompt
    migration


may be treated as semantic authority.

Research program-comprehension literature around:

    intent inference
    maintenance assumptions
    code archaeology
    design rationale loss


======================================================================
6. DESIGN RATIONALE LOSS
======================================================================

Research established work on loss of:

    rationale
    architecture decisions
    requirement traceability
    design intent


Ask whether AI agents worsen this because they consume artifacts without
institutional memory.

Potential solution:

    machine-visible provenance and semantic decision records


======================================================================
7. KNOWLEDGE DEGRADATION
======================================================================

Study how domain knowledge degrades as:

    original developers leave
    documentation becomes stale
    tests diverge
    architecture evolves
    business rules duplicate


Compare human-maintained systems with AI-maintained systems.


======================================================================
8. REQUIREMENTS TRACEABILITY
======================================================================

Research:

    requirements traceability
    architecture traceability
    change-impact analysis
    traceability matrices
    model-driven trace links


Question:

    Does semantic dependency closure solve an old traceability problem in a
    more operational form?


======================================================================
9. ARCHITECTURE EROSION
======================================================================

Research:

    architectural drift
    architectural erosion
    software decay
    dependency violations
    layering erosion
    modularity degradation


Separate:

    structural erosion

from:

    semantic erosion


A system may preserve package boundaries while its business meaning drifts.


======================================================================
10. TECHNICAL DEBT
======================================================================

Compare semantic drift with:

    technical debt
    design debt
    requirements debt
    architectural debt
    knowledge debt
    documentation debt


Ask whether:

    semantic debt

or:

    assumption debt

is a useful distinct concept.


======================================================================
11. ASSUMPTION DEBT
======================================================================

Candidate definition:

    Assumption Debt is consequential system behavior that depends on
    propositions whose status, rationale, provenance, or authority is not
    explicit enough to determine whether they remain valid.


Examples:

    "This customer type can never refund"
    "This field is always populated"
    "This state cannot occur after shipment"
    "This service is authoritative"


Research whether similar terminology already exists.


======================================================================
12. SEMANTIC DEBT
======================================================================

Potential definition:

    Semantic Debt is the future cost created when consequential domain meaning
    is encoded implicitly, ambiguously, redundantly, or inconsistently.

Measure:

    number of implicit assumptions
    duplicated business rules
    untraceable policy decisions
    stale semantic dependencies
    ambiguous state meanings


Challenge whether this is truly distinct from existing debt categories.


======================================================================
13. LONGITUDINAL AGENT BENCHMARKS
======================================================================

Research current benchmarks that test:

    repeated repository modification
    multi-step maintenance
    long-horizon coding agents
    sequential issue resolution
    repository evolution
    agent-generated code over time


Do not focus only on one-shot SWE-bench-style tasks.

Look for systems like:

    SWE-EVO
    longitudinal coding benchmarks
    repository evolution benchmarks
    continuous software engineering agents


Identify whether semantic drift is currently measured.


======================================================================
14. ONE-SHOT BENCHMARK LIMITATION
======================================================================

Most coding benchmarks evaluate:

    task at T
        ->
    correct patch


But real maintenance is:

    T1 patch
        ->
    T2 patch depends on T1
        ->
    T3 agent interprets T1+T2
        ->
    ...
        ->
    T50


Investigate why one-shot benchmarks may hide compounding semantic error.


======================================================================
15. ERROR COMPOUNDING
======================================================================

Develop a model.

Suppose each change has probability:

    p = introducing a latent semantic assumption

and probability:

    q = later changes depending on that assumption


Over many tasks:

    hidden semantic dependency count may grow nonlinearly.


Do not invent a mathematical law without evidence.

Develop candidate models and testable predictions.


======================================================================
16. PATH DEPENDENCE
======================================================================

Software evolution is path-dependent.

Later architecture depends on earlier decisions.

AI may increase path dependence if:

    it optimizes locally
    it copies existing patterns
    it treats precedent as intent


Research:

    path dependence in software engineering
    architectural lock-in
    design inertia


======================================================================
17. COPY-PATTERN AMPLIFICATION
======================================================================

AI coding agents often imitate repository patterns.

That is useful.

But if pattern is wrong:

    wrong pattern may propagate faster.


Research:

    in-context pattern copying
    code completion behavior
    repository style imitation
    defect propagation


Question:

    Does AI accelerate both good architecture and bad architecture?


======================================================================
18. FALSE CONSENSUS FROM REPETITION
======================================================================

If five modules contain same assumption, later agent may infer:

    "This must be intentional."


But all five may descend from:

    one accidental implementation.


This parallels evidence-lineage issues.

Provenance could expose:

    all five derive from same semantic decision or same copied artifact.


======================================================================
19. TEST ENTRENCHMENT
======================================================================

Tests can preserve bugs or obsolete semantics.

Agent sees failing test after changing behavior and may:

    restore stale behavior

rather than:

    update obsolete test


Research test maintenance and test-code co-evolution.


======================================================================
20. GENERATED TEST ADVANTAGE
======================================================================

If tests are generated from semantic specification:

    semantics change
        ->
    generated tests change


This may reduce stale-test authority.

But it creates:

    specification single-point-of-failure risk


Study both.


======================================================================
21. DATABASE SEMANTIC DRIFT
======================================================================

Database schemas often preserve historical assumptions.

Examples:

    nullable status field
    magic values
    overloaded columns
    derived flags
    denormalized state


Agents may infer semantics from schema.

Research:

    schema evolution
    data semantics
    legacy-system archaeology


======================================================================
22. API CONTRACT ENTRENCHMENT
======================================================================

Temporary API behavior may become external contract.

Example:

    undocumented null
    fallback
    error code
    ordering


Once clients depend on it:

    implementation accident becomes semantic reality.


Research Hyrum's Law and API evolution.


======================================================================
23. Hyrum's Law
======================================================================

Investigate the relevance of:

    "With a sufficient number of users of an API, every observable behavior
    will be depended on by somebody."


Question:

    Do AI agents effectively become another class of API consumer that can
    accidentally stabilize incidental behavior?


======================================================================
24. PROMPT / AGENT INSTRUCTION DRIFT
======================================================================

Semantic behavior may be distributed across:

    code
    system prompts
    tool descriptions
    agent instructions
    runbooks


These can drift separately.

Research whether semantic compilation could reduce this fragmentation.


======================================================================
25. DOCUMENTATION DRIFT
======================================================================

AI-generated documentation may create additional authority artifacts.

Potential cycle:

    code assumption
        ->
    AI writes documentation
        ->
    later agent reads documentation
        ->
    assumption gains perceived legitimacy


Study this risk.


======================================================================
26. GENERATED SUMMARY DRIFT
======================================================================

Repository summaries are attractive for context compression.

But summaries may become stale.

Hypothesis:

    compiler-generated semantic summaries are safer than AI-written summaries
    because they derive from current authoritative semantics.


Research this distinction.


======================================================================
27. SEMANTIC AUTHORITY
======================================================================

Proposed architectural rule:

    consequential meaning should have an explicit authority source.


Examples:

    state definitions
    transition declarations
    policy rules
    evidence requirements
    semantic IDs
    migration decisions


Implementation artifacts should not silently redefine these.


======================================================================
28. TRUSTED SPECIFICATION VS IMPLEMENTATION
======================================================================

Potential hierarchy:

Tier 1:
    semantic specification

Tier 2:
    generated/trusted enforcement

Tier 3:
    application implementation

Tier 4:
    probabilistic agent output


Ask whether this hierarchy prevents reverse inference:

    implementation accident -> domain truth


======================================================================
29. SEMANTIC IDS
======================================================================

Stable semantic identifiers may distinguish:

    rename

from:

    replacement

from:

    state split

from:

    state merge


Example:

    SC-APPROVED

renamed label:

    Fully Approved

vs:

    semantic split into new identities


Research model/version identity systems.


======================================================================
30. SEMANTIC MIGRATION
======================================================================

Current proposed rule:

    a state split invalidates every dependent consequential interpretation
    until explicitly redistributed.


Example:

    Approved
        ->
    ConditionallyApproved
    FullyApproved


Dependencies on Approved must receive explicit disposition.


Question:

    Does this reduce semantic drift by forcing meaning redistribution?


======================================================================
31. WILDCARD / DEFAULT DRIFT
======================================================================

Example:

    Captured -> CanRefund
    _        -> CannotRefund


Add:

    Disputed


System silently interprets:

    Disputed -> CannotRefund


That may be accidental semantic drift.


Proposed rule:

    prohibit wildcard/default for consequential closed state families unless
    equivalence is declared.


Research whether language/compiler literature supports this concern.


======================================================================
32. SEMANTIC CHANGE COVERAGE
======================================================================

Use metric:

        consequential interpretations mechanically surfaced
SCC = -------------------------------------------------------
             consequential interpretations actually affected


Investigate whether SCC predicts longitudinal drift.


Hypothesis:

    higher SCC
        ->
    fewer stale interpretations
        ->
    lower semantic debt growth


======================================================================
33. DEPENDENCY CLOSURE
======================================================================

If semantic dependency graph is complete:

    change to state/policy
        ->
    all dependent semantics surfaced


If incomplete:

    hidden dependencies survive


Research relation to:

    change-impact analysis
    traceability completeness
    program slicing
    dependency graphs


======================================================================
34. PROVENANCE
======================================================================

Every important semantic rule may need provenance:

    why introduced
    requirement/source
    actor
    date
    policy
    related evidence
    migration history


Question:

    How much provenance is useful before it becomes bureaucratic noise?


======================================================================
35. DECISION RECORDS
======================================================================

Compare with:

    ADRs
    architecture decision records
    design rationale systems


Potential difference:

    ADRs are prose

whereas:

    semantic provenance is machine-linked to actual rules.


======================================================================
36. POLICY VERSIONING
======================================================================

Without versioning:

    new policy may silently reinterpret old decisions.


With:

    PaymentPolicy@7

historical transition can remain attributable.


Research whether policy versioning reduces semantic ambiguity over time.


======================================================================
37. EPISTEMIC STATE
======================================================================

AI assumption should perhaps remain:

    Assumed

until evidence promotes it.


This prevents:

    repeated persistence -> false verification


Connect this research with explicit epistemic architecture.


======================================================================
38. AGENT-GENERATED ASSUMPTION
======================================================================

Potential rule:

    if agent introduces a consequential new proposition not supported by
    existing semantic authority:

        record as proposed assumption

rather than:

        silently encode it


Could this be practical?


======================================================================
39. ASSUMPTION REVIEW OBLIGATION
======================================================================

A consequential assumption might create:

    obligation:
        ValidateAssumption


This could prevent long-term silent accumulation.


But too many obligations may overwhelm development.


Research threshold criteria.


======================================================================
40. SEMANTIC DIFF
======================================================================

Conventional git diff shows:

    text changes


Potential semantic diff shows:

    added state
    removed transition
    changed authority
    changed evidence requirement
    added obligation
    policy impact


Question:

    Can semantic diffs improve AI and human review?


======================================================================
41. SEMANTIC CHANGE LOG
======================================================================

Maintain:

    semantic version
    migration
    rationale
    impact


This may provide compact historical context to later agents.


Compare with:

    changelogs
    schema migrations
    migration metadata
    ontology evolution


======================================================================
42. CONTEXT COMPRESSION OVER TIME
======================================================================

Conventional maintenance may require increasing context because historical
semantics become harder to reconstruct.

Semantic architecture may let agent read:

    current semantic specification
    migration history relevant to changed concept


instead of:

    years of repository archaeology


This is a major token-cost hypothesis.


======================================================================
43. CONTEXT GROWTH RATE
======================================================================

Define:

    context tokens required per maintenance task over system age


Hypothesis A:

Conventional:

    context/task grows with repository history and coupling


Hypothesis B:

Semantic:

    context/task grows more slowly because current semantics and dependencies
    remain explicit


Measure slope, not just absolute cost.


======================================================================
44. SEMANTIC CONTEXT HALF-LIFE
======================================================================

Explore concept:

    How long does an AI-generated repository summary remain safe before enough
    semantic changes make it misleading?


Compare:

    AI summary
    generated semantic contract


Potential metric:

    summary validity after N semantic changes


======================================================================
45. LONGITUDINAL TOKEN ECONOMICS
======================================================================

Model:

    task 1
    task 10
    task 50
    task 100
    task 500


Measure:

    tokens
    files read
    searches
    repair loops
    defects


Question:

    Does semantic architecture flatten the cost curve?


======================================================================
46. AGENT RESET
======================================================================

Use fresh agent context on every task.

This simulates lack of persistent human memory.

Then compare architectures.

This may expose value of explicit semantics.


======================================================================
47. PERSISTENT AGENT MEMORY
======================================================================

Also test with memory.

Question:

    Does good agent memory eliminate the architecture advantage?

Counterargument:

    memory itself may preserve stale assumptions.


Research.


======================================================================
48. HUMAN-INSTITUTIONAL MEMORY
======================================================================

Human teams have:

    senior developers
    Slack history
    tribal knowledge
    code review
    architectural intuition


AI-heavy organizations may weaken those stabilizers.

Investigate whether this changes architecture requirements.


======================================================================
49. ORGANIZATIONAL SCALE
======================================================================

Semantic drift may worsen with:

    more agents
    more teams
    more parallel changes


Measure cross-agent precedent propagation.


======================================================================
50. MULTI-AGENT SEMANTIC CONFLICT
======================================================================

Agent A and Agent B independently modify related concepts.

Without shared semantic authority:

    both patches may be locally plausible
    combined meaning inconsistent


Semantic graph could expose conflict.


======================================================================
51. PARALLEL CHANGE EXPERIMENT
======================================================================

Give two agents:

A:
    add partial refunds

B:
    change dispute handling


Both affect Payment semantics.


Measure:

    merge conflicts
    semantic conflicts
    hidden incompatibilities


Compare architectures.


======================================================================
52. CODE GENERATION VOLUME
======================================================================

If AI lowers marginal code-generation cost:

    organizations may create more code

which could increase:

    semantic surface area
    maintenance burden


Hypothesis:

    AI makes semantic architecture more important because code volume ceases to
    be the main scarcity; understanding does.


Research whether empirical data supports this.


======================================================================
53. LEGACY SYSTEM IMPLICATION
======================================================================

Legacy code lacks explicit semantic authority.

AI agents must reconstruct meaning from:

    code
    tests
    schemas
    comments
    behavior


Question:

    Does AI make legacy semantic debt economically visible through token/tool cost?


This may be a strategic application.


======================================================================
54. SEMANTIC REVERSE ENGINEERING
======================================================================

Potential migration approach:

    infer candidate semantic model from legacy code
        ->
    human validates
        ->
    establish authoritative semantic layer


Research model extraction and program comprehension.


======================================================================
55. WRONG SEMANTIC SPECIFICATION
======================================================================

A major counterargument:

    explicit semantic authority can preserve wrong meaning more strongly.


If specification wrong:

    compiler
    tests
    capabilities
    agents

may all reinforce it.


Study correlated failure.


======================================================================
56. SEMANTIC RIGIDITY
======================================================================

Explicit rules may discourage healthy change.

Developers may avoid changing semantics because migrations are expensive.

This could create:

    architecture conservatism
    product rigidity


Research similar problems in strongly governed systems.


======================================================================
57. OVER-MODELING
======================================================================

If too much product hypothesis is encoded:

    semantic drift may decrease

but:

    pivot cost may increase


Connect with startup pivotability research.


======================================================================
58. MINIMUM SEMANTIC CORE
======================================================================

Potential principle:

    only consequential, validated semantics belong in trusted core.


This may balance:

    drift resistance
    adaptability


Research how to identify that boundary.


======================================================================
59. FORMAL METHODS
======================================================================

Model checking could ensure:

    transitions remain reachable
    invariants hold


But it does not ensure:

    rules reflect business intent


Clarify role.


======================================================================
60. SEMANTIC TEST ORACLE
======================================================================

To measure drift experimentally, need independent reference semantics.

Create hidden canonical business specification.

Agent repositories do not see full oracle.

After each change:

    evaluate behavior against reference


This distinguishes:

    repository self-consistency

from:

    true semantic correctness.


======================================================================
61. EXPERIMENT — SEQUENTIAL CHANGES
======================================================================

Create same V1 in:

A. conventional architecture
B. semantic architecture


Apply:

    50 sequential feature/maintenance tasks


Each later task starts from prior result.


Measure drift.


======================================================================
62. TASK DESIGN
======================================================================

Include:

    state additions
    state splits
    policy changes
    UI changes
    bug fixes
    cross-module changes
    ambiguous requirements
    temporary workarounds
    external-effect changes
    product pivots


Some tasks should intentionally introduce opportunities for accidental assumptions.


======================================================================
63. HIDDEN ASSUMPTIONS
======================================================================

Insert ambiguous tasks such as:

    "Allow premium customers to cancel later."


Do not define:

    exact cutoff

unless agent asks or architecture surfaces ambiguity.


Observe whether unsupported choices become durable precedent.


======================================================================
64. TEMPORARY WORKAROUND TEST
======================================================================

Task explicitly says:

    temporary workaround until provider fixes API


Later tasks should reveal whether workaround becomes permanent semantic rule.


Measure architectures.


======================================================================
65. BUG-AS-FEATURE TEST
======================================================================

Introduce a bug that remains for several iterations.

Later agent sees it.

Does agent preserve it as expected behavior?


Then reveal canonical intent.


Measure correction cost.


======================================================================
66. STALE TEST TEST
======================================================================

Leave an outdated test after intended policy change.

Observe whether agent:

    changes code back

or:

    updates stale test


Semantic architecture should help distinguish authority.


======================================================================
67. COPY-PASTE PROPAGATION TEST
======================================================================

Introduce one questionable pattern.

Later tasks affect neighboring modules.

Measure how many copies appear after N changes.


======================================================================
68. RENAMING VS SEMANTIC CHANGE
======================================================================

Test:

    rename state only

vs:

    split state meaning


Without semantic IDs, agent may confuse them.

Measure impact.


======================================================================
69. POLICY VERSION TEST
======================================================================

Change policy twice.

Then ask agent to explain historical action.

Can it distinguish:

    valid under old policy

from:

    currently invalid?


======================================================================
70. PRODUCT PIVOT TEST
======================================================================

Invalidate a major product assumption.

Measure:

    how much obsolete semantics remain accidentally active

after pivot.


======================================================================
71. AGENT HANDOFF TEST
======================================================================

Every 5 tasks switch to fresh model/session.

Measure:

    reconstruction cost
    semantic errors
    preserved intent


This simulates real agent turnover.


======================================================================
72. DIFFERENT MODEL HANDOFF
======================================================================

Use different model families over time.

Question:

    Does explicit semantics reduce model-specific interpretation variance?


======================================================================
73. AGENT EXPLANATION TEST
======================================================================

After task N ask:

    "Why is this rule true?"


Score answer against:

    actual semantic provenance

not:

    plausible explanation


This tests whether rationale remains reconstructable.


======================================================================
74. DRIFT METRICS
======================================================================

Develop metrics such as:

Semantic Drift Rate:

    unintended semantic deviations
    ------------------------------
    maintenance tasks


Assumption Accumulation:

    unresolved consequential assumptions after N tasks


Stale Dependency Rate:

    affected interpretations not updated


Rationale Recovery Accuracy:

    correctly explained semantic decisions
    ---------------------------------------
    tested decisions


======================================================================
75. SEMANTIC ENTROPY
======================================================================

Explore but do not assume usefulness.

Potential notion:

    number of plausible interpretations of system behavior available to a new
    agent from repository artifacts


Explicit semantics should reduce ambiguity.


Find a measurable proxy rather than vague metaphor.


======================================================================
76. CONTEXT RECONSTRUCTION COST
======================================================================

Measure:

    files read
    searches
    tokens
    tool calls

required before first correct edit.


Track over repository age.


======================================================================
77. REPAIR COST OF OLD ASSUMPTIONS
======================================================================

When hidden assumption finally discovered:

    how many files/tests/modules must change?


This may measure compounding debt.


======================================================================
78. SEMANTIC FAN-OUT GROWTH
======================================================================

Track number of dependents per semantic rule over time.

If hidden rules gain dependents:

    correction becomes expensive.


Dependency closure may make growth visible earlier.


======================================================================
79. DUPLICATED RULE COUNT
======================================================================

Track same business rule encoded in:

    services
    UI
    tests
    SQL
    prompts


Semantic compilation may reduce duplication.


======================================================================
80. AUTHORITY VIOLATION COUNT
======================================================================

Track cases where implementation introduces semantic behavior outside
authoritative specification.


This may be a key erosion metric.


======================================================================
81. COST PER SEMANTICALLY CORRECT CHANGE
======================================================================

Primary economic metric:

                    total maintenance cost
CostCorrectChange = -----------------------------
                    correct semantic changes


Include:

    inference
    tools
    retries
    human correction
    defect repair


======================================================================
82. LONGITUDINAL COST
======================================================================

Compute cumulative:

    total tokens
    total tool calls
    total defects
    total human interventions
    total cost


Do not evaluate only per-task average.


======================================================================
83. COST GROWTH SLOPE
======================================================================

Fit:

    task index -> context/cost


Question:

    does conventional cost grow faster?


This may be more valuable than static benchmark comparison.


======================================================================
84. SEMANTIC RETENTION
======================================================================

Measure intended prior business rules preserved correctly after N changes.

Metric:

    correctly retained validated semantics
    --------------------------------------
    validated semantics expected to survive


======================================================================
85. CHANGE CORRECTNESS VS RETENTION
======================================================================

A patch may correctly implement new feature but accidentally break old semantics.

Score both:

    task correctness
    semantic retention


======================================================================
86. ARCHITECTURAL EROSION
======================================================================

Track:

    cross-module writes
    dependency cycles
    wildcard/default introductions
    unowned state
    duplicated policies
    direct effect calls
    bypasses


Measure whether AI gradually defeats constraints.


======================================================================
87. CONSTRAINT EROSION
======================================================================

Agents may weaken architecture to complete tasks faster.

Examples:

    make constructor public
    add wildcard
    suppress analyzer
    bypass capability
    mutate database directly


Track frequency.


======================================================================
88. ARCHITECTURE SELF-DEFENSE
======================================================================

A strong semantic architecture should make erosion itself visible.

Examples:

    compile error
    analyzer diagnostic
    failing generated test


Measure how often attempts are blocked mechanically.


======================================================================
89. HUMAN REVIEW LOAD
======================================================================

Over time, do reviewers need to understand increasing repository context?

Semantic architecture may produce:

    small semantic diff
    impact report


Measure human review minutes if practical.


======================================================================
90. CURRENT AI RESEARCH
======================================================================

Search current research on:

    long-horizon coding agents
    repository evolution
    persistent agent memory
    self-generated context
    autonomous software maintenance
    codebase drift
    AI technical debt
    agent-generated technical debt
    iterative code generation
    model collapse analogies only if directly relevant
    software archaeology with LLMs


Avoid speculative analogy where evidence is weak.


======================================================================
91. HUMAN SOFTWARE MAINTENANCE LITERATURE
======================================================================

Research foundational work on:

    Lehman's laws of software evolution
    software entropy
    architectural erosion
    technical debt
    program comprehension
    change impact
    software aging
    maintenance cost curves


Determine which established findings already predict the problem.


======================================================================
92. LEHMAN'S LAWS
======================================================================

Investigate whether laws of software evolution are relevant.

Do not assume AI changes them.

Ask:

    Does AI accelerate change rate without changing underlying erosion dynamics?


======================================================================
93. SOFTWARE ENTROPY TERMINOLOGY
======================================================================

"Software entropy" is often used loosely.

Avoid adopting it unless precisely defined.

Prefer measurable terms:

    semantic drift
    dependency growth
    assumption accumulation
    architectural violations


======================================================================
94. HUMAN VS AI COMPARISON
======================================================================

If possible compare:

    human maintenance
    AI maintenance
    human+AI


Do not claim AI is worse without evidence.


AI may actually improve consistency in some contexts.


======================================================================
95. AI ADVANTAGE COUNTERARGUMENT
======================================================================

LLMs can search entire repositories quickly and may preserve consistency better
than humans.

Semantic architecture may therefore provide smaller incremental benefit than
expected.


Test this seriously.


======================================================================
96. RETRIEVAL COUNTERARGUMENT
======================================================================

Modern repository indexing, embeddings, graph retrieval, and agent memory may
already solve much of semantic reconstruction.

Compare:

    retrieval improvements

against:

    explicit semantic authority


Question:

    Is the main issue finding information or knowing which information is
    authoritative?


======================================================================
97. MEMORY COUNTERARGUMENT
======================================================================

Persistent project memory may preserve rationale.

But memory can become:

    stale
    contradictory
    unverified


Compare memory systems with semantic provenance.


======================================================================
98. DOCUMENTATION COUNTERARGUMENT
======================================================================

Could high-quality docs/ADRs solve the problem cheaply?

Compare:

    prose governance

against:

    machine-enforced semantics


Measure maintenance burden and drift.


======================================================================
99. DDD COUNTERARGUMENT
======================================================================

Could strong DDD aggregates and modularity solve most of this?

Identify incremental value of:

    dependency closure
    migration enforcement
    epistemic status
    capabilities/obligations
    generated semantic context


======================================================================
100. STRONG TYPES COUNTERARGUMENT
======================================================================

Maybe:

    F#/Rust + good modeling

already solves much of longitudinal drift.


Determine where a semantic compiler adds value beyond type system.


======================================================================
101. FORMAL SPEC COUNTERARGUMENT
======================================================================

Maybe existing formal methods already solve drift better.

Compare:

    TLA+
    Alloy
    refinement types
    proof assistants


Question:

    Is our architecture primarily a usability/adoption layer over known formal ideas?


======================================================================
102. SEMANTIC CORE CHANGE RATE
======================================================================

If semantic model changes constantly:

    trusted spec may provide little stability.


Measure:

    semantic churn


Hypothesis:

    durable semantic core should change slower than implementation.


======================================================================
103. VOLATILITY CLASSIFICATION
======================================================================

Classify:

    durable
    provisional
    experimental


Track whether experimental concepts accidentally migrate into durable core.


This connects startup pivotability to drift.


======================================================================
104. PROMOTION OF SEMANTICS
======================================================================

Potential rule:

    experimental -> provisional -> durable


Promotion requires:

    evidence
    repeated use
    explicit review


Investigate whether this is useful or bureaucratic.


======================================================================
105. DEPRECATION
======================================================================

Semantic concept removal should include:

    dependency impact
    migration
    historical provenance


Avoid leaving zombie semantics.


======================================================================
106. ORPHAN DETECTION
======================================================================

After product pivot:

    semantic modules/states no longer referenced


Compiler could report:

    orphaned semantics


This may prevent obsolete meaning surviving indefinitely.


======================================================================
107. DEAD SEMANTIC CODE
======================================================================

Static dead code is not same as:

    semantically obsolete code


A feature may still be reachable but no longer intended.


Need provenance/product decision context.


======================================================================
108. SEMANTIC HEALTH REPORT
======================================================================

Potential periodic report:

    unresolved assumptions
    orphaned states
    unused capabilities
    blocked obligations
    policy-version skew
    wildcard violations
    dependency cycles
    high fan-out semantic nodes
    stale evidence


Could this act as architecture drift monitoring?


======================================================================
109. AI COST OF SEMANTIC HEALTH
======================================================================

If semantic health report lets agent target issues directly:

    less repository scanning


Potential recurring maintenance savings.


======================================================================
110. LONGITUDINAL BENCHMARK DESIGN
======================================================================

Recommended benchmark:

Repositories:

    A. competent conventional modular monolith
    B. state-constrained semantic modular monolith


Initial functionality identical.

Run:

    50–100 sequential changes

with:

    fresh agent session each task
    same model/settings
    hidden semantic oracle
    periodic adversarial ambiguity


Record all metrics.


======================================================================
111. PRE-REGISTRATION
======================================================================

Before experiment freeze:

    task sequence
    hidden oracle
    evaluation criteria
    semantic retention rules
    allowed architecture constraints
    stopping conditions


Prevent hindsight bias.


======================================================================
112. ABLATION
======================================================================

Test semantic architecture without:

    provenance
    dependency closure
    migration enforcement
    exhaustive matching
    epistemic state


Determine which mechanisms actually reduce drift.


======================================================================
113. MODEL-SCALE EXPERIMENT
======================================================================

Test:

    small model
    medium model
    frontier model


Question:

    does semantic structure reduce drift especially for smaller models?


======================================================================
114. CONTEXT-LIMIT EXPERIMENT
======================================================================

Artificially constrain context budget.

Semantic architecture may degrade more gracefully if it can select relevant
semantic slices.


======================================================================
115. REPOSITORY-SCALE EXPERIMENT
======================================================================

Test systems of increasing size.

Question:

    does drift/context advantage increase with scale?


======================================================================
116. PRODUCT-PIVOT EXPERIMENT
======================================================================

Apply major business pivot after 30 maintenance tasks.

Measure:

    obsolete assumptions remaining
    reusable semantics
    agent context
    migration cost


This connects two research tracks.


======================================================================
117. SEMANTIC BUG INJECTION
======================================================================

Insert one incorrect semantic rule intentionally.

Observe:

    does architecture amplify wrong specification more than conventional code?


This is essential falsification.


======================================================================
118. SPECIFICATION CORRECTION
======================================================================

Later correct semantic rule.

Measure:

    how completely dependents are surfaced and repaired.


This tests whether explicit authority also makes correcting central mistakes easier.


======================================================================
119. STRONG SUCCESS CRITERIA
======================================================================

A strong result would show over many sequential tasks:

    lower semantic drift rate
    higher semantic retention
    fewer hidden assumptions
    lower context growth
    fewer files read
    fewer repair loops
    lower cumulative cost
    fewer architectural bypasses


And benefits persist after:

    product change
    agent handoff
    model change


======================================================================
120. FALSIFICATION CONDITIONS
======================================================================

The hypothesis should be weakened if:

    AI-maintained conventional systems do not drift materially faster

or:

    semantic architecture does not reduce drift

or:

    wrong semantic specifications create worse correlated failures

or:

    architecture constraints are routinely weakened by agents

or:

    semantic maintenance cost dominates

or:

    high-quality retrieval/docs/memory provide equivalent benefit more cheaply.


======================================================================
121. REQUIRED SOURCE QUALITY
======================================================================

Prefer:

    foundational software-evolution research
    primary empirical software-engineering studies
    architecture erosion literature
    requirements traceability research
    current long-horizon agent benchmarks
    official benchmark papers


Clearly distinguish:

    established human-software findings
    AI-specific evidence
    architecture inference
    speculation


======================================================================
122. REQUIRED OUTPUT
======================================================================

Produce:

1. Executive verdict
2. Definition of semantic drift
3. Intentional evolution vs drift
4. Human software-evolution literature
5. Architecture erosion literature
6. Technical/semantic/assumption debt comparison
7. Requirements/design-rationale loss
8. AI-specific drift mechanisms
9. Evidence for AI pattern propagation
10. Test/documentation/schema entrenchment
11. Hyrum's Law implications
12. Semantic authority model
13. Provenance implications
14. Semantic migration implications
15. Dependency-closure implications
16. Epistemic-state implications
17. Longitudinal context-cost hypothesis
18. Persistent memory/retrieval counterarguments
19. Formal methods/strong-type counterarguments
20. Wrong-specification risk
21. Over-modeling/rigidity risk
22. Metrics
23. Longitudinal benchmark design
24. Ablation plan
25. Economic model
26. What is already supported
27. What remains speculative
28. Architecture changes recommended
29. Highest-value experiment
30. Final verdict


======================================================================
123. FINAL VERDICT FORMAT
======================================================================

Answer:

Does longitudinal semantic drift exist in conventional software?
    Strongly established / Established / Moderate evidence / Weak evidence

Is there evidence AI agents amplify it?
    Strong / Moderate / Weak / No direct evidence

Does explicit semantic authority plausibly reduce it?
    Strong / Moderate / Weak / Unclear

Does semantic dependency closure plausibly reduce stale assumptions?
    Strong / Moderate / Weak / Unclear

Does provenance plausibly reduce rationale loss?
    Strong / Moderate / Weak / Unclear

Does semantic architecture plausibly reduce long-run agent context cost?
    Strong / Moderate / Weak / Unclear

Biggest AI-specific drift mechanism:
    ...

Strongest existing research analogue:
    ...

Most dangerous architecture failure mode:
    ...

Most important missing evidence:
    ...

Best longitudinal metric:
    ...

Best first experiment:
    ...

Most important architecture change suggested by research:
    ...


======================================================================
124. RESEARCH STANDARD
======================================================================

Be skeptical.

Do not call ordinary software evolution an AI-specific problem without evidence.

Do not assume surviving code represents intended meaning.

Do not assume tests or documentation are semantic authority.

Do not assume explicit specifications are automatically correct.

Do not treat architectural rigidity as a virtue.

Do not measure only defects at the end; measure how hidden assumptions accumulate
and how maintenance/context cost changes over time.

The central question is:

    Does explicit, machine-visible semantic authority prevent repeated AI
    maintenance from turning temporary assumptions and implementation accidents
    into durable system truth — and does that materially reduce long-term
    correctness risk and agent execution cost?
