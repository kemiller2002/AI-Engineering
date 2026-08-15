STARTUP PIVOT RESILIENCE BENCHMARK SPECIFICATION
================================================

Benchmark ID:
    SPRB-001

Title:
    Startup Pivot Resilience Benchmark for AI-Maintained Software

Purpose:
    Evaluate whether state-constrained semantic modularity improves a startup's
    ability to pivot while preserving validated capability, reducing change
    blast radius, reducing AI-agent context requirements, and lowering total
    cost per correct pivot.

This benchmark is intentionally designed to test strategic flexibility rather
than architectural elegance.

The benchmark compares two equivalently competent implementations of the same
startup product:

    A. Conventional modular architecture

    B. State-constrained semantic modular architecture

The benchmark must not be designed around knowledge of the future pivots.

The pivot sequence must remain hidden from the teams or agents building V1.


1. PRIMARY RESEARCH QUESTIONS
=============================

The benchmark should answer:

1. Does state-constrained semantic modularity preserve more validated
   capabilities during a startup pivot?

2. Does it reduce the number of modules and files that must be changed?

3. Does it reduce the amount of repository context an AI agent must inspect?

4. Does it reduce input tokens, output tokens, model calls, tool calls,
   repair loops, and wall-clock execution cost?

5. Does it improve semantic correctness, regression resistance,
   state-transition correctness, and integration correctness?

6. Does it reduce cost per correct pivot?

7. Does it remain advantageous as pivots become more severe?

8. Does it remain advantageous across sequential pivots?

9. Does semantic modularity create excessive upfront cost that eliminates
   downstream savings?

10. Does the architecture remain useful when the pivot changes the customer,
    workflow, business model, or product boundary?


2. CORE HYPOTHESIS
==================

Primary hypothesis:

    Software organized around explicit ownership of consequential state,
    machine-visible semantic dependencies, explicit transitions, and replaceable
    orchestration will preserve more validated capability and require less
    AI-agent context during startup pivots than equivalently competent
    conventional software.

Economic hypothesis:

    Lower repository exploration, smaller context slices, fewer semantic errors,
    and fewer repair loops will reduce the total AI execution cost required to
    complete a pivot correctly.

Null hypothesis:

    State-constrained semantic modularity provides no material improvement in
    semantic retention, context consumption, correctness-adjusted token cost,
    or total pivot cost after accounting for additional modeling and tooling.


3. BENCHMARK PRINCIPLES
=======================

The benchmark must follow these principles:

    Blind future pivots
    Equivalent business functionality
    Competent conventional architecture
    Identical task descriptions
    Identical test requirements
    Identical external integrations
    Identical AI model where possible
    Identical tooling where possible
    Multiple repeated runs
    Fresh agent sessions
    Full token accounting
    Semantic correctness evaluation
    Longitudinal testing

Do not intentionally weaken the conventional implementation.
Do not intentionally optimize the semantic implementation for known pivots.
Do not reveal pivot scenarios during V1 implementation.


4. INITIAL STARTUP
==================

Startup concept:

    Accessible travel planning and booking platform.

Initial customer:

    Individual traveler with accessibility needs.

Initial product promise:

    Help a traveler describe accessibility requirements, identify viable
    properties, construct a trip, reserve inventory, and pay.

Initial user journey:

    Create Account
        ->
    Create Accessibility Profile
        ->
    Create Trip Request
        ->
    Search Accessible Inventory
        ->
    Evaluate Options
        ->
    Construct Itinerary
        ->
    Reserve
        ->
    Pay
        ->
    Receive Confirmation


5. REQUIRED V1 BUSINESS CAPABILITIES
====================================

Both implementations must support equivalent V1 functionality.

Identity
--------
    create account
    authenticate
    update traveler profile

Accessibility
-------------
    capture accessibility requirements
    record evidence/source where appropriate
    represent verified and unverified accessibility facts

Trip Request
------------
Suggested lifecycle:
    Draft
    Submitted
    Evaluating
    Viable
    Unfulfillable
    Accepted
    Cancelled

Inventory
---------
    hotel/property inventory
    accessibility attributes
    availability
    pricing
    inventory source

