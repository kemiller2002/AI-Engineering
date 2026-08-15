AI RESEARCH MISSION 05 — EPISTEMIC STATE, EVIDENCE, AND AGENT TRUTH CONTROL
=================================================================================

ROLE
====

Act as a combined:

- AI-agent systems researcher
- epistemic-logic researcher
- knowledge-representation researcher
- belief-revision researcher
- truth-maintenance systems researcher
- provenance/data-lineage researcher
- formal-methods researcher
- decision-support researcher
- software-architecture researcher
- AI inference-cost researcher

Your task is to investigate whether explicitly modeling the epistemic status of
claims can make AI-operated software safer, more correct, and cheaper to run.

Do not assume the proposed model is correct.

Challenge it against established work in:

    epistemic logic
    belief revision
    truth-maintenance systems
    argumentation
    evidence theory
    provenance
    data lineage
    Bayesian reasoning
    Dempster-Shafer theory
    scientific evidence systems
    clinical decision support
    knowledge graphs
    uncertainty-aware AI systems

The core architectural hypothesis is:

    An AI agent should not be allowed to silently promote a proposition from
    "reported" or "inferred" into "verified" simply because it has been repeated,
    persisted, or accepted by previous agents.

A consequential claim should have explicit epistemic state, evidence, provenance,
and rules governing promotion, contradiction, invalidation, and use.


======================================================================
1. PRIMARY RESEARCH QUESTION
======================================================================

Does representing epistemic status as authoritative machine-readable state reduce:

    hallucinated certainty
    unsupported assumptions
    inherited semantic errors
    stale beliefs
    repeated rediscovery
    repository/context reconstruction
    unsafe agent actions
    human verification burden
    total cost per correct completion?

And does it improve:

    traceability
    explainability
    evidence quality
    downstream decision correctness
    recovery after evidence invalidation
    multi-agent consistency?


======================================================================
2. PROPOSED EPISTEMIC MODEL
======================================================================

Candidate epistemic states:

    Unknown
    Reported
    Assumed
    Inferred
    Supported
    Verified
    Contradicted
    Invalidated

Do not assume this is the correct state set.

Research whether these are:

    mutually exclusive
    ordered
    partially ordered
    orthogonal dimensions
    better represented as a lattice
    better represented as evidence annotations rather than states


Central principle:

    Time and repetition do not increase epistemic authority.
    Evidence does.


Example:

    Claim:
        HotelRoomHasRollInShower

    Status:
        Reported

    Source:
        Hotel marketing page

This must not silently become:

        Verified

merely because:

    multiple agents reuse it
    it appears in several documents
    it has existed for months
    a previous model wrote it into a database


======================================================================
3. CLAIM VS STATE
======================================================================

Distinguish:

    domain state

from:

    epistemic state.

Example domain state:

    Reservation = Confirmed

Example claim:

    RoomIsWheelchairAccessible

Example epistemic status of claim:

    Supported

These are different semantic dimensions.

Investigate existing systems that model:

    proposition
    truth status
    confidence
    source
    evidence
    belief state

separately.


======================================================================
4. CLAIM DEFINITION
======================================================================

Develop a precise working definition.

Candidate:

    A claim is a proposition about a subject whose acceptance may affect
    reasoning, capabilities, obligations, policy, or consequential transitions.

Examples:

    CustomerIdentityIsVerified
    FraudRiskIsLow
    HotelRoomHasAccessibleShower
    LabResultSupportsDiagnosis
    DeploymentPassedSecurityReview

A claim is not necessarily:

    true
    false
    binary
    permanent


======================================================================
5. EPISTEMIC STATE VS CONFIDENCE
======================================================================

This distinction is critical.

Example:

    95% confidence

is not the same as:

    Verified

Likewise:

    low confidence

is not the same as:

    Contradicted.


Investigate whether the architecture should separate:

    epistemic status
    confidence/probability
    evidence strength
    source authority
    freshness


Potential model:

ClaimRecord:

    proposition
    epistemicStatus
    confidence
    evidenceSet
    sourceAuthority
    observedAt
    validUntil
    provenance


======================================================================
6. UNKNOWN MUST NOT COLLAPSE TO FALSE
======================================================================

Investigate one of the architecture's strongest principles:

    Unknown != False

Example:

    AccessibilityFeatureVerified = Unknown

must not become:

    AccessibilityFeature = False


This is especially important in:

    healthcare
    accessibility
    fraud
    compliance
    security
    missing data


Research:

    three-valued logic
    four-valued logic
    SQL NULL semantics
    Kleene logic
    Belnap logic
    open-world assumption
    closed-world assumption


