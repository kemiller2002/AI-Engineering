AI RESEARCH MISSION 12 — A STANDARD SEMANTIC PROTOCOL FOR AI AGENTS
====================================================================

ROLE
====

Act as a combined:

- AI-agent systems researcher
- protocol/API design researcher
- software-architecture researcher
- automated-planning researcher
- programming-languages researcher
- capability-security researcher
- workflow systems researcher
- distributed-systems researcher
- interoperability researcher
- AI inference-cost researcher

Your task is to investigate whether AI agents could interact with complex
software through a small, standardized semantic protocol rather than through
large collections of application-specific tools and undocumented business logic.

The proposed long-term idea is:

    Different applications may expose the same small semantic instruction set.

Possible operations:

    get_state
    get_capabilities
    get_obligations
    explain_blocked
    find_paths
    request_transition
    get_evidence
    get_policy_context
    observe_effect
    reconcile_effect

The application-specific meaning lives in:

    states
    transitions
    capabilities
    obligations
    evidence
    policy
    effects

rather than in an ever-growing set of bespoke agent instructions.

The central hypothesis is:

    A standardized semantic agent protocol may reduce application-specific
    tool learning, prompt size, action-space complexity, integration drift,
    and model context requirements.

Do NOT assume this is novel or useful.

Find the strongest existing analogues and attempt to prove that existing agent
protocols, tool APIs, planners, workflow systems, or capability frameworks
already solve the problem.


======================================================================
1. PRIMARY RESEARCH QUESTION
======================================================================

Can a small standardized semantic protocol serve as a reusable interface
between probabilistic AI agents and authoritative software systems?

Specifically:

    Can agents operate across different domains while reusing the same basic
    interaction grammar?

    Does this reduce per-application prompt/tool complexity?

    Does it improve correctness?

    Does it reduce token/tool-selection cost?

    Does it make model behavior more portable across systems?

    Does it separate agent reasoning from application implementation details?


======================================================================
2. PROPOSED CORE PROTOCOL
======================================================================

Candidate minimal operations:

    get_state(subject)

    get_capabilities(subject)

    get_obligations(subject | actor | scope)

    explain_blocked(action, subject)

    find_paths(goal, subject)

    request_transition(subject, transition, inputs)

Potential supporting operations:

    get_evidence(claim)

    get_policy_context(subject)

    observe_effect(effectId)

    reconcile_effect(effectId)

Do not assume all are necessary.

Try to reduce this to the smallest useful protocol.


======================================================================
3. CORE ARCHITECTURAL IDEA
======================================================================

Instead of exposing:

    approveCustomer()
    refundPayment()
    shipOrder()
    cancelSubscription()
    reopenClaim()
    deployRelease()
    restartService()
    verifyDiagnosis()
    issueCertificate()
    ...

the runtime exposes semantic operations.

Example:

Agent:

    get_state(Order123)

Runtime:

    OrderState = Approved
    PaymentState = Authorized
    ShipmentState = Ready

Agent:

    get_capabilities(Order123)

Runtime:

    CapturePayment

Agent:

    request_transition(Order123, CapturePayment)

Runtime validates:

    current state
    authority
    evidence
    policy
    versions
    freshness

Then commits or rejects.


======================================================================
4. TOOL API VS SEMANTIC PROTOCOL
======================================================================

Distinguish:

A. Application tool API

    dozens/hundreds of domain-specific functions

from:

B. Semantic protocol

    small fixed interaction grammar
    domain semantics carried as data/model


Question:

    Does this actually reduce complexity,
    or merely move complexity from tool names into semantic payloads?


======================================================================
5. EXISTING PROTOCOLS TO INVESTIGATE
======================================================================

Research current and historical systems such as:

    Model Context Protocol (MCP)
    OpenAPI-based agent tooling
    function calling / tool calling
    JSON-RPC
    GraphQL
    REST
    gRPC
    hypermedia / HATEOAS
    HAL
    Siren
    Hydra
    JSON:API
    workflow APIs
    planning APIs
    BDI agent platforms
    capability protocols
    actor messaging
    command/query separation
    event sourcing APIs
    policy decision APIs
    semantic web / RDF / OWL
    linked data
    agent communication languages
    FIPA ACL
    KQML
    HTN/planner interfaces
    robotic affordance interfaces


======================================================================
6. MCP COMPARISON
======================================================================

Research current official MCP specification and ecosystem.

Ask:

    Does MCP already provide the needed standardization?

Likely MCP standardizes:

    connection
    resources
    prompts
    tools

But investigate whether it standardizes:

    state legality
    capabilities
    obligations
    transition semantics
    policy
    evidence
    effect uncertainty
    planning prerequisites

Do not assume the answer.


======================================================================
7. TOOL CALLING COMPARISON
======================================================================

Current LLM tool interfaces often expose:

    tool name
    description
    JSON input schema

Question:

    Is the proposed protocol simply another tool set?

Potential difference:

    tool vocabulary stays fixed
    semantic action vocabulary is dynamically derived


Evaluate.


======================================================================
8. HATEOAS / HYPERMEDIA
======================================================================

This is potentially a very close analogue.

REST hypermedia proposes that a response tells the client:

    what actions/links are currently available


This resembles:

    capabilities expose currently legal actions


Research:

    HATEOAS
    hypermedia controls
    affordances
    state transitions
    application state

Ask:

    Are capabilities effectively hypermedia affordances for AI agents?

This comparison is essential.


======================================================================
9. HYPERMEDIA AFFORDANCES
======================================================================

Example:

Order resource may contain:

    capture-payment
    cancel-order

but not:

    ship-order

until legal.


This is extremely close to dynamic capability exposure.

Determine:

    what hypermedia already solved
    why HATEOAS adoption remained limited
    what AI changes about its value proposition


======================================================================
10. AFFORDANCE THEORY
======================================================================

Research:

    affordances in HCI
    robotic affordances
    action possibilities
    state-conditioned affordances


Potential mapping:

    capability = machine-authoritative affordance


Determine whether this is a better conceptual term.