Itinerary
---------
    proposed itinerary
    selected property
    travel dates
    relevant accessibility match information

Reservation
-----------
Suggested lifecycle:
    Proposed
    Held
    Confirmed
    Cancelled

Payment
-------
Suggested lifecycle:
    None
    Authorized
    Captured
    Refunded

Notification
------------
    reservation confirmation
    cancellation notice
    key status updates

Audit / Provenance
------------------
At minimum:
    who initiated important actions
    when important actions occurred


6. EXTERNAL ADAPTERS
====================

Use test doubles or reproducible mock services for:

    payment processor
    hotel inventory source
    email/notification provider
    identity provider if needed

The adapters must behave identically in both architectures.


7. ARCHITECTURE A — CONVENTIONAL
================================

Architecture A should represent competent modern commercial development.

Recommended characteristics:

    modular monolith
    domain/services/repositories
    typed models where normal for chosen language
    enums/status types where appropriate
    ordinary service-layer validation
    dependency injection
    good unit/integration tests
    reasonable package boundaries
    documented APIs

Avoid intentionally poor practices such as:

    giant god classes
    untyped JSON everywhere
    direct SQL scattered across the project
    no tests
    intentionally tangled dependencies

The benchmark is not good architecture vs bad architecture.

It is:

    conventional competent architecture
        vs
    state-constrained semantic modular architecture.


8. ARCHITECTURE B — STATE-CONSTRAINED SEMANTIC MODULAR
======================================================

Architecture B must use explicit semantic ownership.

Each consequential domain state has one semantic owner.

Modules may:

    expose state
    expose claims
    expose events
    expose capabilities
    expose obligations
    accept transition requests

Modules may not:

    mutate another module's authoritative state directly.

Required semantic concepts:

    Subject
    StateFamily
    StateCase
    Transition
    Requirement
    Capability
    Obligation
    Event
    Effect
    Authority where applicable
    Policy where applicable
    SemanticDependency

State interpretation must be exhaustive for consequential state families.

Implicit future-state handling should be prohibited unless semantic equivalence
is explicitly declared.


9. ARCHITECTURE B — MODULES
===========================

Recommended semantic modules:

    identity
    accessibility
    trip-request
    inventory
    itinerary
    reservation
    payment
    notification

Product journey/orchestration should remain separate from durable semantic
modules.

Example:

    journeys/
        consumer-self-service/


10. SEMANTIC STABILITY CLASSIFICATION
=====================================

Architecture B should classify important concepts using:

    durable
    provisional
    experimental

Examples:

    Payment.Captured
        durable

    Reservation.Confirmed
        durable

    TripRequest.Viable
        provisional or durable depending on design

    CurrentCheckoutStep
        experimental / not semantic domain state

Benchmark rule:

    Product-experiment state must not be promoted into durable semantic state
    without justification.


11. V1 IMPLEMENTATION FREEZE
============================

When V1 passes acceptance tests:

    tag repository
    freeze architecture
    freeze test baseline
    record code metrics
    record semantic metrics
    record build/runtime environment

No pivot information may have been disclosed before this point.


12. BASELINE METRICS BEFORE PIVOT
=================================

Record for each architecture:

    LOC
    files
    modules
    test count
    build duration
    semantic modules
    state families
    transitions
    explicit dependencies
    module dependency graph
    average module size
    test coverage if available
    static dependency fan-out
    semantic dependency fan-out

Architecture B additionally records:

    semantic IR token size
    generated agent-context token size
    semantic dependency graph size


13. BLIND PIVOT SEQUENCE
========================

Pivots should be applied from V1 independently first.

Then optionally as a longitudinal sequence.

This avoids conflating individual pivot difficulty with accumulated drift.


14. PIVOT A — ADVISOR-ASSISTED PLANNING
=======================================

Business discovery:

    Travelers do not want to construct accessible trips themselves.

New product:

    Traveler submits accessibility needs and trip goals.
    A travel advisor creates the itinerary.
    Traveler reviews and accepts the proposal.

Required changes may include:

    new advisor role
    advisor work queue
    itinerary proposal workflow
    traveler approval
    removal/reduction of self-service trip construction