Ask which formal model best represents this.


======================================================================
7. REPORTED VS VERIFIED
======================================================================

Example:

    Hotel says:
        "Room is wheelchair accessible."

That is:

    Reported

Potential verification:

    measured door width
    photo evidence
    third-party inspection


Ask:

    What rules should allow promotion from Reported -> Verified?

Research:

    evidence provenance
    certification systems
    trust models
    source reliability
    testimony in epistemic logic


======================================================================
8. ASSUMED
======================================================================

An assumption may be useful temporarily.

Example:

    Assume API response corresponds to latest policy version

for simulation.

But an assumption should remain distinguishable from:

    fact
    report
    inference
    verification


Investigate:

    assumption-based truth maintenance systems
    non-monotonic logic
    hypothetical reasoning
    defeasible logic


Question:

    Should assumptions exist in authoritative runtime state?

Or only in:

    planning/simulation contexts?


======================================================================
9. INFERRED
======================================================================

Example:

Evidence:

    Door width = 36 inches
    Threshold = >= 32 inches

Inference:

    DoorWidthMeetsRequirement


This may be deterministic inference.

Other inference may be probabilistic:

    symptoms -> likely diagnosis


Investigate whether one epistemic status:

    Inferred

is too coarse.

Possible distinction:

    DeductivelyDerived
    ProbabilisticallyInferred
    HeuristicallyInferred
    ModelPredicted


======================================================================
10. SUPPORTED
======================================================================

What does:

    Supported

mean?

Potential interpretation:

    evidence exists in favor of claim
    but verification threshold has not been met


Research whether this maps to:

    warranted belief
    justified belief
    evidence support
    argumentation strength
    Bayesian posterior threshold


Challenge whether Supported belongs in the state machine.


======================================================================
11. VERIFIED
======================================================================

Develop a rigorous definition.

Potential definition:

    A claim is Verified only when evidence satisfying a declared verification
    policy has been accepted by an authorized verification process.


Thus:

    Verified

depends on:

    evidence
    verification policy
    authority
    possibly freshness
    version


Example:

    Verified under AccessibilityPolicy@8

This may later cease to satisfy:

    AccessibilityPolicy@9


Question:

    Does "Verified" describe truth?

Or:

    successful satisfaction of a verification procedure?

This distinction is important.


======================================================================
12. CONTRADICTED
======================================================================

A claim may have evidence against it.

Example:

Claim:

    RoomHasRollInShower

Evidence A:
    hotel report says yes

Evidence B:
    inspection photo shows tub


Should epistemic state become:

    Contradicted

or:

    Contested / Conflicted?


Research:

    paraconsistent logic
    argumentation frameworks
    truth-maintenance systems


Important requirement:

    contradictory evidence should not necessarily cause database corruption or
    force an immediate true/false choice.


======================================================================
13. INVALIDATED
======================================================================

Invalidated may mean:

    evidence previously trusted is no longer valid

Examples:

    certification expired
    source retracted
    instrument calibration failed
    policy changed
    document was discovered fraudulent
    data was attached to wrong subject


Question:

    Is Invalidated a status of the claim?

Or:

    a status of evidence?


Potential architecture:

    evidence invalidated
        ->
    claim support recalculated
        ->
    claim epistemic status may downgrade


Research this distinction deeply.


======================================================================
14. CLAIM LIFECYCLE VS EVIDENCE GRAPH
======================================================================

The current architecture often imagines:

    Claim
        ->
    EpistemicState

But a stronger model may be:

    Claim
      |
      +-- supporting evidence
      +-- opposing evidence
      +-- inference rules
      +-- provenance
      +-- verification policy

Epistemic status is then:

    derived

rather than directly mutated.


Investigate whether this is superior.


======================================================================
15. TRUTH-MAINTENANCE SYSTEMS
======================================================================

Research deeply:

    Truth Maintenance Systems (TMS)
    Justification-based TMS
    Assumption-based TMS
    Logic-based TMS


Ask:

    How do these systems handle:
        beliefs
        justifications
        assumptions
        contradictions
        retraction
        dependency propagation?


This may be one of the closest intellectual ancestors.


======================================================================
16. BELIEF REVISION
======================================================================

Research:

    AGM belief revision
    contraction
    expansion
    revision
    non-monotonic reasoning


Question:

    When evidence changes, how should dependent claims be updated?

The proposed architecture currently suggests:

    Evidence invalidated
        ->
    claim downgraded
        ->
    dependent capabilities disappear
        ->
    obligations created


Compare this with formal belief-revision theory.


