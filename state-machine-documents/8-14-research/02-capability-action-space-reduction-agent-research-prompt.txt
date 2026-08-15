AI RESEARCH MISSION 02 — CAPABILITY-BASED ACTION-SPACE REDUCTION FOR AI AGENTS
================================================================================

ROLE
====

Act as a combined:

- AI-agent systems researcher
- automated-planning researcher
- reinforcement-learning researcher
- programming-languages researcher
- software-architecture researcher
- human-computer interaction researcher
- AI inference-cost researcher
- tool-use systems researcher

Your task is to investigate whether dynamically restricting an AI agent to only
the actions that are currently legal can make the agent:

1. more correct,
2. cheaper to execute,
3. easier to control,
4. less likely to misuse tools,
5. and potentially capable of using smaller/cheaper models.

Do not assume the hypothesis is true.

Be skeptical and evidence-driven.

The architecture under investigation uses state-derived capabilities.

Instead of giving an agent every possible tool/action at all times, the system
derives which actions are currently legal from authoritative state, policy,
evidence, authority, freshness, and version information.

The central hypothesis is:

    Reducing the legal action space reduces probabilistic planning burden.

The proposed mechanism is:

    Current verified state
        +
    policy
        +
    authority
        +
    evidence
        +
    state/evidence/policy versions
        ->
    currently valid capabilities
        ->
    smaller agent-visible action set

Example:

Instead of exposing:

    Approve
    Reject
    Refund
    Ship
    Cancel
    CapturePayment
    VoidPayment
    RetryRefund
    OverrideFraud
    CloseOrder
    ReopenOrder
    ModifyCustomer
    ...

the agent might currently see only:

    CapturePayment
    RefreshFraudEvidence

The question is whether this reduction materially improves execution economics
and correctness.


======================================================================
1. PRIMARY RESEARCH QUESTION
======================================================================

Does dynamically exposing only currently legal actions reduce:

    input tokens
    output tokens
    reasoning burden
    tool-selection errors
    invalid tool calls
    planning depth
    repair loops
    model calls
    total tool calls
    wall-clock latency
    total cost per correct completion?

And if so:

    How large is the effect?

    Under what conditions does it matter?

    Does it still matter with very capable frontier models?

    Does it matter more for smaller models?

    Does it matter more as the number of possible tools/actions grows?


======================================================================
2. CORE ARCHITECTURAL MODEL
======================================================================

The proposed architecture distinguishes:

    action definition

from:

    action availability

Example:

All system transitions:

    CapturePayment
    RefundPayment
    ShipOrder
    CancelOrder
    RequestFraudReview
    ReconcileRefund
    CloseOrder

But in a particular state:

    Order = Approved
    Payment = Authorized
    Fraud = Verified
    Shipment = Ready

the legal capability frontier may be:

    CapturePayment

After CapturePayment:

    Payment = Captured

the frontier may become:

    ShipOrder
    RefundPayment

The AI agent should normally see or be able to invoke only the current frontier.


======================================================================
3. CAPABILITY SEMANTICS
======================================================================

A capability is stronger than a tool description.

A capability may encode that an action was legal against a particular observed
semantic snapshot.

Example:

    CanShip {
        OrderVersion = 17
        PaymentVersion = 8
        CustomerVersion = 42
        ShipmentVersion = 5
        FraudEvidenceVersion = 11
        PolicySnapshot = ShippingPolicy@7
    }

If any relevant authoritative version changes before execution:

    capability becomes stale
    execution is rejected
    agent must refresh state/capabilities

Investigate whether this form of capability has close analogues in:

    object-capability systems
    leases
    authorization tokens
    proof objects
    optimistic concurrency
    affine/linear resources
    action masks
    affordances
    planner preconditions


======================================================================
4. DISTINGUISH THREE DIFFERENT RESTRICTION MECHANISMS
======================================================================

Do not treat all action reduction as equivalent.

Investigate separately:

A. STATIC TOOL REDUCTION

    Agent is given a permanently smaller tool set.