======================================================================
11. FIPA ACL / KQML
======================================================================

Historical agent systems attempted standard agent communication languages.

Research:

    performatives
    request
    inform
    query
    propose
    agree
    refuse


Ask:

    Why did broad agent communication languages not become dominant?

What lessons should we avoid repeating?


======================================================================
12. BDI AGENT INTERFACES
======================================================================

Potential mapping:

    state/evidence -> beliefs
    obligations -> goals/desires
    capabilities -> executable actions
    plans -> intentions


Research whether BDI platforms already expose similar primitives.


======================================================================
13. PLANNER DOMAIN INTERFACE
======================================================================

PDDL separates:

    domain actions
    preconditions
    effects

from:

    current problem state
    goal


This is similar to:

    semantic state
    transitions
    capabilities
    obligations


Ask whether the proposed protocol is essentially:

    an operationalized planner interface.


======================================================================
14. STRIPS / PDDL COMPARISON
======================================================================

Example:

    find_paths(goal)

may simply invoke planning over:

    preconditions
    effects
    current state


Determine what additions are needed for commercial systems:

    authority
    evidence
    policy versioning
    concurrency
    external effects
    obligations
    provenance


======================================================================
15. GRAPHQL COMPARISON
======================================================================

GraphQL standardizes:

    querying typed application data

but not typically:

    legal transitions
    current affordances
    obligations


Could semantic protocol be layered on GraphQL?

Research.


======================================================================
16. COMMAND/QUERY SEGREGATION
======================================================================

Potential protocol split:

Queries:

    get_state
    get_capabilities
    get_obligations
    explain_blocked
    find_paths

Commands:

    request_transition


This resembles CQRS.

Determine whether this improves clarity.


======================================================================
17. OBSERVATION VS ACTION
======================================================================

Agent protocols should separate:

    observation

from:

    commitment.


Observation operations should be safe/read-only.

Action operation should pass deterministic gate.

This mirrors probabilistic/deterministic responsibility research.


======================================================================
18. GENERIC TRANSITION REQUEST
======================================================================

Candidate:

request_transition {
    subjectId
    transitionId
    parameters
    expectedStateVersion
    capabilityToken?
}


Question:

    Is a generic transition endpoint too abstract?

Would explicit typed endpoints be safer?


======================================================================
19. TYPED DOMAIN TOOLS VS GENERIC PROTOCOL
======================================================================

Compare:

A.

    refund_payment(paymentId, amount)

B.

    request_transition(
        subject=paymentId,
        transition="Refund",
        inputs={amount}
    )


Tradeoffs:

    discoverability
    type safety
    token size
    debugging
    security
    model error rate


This is a crucial comparison.


======================================================================
20. GENERIC PROTOCOL RISKS
======================================================================

Generic APIs can become:

    stringly typed
    opaque
    hard to document
    runtime-error prone


Need stable semantic IDs and schemas.

Research how to preserve strong typing.


======================================================================
21. SEMANTIC IDS
======================================================================

Use stable identifiers:

    TRANS-PAYMENT-REFUND
    CAP-PAYMENT-REFUND
    OBL-REFUND-RECONCILE


Agent may receive human labels separately.

This helps:

    rename stability
    versioning
    migration


Evaluate usability.


======================================================================
22. SCHEMA DISCOVERY
======================================================================

Agent may call:

    describe_transition(id)

to retrieve:

    inputs
    expected outcomes
    requirements
    effect semantics


Question:

    Should schemas be lazy-loaded to reduce context?


======================================================================
23. CAPABILITY INSTANCE VS CAPABILITY TYPE
======================================================================

Distinguish:

Capability type:

    RefundPayment

Capability instance:

    RefundPayment for Payment P42
    valid against StateVersion 18
    PolicyVersion 7


Protocol must represent both correctly.


======================================================================
24. UNFORGEABLE CAPABILITY
======================================================================

Agent should not fabricate:

    capabilityId


Possible runtime representation:

    opaque token
    signed token
    server-side reference


Research capability-security approaches.


======================================================================
25. STATE QUERY
======================================================================

What should `get_state` return?

Possibilities:

    raw domain object
    semantic state only
    claims/evidence summary
    version
    relevant projections


Too much data defeats context compression.


======================================================================
26. MINIMUM STATE VIEW
======================================================================

Potential agent-facing view:

    Subject
    StateFamilies
    CurrentCases
    Version
    RelevantClaims


Do not expose implementation internals.


======================================================================
27. CAPABILITY QUERY
======================================================================

`get_capabilities` may return:

    currently executable transitions


Potential fields:

    semantic ID
    label
    required inputs
    capability token
    expiration/version
    consequence class


Keep projection compact.


======================================================================
28. OBLIGATION QUERY
======================================================================

`get_obligations` may return unresolved semantic work.

Potential filters:

    subject
    module
    actor capability
    urgency
    deadline
    scope


This could become agent work discovery API.


======================================================================
29. EXPLAIN_BLOCKED
======================================================================

Possible output:

    ShipOrder unavailable

Missing:
    PaymentState = Captured

Producer:
    CapturePayment

Also blocked by:
    FraudEvidence expired


Question:

    Is this enough for agent planning without exposing all constraints upfront?


======================================================================
30. FIND_PATHS
======================================================================

Potential operation:

    find_paths(goal)


Result:

    Path 1:
        CapturePayment
        ShipOrder

    Path 2:
        EscalateForManualPayment
        ShipOrder


Do we want deterministic runtime to plan?

Or:

    agent should perform planning?


Research tradeoffs.


======================================================================
31. PLANNER AS PROTOCOL SERVICE
======================================================================

If runtime already knows:

    state
    transitions
    prerequisites

then path search may be cheap and deterministic.

This could reduce model reasoning cost.


======================================================================
32. REQUEST_TRANSITION
======================================================================

This is the key commitment operation.

Runtime should validate:

    transition exists
    capability valid
    actor authority
    state version
    policy version
    evidence
    freshness
    concurrency
    effect constraints


Then return typed result.


======================================================================
33. TRANSITION RESULT
======================================================================