Expected durable capabilities:

    identity
    accessibility profile
    inventory
    reservation
    payment
    notification

Research question:

    Can orchestration change while durable semantic modules remain intact?


15. PIVOT B — ACCESSIBILITY VERIFICATION FOR TRAVEL AGENCIES
============================================================

Business discovery:

    Travel agencies care more about trustworthy accessibility data than
    end-to-end booking.

New customer:

    travel agency

New product:

    accessibility verification and evidence service

Remove:

    consumer trip purchase as the product's central value proposition

Retain where useful:

    accessibility evidence
    property data
    inventory identity
    provenance
    confidence/verification status

New requirements:

    agency accounts
    property accessibility reports
    verification status
    data provenance
    API or portal access

Research question:

    How much validated accessibility capability survives when booking becomes
    secondary?


16. PIVOT C — HOTEL ACCESSIBILITY CERTIFICATION
===============================================

Business discovery:

    Hotels will pay to verify and publish accessibility characteristics.

New customer:

    hotels / property operators

New product:

    accessibility certification and evidence management

Potential retained capabilities:

    accessibility evidence
    verification
    provenance
    property identity
    reporting

Potentially obsolete:

    consumer itinerary construction
    booking workflow
    traveler payment

New concepts:

    certification application
    evidence review
    certification status
    renewal
    reviewer authority

Research question:

    Does the architecture retain domain knowledge even when the customer side
    of the market flips?


17. PIVOT D — ACCESSIBILITY INVENTORY API
=========================================

Business discovery:

    The strongest opportunity is infrastructure, not the end-user product.

New product:

    API that exposes normalized accessibility inventory and evidence.

Remove:

    consumer UI as primary product
    direct booking
    itinerary planning

Retain:

    property identity
    accessibility attributes
    evidence
    verification
    data ingestion
    provenance

New requirements:

    API authentication
    customer accounts
    usage limits
    versioned schemas
    data freshness

Research question:

    Can durable semantic capability survive a product-layer collapse?


18. PIVOT E — CORPORATE ACCESSIBLE TRAVEL MANAGEMENT
====================================================

New customer:

    corporate travel departments

New product:

    accessible employee travel management

New requirements:

    company accounts
    employees
    travel policy
    approvals
    advisor assistance
    booking
    payment/invoicing
    auditability

Potential reuse:

    accessibility profile
    inventory
    reservation
    payment
    evidence
    notification

New semantic complexity:

    organization policy
    authority
    approvals
    obligations

Research question:

    How well does the architecture adapt to a more complex B2B domain?


19. OPTIONAL PIVOT F — DELIBERATELY HOSTILE PIVOT
=================================================

Use one pivot designed to invalidate most of V1.

Example:

    Stop working in travel.

    Use the accessibility evidence platform to certify accessibility of
    restaurants and public venues.

Purpose:

    identify the point at which architectural reuse legitimately collapses.

A good architecture should not be rewarded for preserving irrelevant code.


20. AGENT EXECUTION PROTOCOL
============================

For each pivot:

    start from frozen V1
    create fresh repository copy
    create fresh agent session
    provide only the pivot request and standard repository instructions
    do not provide architecture-specific hints beyond those normally available
    in the repository

Allow normal tools:

    repository search
    file read
    edit
    shell
    compiler
    tests

Architecture B may expose semantic tools that are part of the architecture:

    get_semantic_modules
    get_module_contract
    get_dependencies
    get_impact_report
    get_available_transitions
    validate_semantic_migration

Their token/tool cost must be counted.


21. CONTEXT STRATEGIES
======================

Run multiple retrieval/context conditions if possible.

Condition 1 — Natural Agent
    Allow the agent to explore normally.

Condition 2 — Broad Repository Context
    Provide broad conventional context.

Condition 3 — Dependency-Aware Retrieval
    Use language/static dependency information.

Condition 4 — Semantic Context
    Architecture B receives:
        semantic impact
        affected modules
        direct dependency contracts
        relevant implementation

Condition 5 — Semantic Lazy Expansion
    Start with minimal semantic slice.
    Fetch additional module context only when semantic dependency, compiler
    error, test failure, or explicit agent request requires expansion.