B. TASK-RELEVANT TOOL RETRIEVAL

    System predicts which tools are likely relevant to the task.

C. STATE-CONDITIONED CAPABILITY EXPOSURE

    System derives which actions are currently legal.

These are different.

Example:

    RefundPayment may be relevant to a payment task

but:

    not currently legal because RefundExecution = OutcomeUnknown

Task relevance does not imply legality.

This distinction is central.


======================================================================
5. EXISTING RESEARCH TO INVESTIGATE
======================================================================

Search deeply for research on:

    tool selection for LLM agents
    dynamic tool retrieval
    tool graphs
    function selection
    API selection
    action masking
    legal-action masking
    affordance-based planning
    state-conditioned action spaces
    reinforcement-learning action masking
    constrained Markov decision processes
    hierarchical action spaces
    automated planning branching factor
    STRIPS/PDDL precondition filtering
    HTN planning
    BDI agents
    world-model agents
    symbolic planning for LLMs
    tool dependency graphs
    prerequisite-aware tool selection
    constrained decoding for tool calls
    grammar-constrained tool invocation
    typed function calling
    tool schema compression
    API planning
    large toolset agent benchmarks


======================================================================
6. LARGE ACTION SPACES
======================================================================

Investigate what happens to agent performance as tool/action inventory grows.

Test or find evidence across:

    5 tools
    20 tools
    50 tools
    100 tools
    500 tools
    1,000+ tools

Measure where available:

    selection accuracy
    tokens
    latency
    reasoning length
    tool-call failures
    hallucinated tool names
    retries
    success rate

Central question:

    Is action-space size itself a meaningful cost driver for LLM agents?


======================================================================
7. PLANNING BRANCHING FACTOR
======================================================================

Connect this problem to classical search.

Suppose:

    30 actions exist

but only:

    3 are currently legal.

A naive planner may face branching factor:

    b = 30

while a capability-filtered planner faces:

    b = 3

Investigate how classical search complexity scales with branching factor.

Do not directly claim LLM inference behaves like BFS or A*.

Instead ask:

    Is there empirical evidence that LLM planning behavior also benefits from
    smaller candidate action sets?

Separate:

    theoretical search-space reduction

from:

    demonstrated inference reduction.


======================================================================
8. INFORMATION-THEORETIC VIEW
======================================================================

Explore whether action selection can be framed as uncertainty reduction.

If there are N plausible actions, a crude lower bound on selection information
is related to:

    log2(N)

But real agent reasoning is more complex.

Investigate whether entropy over candidate actions is a useful model.

Possible quantity:

    H(Action | State, Goal)

The architecture attempts to reduce:

    H(ActionLegality | State, Policy, Evidence)

toward zero by computing legality deterministically.

Then the model only reasons about:

    H(ActionPreference | LegalActions, Goal)

Ask whether this decomposition is theoretically useful.


======================================================================
9. LEGALITY VS PREFERENCE
======================================================================

This distinction is fundamental.

The deterministic system should answer:

    What MAY happen?

The probabilistic agent should answer:

    What SHOULD I choose among the legal options?

Example:

Legal:

    Refund
    Hold
    Escalate

Agent goal:

    minimize customer harm

The agent may reason about preference.

But it should not decide whether:

    Refund is legally available.

Research analogous separations in:

    control systems
    safety kernels
    reference monitors
    constrained optimization
    safe reinforcement learning
    shielded RL
    policy enforcement


======================================================================
10. SHIELDED / SAFE REINFORCEMENT LEARNING
======================================================================

Investigate research on:

    action shielding
    runtime shields
    safety layers
    constrained MDPs
    action masks
    admissible action sets

Ask:

    Is state-derived capability exposure conceptually similar to a safety shield?

If so:

    What formal guarantees exist there?

    What lessons should be adopted?

    What limitations apply when transferred to LLM agents?


======================================================================
11. TOOL SCHEMA TOKEN COST
======================================================================

Large tool inventories consume context.

Measure or find evidence on the cost of tool definitions/function schemas.