======================================================================
17. EPISTEMIC LOGIC
======================================================================

Research:

    knowledge operators
    belief operators
    common knowledge
    distributed knowledge
    dynamic epistemic logic


Ask whether the architecture needs:

    "the system knows X"

or more precise:

    "Actor A knows X"
    "System accepts X"
    "Evidence supports X"


Avoid using "knowledge" loosely.


======================================================================
18. MULTI-AGENT EPISTEMICS
======================================================================

Different agents may have different observations.

Example:

    Agent A saw latest fraud report.
    Agent B is operating from cached state.


Research:

    distributed knowledge
    common knowledge
    belief synchronization
    multi-agent epistemic logic


Potential architectural consequence:

    authoritative epistemic state should not equal each agent's local belief.


======================================================================
19. PROVENANCE
======================================================================

Every consequential claim may need:

    source
    timestamp
    actor
    evidence
    derivation
    policy
    model/version if AI-generated
    transformation chain


Research:

    W3C PROV
    scientific provenance
    database provenance
    lineage systems
    knowledge graph provenance


Ask which standards should be adopted rather than reinvented.


======================================================================
20. DATA LINEAGE
======================================================================

Example:

Claim:

    CustomerIncome > threshold

Derived from:

    uploaded tax return
        ->
    OCR
        ->
    extracted number
        ->
    normalized currency
        ->
    rule


If OCR is later found wrong:

    downstream claim must be reconsidered.


Research whether lineage systems already provide dependency propagation.


======================================================================
21. AI-GENERATED CLAIMS
======================================================================

AI outputs should likely enter as:

    Inferred

or:

    Proposed

rather than:

    Verified


Investigate whether a distinct epistemic origin is required:

    GeneratedByModel
    HumanReported
    SensorObserved
    Imported
    Derived


Question:

    Should origin be separate from epistemic status?

Likely yes.


======================================================================
22. MODEL CONFIDENCE
======================================================================

LLM confidence is often unreliable.

Research:

    calibration
    verbalized confidence
    token probabilities
    self-consistency
    uncertainty estimation


Do not treat model confidence as evidence of truth.


======================================================================
23. EVIDENCE AUTHORITY
======================================================================

Not all evidence sources are equal.

Example:

    random website
    customer report
    certified inspector
    government database
    calibrated sensor


Potential fields:

    source type
    source authority
    verification method
    trust policy


Research:

    trust management
    credential systems
    source reputation
    evidence hierarchies


======================================================================
24. EVIDENCE FRESHNESS
======================================================================

A verified claim may expire.

Example:

    FraudClear

verified:

    20 minutes ago

Policy requires:

    age < 30 minutes


At 31 minutes:

    evidence may remain historically valid

but:

    insufficient for current transition.


Thus separate:

    truth/evidence status

from:

    transition freshness requirement.


Research temporal logic and credential freshness.


======================================================================
25. POLICY-RELATIVE VERIFICATION
======================================================================

Claim may be:

    Verified under Policy@7

but not:

    sufficient under Policy@8


This suggests verification is policy-relative.

Research:

    compliance certification
    policy versioning
    proof obligations
    credential semantics


Question:

    Should verification records preserve the verification policy snapshot?


======================================================================
26. CLAIM DEPENDENCY GRAPH
======================================================================

Example:

Evidence E1
    ->
Claim A

Claim A + E2
    ->
Claim B

Claim B
    ->
Capability C


If E1 is invalidated:

    A changes
    B changes
    C disappears


The semantic compiler may need a dependency graph.

Research:

    incremental computation
    truth-maintenance
    build systems
    provenance
    dependency-directed backtracking


======================================================================
27. EPISTEMIC CASCADE
======================================================================

Potential cascade:

Evidence invalidated
    ->
Claim downgraded
    ->
Capability removed
    ->
Obligation raised
    ->
Plan invalidated
    ->
Agent must reassess


Investigate whether this architecture corresponds to existing reactive knowledge
systems.


======================================================================
28. SEMANTIC DRIFT ACROSS AGENTS
======================================================================

Core AI-specific risk:

Agent 1:

    infers A

Agent 1 writes code/data as though A were fact

Agent 2 later observes artifact and assumes:

    A was intentional verified truth

Agent 3 builds on A


This creates:

    assumption inheritance
    semantic drift


Research whether longitudinal agent studies observe this phenomenon directly or
through adjacent failure modes.


======================================================================
29. ASSUMPTION DEBT
======================================================================

Consider defining:

    Assumption Debt

as:

    consequential behavior depending on propositions that have not reached the
    required epistemic authority.


