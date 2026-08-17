AI RESEARCH MISSION 02 — CAPABILITY-BASED ACTION-SPACE REDUCTION FOR AI AGENTS
Research Report
Date: 2026-08-14

================================================================================
EXECUTIVE VERDICT
================================================================================

The central hypothesis is plausible and partially supported, but it needs to be
split into three claims because the evidence strength differs sharply:

1. Deterministically preventing illegal actions improves correctness.
   VERDICT: STRONG EVIDENCE.

2. Showing an LLM fewer candidate tools/actions can improve tool selection and
   reduce prompt size.
   VERDICT: MODERATE-TO-STRONG EVIDENCE.

3. State-conditioned capability exposure reduces total end-to-end agent cost
   enough to matter economically, including enough to substitute smaller models
   for larger ones.
   VERDICT: MODERATE EVIDENCE for the mechanism, WEAK DIRECT EVIDENCE for the
   complete economic claim.

The strongest conclusion is not "fewer tools are always better." It is:

    Deterministic computation should decide which actions are admissible;
    probabilistic reasoning should decide which admissible action best serves
    the goal.

That separation is supported by several mature research traditions:
invalid-action masking, shielded reinforcement learning, reference monitors,
formal policy enforcement, classical planning preconditions, typed state
representations, optimistic concurrency, and object-capability security.

Recent LLM-agent research increasingly points in the same direction. Large-scale
tool retrieval is demonstrably difficult; stateful dependencies remain difficult
even for capable models; explicit structured state improves policy-adherent tool
use; and runtime enforcement can eliminate policy violations that prompting does
not reliably prevent.

However, the specific architecture proposed here is stronger than most existing
systems. It proposes PRE-COMPUTING the currently legal action frontier and
exposing only that frontier to the model, rather than:

- exposing everything and prompting the model to obey rules,
- retrieving tools based only on semantic task relevance,
- or allowing the model to propose an illegal action and blocking it afterward.

That distinction matters economically. Post-hoc enforcement can improve safety
while increasing cost because the model still spends tokens selecting and
attempting illegal actions, then must repair. Pre-filtering may remove that work
before inference. The literature does not yet adequately measure this.

The most important missing experiment is therefore a controlled comparison of:

    Full tools + natural-language policy
    vs task-retrieved tools
    vs full tools + post-hoc policy gate
    vs state-derived legal capabilities
    vs state-derived legal capabilities + obligations/prerequisite guidance

while holding model, tasks, state, and success criteria constant and measuring:

    success
    policy violations
    invalid action attempts
    model calls
    tool calls
    input/output tokens
    cached/uncached tokens
    latency
    repair loops
    human intervention
    total cost per correct completion

The proposed research program should proceed.

================================================================================
1. EXISTING RESEARCH ON ACTION-SPACE RESTRICTION
================================================================================

The proposed architecture has no single exact predecessor, but its core ideas
appear independently in multiple fields.

A. INVALID-ACTION MASKING IN REINFORCEMENT LEARNING

Huang and Ontañón, "A Closer Look at Invalid Action Masking in Policy Gradient
Algorithms" (2020/2022), formally analyzes masking actions that are invalid under
game rules. The work provides theoretical justification and empirically shows
that masking becomes increasingly important as the invalid-action space grows.

This is one of the closest conceptual analogues to the present hypothesis.

The analogy is:

    RL environment state
        -> valid action mask
        -> policy chooses only among valid actions

versus:

    authoritative software state + policy + evidence + authority
        -> valid capability frontier
        -> LLM chooses only among valid actions

Transfer limitation:
An LLM tool agent is not simply a policy-gradient network choosing from a fixed
categorical output head. Its tool schemas consume input context; its reasoning
may involve language generation; it may perform tool retrieval; and it can
change plans through multi-turn interaction. Therefore RL masking cannot by
itself establish token or API cost reductions for LLMs.

What it does establish is the more basic principle: if invalid actions are known
deterministically, forcing a learned policy to model and sample them is often
unnecessary and can become increasingly harmful as the invalid portion grows.

B. SHIELDED / SAFE RL

Alshiekh et al., "Safe Reinforcement Learning via Shielding" (2017), introduced
a reactive shield synthesized from temporal-logic safety specifications. A
shield can either present a list of safe actions before the agent chooses or
intervene after the agent proposes an unsafe action.

This distinction maps almost exactly onto two architecture choices:

    PRE-SHIELD:
        expose only legal capabilities

    POST-SHIELD:
        expose everything, block illegal execution

The literature suggests both can enforce safety, but their agent-level economics
are different. A pre-shield can eliminate illegal candidates from the decision
problem. A post-shield permits wasted reasoning and recovery cycles.

This is a central design lesson.

C. FORMAL RUNTIME POLICY ENFORCEMENT FOR LLM AGENTS

FORGE (2026), "Formal Policy Enforcement for Real-World Agentic Systems,"
provides especially strong recent evidence. It instruments agent actions with a
formal reference monitor using Datalog policies and runtime state. In selected
tau^2-bench customer-service scenarios, reported compliance increased from 58%
to 98% across three frontier models. The paper reports that policy violations
are prevented by construction under its environment assumptions.

Crucially, FORGE also reports overhead. Mean latency increased and token/API
cost increased in the tau^2-bench case because agents sometimes proposed
illegal actions, received structured denial feedback, and had to recover.

That finding strengthens the case for PRE-FILTERED capabilities:
runtime enforcement works for correctness, but post-hoc denial can be
economically worse than never offering the illegal action to the model.

D. STRUCTURED STATE + POLICY GATING

LedgerAgent (2026) makes observed state explicit in a schema-anchored typed
ledger and checks environment-changing calls against state-dependent policy
constraints. It reports better policy-adherent task performance and consistency
across multiple customer-service domains and models.

This is unusually close to the proposed state-system-first architecture. It
supports several premises:

- state buried in conversation history is unreliable,
- current state should be explicit,
- state-dependent policy should be enforced outside unconstrained model
  reasoning,
- typed structured state can improve consistency without changing model
  weights.