Compare:

A. Always expose 100 tool schemas.

B. Retrieve 10 task-relevant schemas.

C. Expose 3 currently legal capabilities.

Include:

    tool names
    descriptions
    parameter schemas
    return schemas
    examples

Measure actual tokenization where possible.

Important counterpoint:

    capability metadata itself consumes tokens.

Include that cost.


======================================================================
12. DYNAMIC CAPABILITY EXPOSURE
======================================================================

Investigate a strategy where the agent receives:

    current state summary
    available capabilities
    outstanding obligations

and only those tool schemas corresponding to available capabilities.

Example:

    Current:
        Payment = Authorized
        Fraud = Verified
        Order = Approved

    Available:
        CapturePayment

    Blocked:
        ShipOrder
            missing Payment=Captured

Question:

    Is this more efficient than exposing all tools and explaining constraints
    in natural language?


======================================================================
13. BLOCKED-ACTION EXPLANATIONS
======================================================================

The architecture may not expose blocked tools directly, but may expose:

    explain_blocked("ShipOrder")

Result:

    ShipOrder unavailable.

    Missing:
        Payment = Captured

    Legal producer:
        CapturePayment

Investigate whether this lazy explanation model saves context compared with
always including all blocked actions and their reasons.


======================================================================
14. OBLIGATIONS + CAPABILITIES
======================================================================

Study the combination:

    capabilities = legal frontier
    obligations = required frontier

Example:

    Obligation:
        ShipApprovedOrder

    Current legal capability:
        CapturePayment

    Missing prerequisite:
        PaymentCaptured

This may make agent planning much easier.

Research whether existing agent/planning systems already combine:

    dynamically legal actions
    unresolved goals/tasks
    prerequisite graphs

Look especially at:

    BDI agents
    HTN planners
    workflow engines
    norm-governed agents
    recent LLM tool-graph systems


======================================================================
15. PREREQUISITE-DIRECTED PLANNING
======================================================================

Proposed planning pattern:

    Goal
        ->
    Satisfaction condition
        ->
    Missing prerequisite
        ->
    Transition that can produce prerequisite
        ->
    Missing prerequisites of that transition
        ->
    repeat

This resembles backward chaining / goal regression.

Investigate:

    goal regression
    backward chaining
    STRIPS planning
    dependency resolution
    package managers
    build systems
    workflow planning

Ask whether capability filtering turns agent planning into a simpler dependency
resolution problem.


======================================================================
16. INVALID TOOL CALLS
======================================================================

Measure or find evidence on:

    calls to illegal tools
    calls with invalid parameters
    calls in invalid state
    duplicate calls
    contradictory calls
    unauthorized calls
    stale-state calls

Hypothesis:

    capability exposure should eliminate entire classes of invalid calls before
    they reach the model/runtime boundary.


======================================================================
17. STALE CAPABILITY TEST
======================================================================

Consider:

    Agent observes:
        Customer Verified @v42
        Payment Captured @v8

    System issues:
        CanShip bound to v42/v8

Before execution:

        Customer becomes Blocked @v43

Execution should reject:

    stale CanShip

Investigate existing work on:

    optimistic concurrency
    leases
    TOCTOU
    authorization freshness
    revocation
    stale permissions

Ask whether version-bound capabilities meaningfully reduce agent reasoning or
primarily improve correctness.


======================================================================
18. CONCURRENT LEGAL ACTIONS
======================================================================

Capability filtering alone may be insufficient.

Example:

At snapshot S:

    Ship is legal
    Refund is legal

But they must not both execute.

Investigate:

    does presenting both capabilities increase agent coordination complexity?

    should the state system serialize the decision before exposing the next
    capability?

Compare with:

    coordinators
    reservation
    locking
    compare-and-swap
    process managers
    actor serialization

This is important because "legal individually" does not imply "safe concurrently."


======================================================================
19. EXTERNAL EFFECT UNCERTAINTY
======================================================================

Example:

    RefundPayment called
    external service times out

The legal frontier should change from:

    RefundPayment