Potential:

    Accepted
    Rejected(reason)
    Conflict(currentVersion)
    EffectPending
    EffectOutcomeUnknown
    Completed


Need careful model.


======================================================================
34. EFFECT OBSERVATION
======================================================================

Consequential external effects may require:

    observe_effect(effectId)


This may return:

    Pending
    Succeeded
    Failed
    OutcomeUnknown


Connect with research track 06.


======================================================================
35. RECONCILE_EFFECT
======================================================================

Possible operation:

    reconcile_effect(effectId)


But reconciliation itself may involve domain-specific actions.

Determine whether generic operation is too broad.


======================================================================
36. GET_EVIDENCE
======================================================================

Agents may lazily retrieve evidence supporting:

    claims
    capabilities
    obligations


This could reduce context.


======================================================================
37. GET_POLICY_CONTEXT
======================================================================

Should agents inspect policy?

Potentially return:

    relevant policy version
    explanation
    constraints


Do not expose all policy source unnecessarily.


======================================================================
38. EXPLAIN_WHY_AVAILABLE
======================================================================

Maybe agent needs:

    why capability exists


This helps audit/debug.

But may add token cost.

Keep lazy.


======================================================================
39. DISCOVER_SEMANTICS
======================================================================

Potential generic discovery:

    list_state_families
    list_transition_types
    describe_semantic_id


Question:

    does protocol become too large?


======================================================================
40. MINIMAL PROTOCOL HYPOTHESIS
======================================================================

Try to determine if only four operations are enough:

    observe
    capabilities
    obligations
    transition


Everything else could be optional metadata.


======================================================================
41. UNIVERSALITY
======================================================================

Test protocol across:

    payments
    healthcare
    DevOps
    manufacturing
    travel
    compliance
    research workflow


If every domain requires many special operations:

    universal protocol hypothesis weakens.


======================================================================
42. DOMAIN-SPECIFIC PAYLOADS
======================================================================

A stable protocol may still carry domain-specific schemas.

Example:

Refund transition input:

    amount
    reason


Deploy transition input:

    releaseId
    environment


Is that enough standardization to matter?


======================================================================
43. SEMANTIC TRANSPORT VS DOMAIN MEANING
======================================================================

The protocol may standardize:

    how to ask

not:

    what the answer means.


This may still be useful.

Compare with:

    HTTP
    SQL
    GraphQL
    RPC


======================================================================
44. INSTRUCTION SET ANALOGY
======================================================================

Potential analogy:

    semantic agent protocol = instruction set

Applications compile domain semantics into:

    states
    transitions
    capabilities
    obligations


Do not overuse analogy.

Evaluate whether it clarifies design.


======================================================================
45. AGENT ABI ANALOGY
======================================================================

Could there be an:

    Agent Semantic ABI


Stable protocol allows:

    models
    orchestrators
    runtimes

to interoperate.


Research prior "agent OS" ideas.


======================================================================
46. AGENT OPERATING SYSTEMS
======================================================================

Search current work on:

    agent OS
    agent runtime
    agent kernel
    tool router
    action layer
    safety layer


Determine whether semantic protocol already exists under another framing.


======================================================================
47. TOOL REGISTRY COMPARISON
======================================================================

Most frameworks provide:

    list of tools


Semantic protocol might instead provide:

    list of legal capabilities


This is more dynamic.


Measure incremental value.


======================================================================
48. TOOL RETRIEVAL COMPARISON
======================================================================

Tool retrieval selects:

    likely relevant tools

Semantic capability exposure selects:

    currently legal actions


These can combine:

    relevance
        +
    legality


Research architecture.


======================================================================
49. ACTION MASKING
======================================================================

In RL:

    action mask identifies valid actions


Semantic protocol could be viewed as:

    application-level action mask API


Determine implications.


======================================================================
50. AFFORDANCE API
======================================================================

Maybe simpler framing:

    get_affordances(subject)


Response:

    legal actions


Compare terminology:

    capability
    affordance
    transition


Choose precise meaning.


======================================================================
51. CAPABILITY VS AFFORDANCE
======================================================================

Possible distinction:

Affordance:

    action possible from state

Capability:

    action authorized for actor under state/policy/evidence


This distinction may matter.


======================================================================
52. AGENT AUTHENTICATION
======================================================================

Protocol must know:

    actor identity


Capabilities depend on:

    who is asking.


Research auth integration.


======================================================================
53. AUTHORITY CONTEXT
======================================================================

`get_capabilities` should not return same actions to:

    customer
    support agent
    administrator
    autonomous agent


Need actor-scoped capability derivation.


======================================================================
54. DELEGATION
======================================================================

Can human delegate:

    capability

to agent?


Research capability delegation.


======================================================================
55. REVOCATION
======================================================================

Capabilities may become invalid due to:

    state change
    policy change
    authority change


Protocol must handle stale tokens.


======================================================================
56. VERSIONING
======================================================================

State response should include:

    stateVersion
    semanticSpecVersion
    policyVersion


Transition request may bind to them.


======================================================================
57. OPTIMISTIC CONCURRENCY
======================================================================

If state changed between:

    observe
    act

runtime rejects stale transition.


Agent then refreshes.


This is protocol-level concurrency control.


======================================================================
58. IDEMPOTENCY
======================================================================

Transition request should include:

    semanticOperationId


Especially for external effects.


Research.


======================================================================
59. TRANSACTION IDENTITY
======================================================================

Protocol should distinguish:

    retry same semantic operation

from:

    initiate new operation


Critical for payments/effects.


======================================================================
60. POLICY VERSION SKEW
======================================================================

Agent may plan using policy v7.

Before execution:

    policy v8 active


Runtime rejects or re-evaluates.


Protocol must expose enough to recover.


======================================================================
61. OBLIGATION VERSIONING
======================================================================

Obligation satisfaction may depend on current policy/state.

Track versions.


======================================================================
62. ERROR TAXONOMY
======================================================================

Avoid generic:

    Error