LedgerAgent still generally allows the model to propose an action and then gates
it. The proposed capability architecture can be seen as moving the same
deterministic legality computation earlier in the pipeline.

================================================================================
2. TOOL-SELECTION LITERATURE
================================================================================

The evidence that large tool inventories create a real selection problem is now
substantial.

ToolLLM / ToolBench (2023) assembled more than 16,000 real-world APIs and used a
neural API retriever to recommend candidate APIs. The mere existence of the
retrieval layer is architecturally significant: large toolsets are already too
large to naïvely place in every prompt, and pre-selection improves tractability.

Gorilla / APIBench (2023) also showed that retrieval over API documentation can
improve tool usage and reduce hallucinated API calls, especially when tools or
documentation change.

ToolRet (2025) is more decisive. It benchmarks retrieval over roughly 43,000
tools and 7,600 retrieval tasks. Strong conventional information-retrieval
models perform poorly on tool retrieval, and retrieval quality affects
end-to-end agent task success. Training specifically for tool retrieval improves
downstream pass rates.

A 2026 paper, "How Many Tools Should an LLM Agent See? A Chance-Corrected
Answer," directly treats candidate depth as a variable. It evaluates registry
sizes from 20 to 3,251 tools and reports that adaptive policies can often obtain
similar retrieval coverage at much smaller candidate depths. In one BFCL
condition, roughly 90% coverage was achieved with an average shortlist around 7
tools compared with a fixed shortlist of 50. The paper also notes that extra
candidates can actively hurt downstream LLM tool-choice accuracy.

The paper estimates roughly 200 tokens per tool description, implying that 100
candidate tools can consume around 20,000 tokens before the user query is
processed. That number should not be generalized to every tool schema, but it
demonstrates that schema inventory can be a first-order context cost.

Important limitation:
Almost all tool-retrieval research asks:

    Which tools are relevant to the task?

The present research asks a different question:

    Which relevant actions are legal NOW?

Those are not equivalent.

A refund tool can be highly relevant and still be illegal because:
- no captured payment exists,
- a refund is already pending,
- outcome is unknown,
- the actor lacks authority,
- required evidence is stale,
- policy changed,
- or another transition has consumed the precondition.

Task retrieval should therefore be considered an upstream or complementary
filter, not a substitute for legal-capability derivation.

================================================================================
3. ACTION MASKING / SAFE RL LITERATURE
================================================================================

The safe-RL literature gives the strongest theoretical analogue for capability
exposure.

Key results and lessons:

1. Mask invalid actions when validity is externally knowable.
   This prevents probability mass and exploration from being wasted on actions
   the environment will reject.

2. The benefit increases as invalid actions dominate the nominal action space.
   This predicts a strong interaction with the Capability Reduction Ratio (CRR).

3. A shield can operate before or after policy selection.
   For LLM agents, pre-choice shielding is more likely to reduce inference work;
   post-choice shielding mainly improves safety.

4. Safety guarantees depend on the correctness of the shield/specification.
   Masking the wrong action can create liveness failures or make valid goals
   unreachable.

5. Runtime computation is not free.
   Online shielding trades precomputation/storage against runtime evaluation.

The closest conceptual formula is:

    SafeActions(s) = { a in A | SafetySpecification(s, a) = true }

The proposed capability architecture generalizes this:

    Capabilities(s,p,e,u,v) =
        { a in A |
            state_preconditions(a,s)
            AND policy_allows(a,p)
            AND evidence_sufficient(a,e)
            AND authority_allows(a,u)
            AND versions_current(a,v) }

This is not merely safety masking. It is admissibility masking across semantic,
policy, evidentiary, authorization, and freshness constraints.

================================================================================
4. PLANNING BRANCHING-FACTOR THEORY
================================================================================

Classical planning strongly supports reducing irrelevant or inapplicable
operators, but care is required when translating this into LLM claims.

If a search algorithm explores a tree of branching factor b to depth d, the
number of potential nodes grows approximately with b^d in the worst case. A
change from b=30 to b=3 can therefore be enormous for explicit combinatorial
search.

STRIPS/PDDL planners already distinguish operator definitions from applicable
actions: an action whose preconditions are false is not applicable in the
current state. Planning systems also use pruning, helpful actions, landmarks,
partial-order methods, abstractions, and heuristics specifically because
branching factor dominates search complexity.

This supports the architectural logic:

    action definition != current applicability

However:

An autoregressive LLM is not performing BFS, DFS, or A* over a fully materialized
tree. Therefore "30 tools vs 3 tools means a 10x branching factor and thus 10^d
less LLM compute" would be an unjustified claim.

The defensible inference is narrower:

- explicit planners benefit greatly from smaller applicable action sets;
- LLM tool-selection studies show extra candidates can hurt accuracy and add
  context;
- therefore smaller legal candidate sets have a plausible mechanism for
  reducing LLM planning burden;
- the magnitude must be measured empirically.

================================================================================
5. LLM-SPECIFIC EMPIRICAL EVIDENCE
================================================================================

The following points are directly supported by existing LLM-agent research:

A. Large-scale tool selection is difficult.
ToolRet, ToolBench, Gorilla, LiveMCPBench, ComplexMCP, and related systems all
treat tool retrieval or large inventories as a substantive problem.

B. More candidates can reduce tool-choice accuracy.
Recent depth-selection research explicitly reports this downstream effect.

C. Stateful dependencies remain difficult.
ToolSandbox includes state dependencies between tools and reports that these
tasks challenge even strong models.

D. Interdependent real-world toolsets remain unsolved.
ComplexMCP (2026) uses more than 300 tools across seven stateful sandboxes and
reports a substantial human/model gap, identifying tool-retrieval saturation and
environment-verification failures as important bottlenecks.

E. Explicit state helps.
LedgerAgent reports gains from a typed state ledger and deterministic gating.

F. Runtime policy enforcement helps correctness.
FORGE reports large compliance gains and elimination of policy-violating
executions under its enforcement assumptions.

What is NOT yet strongly established:

- exact token savings from state-conditioned legality masking,
- exact reduction in reasoning tokens,
- exact reduction in model calls,
- exact crossover point where capability discovery is cheaper than full
  inventory exposure,