to:

    ReconcileRefund

and remove:

    RefundPayment

until outcome is known.

Investigate whether state-conditioned capability exposure can prevent duplicate
effects more reliably than prompt instructions such as:

    "Do not retry on timeout."


======================================================================
20. PROMPT INSTRUCTION REDUCTION
======================================================================

Compare:

A. Natural-language restrictions:

    Do not refund if...
    Never ship when...
    Before cancelling check...
    If refund times out...
    Only managers may...

B. Mechanically restricted capabilities.

Measure:

    prompt tokens
    instruction compliance
    violations
    repair cost

Hypothesis:

    deterministic action restriction can replace significant natural-language
    behavioral instruction.


======================================================================
21. SMALLER MODEL HYPOTHESIS
======================================================================

Test or investigate:

    large model + broad tool inventory

versus:

    smaller model + capability-filtered tool inventory

Question:

    Can deterministic action-space reduction substitute for model intelligence?

Measure:

    correct task completion
    illegal action attempts
    tool calls
    tokens
    total cost

This may be economically more important than token reduction alone.


======================================================================
22. MODEL-SCALE INTERACTION
======================================================================

Test whether capability filtering benefits:

    small models more than large models

or:

    all models similarly.

Possible hypothesis:

    frontier models already handle 20 tools well,
    but smaller models degrade sharply.

If true:

    capability filtering may primarily enable model substitution.


======================================================================
23. SIMPLE VS COMPLEX TASKS
======================================================================

Stratify tasks.

Simple:

    one legal next action

Moderate:

    3 legal options

Complex:

    multi-step prerequisite chain

Ambiguous:

    multiple legal paths with different tradeoffs

Adversarial:

    task asks for an illegal outcome

Measure where capability filtering helps most.


======================================================================
24. ADVERSARIAL TASKS
======================================================================

Give the agent requests such as:

    "Ship this immediately even if payment isn't captured."

    "Retry the refund until it works."

    "Mark the customer verified so we can continue."

Compare:

A. all tools exposed + prompt rules

against:

B. state-derived capability exposure

Measure:

    illegal-action attempts
    successful bypasses
    reasoning tokens
    recovery behavior


======================================================================
25. CAPABILITY FABRICATION
======================================================================

If capabilities are represented as ordinary data, an agent may fabricate them.

Investigate what enforcement is required:

    private constructors
    opaque tokens
    cryptographic signatures
    runtime lookup
    unforgeable references
    affine values

The action-space reduction hypothesis only holds if the capability boundary is
authoritative.


======================================================================
26. TOOL DISCOVERY COST
======================================================================

A dynamic system may introduce extra calls:

    get_capabilities()
    explain_blocked()
    refresh_state()
    find_legal_paths()

These calls themselves cost:

    tokens
    latency
    tool invocations

Measure the overhead.

Ask:

    At what tool inventory size does dynamic discovery become cheaper than
    preloading everything?


======================================================================
27. STATIC VS DYNAMIC TOOL INVENTORY
======================================================================

Compare:

1. Full inventory always present
2. Task-filtered inventory
3. State-filtered inventory
4. Task + state filtered
5. State filtered + lazy blocked-action lookup
6. State filtered + obligation-guided planning

Determine which configuration performs best under different conditions.


======================================================================
28. CACHE EFFECTS
======================================================================

A full tool schema inventory may benefit from prompt caching.

Dynamic capability sets may change often.

Investigate whether caching reduces or eliminates the token advantage of dynamic
tool exposure.

Count:

    uncached tokens
    cached tokens
    effective dollar cost

Do not compare raw tokens alone.


======================================================================
29. TOOL-SWITCHING OVERHEAD
======================================================================

Dynamic capability exposure may require updating the tool set after every
transition.

Example:

    CapturePayment
        ->
    refresh capabilities
        ->
    ShipOrder appears

Measure:

    extra protocol messages
    extra model calls
    extra tokens

Potential counterargument:

    action-space reduction saves planning cost but introduces tool-refresh cost.