22. TOKEN ACCOUNTING
====================

Record per run:

    system tokens if measurable
    task prompt tokens
    repository/context tokens
    semantic contract tokens
    tool schema tokens
    cached input tokens
    uncached input tokens
    output tokens
    reasoning tokens if available
    total tokens

Do not omit semantic metadata from Architecture B's accounting.


23. MODEL COST ACCOUNTING
=========================

Record:

    provider
    model
    pricing date
    input token price
    cached token price
    output token price

Calculate:

    inference cost per attempt
    inference cost per correct pivot

Prices must be current at experiment execution time.


24. TOOL ACTIVITY METRICS
=========================

Record:

    search calls
    file reads
    files opened
    files edited
    shell calls
    compile calls
    test calls
    semantic-tool calls
    failed tool calls
    total tool calls


25. CONTEXT METRICS
===================

Record:

    unique files read
    implementation tokens read
    contract tokens read
    modules inspected
    modules modified

Calculate Context Size Ratio:

        state-constrained task context
CSR = --------------------------------
        conventional task context

Calculate Context Reduction:

    1 - CSR


26. MODULE ESCAPE RATE
======================

Definition:

    percentage of tasks initially classified as local that require
    unexpected context outside the predicted semantic module set.

Measure:

    initial predicted modules
    actual modules inspected
    actual modules modified

High escape rate weakens the semantic-context hypothesis.


27. SEMANTIC RETENTION RATIO
============================

Define:

        validated semantic capabilities preserved
SRR = ---------------------------------------------
      validated semantic capabilities before pivot

Do not use LOC as the only reuse measure.

Possible preserved-capability units:

    semantic module
    state machine
    transition family
    invariant set
    evidence model
    effect contract
    authority model
    test suite for durable semantics


28. CODE RETENTION
==================

Still record conventional reuse measures:

    lines preserved
    files preserved
    modules preserved
    tests preserved

But report separately from semantic retention.


29. PIVOT BLAST RADIUS
======================

Define:

        semantic modules requiring modification
PBR = --------------------------------------------
              total semantic modules

Also record:

    files modified
    modules modified
    contracts modified
    tests modified


30. HYPOTHESIS DISPOSAL RATIO
=============================

Measure how much experimental/product code can be discarded without changing
durable semantic modules.

A high value can be good if semantic retention and correctness remain high.


31. SEMANTIC CHANGE COVERAGE
============================

Use:

        consequential interpretations mechanically surfaced
SCC = -------------------------------------------------------
             consequential interpretations actually affected

Use especially for:

    state addition
    state split
    contract evolution
    policy changes


32. CORRECTNESS EVALUATION
==========================

Every pivot must have hidden acceptance tests.

Evaluate:

    functional correctness
    semantic state correctness
    illegal transition prevention
    authority correctness
    effect handling
    regression failures
    data migration correctness
    integration behavior

Do not count "code compiles" as "correct pivot."


33. SEMANTIC DEFECT CLASSIFICATION
=================================

Classify defects such as:

    invalid state representation
    illegal transition
    missing transition case
    stale policy assumption
    cross-module mutation
    missing authorization
    incorrect external retry
    fabricated trusted state
    hidden wildcard/default behavior
    unresolved semantic dependency
    wrong migration of old meaning
    accidental loss of preserved capability


34. AGENT BEHAVIOR METRICS
==========================

Record attempts to:

    add broad defaults
    use wildcard cases
    weaken tests
    bypass type checks
    suppress warnings
    directly mutate authoritative state
    duplicate business rules
    cross module boundaries improperly
    fabricate capability/evidence/event objects

These may indicate whether the architecture resists shortcut behavior.


35. RETRY / REWORK METRICS
==========================

Record:

    failed compile cycles
    failed test cycles
    semantic validator failures
    rollback attempts
    repair loops
    duplicated edits
    regression repairs


36. HUMAN INTERVENTION
======================

If a human must intervene, record:

    intervention count
    intervention duration
    reason

Examples:

    ambiguous business decision
    broken architecture
    agent dead end
    semantic migration decision
    infrastructure issue