- robust evidence that capability masking enables a smaller model to match a
  larger model at lower total cost,
- the interaction with provider prompt caching over long-running production
  sessions.

================================================================================
6. STATIC VS TASK-BASED VS STATE-BASED TOOL RESTRICTION
================================================================================

These mechanisms must remain separate in both architecture and experiments.

A. STATIC TOOL REDUCTION

Definition:
A permanently smaller tool inventory.

Strength:
Simple. Easy to cache. Low runtime overhead.

Weakness:
Cannot adapt to changing state, authority, evidence, or policy.

Best use:
Bounded agents with narrow responsibility.

B. TASK-RELEVANT RETRIEVAL

Definition:
Select tools likely to help with the user goal.

Strength:
Strong evidence for reducing large registries to manageable candidate sets.

Weakness:
Relevance is semantic, not normative.
A retrieved action can be highly relevant but illegal.

Failure example:
User asks for refund -> retriever correctly retrieves RefundPayment ->
RefundPayment is currently unsafe because external outcome is unknown.

C. STATE-CONDITIONED CAPABILITY EXPOSURE

Definition:
Derive actions that are admissible against authoritative state and policy.

Strength:
Can eliminate entire classes of invalid calls by construction.
Potentially reduces planning and prompt burden.

Weakness:
Requires accurate state model, policy model, evidence provenance, authority
model, concurrency/freshness semantics, and complete capability derivation.

D. TASK + STATE FILTERING

Likely production optimum:

    Task retrieval narrows global tool universe
        ->
    state/policy/evidence derivation removes illegal actions
        ->
    obligations/prerequisites rank remaining legal frontier

This separates three questions cleanly:

    Could this tool matter?
    May it happen now?
    Should it happen next?

================================================================================
7. CAPABILITY SEMANTICS COMPARISON
================================================================================

The proposed capability object has strong analogues but is a novel composition.

OBJECT-CAPABILITY SYSTEMS
A capability reference both designates an object and conveys authority to invoke
it. This supports the idea that "having the action" can itself embody permission.

LEASES
Capabilities can expire or require renewal, analogous to time/freshness-bound
rights.

OPTIMISTIC CONCURRENCY
Version tokens ensure that an action authorized against state version N is
rejected if the authoritative record changes before execution. This is a direct
analogue to binding CanShip to observed versions.

PROOF OBJECTS / REFINEMENT TYPES
A value can encode evidence that required predicates were established before
construction. This suggests capability constructors should be private and
capabilities should only be minted by a trusted derivation layer.

LINEAR / AFFINE RESOURCES
Some permissions should be consumed once. A one-use CapturePayment or ShipOrder
capability resembles an affine resource: use at most once, preventing accidental
replay.

ACTION MASKS
The capability set is the model-visible projection of admissible actions.

PLANNER PRECONDITIONS
The state system computes action applicability from preconditions.

REFERENCE MONITORS
Even if the model sees a capability, final execution should still pass through a
trusted monitor because state may have changed.

Recommended semantics:

    Capability = opaque, runtime-authoritative, version-bound, optionally
    single-use permission to attempt one semantic transition.

Do NOT represent capabilities as ordinary forgeable JSON whose possession alone
authorizes effects.

================================================================================
8. TOOL-SCHEMA TOKEN-COST ANALYSIS
================================================================================

Tool schemas can consume substantial context because each tool may include:

- function name,
- description,
- parameter names,
- parameter descriptions,
- JSON schema,
- enums,
- constraints,
- return description,
- examples.

A recent 2026 tool-depth study uses an approximate figure of 200 tokens per tool
description and notes that 100 tools can therefore consume about 20,000 tokens.

Illustrative—not universal—schema arithmetic:

    5 tools   x 200 tokens ~= 1,000 tokens
    20 tools  x 200 tokens ~= 4,000 tokens
    50 tools  x 200 tokens ~= 10,000 tokens
    100 tools x 200 tokens ~= 20,000 tokens
    500 tools x 200 tokens ~= 100,000 tokens

Real schemas may be much smaller or much larger.

Capability metadata introduces a counter-cost. If every visible capability
contains verbose provenance such as:

    state versions
    policy IDs
    evidence IDs
    authority metadata
    derivation traces

then a 3-capability frontier may still be expensive.

Recommended architecture:

INTERNAL CAPABILITY
    rich, authoritative, fully versioned

MODEL PROJECTION
    compact:
        CapturePayment
        RefreshFraudEvidence

LAZY INSPECTION
    capability_details("CapturePayment")
    explain_blocked("ShipOrder")

The agent should not routinely receive security metadata it does not need for
choice.

================================================================================
9. PROMPT-INSTRUCTION REPLACEMENT ANALYSIS
================================================================================

Natural-language policy instructions have several costs:

1. Tokens are paid repeatedly unless cached.
2. The model must retrieve the correct rule from context.
3. The model must map the rule to current state.
4. The model must resist user instructions that conflict with policy.
5. The model may interpret ambiguous policy differently across runs.
6. The model may call a syntactically valid tool that is semantically illegal.

LedgerAgent and FORGE provide direct evidence that prompt-only policy adherence
is imperfect and that deterministic enforcement improves outcomes.

The ideal replacement is not necessarily "remove all policy text."

Use two layers:

    MACHINE ENFORCEMENT
        Determines what may execute.

    MODEL-FACING EXPLANATION
        Provides enough rationale to choose intelligently and communicate with
        the user.

This avoids using the LLM as the primary policy interpreter while preserving
transparency.

Potential token savings can be significant if long policy sections can be
removed from repeated prompts. But prompt caching can reduce their monetary cost
substantially. Therefore experiments must report:

    raw input tokens
    cache-write tokens
    cache-read tokens
    uncached tokens
    effective provider cost

================================================================================
10. PREREQUISITE-DIRECTED PLANNING
================================================================================

The proposed planning loop:

    goal
      -> satisfaction condition
      -> missing prerequisite
      -> transition producing prerequisite
      -> prerequisites of that transition
      -> repeat