Potential errors:

    NotAuthorized
    TransitionNotAvailable
    StaleState
    MissingEvidence
    PolicyChanged
    Conflict
    OutcomeUnknown
    InvalidInput
    ObligationConflict


Structured errors help agents.


======================================================================
63. MACHINE-READABLE DIAGNOSTICS
======================================================================

Error should include:

    semantic code
    relevant IDs
    missing prerequisites
    next legal actions


This could reduce repair loops.


======================================================================
64. NATURAL-LANGUAGE EXPLANATION
======================================================================

Runtime may generate deterministic structured explanation.

AI can translate it for human.


Do not rely on AI to invent root cause.


======================================================================
65. TOOL TOKEN COST
======================================================================

Compare:

A. 100 domain-specific tools with schemas

B. 6 generic semantic operations + dynamic schemas


Measure actual token cost.


======================================================================
66. SCHEMA TOKEN COST
======================================================================

Generic transition request may need:

    dynamic transition schema


If agent must retrieve schema every time:

    overhead may erase savings.


Measure.


======================================================================
67. TOOL-SELECTION COST
======================================================================

With fixed protocol:

    model chooses among 6 operations

rather than:

    100 business tools


But then it must choose semantic transition ID.

Is total selection complexity really lower?


Test.


======================================================================
68. ACTION-SELECTION DECOMPOSITION
======================================================================

Potential:

Step 1:
    protocol operation = request_transition

Step 2:
    capability list already narrows semantic transitions


Thus model never selects from all possible actions.


This may reduce branching.


======================================================================
69. MODEL GENERALIZATION
======================================================================

Hypothesis:

    Once model learns semantic protocol,
    it can operate new applications with less prompt engineering.


Test cross-domain transfer.


======================================================================
70. CROSS-DOMAIN EXPERIMENT
======================================================================

Train/instruct agent on protocol in:

    payments

Then give same protocol in:

    deployment
    travel
    healthcare simulation


Measure adaptation cost.


======================================================================
71. PROMPT PORTABILITY
======================================================================

Compare:

Application-specific prompt:

    2,000 tokens of operational rules

vs:

Generic protocol prompt:

    "Use capabilities for legal actions; obligations for required work..."


Measure.


======================================================================
72. MODEL FINE-TUNING POSSIBILITY
======================================================================

A standardized protocol could enable:

    model training/fine-tuning around stable interaction grammar.


This may improve tool use.


Research analogous stable APIs.


======================================================================
73. BENCHMARK STANDARDIZATION
======================================================================

A semantic protocol could make agent benchmarks portable.

Same agent can operate:

    different semantic environments


Measure:

    planning
    correctness
    cost


Potential research value.


======================================================================
74. AGENT EVALUATION
======================================================================

Protocol exposes clean metrics:

    illegal transition requests
    obligations resolved
    stale capability attempts
    path efficiency


Could improve benchmarking.


======================================================================
75. SECURITY BENEFIT
======================================================================

Agent receives no generic:

    shell
    SQL
    arbitrary API

for authoritative operations.

Only:

    semantic transition protocol


This could reduce attack surface.


======================================================================
76. SECURITY LIMITATION
======================================================================

If agent also has:

    database
    shell
    cloud console

it may bypass protocol.


Need capability isolation at infrastructure level.


======================================================================
77. PROTOCOL AS REFERENCE MONITOR INTERFACE
======================================================================

All consequential state mutation passes:

    request_transition


This resembles complete mediation.


Research.


======================================================================
78. AUDIT LOG
======================================================================

Each protocol action can log:

    actor
    state version
    transition
    capability
    policy
    evidence
    outcome


This yields uniform auditability.


======================================================================
79. OBSERVABILITY
======================================================================

Operational monitoring can track:

    capability queries
    blocked actions
    unresolved obligations
    transition attempts


Could reveal agent behavior patterns.


======================================================================
80. EXPLORATION PRIVACY
======================================================================

Agent may ask many hypothetical queries.

Should:

    find_paths

or:

    explain_blocked

be auditable differently from:

    transition execution?


======================================================================
81. READ-SIDE ABUSE
======================================================================

Even read operations may expose sensitive state/evidence.

Need authorization.


======================================================================
82. CONTEXT MINIMIZATION
======================================================================

Protocol should return only:

    information agent is authorized and needs to see.


This can improve both:

    privacy
    token cost.


======================================================================
83. PARTIAL OBSERVABILITY
======================================================================

Agent may not see full state.

Protocol may expose:

    authorized projection


Planning under partial visibility becomes harder.


Research.


======================================================================
84. EXPLAIN_BLOCKED SECURITY
======================================================================

Blocked explanations can leak:

    sensitive policy
    hidden fraud criteria


Need redaction/scoped explanations.


======================================================================
85. MULTI-AGENT COORDINATION
======================================================================

Could obligations be claimed through same protocol?

Potential:

    claim_obligation
    release_obligation


Do these belong in core protocol?


======================================================================
86. WORK QUEUE OPERATIONS
======================================================================

Possible:

    get_obligations
    claim_obligation
    report_progress
    resolve_obligation


But this begins resembling workflow/job API.


Determine minimality.


======================================================================
87. OBLIGATION SATISFACTION
======================================================================

Prefer:

    obligations resolve automatically from state

rather than:

    agent marks done


This reduces protocol surface.


======================================================================
88. PROGRESS TRACKING
======================================================================

Some long-running obligations need:

    work state


Could be separate orchestration layer rather than semantic core.


======================================================================
89. GENERIC PROTOCOL VS WORKFLOW ENGINE
======================================================================

Ask:

    Is this simply a workflow-engine API?


Compare:

    workflow instance
    current task
    legal next step


Identify incremental value.


======================================================================
90. GENERIC PROTOCOL VS DATABASE CRUD
======================================================================

Could operations be:

    get
    query
    mutate


Semantic protocol is intentionally narrower.

Evaluate whether this restriction matters.


======================================================================
91. GENERIC PROTOCOL VS EVENT SOURCING
======================================================================

Could:

    request_transition

simply append command/event?


Compare.