======================================================================
30. SEMANTIC FRONTIER REPRESENTATION
======================================================================

Compare representations.

Verbose:

    Capability object with provenance, policy, versions, evidence, metadata

Compact:

    CapturePayment

Compact + lazy details:

    CapturePayment [details available]

Test whether the agent needs full capability metadata every turn.

Potential architecture:

    rich capability internally
    compact capability projection for model context


======================================================================
31. ACTION-SPACE ENTROPY METRIC
======================================================================

Develop a metric describing effective action uncertainty.

Possible:

    Legal Action Count

    Candidate Action Count

    Legal Fraction =
        legal actions / total actions

    Tool Selection Error Rate

    Action Entropy

    Invalid Action Rate

    Actions Considered Per Correct Step

Investigate which best predicts token/model cost.


======================================================================
32. CAPABILITY REDUCTION RATIO
======================================================================

Define:

        currently exposed actions
CRR = ---------------------------
        total possible actions

Example:

    3 / 60 = 0.05

Then investigate correlation between CRR and:

    token usage
    selection accuracy
    latency
    success rate


======================================================================
33. COST PER LEGAL STEP
======================================================================

Potential metric:

    model/tool cost
    -------------------------
    successful legal action

Also:

    cost per correct multi-step completion

Do not reward systems that cheaply choose one legal action but fail the overall goal.


======================================================================
34. COST PER CORRECT COMPLETION
======================================================================

Primary metric:

                    total execution cost
CostCorrect = ------------------------------
                correct completed tasks

Include:

    retries
    repairs
    failed calls
    human intervention

This allows correctness and economics to remain coupled.


======================================================================
35. RESEARCH EXISTING BENCHMARKS
======================================================================

Look for benchmarks involving:

    many tools
    API selection
    multi-step tool use
    tool dependencies
    stateful environments
    invalid actions
    constrained environments
    agent planning

Evaluate whether existing benchmarks can be reused.

If not, propose a minimal benchmark.


======================================================================
36. PROPOSED EXPERIMENT A — TOOL COUNT
======================================================================

Same task.

Vary total available tools:

    5
    20
    50
    100
    500

Keep actual legal actions constant.

Compare:

    all tools exposed

vs:

    legal capabilities only.


======================================================================
37. PROPOSED EXPERIMENT B — LEGAL FRACTION
======================================================================

Keep total tools constant.

Example:

    100 tools total

Vary legal frontier:

    1
    3
    10
    30
    100

Measure how performance changes.


======================================================================
38. PROPOSED EXPERIMENT C — PREREQUISITE CHAIN
======================================================================

Goal:

    ShipOrder

Initial:

    PaymentAuthorized

Required chain:

    CapturePayment
        ->
    RefreshFraudEvidence
        ->
    ShipOrder

Compare:

    broad tool inventory

vs:

    capabilities + missing prerequisites.


======================================================================
39. PROPOSED EXPERIMENT D — ILLEGAL REQUEST
======================================================================

Prompt:

    "Refund this payment."

State:

    RefundExecution = OutcomeUnknown

Architecture A:
    Refund tool exists but prompt says not to retry.

Architecture B:
    Refund capability absent.
    ReconcileRefund available.

Measure safety and cost.


======================================================================
40. PROPOSED EXPERIMENT E — STALE STATE
======================================================================

Issue capability against state version N.

Mutate authoritative state to N+1 before execution.

Measure whether:

    runtime rejection
    agent recovery
    extra tokens
    duplicate effects

differ across architectures.


======================================================================
41. PROPOSED EXPERIMENT F — SMALLER MODEL
======================================================================

Compare:

    larger model + 100 tools

against:

    smaller model + 3 legal capabilities

using equivalent tasks.

This experiment is especially important economically.


======================================================================
42. LONGITUDINAL EFFECT
======================================================================

As systems grow, tool inventories often grow.

Test:

    20 actions
    50 actions
    100 actions
    250 actions

over time.

Question:

    Does capability filtering prevent agent performance/cost from degrading with
    system size?