is classical goal regression / backward chaining.

Example:

    Goal: ShipOrder
    Requires: PaymentCaptured AND FraudVerified
    Missing: PaymentCaptured
    Producer: CapturePayment
    CapturePayment requires: PaymentAuthorized
    Current: PaymentAuthorized
    Therefore current action: CapturePayment

This can transform planning from open-ended tool search into dependency
resolution over a state-transition graph.

The strongest architectural opportunity is not simply action masking. It is:

    capabilities = what can happen now
    obligations  = what must eventually become true
    producers    = what transitions can establish missing prerequisites

Together they expose a constrained proof/search problem.

This resembles:
- STRIPS regression,
- HTN decomposition,
- build systems,
- package dependency resolution,
- workflow engines,
- BDI intention management.

Potential agent interface:

    Goal:
        ShipOrder

    Unsatisfied:
        PaymentCaptured

    Available producer:
        CapturePayment

    Available actions:
        CapturePayment

This may drastically reduce the amount of world reconstruction the model must
perform.

================================================================================
11. OBLIGATIONS + CAPABILITIES ANALYSIS
================================================================================

Capabilities alone answer:

    What may I do?

Obligations answer:

    What still needs to become true?

The pair is more powerful than either alone.

Without obligations, a small capability set can still leave the model unsure
which action advances the goal.

Without capabilities, obligations may tell the model what is missing while
leaving it to sift through dozens of illegal producers.

Combined:

    obligation
        -> missing condition
        -> currently legal producer capability

This suggests a three-frontier runtime:

1. LEGAL FRONTIER
   All currently executable transitions.

2. REQUIRED FRONTIER
   Outstanding obligations / unsatisfied goals.

3. EXPLANATION FRONTIER
   Why a desired action is blocked and which prerequisite can unlock it.

A model may need only a small projection of all three.

================================================================================
12. STALE CAPABILITY / FRESHNESS ANALYSIS
================================================================================

Version-bound capabilities map directly onto optimistic concurrency and TOCTOU
(time-of-check/time-of-use) control.

Example:

    CanShip:
        CustomerVersion=42
        PaymentVersion=8
        FraudEvidenceVersion=11
        Policy=ShippingPolicy@7

Then:

    CustomerVersion -> 43

must invalidate CanShip.

This changes the role of the LLM. The model does not need to reason:
"Did anything change since I looked?"

Instead, execution establishes freshness mechanically.

Correctness benefit:
STRONG.

Reasoning/token benefit:
Plausible but not established.

Recommended execution rule:

    execute(capability, args):
        authenticate capability
        re-read or atomically verify required versions
        re-check non-versionable time constraints
        consume capability if single-use
        execute transition
        record outcome
        emit new state/version
        invalidate affected capabilities

Capabilities should not be long-lived bearer permissions unless the domain
specifically allows that.

================================================================================
13. CONCURRENT-ACTION LIMITATIONS
================================================================================

A subtle but serious limitation:

    individually legal != jointly safe

At snapshot S:

    ShipOrder is legal
    RefundPayment is legal

but executing both may violate business invariants.

Therefore capability filtering cannot be defined purely as independent action
predicates. The system needs conflict semantics.

Possible mechanisms:

- aggregate-level serialization,
- compare-and-swap on shared version tokens,
- reservation tokens,
- actor/mailbox serialization,
- transactional transitions,
- process managers/sagas,
- mutually exclusive capability groups,
- capability consumption.

A useful model:

    CanShip and CanRefund can both be derivable at version V.

Whichever is executed first changes/consumes V.

The second then fails freshness validation.

For higher-consequence effects, explicit decision serialization may be safer:

    DecideFulfillmentDisposition
        -> produces either CanShip OR CanRefund

rather than exposing both effects simultaneously.

================================================================================
14. EXTERNAL-EFFECT UNCERTAINTY IMPLICATIONS
================================================================================

This is one of the strongest application areas.

Suppose:

    RefundPayment
        -> external provider timeout

The system must not infer failure.

The semantic state should become:

    RefundExecution = OutcomeUnknown

Then:

    RefundPayment capability = absent
    ReconcileRefund capability = present

This mechanically prevents duplicate external effects.

Prompt instruction:

    "Do not retry if the refund times out"

is weaker because:
- the instruction can be forgotten,
- the agent may classify the timeout incorrectly,
- another agent may not have the same context,
- retries may occur after conversation truncation,
- a new process may lack the instruction history.

State-conditioned capability exposure persists the uncertainty as domain state.

This is likely one of the largest correctness wins.

================================================================================
15. SMALLER-MODEL HYPOTHESIS
================================================================================

This is economically important and currently under-tested.

Reasoning:

A broad-tool agent must perform some combination of:

    understand task
    identify relevant tools
    reject irrelevant tools
    infer legal tools
    remember policy
    check state
    choose action
    form arguments

A capability-filtered agent may need only:

    understand goal
    choose among 1-3 legal actions
    form arguments

If deterministic infrastructure removes enough classification and policy burden,
a smaller model may become viable.

Evidence supporting plausibility:
- smaller candidate sets improve tool-selection tractability,
- constrained decoding can allow generalist models to perform better on
  structured tool invocation,
- SLM function-calling research shows smaller models can perform useful tool
  selection when tasks/interfaces are constrained,
- deterministic state/policy systems reduce work the model must do.

Evidence missing:
No robust body of work yet demonstrates:

    small model + state-conditioned legal capability frontier
        >=
    frontier model + broad toolset

on realistic stateful business workflows at lower total cost.

This should be treated as a high-value experimental hypothesis, not a current
fact.

Prediction:
The effect will probably be strongest when:
- nominal tool inventory is large,
- legal fraction is small,
- policy/state rules are complex,
- actions are structured,
- choice among legal options is comparatively simple.

It will be weaker where:
- most difficulty is semantic interpretation,
- the environment is unstructured,
- legal action count remains large,
- tools require complex argument generation,
- success depends on broad world knowledge.

================================================================================
16. MODEL-SCALE INTERACTION
================================================================================

Likely pattern:

SMALL MODELS
    Benefit most from reduction because distractors, long policies, and large
    schemas consume proportionally more capability.

FRONTIER MODELS
    Still benefit in correctness because deterministic boundaries remove
    failure classes, but marginal tool-selection gains may be smaller at low
    tool counts.

VERY LARGE TOOL REGISTRIES
    Even frontier models generally require retrieval or hierarchy because raw
    schema context becomes impractical.

The right experiment is factorial:

    model size x total tools x legal tools x task complexity

For example:

    Models:
        small / medium / frontier

    Total tools:
        20 / 100 / 500

    Legal tools:
        1 / 3 / 10 / all

This allows measurement of interaction effects rather than only average gains.

================================================================================
17. CACHING IMPLICATIONS
================================================================================

Prompt caching is the strongest economic counterargument to raw input-token
savings.

Modern model APIs can cache repeated prefixes including tool definitions or
system prompts. Anthropic documentation explicitly supports caching tool
definitions. Other providers also implement forms of prompt caching.

Therefore:

    20,000 repeated tool-schema tokens
        !=
    20,000 full-price input tokens on every turn

But caching does not eliminate every cost:

- cache reads generally still have nonzero cost,
- cached prefixes still occupy effective context,
- attention/latency effects may remain provider-dependent,
- dynamic tool sets can invalidate or fragment caches,
- legality rules/state may be uncached,
- more candidate tools can still reduce selection accuracy even when their
  monetary input cost is discounted.

Capability filtering may therefore have two independent economic mechanisms:

1. CONTEXT COST REDUCTION
2. ERROR/REPAIR REDUCTION

Caching weakens mechanism 1 but does much less to weaken mechanism 2.

Experiments must compare effective billable cost, not only token count.

================================================================================
18. DYNAMIC-TOOL-REFRESH OVERHEAD
================================================================================

The architecture may require:

    get_state
    derive_capabilities
    call model
    execute action
    update state
    derive_capabilities again

Naïvely implemented, this can create substantial protocol churn.

Avoid making capability refresh an LLM-visible tool call when the runtime can do
it deterministically.

BAD:
    LLM -> get_capabilities()
    LLM -> choose
    LLM -> refresh_capabilities()
    LLM -> choose

BETTER:
    runtime computes capabilities as part of each state transition
    next model invocation automatically receives current projection

The system should treat capability calculation as infrastructure, not as agent
work.

The cost then becomes:
- CPU/database/policy-evaluation overhead,
- changed schema serialization,
rather than additional model reasoning calls.

FORGE's results are instructive: policy evaluation itself can be cheap, while
agent recovery after a blocked action dominates overhead. That suggests
pre-filtering may have favorable economics if it prevents those denied attempts.

================================================================================
19. COUNTERARGUMENTS
================================================================================

1. "Modern models already select tools well."
True for small, well-described sets in many tasks. Much weaker at large scale
or with overlapping tools. Capability filtering may have small value at 5 tools
and large value at 500.

2. "Prompt caching makes large inventories cheap."
Partially true. It reduces repeated input cost but not necessarily selection
errors, context dilution, or reasoning burden.

3. "Dynamic refresh costs more than it saves."
Possible. This is an empirical crossover-point question. Runtime-derived
capabilities should therefore be refreshed outside the LLM loop.

4. "Agents need blocked actions to plan."
Sometimes true. This argues for lazy blocked-action explanation, not universal
exposure.

5. "Removing tools harms exploration."
True in open-ended discovery tasks. Less relevant in governed business
transitions where illegal exploration is not acceptable.

6. "Capability derivation is expensive."
Possible in highly relational policies. But deterministic computation can often
be cheaper and more auditable than repeated LLM interpretation.

7. "Masking hides specification errors."
Correct. A missing capability can make a valid outcome unreachable.

8. "Wrong capability logic is more dangerous than model error."
Potentially. Deterministic code concentrates responsibility: it can produce
systematic failures instead of probabilistic ones. This requires stronger
verification/testing.

9. "Task retrieval gives most of the benefit."
Maybe for token cost, not for legality. Retrieval cannot reliably encode state,
authority, concurrency, or outcome uncertainty unless it becomes a capability
system in disguise.

10. "Tool descriptions are a small fraction of context."
Sometimes. Measure the actual system. The benefit depends on schema size and
conversation length.

11. "Reasoning cost dominates input size."
Possible for reasoning models. But error/repair savings may still dominate.

12. "Small sets cause premature commitment."
True if the derivation layer filters preference rather than legality. The system
must preserve ALL legal actions, not only predicted-good actions.

13. "Illegal actions can be useful hypotheticals."
Yes. Separate discussion vocabulary from executable capability. The model may be
allowed to discuss RefundPayment without possessing CanRefund.

14. "Dynamic schemas hurt caching."
True. Compact capability lists and stable tool families may mitigate this.

15. "Capabilities become too granular."
A serious design risk. Capability boundaries should follow semantic transitions,
not every field mutation.

================================================================================
20. FAILURE MODES
================================================================================

A. FALSE NEGATIVE CAPABILITY
A legal action is omitted.
Consequence: liveness failure, inability to complete valid goal.

B. FALSE POSITIVE CAPABILITY
An illegal action is exposed.
Consequence: safety failure unless execution revalidates.

C. STALE CAPABILITY
State changes after issuance.
Mitigation: version-bound validation.

D. FORGED CAPABILITY
Agent fabricates a capability token.
Mitigation: opaque references/signatures/runtime lookup/private constructors.

E. REPLAY
One-use effect capability invoked twice.
Mitigation: consumption/idempotency keys/version transition.

F. PARTIAL STATE
Capability derivation occurs without required authoritative information.
Mitigation: Unknown must be a first-class state, not false/true guessed value.

G. POLICY VERSION SKEW
Model/runtime use different policies.
Mitigation: bind capability to policy version.

H. EVIDENCE STALENESS
Old fraud/identity/approval evidence remains accepted.
Mitigation: freshness predicates and evidence versioning.

I. CONCURRENT LEGAL ACTIONS
Two individually valid actions conflict.
Mitigation: serialization/version consumption/reservation.