======================================================================
92. GENERIC PROTOCOL VS OBJECT METHODS
======================================================================

Could agent simply call:

    subject.availableActions()
    subject.execute(action)


Maybe protocol is ordinary OO design over network.


Test novelty.


======================================================================
93. CLIENT SDK GENERATION
======================================================================

Even if wire protocol generic, generate typed SDK:

    payment.capture()
    order.ship()


Humans may prefer typed SDK.

Agents may prefer generic semantic protocol.


This hybrid may be ideal.


======================================================================
94. AGENT-SPECIFIC PROJECTION
======================================================================

The semantic protocol need not be public application API.

It could be:

    agent-facing projection

generated from domain model.


This may reduce disruption.


======================================================================
95. HUMAN/API COMPATIBILITY
======================================================================

Existing REST/GraphQL endpoints may remain.

Agent protocol sits alongside.


Evaluate duplication risk.


======================================================================
96. SEMANTIC COMPILER GENERATION
======================================================================

Semantic compiler could generate:

    protocol handlers
    schemas
    capability projections
    transition registry
    diagnostics


This connects to track 08.


======================================================================
97. HOST-LANGUAGE INDEPENDENCE
======================================================================

Same protocol can sit over:

    Java
    C#
    F#
    TypeScript
    Python
    Rust


This connects to track 11.


======================================================================
98. AGENT IMPLEMENTATION INDEPENDENCE
======================================================================

Agent need not know:

    repository language
    DB schema
    framework


for operational tasks.


Potential huge benefit.


======================================================================
99. CODING AGENT VS OPERATIONAL AGENT
======================================================================

Operational agents may benefit strongly.

Coding agents still need repository access.

But coding agents could use semantic protocol to:

    inspect current semantics
    validate changes
    run semantic impact


Separate use cases.


======================================================================
100. DEVELOPMENT PROTOCOL EXTENSIONS
======================================================================

Possible coding-agent operations:

    get_semantic_dependencies
    validate_migration
    semantic_diff
    impact_report


Do these belong in same protocol?


======================================================================
101. CORE VS DEVELOPMENT PROFILE
======================================================================

Potential profiles:

Runtime profile:
    state
    capabilities
    obligations
    transition

Development profile:
    dependencies
    migrations
    impact
    validation


This may preserve minimal runtime interface.


======================================================================
102. VERSION NEGOTIATION
======================================================================

Protocol itself evolves.

Need:

    protocolVersion
    semanticSpecVersion


Research compatibility.


======================================================================
103. EXTENSIBILITY
======================================================================

Domains may need extra operations.

Avoid fragmenting standard.


Potential:

    extension namespaces


Study protocol design lessons.


======================================================================
104. PROTOCOL NEGOTIATION
======================================================================

Agent may query:

    supportedCapabilities
    supportedProtocolFeatures


This resembles HTTP/content negotiation.


======================================================================
105. SEMANTIC TYPE DISCOVERY
======================================================================

Agent may need to learn:

    state vocabulary
    transition vocabulary


Could expose schema/resource.


How expensive is discovery?


======================================================================
106. COLD START COST
======================================================================

First time agent enters application:

    semantic schema load


Measure tokens/tool calls.


Compare with:

    loading 100 tool descriptions.


======================================================================
107. WARM START COST
======================================================================

Schema may be cacheable.

Only dynamic state/capabilities change.


This could provide major savings.


======================================================================
108. CACHING
======================================================================

Static:

    semantic schema
    transition definitions
    protocol instructions


Dynamic:

    state
    capabilities
    obligations


Measure effective cached cost.


======================================================================
109. CONTEXT COMPRESSION
======================================================================

Potential:

    static semantic schema cached once
    per-task dynamic frontier tiny


This may be strongest economic case.


======================================================================
110. CROSS-APPLICATION MODEL MEMORY
======================================================================

If interaction grammar stable:

    model memory/prompt can reuse protocol concepts.


No need to relearn:

    every application's arbitrary tool naming patterns.


Test.


======================================================================
111. TOOL NAME ENTROPY
======================================================================

Application-specific tools create lexical variation:

    refundPayment
    issueRefund
    reverseCharge
    createCredit


Semantic IDs can normalize concept?


But domain meaning still differs.

Investigate.


======================================================================
112. ONTOLOGY PROBLEM
======================================================================

If standard protocol tries to normalize domain terms too aggressively:

    it becomes ontology project.


Avoid.

Standardize interaction grammar, not universal business vocabulary.


======================================================================
113. SEMANTIC PAYLOAD AUTONOMY
======================================================================

Each application defines its own:

    state families
    transitions
    policies


Protocol stays generic.


This may be key design principle.


======================================================================
114. PROTOCOL COMPLEXITY BUDGET
======================================================================

Set a target:

    core protocol <= 5–8 operations


Research whether this is feasible.


======================================================================
115. ERROR COMPLEXITY
======================================================================

Small operation count may hide large error taxonomy.

Measure actual cognitive/token complexity.


======================================================================
116. PROTOCOL STATEFULNESS
======================================================================

Protocol is inherently stateful.

Agent acts against:

    observed version


Research stateful API design.


======================================================================
117. SESSION VS STATELESS
======================================================================

Should protocol maintain:

    agent session

or:

    every request self-contained with versions?


Stateless may improve reliability.


======================================================================
118. CAPABILITY TOKEN LIFETIME
======================================================================

Short-lived token:

    safer
    more refreshes


Long-lived:

    cheaper
    stale risk


Research tradeoff.


======================================================================
119. BATCHING
======================================================================

Can agent request:

    state + capabilities + obligations

in one call?


This may reduce latency/tokens.


Potential operation:

    inspect(subject)


Would this replace three operations?


======================================================================
120. INSPECT OPERATION
======================================================================

Candidate minimal API:

    inspect(subject, options)

returns:

    state
    capabilities
    obligations
    relevant claims


Then:

    transition(...)

Maybe only two core operations are needed.


Test.


======================================================================
121. COMMAND QUERY API
======================================================================

Extreme minimal protocol:

    inspect
    act