37. COST PER CORRECT PIVOT
==========================

Primary economic metric:

                    total cost across all attempts
CostCorrectPivot = --------------------------------
                    correct completed pivots

Include where measurable:

    inference
    CI/runtime/tooling
    human intervention


38. UPFRONT ARCHITECTURE COST
=============================

Measure initial V1 cost separately.

Record:

    implementation effort
    semantic modeling effort
    code-generation/tooling effort
    test effort
    infrastructure effort

Architecture B should not be allowed to hide its additional upfront cost.


39. BREAK-EVEN
==============

Calculate cumulative architecture cost across:

    V1
    pivot 1
    pivot 2
    pivot 3
    ...

Determine the point where:

    cumulative cost of Architecture B
        <
    cumulative cost of Architecture A

Report both:

    number of pivots
    number of agent tasks
    elapsed operating period under assumed task volume


40. SINGLE-PIVOT EXPERIMENT
===========================

Run each pivot independently from V1.

Purpose:

    compare architectural resilience by pivot type.


41. LONGITUDINAL EXPERIMENT
===========================

Run a selected sequence:

    V1
        ->
    Pivot A
        ->
    Pivot E
        ->
    Pivot D

or another pre-registered sequence.

Measure:

    architectural erosion
    coupling growth
    semantic graph growth
    context growth
    token growth
    module fan-out
    repair cost


42. ARCHITECTURAL EROSION METRICS
=================================

Track after each pivot:

    number of cross-module dependencies
    number of direct cross-module writes
    semantic dependency fan-out
    average semantic module context size
    cycle count in module dependency graph
    module escape rate
    contract size
    agent context size


43. SMALLER MODEL EXPERIMENT
============================

After baseline runs compare:

    larger model + conventional context

against:

    smaller/cheaper model + semantic context

Measure:

    correctness
    retries
    total tokens
    cost per correct pivot

This may reveal a larger economic benefit than token savings alone.


44. CACHING EXPERIMENT
======================

Measure:

    stable semantic contract tokens
    stable repository prefix tokens
    cached context reuse

Determine whether Architecture B creates more reusable/cachable context.


45. PARALLEL AGENT EXPERIMENT
=============================

For pivots involving multiple modules:

Architecture A:
    multiple agents work using normal repository boundaries.

Architecture B:
    agents work within semantic modules and contracts.

Measure:

    duplicated context
    coordination messages
    merge conflicts
    semantic conflicts
    rework


46. REQUIRED RUN COUNT
======================

Pilot:

    minimum 5 runs per architecture per pivot

Better:

    20+ runs per architecture per pivot

Use the same model/settings.

Randomize run ordering.


47. PRE-REGISTRATION
====================

Before execution, freeze:

    pivot definitions
    acceptance tests
    metrics
    scoring rules
    stopping rules
    architecture constraints

Do not modify scoring because results are inconvenient.


48. FALSIFICATION CONDITIONS
============================

The semantic-modularity hypothesis should be weakened if:

    semantic retention is not materially higher
    context size is not materially lower
    module escape is frequent
    semantic contracts offset context savings
    correctness is unchanged or worse
    cost per correct pivot is not lower
    upfront cost creates an impractical break-even period
    Architecture B requires significantly more human intervention
    semantic migrations become dominant overhead
    dependencies become as dense as Architecture A


49. STRONG SUCCESS CONDITIONS
=============================

A strong result would show across multiple pivot types:

    higher semantic retention
    smaller pivot blast radius
    fewer implementation files inspected
    fewer context tokens
    equal or higher semantic correctness
    fewer repair loops
    lower cost per correct pivot

An especially strong result would show:

    smaller models reach equivalent correctness with semantic context.


50. REPORTING TABLE — PER PIVOT
===============================

Metric                          Architecture A   Architecture B
----------------------------------------------------------------
Correct completion rate
Semantic retention ratio
LOC retained
Tests retained
Modules modified
Files modified
Files read
Modules inspected
Input tokens
Output tokens
Total tokens
Model calls
Tool calls
Compile cycles
Test cycles
Repair cycles
Human interventions
Semantic defects
Regression defects
Wall-clock duration
Inference cost
Cost per correct pivot