J. EXTERNAL OUTCOME UNCERTAINTY
Timeout misclassified as failure and action repeated.
Mitigation: explicit OutcomeUnknown transition and reconciliation capability.

K. UNREACHABLE OBLIGATION
Required outcome exists but no capability path can satisfy it.
Mitigation: obligation reachability checks and alarms.

L. CAPABILITY EXPLOSION
Combinatorial type/state combinations create too many capabilities.
Mitigation: derive semantic capabilities from predicates; do not create a unique
type for every Cartesian combination of state.

M. TOOL CHURN
Tool list changes every step and hurts caching/interfaces.
Mitigation: stable semantic tool families plus dynamic availability metadata, or
provider-level tool toggling where supported.

================================================================================
21. PROPOSED EXPERIMENTS
================================================================================

EXPERIMENT A — TOOL COUNT

Hold legal frontier constant at 3.

Nominal tools:
    5, 20, 50, 100, 500

Conditions:
    full inventory
    task retrieval
    state capabilities

Measure:
    success
    tool-selection accuracy
    input/output tokens
    latency
    invalid attempts
    repairs
    total cost

Primary question:
Does performance degrade with nominal inventory when legal frontier is fixed?

EXPERIMENT B — LEGAL FRACTION

Total tools = 100.

Legal:
    1, 3, 10, 30, 100

Define:

    CRR = exposed legal actions / nominal actions

Test correlation of CRR with:
    accuracy
    tokens
    action errors
    cost

EXPERIMENT C — PREREQUISITE CHAIN

Goal:
    ShipOrder

Chain:
    CapturePayment
      -> RefreshFraudEvidence
      -> ShipOrder

Compare:
    full inventory
    state-filtered only
    state-filtered + missing prerequisite
    state-filtered + obligation + producer guidance

EXPERIMENT D — ILLEGAL REQUEST

User:
    "Refund this now."

State:
    RefundExecution = OutcomeUnknown

Compare:
    prompt rule only
    post-hoc policy gate
    pre-filtered capability frontier

Expected distinction:
Both gate and capability system may prevent harm, but pre-filtering should
generate fewer illegal attempts and repair loops.

EXPERIMENT E — STALE STATE

Issue CanShip at version N.
Mutate relevant state to N+1 before execution.

Measure:
    unauthorized effect rate
    recovery behavior
    tokens
    retries

EXPERIMENT F — SMALLER MODEL SUBSTITUTION

Compare:
    frontier model + full 100 tools
    frontier model + legal 3
    medium model + legal 3
    small model + legal 3

Use total cost per correct completion as primary metric.

EXPERIMENT G — CACHING

Run identical benchmark with:
    cache cold
    cache warm

Measure:
    provider-billed input cost
    latency
    selection accuracy

EXPERIMENT H — BLOCKED ACTION VISIBILITY

Conditions:
    all blocked actions visible
    none visible
    lazy explain_blocked
    prerequisites only

Question:
Can lazy blocked explanations preserve planning while minimizing context?

EXPERIMENT I — CONCURRENCY

Expose Ship and Refund at same state version.
Race two agents.

Test:
    no concurrency guard
    version guard
    reservation/serialization

EXPERIMENT J — SPECIFICATION COMPLETENESS

Inject capability-derivation bugs that omit valid transitions.

Test whether:
    obligations detect no legal path
    reachability analysis detects dead end
    agent can distinguish "goal impossible" from "capability model incomplete"

================================================================================
22. RECOMMENDED METRICS
================================================================================

PRIMARY

1. Correct Completion Rate
2. Cost per Correct Completion
3. Policy/Safety Violation Rate
4. Invalid Action Attempt Rate
5. External Harm / Duplicate Effect Rate

ACTION-SPACE

6. Nominal Action Count
7. Exposed Action Count
8. Capability Reduction Ratio (CRR)

        CRR = exposed actions / total defined actions

9. Legal Fraction
10. Action-selection entropy where estimable

EFFICIENCY

11. Input tokens
12. Output tokens
13. Reasoning tokens where provider exposes them
14. Cached input tokens
15. Uncached input tokens
16. Model calls
17. Tool calls
18. Rejected tool calls
19. Repair loops
20. Wall-clock latency

PLANNING

21. Actions attempted per successful semantic transition
22. Steps above shortest legal plan
23. Prerequisite-discovery calls
24. Blocked-action explanation calls

CORRECTNESS OF THE CAPABILITY SYSTEM ITSELF

25. Capability false-positive rate
26. Capability false-negative rate
27. Obligation reachability
28. Stale-capability rejection rate
29. Capability replay rejection rate
30. Policy-version mismatch detection rate

Recommended composite:

                      total model + tool + human cost
    CostCorrect = -----------------------------------------
                    number of correct completed tasks

A failed but cheap execution should not appear economically superior.

================================================================================
23. ECONOMIC MODEL
================================================================================

Let:

    C_model_input
    C_model_output
    C_reasoning
    C_tool
    C_latency
    C_repair
    C_human
    C_capability_compute

Then expected task cost:

    C_task =
        C_model_input
      + C_model_output
      + C_reasoning
      + C_tool
      + C_latency
      + C_repair
      + C_human
      + C_capability_compute

And:

    CostCorrect = sum(C_task) / successful_correct_tasks

Capability filtering can create value through four channels.

CHANNEL 1 — FEWER SCHEMA TOKENS
Potentially significant for large toolsets.
Reduced by prompt caching.

CHANNEL 2 — FEWER WRONG TOOL ATTEMPTS
Likely important as tool inventory grows.

CHANNEL 3 — FEWER POLICY REPAIR LOOPS
Potentially larger than token savings.
FORGE demonstrates that post-hoc enforcement can add recovery overhead;
pre-filtering specifically targets this cost.

CHANNEL 4 — MODEL SUBSTITUTION
Potentially the largest economic effect if a smaller model can perform
constrained choice as reliably as a frontier model performs unconstrained choice.

The economic thesis should therefore not be framed primarily as:
"we save tool-schema tokens."