Potential metric:

    unverified dependencies on consequential transitions


Research whether similar concepts exist in:

    requirements debt
    uncertainty debt
    technical debt
    decision debt


======================================================================
30. EPISTEMIC REQUIREMENTS FOR CAPABILITIES
======================================================================

Example:

CanShip requires:

    FraudClear = Verified

not:

    FraudClear = Inferred

This allows policy to require epistemic quality.

Potential syntax:

    requires claim FraudClear atLeast Verified


But an ordered scale may be incorrect.

Investigate whether epistemic states are safely comparable.


======================================================================
31. EPISTEMIC LATTICE HYPOTHESIS
======================================================================

Maybe states are not linear.

Example:

    Reported
    Inferred

neither necessarily dominates the other.

Likewise:

    Supported

may combine multiple evidence forms.


Research lattice models.

Possible dimensions:

    origin
    support
    contradiction
    verification
    freshness
    confidence


Ask whether the current single-enum design is structurally wrong.


======================================================================
32. FOUR-VALUED / PARACONSISTENT MODELS
======================================================================

Consider claim statuses:

    neither true nor false
    true
    false
    both true and false evidence


Belnap-style logic may represent:

    Unknown
    SupportedTrue
    SupportedFalse
    Conflicted


Compare with the proposed states.

This may be superior for contradictory evidence.


======================================================================
33. OPEN-WORLD VS CLOSED-WORLD
======================================================================

In many commercial systems:

    absence of evidence

is interpreted as:

    false


This can be dangerous.

Research:

    open-world assumption
    closed-world assumption


Ask which domains require which behavior.


======================================================================
34. HEALTHCARE CASE STUDY
======================================================================

Use a healthcare example.

Claim:

    PatientHasConditionX


Evidence:

    symptoms
    lab result
    imaging
    clinician assessment


Epistemic states may matter because:

    suspected
    supported
    diagnosed
    ruled out

are not equivalent.


Research existing clinical terminology and avoid inventing incompatible states.


======================================================================
35. ACCESSIBILITY CASE STUDY
======================================================================

Claim:

    HotelRoomIsWheelchairAccessible


Evidence:

    hotel report
    dimensions
    photos
    traveler report
    third-party inspection


Test:

    source conflicts
    stale evidence
    incomplete evidence
    verification policy change


This is an excellent domain for explicit epistemics.


======================================================================
36. FINANCE/FRAUD CASE STUDY
======================================================================

Claim:

    TransactionIsLowRisk


Potential origin:

    ML model inference


Policy may require:

    score threshold
    fresh data
    model version
    perhaps manual review


Distinguish:

    model prediction

from:

    verified fact.


======================================================================
37. SOFTWARE DEPLOYMENT CASE STUDY
======================================================================

Claim:

    BuildIsSafeToDeploy


Evidence:

    tests
    security scan
    code review
    artifact hash


Some evidence may later be invalidated:

    scanner found compromised
    test environment misconfigured


What happens to previous decisions?


======================================================================
38. RESEARCH CASE STUDY
======================================================================

Claim:

    HypothesisSupported


Evidence:

    experiments
    replications
    statistical analysis


This domain may expose weaknesses in a simplistic Verified state.


======================================================================
39. FALSE VERIFICATION
======================================================================

Critical risk:

    bad evidence satisfies policy and claim becomes Verified.


The semantic system cannot guarantee truth.

It can guarantee:

    verification procedure satisfied.


This distinction must remain explicit.


Potential naming alternative:

    VerifiedByPolicy

rather than:

    Verified


Evaluate terminology.


======================================================================
40. VERIFICATION AUTHORITY
======================================================================

Who may declare verification?

Possibilities:

    runtime verifier
    certified human
    trusted external system
    policy engine


AI agents may propose:

    evidence

but should they directly construct:

    Verified<T>?


Likely not for consequential claims.


======================================================================
41. MACHINE-CHECKABLE VERIFICATION
======================================================================

Example:

Evidence:

    measuredWidth = 36

Rule:

    width >= 32


Verification may be deterministic.


Other cases:

    clinician judgment

cannot be fully machine checked.


Develop a taxonomy:

    deterministic verification
    credential verification
    expert verification
    probabilistic assessment
    composite verification


======================================================================
42. EVIDENCE QUALITY
======================================================================

Evidence may differ by:

    directness
    source authority
    freshness
    independence
    reproducibility
    measurement quality


Ask whether evidence quality should be:

    scalar
    categorical
    policy-specific


Avoid a universal evidence score unless justified.