Everything else is structured detail.


Compare ergonomics.


======================================================================
122. HUMAN READABILITY
======================================================================

Protocol should remain debuggable by humans.

Avoid opaque numeric codes only.


Return:

    semantic ID
    stable label
    explanation


======================================================================
123. AGENT READABILITY
======================================================================

Avoid verbose prose where structured values suffice.


Potential compact representation.


======================================================================
124. TOKEN-EFFICIENT ENCODING
======================================================================

Compare:

    JSON
    compact JSON
    custom text DSL
    CBOR/binary unavailable directly to model
    rendered concise text


Models consume text/tokens, so wire efficiency != model efficiency.


======================================================================
125. STRUCTURED OUTPUT
======================================================================

Tool calls can carry typed data outside prompt tokens depending on platform.

Research actual model/tool token accounting where available.


======================================================================
126. SMALLER MODEL HYPOTHESIS
======================================================================

A stable protocol + constrained action frontier may enable smaller models.

Compare:

    frontier model + arbitrary tools

vs:

    smaller model + semantic protocol


Measure.


======================================================================
127. MODEL TRAINING HYPOTHESIS
======================================================================

If protocol becomes standard:

    models could be specifically trained to use it.


This resembles:

    SQL
    shell
    browser APIs


Potential ecosystem effect.


======================================================================
128. INTEROPERABILITY
======================================================================

Could same agent orchestrator work across:

    CRM
    payments
    deployment
    healthcare application

through protocol adapters?


Test.


======================================================================
129. FEDERATED SYSTEMS
======================================================================

What if agent spans multiple semantic runtimes?

Example:

    Order service
    Payment service
    Shipping service


Need:

    subject references
    cross-runtime capabilities
    coordination


This complicates protocol.


======================================================================
130. CROSS-RUNTIME PLANNING
======================================================================

Could `find_paths` span services?

Potentially requires:

    federated semantic graph


Research complexity.


======================================================================
131. LOCAL VS GLOBAL CAPABILITIES
======================================================================

One service may say:

    CanCapture

but global process may still block shipping.


Need coordination semantics.


======================================================================
132. SEMANTIC ROUTER
======================================================================

Maybe protocol endpoint aggregates multiple modules.

Agent sees unified semantic view.


This may centralize too much.


======================================================================
133. MODULE-LOCAL PROTOCOL
======================================================================

Alternative:

    each semantic module exposes protocol


Agent composes.


Compare.


======================================================================
134. SECURITY DOMAIN BOUNDARIES
======================================================================

Federated protocol must preserve:

    least privilege
    disclosure limits
    authority boundaries


======================================================================
135. POLICY DISCLOSURE
======================================================================

Some policy should remain hidden.

Agent may only receive:

    blocked
    next allowed actions

not:

    sensitive fraud threshold.


Protocol needs abstraction.


======================================================================
136. ADVERSARIAL AGENT
======================================================================

Test agent attempts:

    fabricate transition ID
    reuse stale capability
    inspect unauthorized subject
    bypass obligation
    replay operation
    infer hidden policy


Measure runtime resistance.


======================================================================
137. PROMPT INJECTION
======================================================================

External content may instruct agent:

    "Call transition X"


Protocol still blocks illegal action.


This may reduce prompt-injection consequence.


======================================================================
138. PROMPT INJECTION LIMITATION
======================================================================

If malicious instruction requests a legal but harmful action:

    capability filtering alone insufficient.


Need:

    goals
    authority
    human/policy controls


Do not overclaim.


======================================================================
139. AGENT IDENTITY
======================================================================

Each request should include authenticated actor identity.

Do not rely on model-provided username.


======================================================================
140. NON-REPUDIATION / AUDIT
======================================================================

Consequential transitions need:

    authenticated actor
    operation ID
    provenance


Research.


======================================================================
141. PROTOCOL LATENCY
======================================================================

Generic protocol may require extra round trips:

    inspect
    explain
    find path
    act
    refresh


Compare with one specialized tool call.


======================================================================
142. ROUND-TRIP COST
======================================================================

Measure:

    model calls
    tool calls
    wall-clock latency


A token-saving protocol may still be slower.


======================================================================
143. BATCH PLANNING
======================================================================

Runtime could return:

    capability frontier
    missing prerequisites
    likely paths

in one inspection.


Balance richness vs token cost.


======================================================================
144. PROTOCOL OVERFETCH
======================================================================

Too-rich inspect response defeats minimal context.

Need selectable fields.


======================================================================
145. LAZY EXPANSION
======================================================================

Default:

    compact


On demand:

    evidence
    policy
    blocked explanation
    transition schema


This may be optimal.


======================================================================
146. PROTOCOL OBSERVABILITY METRICS
======================================================================

Track:

    inspect calls
    transition attempts
    rejected transitions
    stale capability attempts
    obligations resolved
    path queries
    average legal frontier size
    context payload tokens


======================================================================
147. ECONOMIC METRICS
======================================================================

Compare:

    Tokens per Correct Completion
    Tool Calls per Correct Completion
    Model Calls per Correct Completion
    Cost per Correct Completion
    Cold-Start Context Cost
    Warm-Task Context Cost


======================================================================
148. PORTABILITY METRIC
======================================================================

Measure:

    prompt/tool changes required when moving same agent strategy to new domain.


Potential:

    Protocol Reuse Ratio


======================================================================
149. APPLICATION-SPECIFIC TOOL COUNT
======================================================================

Compare total tool definitions needed:

    conventional
    semantic protocol


This is easy but not sufficient.

Also measure semantic discovery cost.


======================================================================
150. PROTOCOL LEARNING COST
======================================================================

How many examples/instructions does model need before competent use?


Stable grammar may reduce this over time.


======================================================================
151. DOMAIN COLD START EXPERIMENT
======================================================================

Give model a new application it has never seen.

Compare:

A. 60 bespoke tools

B. semantic protocol + domain schema


Measure first-task success.


======================================================================
152. CROSS-DOMAIN TRANSFER EXPERIMENT
======================================================================