A stronger thesis is:

    deterministic architecture purchases reliable decision structure with cheap
    conventional computation so expensive probabilistic inference is used only
    for decisions that genuinely require judgment.

That is the hypothesis worth testing.

================================================================================
24. WHAT IS ALREADY EMPIRICALLY SUPPORTED
================================================================================

SUPPORTED STRONGLY

- Learned agents benefit when known-invalid actions are masked in large discrete
  action spaces.
- Formal/runtime shields can prevent specified classes of unsafe actions.
- Prompt-only policy enforcement is not reliable enough for consequential
  agentic action.
- Explicit structured state can improve policy-adherent stateful tool use.
- Tool retrieval becomes difficult at large scale.
- Tool retrieval quality affects end-to-end task success.
- Large candidate tool sets can consume substantial context.
- Extra candidates can hurt downstream LLM tool choice.
- Stateful tool dependencies remain challenging.
- Version/concurrency checks are mature techniques for rejecting operations made
  against stale state.

SUPPORTED MODERATELY

- Smaller candidate sets reduce LLM decision burden.
- Structured prerequisite information should improve multi-step tool planning.
- Externalizing state reconstruction from prompts improves consistency.

================================================================================
25. WHAT REMAINS SPECULATIVE
================================================================================

- The exact token reduction caused specifically by legal-action filtering rather
  than generic tool retrieval.
- Whether reasoning-token savings are large for frontier reasoning models.
- Whether state-filtered capability refresh is cheaper than stable cached
  inventories in all regimes.
- The inventory-size threshold where dynamic exposure wins economically.
- Whether capability filtering can routinely substitute a small model for a
  frontier model.
- Whether obligation-guided capability planning scales across highly ambiguous
  domains.
- Whether compact capability projections preserve enough information for
  optimal planning.
- Whether capability false negatives become a major production failure mode.
- Whether users/agents need awareness of illegal alternatives for explanation or
  negotiation often enough to offset context savings.

================================================================================
26. ARCHITECTURE CHANGES SUGGESTED BY PRIOR RESEARCH
================================================================================

The research suggests the proposed architecture should be refined as follows.

1. KEEP THE REFERENCE MONITOR EVEN WHEN TOOLS ARE FILTERED
Never assume model-visible capability filtering is the final security boundary.
Revalidate at execution.

2. SEPARATE INTERNAL CAPABILITY FROM MODEL PROJECTION
Internal:
    versions, policy, evidence, authority, provenance, expiration, uniqueness

Model-facing:
    action name, short semantic description, essential parameters

3. TREAT UNKNOWN AS EXPLICIT STATE
Do not infer false from missing evidence.

4. BIND CAPABILITIES TO SEMANTIC VERSIONS
Not merely object IDs.

5. SUPPORT SINGLE-USE / CONSUMABLE CAPABILITIES
For irreversible external effects.

6. COMPUTE CAPABILITIES OUTSIDE THE LLM LOOP
Do not force the agent to repeatedly ask what it may do.

7. ADD OBLIGATIONS
Capabilities prevent bad transitions; obligations help prevent dead-end or
incomplete behavior.

8. ADD REACHABILITY / COMPLETENESS CHECKS
If an obligation exists and no legal path can satisfy it, surface a system
error rather than merely telling the model "no actions available."

9. PROVIDE LAZY BLOCKED-ACTION EXPLANATION
Agents often need to know how to unlock a desired transition, but need not carry
every blocked action every turn.

10. DISTINGUISH DISCUSSION FROM EXECUTION
An agent may discuss an unavailable action without possessing executable
authority for it.

11. MODEL CONFLICT SETS
Two capabilities can be individually legal but mutually exclusive.

12. MODEL EXTERNAL EFFECTS AS OUTCOMES, NOT CALL RETURNS
Success / Failure / OutcomeUnknown should be semantic states.

13. TEST CAPABILITY DERIVATION LIKE A SAFETY-CRITICAL COMPONENT
Property tests:
    every exposed capability satisfies invariants

Completeness tests:
    required valid transitions are derivable

Mutation tests:
    deliberately alter guards and verify test failure

Reachability tests:
    obligations have legal satisfaction paths

14. USE TASK RETRIEVAL AND STATE FILTERING TOGETHER AT VERY LARGE SCALE
Global registry
    -> semantic retrieval
    -> deterministic legality
    -> obligation/prerequisite prioritization

15. BENCHMARK AGAINST POST-HOC GATING
This is vital. Otherwise an observed correctness gain may be attributable to
enforcement generally, not action-space reduction specifically.

================================================================================
27. FINAL VERDICT
================================================================================

Does reducing legal action space improve correctness?
    STRONG EVIDENCE

Reason:
Invalid-action masking, shielding, reference-monitor literature, FORGE, and
LedgerAgent all support moving legality outside unconstrained probabilistic
choice. Direct LLM evidence for PRE-FILTERING is still thinner than the general
correctness evidence, but the mechanism is well supported.

Does it reduce LLM token usage?
    MODERATE EVIDENCE

Reason:
Smaller tool inventories directly reduce schema context, and recent tool-depth
research quantifies potentially large schema costs. However prompt caching,
dynamic metadata, and refresh messages can offset savings. Direct studies of
state-conditioned legal filtering are still missing.

Does it reduce total agent execution cost?
    MODERATE EVIDENCE

Reason:
There are credible savings from fewer tool-selection errors and fewer repair
loops, but deterministic enforcement can itself create overhead. FORGE is an
important warning: post-hoc enforcement improved compliance while increasing
latency/cost because blocked actions required recovery. Pre-filtering may reverse
that cost pattern, but the experiment has not yet been run cleanly.

Does it enable smaller models?
    WEAK-TO-MODERATE EVIDENCE

Reason:
The hypothesis is mechanistically plausible and adjacent work shows smaller
models can benefit from constrained tool-use settings. There is not yet enough
direct evidence that state-derived capability filtering consistently lets a
smaller model match a larger broad-tool model on realistic workflows.

Does state-conditioned filtering provide more value than task-only tool retrieval?
    PROBABLY YES