======================================================================
43. INDEPENDENCE OF EVIDENCE
======================================================================

Three websites repeating the same hotel marketing claim are not three
independent pieces of evidence.


This directly supports:

    repetition does not increase epistemic authority automatically.


Research:

    evidence dependence
    correlated observations
    source lineage


Provenance may be required to detect duplication.


======================================================================
44. EVIDENCE DEDUPLICATION
======================================================================

Example:

Original source S1

is copied into:

    site A
    site B
    model summary C


Without provenance, the system may count:

    three sources


With lineage:

    all derive from S1


Investigate algorithms and provenance standards.


======================================================================
45. CONTRADICTION RESOLUTION
======================================================================

When evidence conflicts:

    do not force the AI to invent resolution.


Possible outcomes:

    Contradicted
    Contested
    RequiresReview
    InsufficientEvidence


Research formal argumentation systems.


======================================================================
46. ARGUMENTATION FRAMEWORKS
======================================================================

Research:

    Dung argumentation frameworks
    structured argumentation
    defeasible argumentation
    argument support/attack graphs


Ask whether claims/evidence should be represented as argument graphs instead of
state machines in complex domains.


======================================================================
47. DEMPSTER-SHAFER / EVIDENCE THEORY
======================================================================

Research whether Dempster-Shafer better captures:

    uncertainty
    ignorance
    conflicting evidence


Do not adopt unless it materially improves the architecture.


======================================================================
48. BAYESIAN MODELS
======================================================================

Bayesian probability can model belief update.

But:

    probability != verification authority


Investigate hybrid models:

    probability/confidence
        +
    provenance
        +
    policy verification status


======================================================================
49. EPISTEMIC STATE AS AGENT CONTEXT COMPRESSION
======================================================================

Instead of sending:

    five reports
    old logs
    previous model analysis
    source documents

the agent might receive:

    Claim:
        HotelRoomHasRollInShower

    Status:
        Contested

    Supporting evidence:
        E1

    Opposing evidence:
        E2

    Required:
        IndependentMeasurement


Question:

    Does this reduce context while preserving sufficient reasoning information?


======================================================================
50. TOKEN COST
======================================================================

Measure:

A. raw evidence context

vs:

B. generated epistemic summary + lazy evidence retrieval


Record:

    tokens
    tool calls
    correctness
    evidence omissions


Potential benefit:

    agents retrieve full evidence only when needed.


======================================================================
51. LAZY EVIDENCE RETRIEVAL
======================================================================

Agent may initially receive:

    claim status
    evidence count/types
    conflict flag
    verification policy


Then call:

    get_evidence(claim)

only if needed.


Compare context economics.


======================================================================
52. SMALLER MODEL HYPOTHESIS
======================================================================

Compare:

    large model reconstructing evidence status from raw documents

against:

    smaller model receiving structured epistemic state


Measure:

    correct decisions
    hallucinated certainty
    tokens
    total cost


This could be a major economic effect.


======================================================================
53. HUMAN REVIEW
======================================================================

Structured epistemic state may let humans review:

    why claim has this status

rather than:

    reread entire history


Measure potential human-review reduction.


======================================================================
54. AUDITABILITY
======================================================================

For consequential transition:

    ShipOrder

record:

    required claim:
        AccessibilityVerified

    evidence:
        E17, E21

    verification policy:
        AccessibilityPolicy@8


This creates decision provenance.


Research audit/compliance systems.


======================================================================
55. HISTORICAL TRUTH
======================================================================

Important distinction:

    "At time T, the system reasonably accepted claim C"

vs:

    "Claim C is objectively true forever."


Historical audit should preserve:

    what was believed
    why
    under which evidence/policy


Research bitemporal systems and temporal databases.


======================================================================
56. POLICY EVOLUTION
======================================================================

Verification rule changes:

Policy@7:

    self-report sufficient

Policy@8:

    independent evidence required


Historical decisions under @7 may remain valid historically.

But current claim may require reassessment.


Investigate:

    prospective policy
    reassessment-triggering policy
    retroactive invalidation


======================================================================
57. EPISTEMIC OBLIGATIONS
======================================================================

Evidence changes may create obligations.

Examples:

    RefreshEvidence
    ReverifyClaim
    ResolveContradiction
    RequestHumanReview


This connects epistemic architecture to obligation-driven agents.


======================================================================
58. EPISTEMIC CAPABILITIES
======================================================================

Capabilities may depend on epistemic quality.

Example:

    CanApproveLoan

requires:

    IdentityVerified
    IncomeSupported
    FraudRiskAssessmentFresh


This prevents agents from treating low-authority beliefs as actionable facts.