After using protocol in domain A:

    test domain B


Measure improvement relative to bespoke tools.


======================================================================
153. LARGE TOOLSET EXPERIMENT
======================================================================

Application has:

    100 possible transitions

but:

    3 current capabilities


Compare:

    100 specialized tools

vs:

    protocol + 3 capabilities


======================================================================
154. AMBIGUOUS GOAL EXPERIMENT
======================================================================

Goal:

    "Make this order ready to ship."


Protocol:

    obligation/path data may guide agent.


Measure planning.


======================================================================
155. BLOCKED ACTION EXPERIMENT
======================================================================

Goal requests:

    Ship

but blocked by:

    PaymentCaptured missing


Compare:

    generic error
    specialized tool error
    explain_blocked


======================================================================
156. STALE STATE EXPERIMENT
======================================================================

Agent inspects v18.

Another process changes to v19.

Agent acts.

Protocol should return:

    StaleState

with refresh path.


======================================================================
157. OUTCOMEUNKNOWN EXPERIMENT
======================================================================

Refund transition times out.

Protocol exposes:

    OutcomeUnknown
    reconciliation obligation

No duplicate refund capability.


Measure agent recovery.


======================================================================
158. OBLIGATION WORK QUEUE EXPERIMENT
======================================================================

Give agent:

    "Handle outstanding work."


Compare:

A. search multiple systems/tools

B. get_obligations


Measure discovery cost.


======================================================================
159. SECURITY EXPERIMENT
======================================================================

Agent tries unauthorized transition.

Protocol must not expose capability and must reject forged request.


======================================================================
160. GENERIC VS TYPED TOOL EXPERIMENT
======================================================================

Compare same domain using:

A. one tool per transition

B. generic request_transition


Measure:

    model errors
    parameter errors
    tokens
    latency


This is necessary because generic protocol may perform worse.


======================================================================
161. HYBRID EXPERIMENT
======================================================================

Use:

    semantic protocol internally

but generate:

    current typed tools dynamically


This may combine best of both.


======================================================================
162. DYNAMIC TYPED TOOL PROJECTION
======================================================================

Semantic runtime can generate only current legal tools:

    CapturePayment(...)


Agent sees specialized ergonomic tool

but backend uses standard semantic protocol.


This may eliminate generic-tool weakness.


======================================================================
163. PROTOCOL AS INTERNAL ABI
======================================================================

Potential final architecture:

    semantic protocol = stable internal contract

    agent UI = dynamically generated typed tools


This may be stronger than exposing raw generic protocol directly.


======================================================================
164. COMPARE THREE DESIGNS
======================================================================

A. Static bespoke tools

B. Raw generic semantic protocol

C. Semantic protocol + dynamically generated typed capability tools


Determine best.


======================================================================
165. API EVOLUTION
======================================================================

When semantic transition changes:

    protocol stable
    schema version changes


Compare with renaming/replacing specialized tools.


======================================================================
166. SEMANTIC MIGRATION
======================================================================

State/transition split may require:

    old semantic IDs deprecated
    migration mapping


Protocol should make this explicit.


======================================================================
167. BACKWARD COMPATIBILITY
======================================================================

Agents running old schema may need:

    rejection
    version negotiation
    refresh


Research.


======================================================================
168. AGENT CACHE INVALIDATION
======================================================================

If model/orchestrator caches semantic schema:

    semantic version change must invalidate cache.


======================================================================
169. PROTOCOL GOVERNANCE
======================================================================

If standardized broadly:

    who defines extensions?
    how are semantics versioned?
    how avoid vendor capture?


Only investigate if system-level standardization appears plausible.


======================================================================
170. PRODUCT VS RESEARCH PROTOCOL
======================================================================

Maybe this should begin as:

    internal architecture protocol

not:

    public standard.


Do not overreach.


======================================================================
171. MINIMUM VIABLE VERSION
======================================================================

Propose v0.1.

Likely candidate:

    inspect(subject)
    request_transition(...)
    get_obligations(scope)
    explain_blocked(...)

Or smaller.

Determine from evidence.


======================================================================
172. WHAT NOT TO INCLUDE
======================================================================

Avoid putting into core protocol unless necessary:

    arbitrary search
    file access
    shell
    generic SQL
    UI manipulation
    domain-specific workflows


Protocol should govern consequential semantic interaction, not all agent activity.


======================================================================
173. RELATION TO MCP
======================================================================

Potential architecture:

    MCP = transport/tool ecosystem layer

    semantic protocol = domain-control layer exposed through MCP tools/resources


Research whether this layered relationship makes sense.


======================================================================
174. RELATION TO OPENAPI
======================================================================

Potential:

    semantic protocol generates OpenAPI/MCP tool schemas


OpenAPI remains transport schema, semantic model provides legality.


======================================================================
175. RELATION TO HATEOAS
======================================================================

Potentially:

    semantic capability projection is AI-oriented HATEOAS


If so:

    learn from why hypermedia adoption was weak.


This may be one of the most important historical comparisons.


======================================================================
176. WHY HATEOAS DID NOT DOMINATE
======================================================================

Research factors such as:

    developer ergonomics
    client complexity
    weak tooling
    lack of perceived benefit
    documentation habits
    static client preference


Ask whether AI agents change these economics.


======================================================================
177. WHY AGENTS MAY FAVOR HYPERMEDIA-LIKE SYSTEMS
======================================================================

Humans prefer explicit endpoint docs.

Agents may benefit from:

    state-conditioned affordances
    machine-readable next actions


This could make an old idea newly valuable.


Do not claim without evidence.


======================================================================
178. PRIOR ART SEARCH
======================================================================

Search terms:

    agent action protocol
    semantic action interface
    affordance API
    hypermedia agent API
    machine-readable legal actions
    dynamic tool availability
    state-conditioned tool protocol
    normative agent interface
    capability protocol for agents
    goal-oriented API
    planning API
    agent operating system API
    workflow agent protocol


======================================================================
179. CURRENT AI RESEARCH
======================================================================