51. REPORTING TABLE — ARCHITECTURAL QUALITY
===========================================

Metric                          V1   Pivot A   Pivot B   Pivot C ...
-------------------------------------------------------------------
Module count
Dependency edges
Dependency cycles
Average fan-out
Semantic fan-out
Semantic contract tokens
Average task context
Module escape rate
Cross-module mutation count
Semantic migration count


52. REPORTING TABLE — REUSE
===========================

Category                         Preserved   Modified   Removed   Added
----------------------------------------------------------------------
Identity
Accessibility
Trip Request
Inventory
Itinerary
Reservation
Payment
Notification
Evidence
Policies
Orchestration
External adapters
Tests


53. INTERPRETING REMOVAL
========================

Do not penalize an architecture simply because code is deleted.

Deleting speculative product code may be desirable.

The benchmark should distinguish:

    loss of useful validated capability

from:

    intentional disposal of invalidated product assumptions.


54. BENCHMARK ANTI-PATTERNS
===========================

Do not:

    prebuild functionality required by future pivots
    expose future pivots to V1 agents
    make Architecture A intentionally tangled
    give Architecture B better documentation without counting it
    compare different business behavior
    count compile success as semantic success
    compare raw token count without correctness
    ignore semantic metadata token cost
    ignore upfront modeling cost
    use only one pivot
    use only one agent run


55. EXPECTED RESEARCH OUTPUT
============================

The benchmark report should conclude:

1. Which pivot types benefited most from semantic modularity?
2. Which pivot types benefited least?
3. How much semantic capability was retained?
4. How much code was retained?
5. How much agent context was reduced?
6. How much token usage changed?
7. How much cost per correct pivot changed?
8. How much additional V1 cost did semantic architecture impose?
9. What was the estimated break-even point?
10. Did module boundaries remain stable longitudinally?
11. Did the semantic approach reduce architectural erosion?
12. Did agents attempt fewer unsafe shortcuts?
13. Did smaller models become viable?
14. Where did the architecture fail?
15. What should be changed before a larger benchmark?


56. BENCHMARK VERDICT CLASSES
=============================

REJECTED
    No meaningful improvement after total costs are included.

CORRECTNESS-ONLY BENEFIT
    Semantic architecture improves correctness but does not materially reduce
    pivot cost or agent context.

CONTEXT BENEFIT
    Semantic architecture materially reduces context but total economic benefit
    is unclear.

ECONOMIC BENEFIT
    Architecture reduces cost per correct pivot enough to offset incremental
    operating overhead.

STRATEGIC FLEXIBILITY BENEFIT
    Architecture preserves materially more validated capability across multiple
    blind pivots and lowers the cost/risk of changing business direction.

STRONG AI-NATIVE ADVANTAGE
    Architecture simultaneously delivers:
        higher semantic correctness
        smaller agent context
        lower inference cost
        lower repair cost
        higher semantic retention
        viable smaller-model substitution


57. CORE BENCHMARK PRINCIPLE
============================

The benchmark is ultimately testing:

    Can validated knowledge remain stable while product hypotheses change?

The state-constrained architecture should succeed not by preserving everything,
but by preserving the right things.


58. CONCISE BENCHMARK THESIS
============================

    Preserve validated semantics.
    Dispose of hypotheses cheaply.
    Measure whether AI makes that economically valuable.


59. RECOMMENDED FIRST PILOT
===========================

For the first pilot, avoid building all pivots.

Use:

    V1
    Pivot A — Advisor-Assisted
    Pivot D — Accessibility Inventory API

Reason:

Pivot A tests:
    workflow/orchestration volatility

Pivot D tests:
    major product-layer removal

Together they provide a useful early test of whether durable capability
boundaries actually survive substantially different business directions.


60. PILOT SUCCESS SIGNAL
========================

Before scaling the benchmark, look for evidence that Architecture B:

    preserves more durable modules
    requires fewer implementation files
    uses materially fewer input/context tokens
    does not lose semantic correctness
    does not require excessive migration work

If those signals do not appear in the pilot, challenge the architecture before
investing in a larger experiment.