======================================================================
59. AGENT ACTION SAFETY
======================================================================

Compare:

Prompt rule:

    "Make sure customer identity is really verified before approving."

against:

Runtime:

    CanApprove absent unless Identity claim satisfies verification policy.


Measure violations and tokens.


======================================================================
60. CROSS-AGENT CONSISTENCY
======================================================================

Multiple agents should consume the same authoritative claim/evidence state.

Otherwise:

    Agent A thinks Verified
    Agent B thinks Unknown


Research distributed consistency for knowledge state.


======================================================================
61. STALENESS
======================================================================

Agent context itself may become stale.

Version claim/evidence state.

Example:

    ClaimVersion = 18


Capability issued against:

    ClaimVersion 18


If evidence changes:

    ClaimVersion 19

capability becomes stale.


This links epistemics with version-bound capability design.


======================================================================
62. CLAIM IDENTITY
======================================================================

Claims need stable identity.

Example:

    "Room 217 has a 36-inch bathroom door"

is distinct from:

    "Hotel has accessible rooms"


Avoid vague propositions.


Research:

    RDF triples
    knowledge graphs
    ontology modeling
    proposition identity


======================================================================
63. SUBJECT VERSIONING
======================================================================

Evidence may apply to a particular version/configuration.

Example:

    Room accessibility measurement before renovation

should not automatically apply after renovation.


Claim scope may need:

    subject version
    effective period


======================================================================
64. SEMANTIC GRANULARITY
======================================================================

Too coarse:

    HotelAccessible = Verified


Better:

    EntranceStepFree
    DoorWidth
    RollInShower
    GrabBars


Research granularity tradeoffs.

Excessively fine claims may explode context and storage.


======================================================================
65. ONTOLOGY RISK
======================================================================

A rich claim system may evolve into:

    ontology/knowledge graph platform


This could create enormous complexity.

Investigate how to keep v0.1 bounded.


======================================================================
66. MINIMUM VIABLE EPISTEMIC MODEL
======================================================================

Propose the smallest model that captures most value.

Possible:

Claim:
    id
    proposition
    subject

Evidence:
    id
    source
    observedAt
    supports/opposes
    provenance

Derived claim status:
    Unknown
    Supported
    Contested
    Verified

Verification record:
    policy
    authority
    timestamp


Compare with the existing 8-state proposal.


======================================================================
67. STATE MACHINE VS DERIVED VIEW
======================================================================

Critical question:

Should epistemic status be authoritative mutable state?

Or:

    derived from evidence graph + verification records?


If derived, status cannot drift independently.


This may be a major architecture change.


======================================================================
68. EVENT SOURCING
======================================================================

Potential evidence events:

    EvidenceAdded
    EvidenceRetracted
    EvidenceExpired
    VerificationGranted
    VerificationRevoked


Epistemic status can be projected.

Compare with event sourcing.


======================================================================
69. SEMANTIC COMPILER
======================================================================

Possible compiler checks:

    Verified claims must have verification producer
    capability cannot require undefined epistemic status
    invalidated evidence cannot support current verification
    evidence dependency cycles
    missing provenance
    stale verification policy
    impossible verification requirement


Investigate feasibility.


======================================================================
70. CLAIM POLICY
======================================================================

Example:

claim FraudClear {
    verification:
        requires RiskAssessment
        maxAge 30m
        modelVersion approved
}


The semantic compiler could generate:

    verification checks
    capability requirements
    agent context


Compare with rule engines/policy engines.


======================================================================
71. SINGLE SOURCE OF TRUTH RISK
======================================================================

If the verification policy is wrong:

    all agents may be consistently wrong.


This creates correlated semantic failure.


Mitigation:

    independent policy review
    test cases
    mutation testing
    evidence audits
    human oversight


Research this seriously.


======================================================================
72. FALSE CERTAINTY RISK
======================================================================

A label:

    Verified

may create psychological overconfidence.

Potential alternative terms:

    VerifiedUnderPolicy
    Accepted
    Established
    Qualified
    Satisfied


Research terminology in regulated systems.


======================================================================
73. FALSE NEGATIVE RISK
======================================================================

A claim may be true but remain:

    Unsupported

because evidence is missing.


System must distinguish:

    not proven

from:

    false


This is crucial.


======================================================================
74. AGENT GAMING
======================================================================

Agent tasked:

    "Get this claim verified."

May attempt:

    fabricate evidence
    use low-quality source
    change verification policy
    duplicate evidence


Strong architecture should prevent shortcuts.


======================================================================
75. EVIDENCE FABRICATION
======================================================================