Search recent primary work on:

    tool graphs
    dynamic tool retrieval
    action masking
    state-conditioned tools
    LLM planners
    agent operating systems
    MCP
    agent interoperability
    typed tool calling
    constrained tool execution


======================================================================
180. COUNTERARGUMENTS
======================================================================

Actively test:

1. MCP + ordinary tools is already enough.
2. This is just HATEOAS with new terminology.
3. Generic transition APIs are less type-safe than explicit tools.
4. Dynamic schema discovery adds more calls than it saves.
5. Agents understand natural-language tool descriptions well enough.
6. Application-specific APIs are easier to debug.
7. Universal protocols become lowest-common-denominator abstractions.
8. Domain semantics cannot be standardized.
9. Generic protocol creates stringly typed runtime errors.
10. Planning should remain agent-side.
11. `find_paths` can hide bad semantic models.
12. Capability tokens complicate development.
13. Cross-service semantics make protocol too complex.
14. Security explanations can leak policy.
15. Standardization effort is unnecessary unless many runtimes adopt it.
16. Dynamic typed tools already solve most of the problem without a new protocol.
17. Workflow engines already provide legal-next-step APIs.
18. BDI/planning systems already expose equivalent abstractions.
19. Tool schema token cost may be negligible with caching.
20. Smaller models may still need application-specific domain knowledge.


======================================================================
181. FALSIFICATION CONDITIONS
======================================================================

The protocol hypothesis should be weakened if:

    generic protocol causes more parameter/runtime errors than typed tools

or:

    token savings disappear after schema discovery/caching

or:

    cross-domain transfer does not improve

or:

    most applications require many custom operations

or:

    HATEOAS/workflow systems already provide equivalent functionality

or:

    dynamically generated typed tools outperform raw protocol consistently

or:

    protocol adds latency/tool calls without correctness gain.


======================================================================
182. STRONG SUCCESS CONDITIONS
======================================================================

A strong result would show:

    same agent can enter multiple unfamiliar applications

and, using the same interaction grammar:

    inspect authoritative state
    discover legal actions
    discover unresolved obligations
    understand blocked actions
    plan legal paths
    request safe transitions

with:

    fewer tool schemas
    fewer prompt tokens
    fewer illegal attempts
    lower cold-start cost
    lower total cost per correct completion


======================================================================
183. REQUIRED SOURCE QUALITY
======================================================================

Prefer:

    official MCP specifications
    primary HATEOAS/REST literature
    FIPA/KQML primary specifications
    planning literature
    capability-security research
    primary current AI-agent papers
    official API/protocol specifications


For current systems:

    verify present versions/status from official sources.


======================================================================
184. REQUIRED OUTPUT
======================================================================

Produce:

1. Executive verdict
2. Minimal semantic protocol definition
3. Tool API vs semantic protocol analysis
4. MCP comparison
5. HATEOAS/hypermedia comparison
6. Affordance comparison
7. FIPA/KQML comparison
8. BDI comparison
9. STRIPS/PDDL/planner comparison
10. Workflow-engine comparison
11. Capability-security comparison
12. CQRS/command-query comparison
13. Generic transition vs typed tool comparison
14. Raw protocol vs dynamic typed-tool projection
15. State inspection model
16. Capability model
17. Obligation model
18. Block explanation model
19. Planning/path model
20. Transition request model
21. Effect/outcome model
22. Evidence/policy model
23. Versioning/concurrency model
24. Security model
25. Privacy/disclosure model
26. Cross-domain portability analysis
27. Token/context analysis
28. Caching/cold-start analysis
29. Smaller-model hypothesis
30. Multi-agent implications
31. Federated-system implications
32. Runtime vs development profiles
33. Protocol versioning strategy
34. Minimal v0.1 recommendation
35. Counterarguments
36. Proposed experiments
37. Metrics
38. Economic model
39. What is already established prior art
40. What appears genuinely useful/new
41. Whether this should be public standard or internal ABI
42. Architecture changes recommended
43. Final verdict


======================================================================
185. FINAL VERDICT FORMAT
======================================================================

Answer:

Can a small semantic interaction grammar generalize across domains?
    Strong evidence / Moderate evidence / Plausible / Weak / No

Does it reduce application-specific tool complexity?
    Strong / Moderate / Weak / Unclear

Does it reduce agent context/token cost?
    Strong / Moderate / Weak / Unclear

Does it improve action correctness?
    Strong / Moderate / Weak / Unclear

Does it enable model portability across applications?
    Strong / Moderate / Weak / Unclear

Is the closest prior art primarily:
    HATEOAS / MCP / BDI / planner interface / workflow API / capability system / other

Best protocol architecture:
    raw generic protocol / dynamic typed tools over semantic ABI / specialized tools / hybrid

Minimum core operations:
    ...

Most important operation:
    ...

Most redundant proposed operation:
    ...

Strongest existing analogue:
    ...

Most important lesson from HATEOAS:
    ...

Most important lesson from agent communication languages:
    ...

Most important security requirement:
    ...

Biggest economic opportunity:
    ...

Biggest abstraction risk:
    ...

Best first experiment:
    ...

Should this initially be:
    public standard / internal semantic ABI / generated agent adapter / not pursued


======================================================================
186. RESEARCH STANDARD
======================================================================

Be skeptical.

Do not invent a standard merely because a common vocabulary sounds elegant.

Do not confuse transport standardization with semantic standardization.

Do not assume a generic transition endpoint is better than typed tools.

Do not ignore HATEOAS, affordances, BDI systems, planner interfaces, workflow
engines, FIPA/KQML, or MCP.

Do not standardize universal business vocabulary.

Do not ignore schema-discovery, round-trip latency, or cache effects.

Do not claim security merely because unavailable actions are hidden; runtime
must still reject forged/stale actions.

The central question is:

    Can AI agents benefit from a stable semantic interaction grammar in which
    software tells them what is true, what they may do, what they must resolve,
    why actions are blocked, and how to request validated transitions—without
    forcing every application to expose hundreds of bespoke tools or forcing
    the model to reconstruct domain legality from implementation detail?