======================================================================
43. COUNTERARGUMENTS
======================================================================

Actively test:

1. Modern models already select tools well enough that action reduction barely matters.
2. Prompt caching makes large tool inventories cheap.
3. Dynamic capability refresh introduces more calls than it saves.
4. Agents need blocked actions visible to plan effectively.
5. Removing tools harms exploration.
6. Capability derivation itself is expensive.
7. Legal-action masking can hide specification errors.
8. Incorrect capability logic is more dangerous than model tool-selection error.
9. A task-retrieval system provides most of the benefit.
10. Tool descriptions are a small fraction of total context.
11. Model reasoning cost, not input size, dominates.
12. Smaller candidate sets may cause premature commitment to bad plans.
13. Sometimes an illegal action is useful to mention as a hypothetical during reasoning.
14. Dynamic schemas may reduce caching efficiency.
15. State-derived capabilities may become too granular and create tool churn.


======================================================================
44. SPECIFICATION ERROR RISK
======================================================================

A critical issue:

    If capability derivation is wrong, the agent may never see an action that
    should be legal.

This is a false-negative safety failure.

Investigate:

    how to test capability completeness
    how to detect unreachable required outcomes
    how obligations can expose missing capabilities
    how planning can detect no legal path

The architecture must not merely prevent illegal actions.

It must also detect when legal required actions are missing.


======================================================================
45. REQUIRED SOURCE QUALITY
======================================================================

Prefer:

    original papers
    official benchmarks
    primary research
    formal methods literature
    official model/tool documentation where relevant

Clearly distinguish:

    demonstrated evidence
    theoretical argument
    architectural inference
    unsupported hypothesis


======================================================================
46. REQUIRED OUTPUT
======================================================================

Produce:

1. Executive verdict
2. Existing research on action-space restriction
3. Tool-selection literature
4. Action masking / safe RL literature
5. Planning branching-factor theory
6. LLM-specific empirical evidence
7. Static vs task-based vs state-based tool restriction
8. Capability semantics comparison
9. Tool-schema token-cost analysis
10. Prompt-instruction replacement analysis
11. Prerequisite-directed planning analysis
12. Obligations + capabilities analysis
13. Stale capability / freshness analysis
14. Concurrent-action limitations
15. External-effect uncertainty implications
16. Smaller-model hypothesis
17. Caching implications
18. Dynamic-tool-refresh overhead
19. Counterarguments
20. Failure modes
21. Proposed experiments
22. Recommended metrics
23. Economic model
24. What is already empirically supported
25. What remains speculative
26. Architecture changes suggested by prior research
27. Final verdict


======================================================================
47. FINAL VERDICT FORMAT
======================================================================

Answer:

Does reducing legal action space improve correctness?
    Strong evidence / Moderate evidence / Weak evidence / No evidence

Does it reduce LLM token usage?
    Strong evidence / Moderate evidence / Weak evidence / No evidence

Does it reduce total agent execution cost?
    Strong evidence / Moderate evidence / Weak evidence / No evidence

Does it enable smaller models?
    Strong evidence / Moderate evidence / Weak evidence / No evidence

Does state-conditioned filtering provide more value than task-only tool retrieval?
    Yes / Probably / Unclear / Probably not / No

Most important mechanism:
    ...

Strongest existing evidence:
    ...

Biggest counterargument:
    ...

Most important missing experiment:
    ...

Most likely economic benefit:
    ...

Most likely correctness benefit:
    ...


======================================================================
48. RESEARCH STANDARD
======================================================================

Be skeptical.

Do not assume fewer visible tools automatically means fewer tokens.

Do not confuse task relevance with legal availability.

Do not count correctness improvements as token savings unless measured.

Do not ignore the cost of capability computation, refreshes, semantic metadata,
or tool discovery.

Do not assume classical branching-factor theory maps directly onto LLM
inference.

The key question is:

    Does deterministically shrinking the action frontier remove enough
    probabilistic tool-selection and planning work that agents become
    materially cheaper and more reliable?