Trusted evidence constructors must be protected.

AI-generated text should not become trusted evidence merely because it is
stored in the system.


Investigate:

    signed attestations
    source authentication
    content hashes
    cryptographic provenance


======================================================================
76. EXTERNAL SOURCE UNCERTAINTY
======================================================================

What if:

    external API gives incorrect data?


Provenance lets system say:

    verified source response

but not:

    objectively true


Again distinguish:

    procedural verification

from:

    metaphysical truth.


======================================================================
77. HUMAN TESTIMONY
======================================================================

Self-report may be legitimate evidence.

Example:

    traveler reports fatigue


Do not rank all self-report as low quality automatically.

Evidence policy must be domain-specific.


======================================================================
78. PRIVACY
======================================================================

Evidence/provenance systems may accumulate sensitive data.

Research:

    minimization
    selective disclosure
    access control
    retention
    cryptographic commitments


Explicit evidence architecture has privacy costs.


======================================================================
79. SECURITY
======================================================================

Attackers may target:

    evidence
    provenance
    verification process


Threats:

    evidence injection
    replay
    stale credential use
    source spoofing
    provenance tampering


Research trust architecture.


======================================================================
80. EXPERIMENT — ASSUMPTION PROMOTION
======================================================================

Give agent:

    ambiguous source saying X is probably true


Compare:

A. ordinary system

B. epistemic architecture


Then perform later tasks relying on X.

Measure:

    whether X becomes treated as fact
    downstream errors
    tokens
    corrective work


======================================================================
81. EXPERIMENT — REPEATED REPORT
======================================================================

Provide the same original claim through five derivative sources.

Measure whether agent incorrectly interprets:

    repetition

as:

    independent corroboration


Epistemic provenance should expose shared source lineage.


======================================================================
82. EXPERIMENT — EVIDENCE INVALIDATION
======================================================================

Start:

    Claim = Verified


Invalidate foundational evidence.

Measure:

    claim downgrade
    capabilities removed
    obligations generated
    stale actions rejected


Compare with conventional system.


======================================================================
83. EXPERIMENT — CONTRADICTORY EVIDENCE
======================================================================

Provide:

    one strong supporting source
    one strong opposing source


Measure:

    whether agent invents certainty
    whether architecture preserves conflict
    downstream actions


======================================================================
84. EXPERIMENT — POLICY CHANGE
======================================================================

Change verification policy.

Measure:

    affected claims surfaced
    token/context cost
    obligations created
    incorrect historical reinterpretation


======================================================================
85. EXPERIMENT — AGENT RESTART
======================================================================

Agent 1 investigates claim.

Agent 2 starts fresh.

Compare:

A. raw history/context

B. authoritative epistemic record


Measure:

    reconstruction tokens
    disagreement
    duplicated research


======================================================================
86. EXPERIMENT — SMALL MODEL
======================================================================

Compare:

    large model + raw evidence corpus

against:

    smaller model + structured epistemic state


Measure:

    decision correctness
    false certainty
    tokens
    cost


======================================================================
87. EPISTEMIC PRECISION/RECALL
======================================================================

Potential metrics:

Verification Precision:

    claims marked verified that truly satisfy reference verification standard
    -------------------------------------------------------------------------
    claims marked verified


Verification Recall:

    truly verifiable claims marked verified
    ---------------------------------------
    truly verifiable claims


Also track:

    false certainty rate
    unsupported-action rate


======================================================================
88. ASSUMPTION SURVIVAL RATE
======================================================================

Metric:

    unsupported assumptions remaining consequential after N agent changes


Compare architectures longitudinally.


======================================================================
89. EVIDENCE RECONSTRUCTION COST
======================================================================

Measure:

    tokens/tool calls required to reconstruct why claim is accepted


Compare:

    conventional records

against:

    explicit provenance/evidence graph.


======================================================================
90. COST PER JUSTIFIED DECISION
======================================================================

Potential economic metric:

    total agent execution cost
    --------------------------
    consequential decisions with adequate evidence/provenance


This may be more meaningful than raw token count.


======================================================================
91. LONGITUDINAL TEST
======================================================================

Run:

    50–100 agent modifications/decisions


Track:

    assumptions introduced
    assumptions promoted
    verification errors
    stale evidence
    inherited beliefs
    correction cost
    context tokens


Hypothesis:

    explicit epistemics prevents compounding assumption drift.


======================================================================
92. COUNTERARGUMENTS
======================================================================

Actively test:

1. The epistemic model becomes too complex.
2. Most commercial software does not need this.
3. Verification status creates false confidence.
4. Evidence graphs consume too many tokens.
5. Agents still need raw sources.
6. Human judgment cannot be encoded.
7. Probability/confidence already solves most of the problem.
8. Provenance is expensive to maintain.
9. Evidence policies become brittle.
10. Contradiction logic becomes a research project itself.
11. Knowledge graphs introduce too much infrastructure.
12. Model outputs may still influence verification indirectly.
13. Users dislike being told "unknown."
14. Systems may become unable to act under uncertainty.
15. Structured epistemics may slow product development.


======================================================================
93. WHERE NOT TO USE
======================================================================

Identify domains where explicit epistemic state is unnecessary.

Likely examples:

    pure computation
    transient UI state
    low-consequence preferences
    obvious deterministic values


Use only where:

    provenance
    uncertainty
    evidence
    authority
    consequential decisions

matter.


======================================================================
94. EXISTING RESEARCH TO PRIORITIZE
======================================================================

Search:

    truth maintenance systems
    assumption-based TMS
    AGM belief revision
    epistemic logic
    dynamic epistemic logic
    paraconsistent logic
    Belnap four-valued logic
    Dung argumentation frameworks
    defeasible reasoning
    Dempster-Shafer theory
    Bayesian evidence
    W3C PROV
    database provenance
    scientific workflow provenance
    clinical evidence systems
    source trust
    trust management
    knowledge graph provenance
    AI uncertainty calibration
    hallucination mitigation
    longitudinal agent belief errors


======================================================================
95. SOURCE QUALITY
======================================================================

Prefer:

    original papers
    standards
    foundational texts
    primary empirical research
    official provenance specifications


Clearly distinguish:

    established formal result
    empirical AI evidence
    architecture inference
    speculation


======================================================================
96. REQUIRED OUTPUT
======================================================================

Produce:

1. Executive verdict
2. Formal definition of Claim
3. Formal definition of Evidence
4. Epistemic-state critique
5. State machine vs lattice analysis
6. Status vs confidence analysis
7. Unknown/false analysis
8. Reported/verified analysis
9. Assumption modeling
10. Inference modeling
11. Contradiction modeling
12. Invalidation modeling
13. Truth-maintenance comparison
14. Belief-revision comparison
15. Epistemic-logic comparison
16. Provenance comparison
17. Evidence-theory comparison
18. Argumentation-framework comparison
19. Bayesian/Dempster-Shafer comparison
20. Verification-policy model
21. Evidence-authority model
22. Freshness model
23. Policy-version model
24. Claim dependency/cascade model
25. AI-agent assumption-drift analysis
26. Context/token implications
27. Smaller-model hypothesis
28. Security implications
29. Privacy implications
30. Failure modes
31. Proposed experiments
32. Metrics
33. Economic implications
34. What is supported by existing research
35. What remains speculative
36. Architecture changes recommended
37. Minimum viable epistemic model
38. Final verdict


======================================================================
97. FINAL VERDICT FORMAT
======================================================================

Answer:

Does explicit epistemic state reduce unsupported certainty?
    Strong evidence / Moderate evidence / Weak evidence / No evidence

Does evidence provenance reduce inherited agent assumptions?
    Strong evidence / Moderate evidence / Weak evidence / No evidence

Does structured epistemic state reduce context/token cost?
    Strong evidence / Moderate evidence / Weak evidence / No evidence

Can it enable smaller models?
    Strong evidence / Moderate evidence / Weak evidence / No evidence

Should epistemic status be:
    mutable state / derived state / lattice / multi-dimensional record / other

Should "Verified" be renamed?
    Yes / No / Maybe
    Recommendation: ...

Closest existing formalism:
    ...

Strongest prior art:
    ...

Most important architecture correction:
    ...

Biggest complexity risk:
    ...

Most valuable AI-specific benefit:
    ...

Most important missing experiment:
    ...


======================================================================
98. RESEARCH STANDARD
======================================================================

Be skeptical.

Do not assume an eight-case union is the right epistemic model.

Do not treat confidence as verification.

Do not treat verification as objective truth.

Do not assume more evidence means better evidence.

Do not count repeated copies of one source as independent evidence.

Do not allow Unknown to collapse into False without explicit closed-world policy.

Do not assume AI-generated text can serve as trusted evidence.

Do not build a full knowledge-representation platform unless evidence shows it
is necessary.

The central question is:

    Can explicit claims, evidence, provenance, and epistemic authority prevent
    AI agents from turning uncertain assumptions into durable system truth —
    while remaining simple enough to improve rather than overwhelm the
    architecture?