Reason:
Task retrieval answers relevance. State-conditioned filtering answers legality.
For consequential stateful systems, legality depends on facts semantic retrieval
does not inherently encode: current state, policy, authority, evidence,
freshness, concurrent transitions, and uncertain external outcomes.

Most important mechanism:
    Removing deterministic legality decisions from probabilistic inference,
    leaving the model to choose preferences among admissible actions.

Strongest existing evidence:
    The combination of invalid-action masking/shielded-RL results, large-tool
    retrieval results, LedgerAgent's structured-state gains, and FORGE's formal
    runtime enforcement results.

Biggest counterargument:
    Dynamic capability computation and schema refresh may add enough churn,
    cache loss, and completeness risk that task retrieval plus a post-hoc
    reference monitor could deliver most of the practical value more simply.

Most important missing experiment:
    A controlled, stateful benchmark comparing full inventory, task retrieval,
    post-hoc policy gating, and pre-filtered state capabilities while measuring
    total cost per correct completion across small, medium, and frontier models.

Most likely economic benefit:
    Not raw token savings alone. The largest upside is likely elimination of
    selection/repair work and possible model substitution: using inexpensive
    deterministic state computation to avoid paying an expensive model to
    repeatedly rediscover rules and reject impossible actions.

Most likely correctness benefit:
    Entire classes of illegal, stale, duplicate, unauthorized, and
    outcome-uncertain actions become unrepresentable or uninvokable at the
    agent boundary.

================================================================================
RESEARCH CONCLUSION
================================================================================

The hypothesis survives skeptical review.

It should be narrowed from:

    "Fewer actions make AI agents cheaper and more correct."

to:

    "When action legality is deterministically knowable from authoritative
    state, policy, evidence, authority, and freshness, computing that legality
    outside the model and exposing only the admissible frontier should reduce
    preventable agent errors. Existing research strongly supports the
    correctness mechanism and moderately supports candidate-set reduction as an
    inference aid. Whether the architecture materially lowers end-to-end cost,
    especially enough to enable smaller models, is a high-value but still
    experimentally unresolved question."

This is a stronger research position because it identifies exactly what prior
work supports and exactly what remains novel.

The most promising novelty is not action masking by itself. Action masking is
old.

The novel research opportunity is the composition:

    explicit semantic state
    + legal transitions
    + evidence/authority/policy/freshness guards
    + version-bound capabilities
    + obligations
    + prerequisite-directed planning
    + compact model-visible action frontier
    + authoritative execution-time revalidation

applied to LLM software agents and evaluated simultaneously for:

    correctness
    token economics
    repair economics
    model substitution
    long-term scaling as system action inventories grow

That complete combination is not yet established by the literature reviewed
here.

================================================================================
SELECTED PRIMARY / HIGH-VALUE SOURCES
================================================================================

1. Huang, Shengyi; Ontañón, Santiago.
   "A Closer Look at Invalid Action Masking in Policy Gradient Algorithms."
   arXiv:2006.14171
   https://arxiv.org/abs/2006.14171

2. Alshiekh, Mohammed et al.
   "Safe Reinforcement Learning via Shielding."
   arXiv:1708.08611
   https://arxiv.org/abs/1708.08611

3. Qin, Yujia et al.
   "ToolLLM: Facilitating Large Language Models to Master 16000+ Real-world APIs."
   arXiv:2307.16789
   https://arxiv.org/abs/2307.16789

4. Patil, Shishir G. et al.
   "Gorilla: Large Language Model Connected with Massive APIs."
   arXiv:2305.15334
   https://arxiv.org/abs/2305.15334

5. Shi, Zhengliang et al.
   "Retrieval Models Aren't Tool-Savvy: Benchmarking Tool Retrieval for Large
   Language Models."
   arXiv:2503.01763
   https://arxiv.org/abs/2503.01763

6. "How Many Tools Should an LLM Agent See? A Chance-Corrected Answer."
   arXiv:2605.24660
   https://arxiv.org/abs/2605.24660

7. Lu, Jiarui et al.
   "ToolSandbox: A Stateful, Conversational, Interactive Evaluation Benchmark
   for LLM Tool Use Capabilities."
   arXiv:2408.04682
   https://arxiv.org/abs/2408.04682

8. Uddin, Md Nayem et al.
   "LedgerAgent: Structured State for Policy-Adherent Tool-Calling Agents."
   arXiv:2606.20529
   https://arxiv.org/abs/2606.20529

9. "Formal Policy Enforcement for Real-World Agentic Systems" (FORGE).
   arXiv:2602.16708
   https://arxiv.org/abs/2602.16708

10. Li, Yuanyang et al.
    "ComplexMCP: Evaluation of LLM Agents in Dynamic, Interdependent, and
    Large-Scale Tool Sandbox."
    arXiv:2605.10787
    https://arxiv.org/abs/2605.10787

11. Younes, Håkan L. S.; Simmons, Reid G.
    "VHPOP: Versatile Heuristic Partial Order Planner."
    Journal of Artificial Intelligence Research, 2003.
    (Classical planning source on search/planning operator structure.)

12. Microsoft Learn.
    "Handling Concurrency Conflicts — EF Core."
    https://learn.microsoft.com/en-us/ef/core/saving/concurrency

13. Cap'n Proto RPC Protocol.
    Object-capability semantics.
    https://capnproto.org/rpc.html

14. Anthropic Claude Platform Documentation.
    "Prompt caching."
    https://docs.anthropic.com/en/docs/build-with-claude/prompt-caching

================================================================================
EVIDENCE LABELS USED IN THIS REPORT
================================================================================

STRONG EVIDENCE
    Multiple directly relevant empirical/formal sources support the mechanism.

MODERATE EVIDENCE
    Adjacent empirical evidence and theory support the claim, but the exact
    proposed architecture has not been directly and comprehensively tested.

WEAK EVIDENCE
    Plausible mechanism or narrow evidence exists, but important direct tests
    are missing.

SPECULATIVE
    Reasonable hypothesis requiring targeted experiments before it should be
    treated as an architectural or economic fact.
