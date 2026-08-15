# AI Research Mission 06 — Outcome Unknown, Effect Uncertainty, and Safe Agent Action

**Research report**  
**Date:** 2026-08-14  
**Basis:** Literature review, primary technical documentation, foundational distributed-systems work, transaction-processing literature, workflow/platform documentation, payment/cloud API documentation, and recent empirical LLM-agent research.

---

# 1. Executive verdict

## Bottom line

The core hypothesis is **substantially supported**.

A consequential external operation can be in a state where the caller knows that it did not receive a successful response but **does not know whether the external effect occurred**. That condition is not equivalent to failure. It is a familiar consequence of distributed execution across unreliable communication boundaries.

For consequential effects, collapsing:

- success,
- known failure,
- and unknown outcome

into a binary success/failure result is unsafe.

The strongest form of the architectural recommendation is therefore:

> **Represent effect outcome separately from invocation/transport outcome, and make indeterminate external outcomes first-class semantic state.**

However, the proposed ternary:

- `Succeeded`
- `Failed`
- `OutcomeUnknown`

is **too small to serve as a universal effect-state algebra**.

Real integrations commonly require distinctions such as:

- `Rejected`
- `Accepted`
- `Pending`
- `Succeeded`
- `KnownFailed`
- `PartiallySucceeded`
- `OutcomeUnknown`
- `ReconciliationConflict`
- `AdministrativelyResolved`

The important contribution is not a particular three-case enum. It is the semantic rule:

> **Unknown must never be silently collapsed into failed or succeeded.**

For AI agents, the evidence is emerging but unusually direct. A July 2026 controlled study, *Verified Tool Calls Improve LLM Agent Reliability Under Non-Atomic Failures*, specifically studied timeouts after dispatch, delayed visibility, and partial state updates. It reported that naive retry strategies can produce duplicate actions and that verify-before-retry behavior combined with idempotency keys substantially reduces duplicate actions while maintaining similar task success.

That study does not prove the complete proposed architecture, but it validates the exact failure mechanism at the heart of this research mission.

## Main conclusion

For consequential operations:

```text
transport failure
    !=
known effect failure
```

and:

```text
timeout
    !=
safe permission to issue a new semantic operation
```

The safest general design is:

```text
Command issued with stable semanticOperationId
        |
        v
Invocation / execution observation
        |
        +--> authoritative success ------> Succeeded
        |
        +--> authoritative non-effect ---> Rejected / KnownFailed
        |
        +--> authoritative pending ------> Pending
        |
        +--> partial authoritative state -> PartiallySucceeded
        |
        +--> insufficient information ---> OutcomeUnknown
                                             |
                                             v
                                   Reconciliation obligation
                                             |
                              +--------------+--------------+
                              |              |              |
                              v              v              v
                         Succeeded      KnownFailed    Conflict /
                                                      Admin resolution
```

During `OutcomeUnknown`, creation of a **new semantic operation** for the same intended effect should normally be unavailable.

A retry of the **same semantic operation**, using the same operation identity and a provider contract that guarantees deduplication/idempotency, may remain legal.

That distinction is critical.

---

# 2. Standard terminology for uncertain outcomes

There is no single universal term across all fields, but several established terms describe closely related conditions.

## Distributed systems / RPC

Common descriptions include:

- ambiguous result
- uncertain outcome
- indeterminate outcome
- request outcome unknown
- maybe semantics
- partial failure

Classic RPC literature distinguishes guarantees such as at-most-once and at-least-once precisely because communication failure prevents the caller from always knowing what happened remotely.

## Database / transaction processing

More formal terminology includes:

- **in-doubt transaction**
- **uncertain commit**
- **unknown transaction resolution**
- **heuristic outcome** in some transaction-processing systems

SQLSTATE includes the category:

```text
08007 — TRANSACTION RESOLUTION UNKNOWN
```

This is particularly strong prior art because the condition is represented explicitly as something different from normal transaction failure.

## Payments / integration engineering

Practical language often includes:

- unknown payment status
- pending
- ambiguous timeout
- reconciliation required
- indeterminate result

Payment APIs often avoid exposing exactly the same abstract vocabulary, but their use of idempotency keys, persistent payment objects, asynchronous status, webhooks, and reconciliation demonstrates that the underlying state distinction is operationally important.

## Recommended terminology

For developers and agent-facing interfaces:

**`OutcomeUnknown`** is the clearest general term.

Why:

- it says exactly what is unknown;
- it avoids implying that execution is still happening;
- it distinguishes clearly from `Pending`;
- it does not over-import database-specific terminology.

For operator interfaces, a user-facing label may be:

**Outcome not yet established — reconciliation required**

For transaction-specific infrastructure, **InDoubt** remains appropriate where that term already exists.

---

# 3. Distributed-systems foundations

## The underlying problem

Suppose client C sends operation O to server S.

Possible timeline:

```text
C -> S: Execute O
S: executes O successfully
S -> C: success response
network drops response
C: timeout
```

From C's local perspective, the observations are compatible with multiple worlds:

1. the request never reached S;
2. the request reached S but was rejected;
3. S accepted it but has not completed it;
4. S executed it successfully but the response was lost;
5. S partially executed it;
6. S itself is uncertain;
7. S executed it and subsequently changed state.

The timeout only proves:

> the caller's waiting condition expired without an authoritative response.

It does **not** prove non-execution.

## Two Generals / coordination impossibility

The Two Generals problem is relevant as intuition: communicating parties cannot obtain common knowledge of successful coordination over an unreliable channel using a finite acknowledgement sequence.

But it should not be used as a sweeping statement that distributed outcomes are always unknowable.

Real systems overcome many practical uncertainty cases using:

- stable storage,
- operation identifiers,
- consensus,
- replicated logs,
- transaction protocols,
- retry + deduplication,
- status queries,
- reconciliation,
- authoritative ledgers.

The theoretical point is narrower:

> A missing message cannot by itself tell the recipient which remote-world outcome occurred.

The architectural implication is therefore not "distributed systems are impossible."

It is:

> software must preserve epistemic uncertainty until stronger evidence arrives.

---

# 4. RPC semantics

Traditional RPC semantics provide useful framing.

## At-least-once

The system retries until a request is executed.

Benefit:

- high chance of eventual execution.

Risk:

- the operation can execute more than once.

Appropriate when operations are naturally idempotent or safely deduplicated.

## At-most-once

The system uses request identity / duplicate suppression so that a request is not executed repeatedly.

Benefit:

- avoids duplicate execution under the defined scope.

But a caller can still experience a timeout and be unsure whether the single allowed execution occurred.

Thus at-most-once execution does not automatically imply:

```text
caller knows outcome
```

## Exactly-once

"Exactly once" is meaningful only relative to a defined boundary.

It may mean:

- exactly one log append,
- exactly one broker-visible message,
- exactly one processing transaction,
- exactly one deduplicated API operation,
- exactly one observable business effect.

Those are not interchangeable.

A broker can provide strong exactly-once behavior inside its transactional domain while the consumer still calls an external payment or email API whose effect lies outside that domain.

Therefore:

> exactly-once infrastructure does not eliminate effect uncertainty beyond the transaction boundary it controls.

---

# 5. Idempotency analysis

Idempotency is one of the strongest existing mechanisms supporting this architecture.

AWS EC2 uses client tokens to make operations such as `RunInstances` idempotent within documented regional/zonal scopes.

Stripe uses idempotency keys to allow clients to repeat requests safely under specified conditions.

Temporal explicitly recommends idempotent Activities because Activities can execute multiple times.

Azure retry guidance warns that non-idempotent operations can execute more than once if a request succeeds remotely but the response is lost.

## Does idempotency eliminate OutcomeUnknown?

No.

Idempotency changes:

```text
retry may duplicate effect
```

into something closer to:

```text
retry of same identity should not create another effect
```

under the provider's guarantee.

But after the first timeout, the caller may still temporarily not know whether the operation:

- has not executed,
- already executed,
- remains pending,
- or will return the cached result on replay.

The outcome remains epistemically unknown until an authoritative mechanism resolves it.

Therefore:

> Idempotency is primarily an **effect-safety mechanism**, not an **outcome-knowledge mechanism**.

It often makes reconciliation easier, because replaying the same semantic operation can safely recover the original outcome.

## Limitations

Idempotency guarantees are scoped.

Examples include:

- time windows;
- account scope;
- region or availability-zone scope;
- endpoint scope;
- parameter identity;
- provider retention duration.

If the key expires or the operation is retried outside the guarantee's scope, duplicate protection may disappear.

This argues for encoding idempotency guarantees as **policy/data**, not treating "has idempotency key" as a universal Boolean safety property.

---

# 6. Exactly-once analysis

Apache Kafka demonstrates why exactly-once language must be scoped carefully.

Kafka supports idempotent producers and transactional mechanisms that can provide exactly-once semantics within Kafka processing patterns.

SQS FIFO similarly provides deduplication behavior within a defined deduplication window.

But none of this means an arbitrary external side effect initiated by a consumer is exactly once.

Example:

```text
Kafka transaction
    -> consume RefundRequested
    -> external bank API refund
    -> produce RefundCompleted
```

If the external refund succeeds and the process crashes before the Kafka transaction commits, replay may call the bank again.

The Kafka transaction cannot atomically include the external bank unless the bank participates in the same transaction protocol.

Thus:

> Exactly-once processing inside system A does not automatically produce exactly-once real-world effects in system B.

This is one reason operation identity and reconciliation remain necessary at integration boundaries.

---

# 7. Transaction / commit uncertainty

Transaction processing provides some of the strongest conceptual prior art.

Two-phase commit includes a prepared/in-doubt period in which participants may be unable to independently decide the final transaction outcome.

Gray and Lamport's *Consensus on Transaction Commit* formalizes the transaction-commit problem and compares classic two-phase commit with Paxos Commit. Classic 2PC can block when the coordinator fails.

This demonstrates an important principle:

> unresolved transaction outcome is a legitimate state of a protocol, not an exception that can safely be translated into "failed."

Application-level external APIs are typically harder because they do not participate in the caller's distributed transaction at all.

A payment provider, shipping company, cloud provider, email service, or governmental filing system usually cannot join the application's local ACID transaction.

Therefore application-level effect uncertainty is not eliminated by local transactions.

---

# 8. Saga comparison

The original Garcia-Molina and Salem Saga model decomposes long-lived transactions into smaller transactions with compensating transactions.

This is relevant but not identical.

## What Sagas solve

Sagas help structure long-running business processes where one global ACID transaction is impractical.

They provide:

- ordered business transactions;
- compensation;
- recovery logic;
- eventual consistency.

## What they do not automatically solve

A saga step can itself have an ambiguous outcome.

Example:

```text
T3 = issue refund
network timeout
```

Before compensation can proceed safely, the saga may need to determine whether T3 occurred.

Worse:

```text
C3 = compensate T3
network timeout
```

The compensation itself can become uncertain.

Therefore:

> `OutcomeUnknown` is orthogonal to Saga compensation.

Compensation is a new effect; it is not rollback in the ACID sense.

The architecture should therefore model uncertainty for both forward and compensating effects.

---

# 9. Payment-system comparison

Payments are an ideal case because duplicate effects have direct economic consequences.

Stripe's PaymentIntent model persists payment lifecycle state rather than treating payment as a single fire-and-forget HTTP call.

Stripe also recommends idempotency for safely repeating mutation requests.

Modern payment integrations commonly use combinations of:

- persistent payment/refund identifiers;
- idempotency keys;
- status APIs;
- asynchronous lifecycle states;
- webhooks;
- provider records;
- ledger or settlement reconciliation.

This is effectively an acknowledgement that:

```text
HTTP response state
```

and:

```text
financial effect state
```

are different things.

## Example safe model

```text
RefundEffect {
    semanticOperationId
    providerOperationId?
    executionState
    observations[]
}
```

If the initiating HTTP call times out:

```text
executionState = OutcomeUnknown
```

The local payment domain should not jump to:

```text
Payment = Refunded
```

nor:

```text
Refund = Failed
```

until authoritative evidence supports that claim.

---

# 10. Durable-workflow comparison

Temporal and Azure Durable-style systems significantly improve:

- workflow persistence;
- crash recovery;
- replay;
- timers;
- retry orchestration.

But durable orchestration does not make an arbitrary external effect safe.

Temporal explicitly recommends idempotent Activities.

Microsoft documentation similarly notes that durable execution does not automatically make non-idempotent external operations safe to retry.

That is crucial prior art.

A durable workflow may know:

```text
Activity invocation did not complete successfully from workflow perspective
```

without knowing:

```text
external charge did not occur
```

Therefore the proposed semantic effect model complements durable execution rather than replacing it.

---

# 11. Messaging comparison

Messaging systems demonstrate the same pattern from another direction.

Amazon SQS standard queues provide at-least-once delivery and explicitly warn consumers to be idempotent because duplicate delivery can occur.

Kafka supports stronger producer and transactional semantics.

But message delivery is not business-effect execution.

Three different identities may exist:

```text
message identity
semantic operation identity
external provider operation identity
```

These should not be conflated.

A duplicated message can legitimately refer to the same semantic operation.

A second message with a new ID could incorrectly create a duplicate semantic operation.

For agent systems, the semantic-operation identity should be the primary protection at the business boundary.

---

# 12. Reconciliation model

## Definition

A useful precise definition is:

> **Reconciliation is the process of establishing or appropriately dispositioning the authoritative outcome of an external effect after the local system lacks sufficient evidence to classify that effect as succeeded, failed, pending, or otherwise resolved.**

Possible evidence sources:

- provider status endpoint;
- provider object lookup;
- ledger;
- settlement file;
- webhook;
- durable event stream;
- physical observation;
- human verification;
- counterparty confirmation.

## Reconciliation is not merely retry

Retry asks:

```text
can we execute again?
```

Reconciliation asks:

```text
what actually happened?
```

That distinction should be architectural.

---

# 13. Pending vs unknown distinction

This distinction is strongly recommended.

## Pending

The external authority has confirmed:

```text
the operation exists and is not yet terminal
```

Example:

```json
{
  "operationId": "R123",
  "status": "processing"
}
```

This is knowledge.

## OutcomeUnknown

The caller currently lacks an authoritative classification.

Example:

```text
request transmitted
connection timed out
no authoritative status yet
```

Therefore:

```text
Pending != OutcomeUnknown
```

A pending operation may be safe to observe.

An unknown operation may first require locating the authoritative operation record.

---

# 14. Failed vs rejected distinction

This distinction is often useful but integration-specific.

## Rejected

The external system authoritatively declined to accept the operation.

Examples:

- validation failure;
- authorization denial;
- duplicate semantic request with incompatible parameters;
- explicit business-rule rejection.

Often retrying unchanged input is pointless.

## Known execution failure

The operation was accepted or started but the provider authoritatively reports terminal failure.

This may have different compensation or retry semantics.

The key invariant is not the exact naming.

It is:

> only classify failure where authoritative evidence supports a failure claim.

---

# 15. Partial-success model

A strict ternary model fails for composite effects.

Examples:

- 80 of 100 transfers completed;
- four of five cloud resources created;
- two of three shipping labels purchased;
- partial infrastructure rollout;
- batch tax submission partially accepted.

Recommended representation:

```text
PartiallySucceeded(details)
```

or, better, decompose the command into independently meaningful child effects where the domain supports it.

Partial success is especially dangerous if mapped to generic failure, because blind retry can duplicate the successful subset.

---

# 16. Proposed effect-state algebra

A reusable generic model should separate lifecycle and knowledge.

Recommended high-level algebra:

```text
EffectState =
    | NotStarted
    | Requested
    | Accepted
    | Pending
    | Succeeded
    | Rejected
    | KnownFailed
    | PartiallySucceeded
    | OutcomeUnknown
    | ReconciliationConflict
    | AdministrativelyResolved
```

Not every integration needs every state.

A compiler or framework can allow effect profiles to select only relevant states.

A richer structure may be even cleaner:

```text
Effect {
    semanticOperationId
    command
    invocationState
    outcomeKnowledge
    providerOperationId?
    attempts[]
    observations[]
    policyVersion
}
```

Where:

```text
InvocationState =
    NotSent
    Sent
    ResponseReceived
    TransportFailed
```

and:

```text
OutcomeKnowledge =
    Unknown
    Pending
    Succeeded
    Rejected
    Failed
    Partial
    Conflict
    AdministrativelyResolved
```

This avoids treating transport state as domain truth.

---

# 17. Semantic operation identity

This is one of the strongest architectural recommendations.

## Definition

> A semantic operation ID identifies the intended business effect independently of individual transport attempts.

Example:

```text
Refund:
    payment = P123
    amount = 50.00
    initiatingBusinessRequest = R17
```

might produce:

```text
semanticOperationId = refund:P123:R17
```

Transport attempts:

```text
HTTP attempt 1
HTTP attempt 2
SDK retry 3
```

all remain attempts of the **same semantic operation**.

The agent should not create:

```text
refund:P123:R18
```

merely because attempt 1 timed out.

This pattern closely resembles:

- Stripe idempotency keys;
- AWS client tokens;
- message deduplication IDs;
- transaction IDs;
- workflow/activity IDs.

The architectural contribution is to elevate that identity to the semantic domain layer rather than leaving it as incidental HTTP middleware.

---

# 18. Retry-layer analysis

Retries commonly occur at many levels:

1. network library;
2. HTTP stack;
3. SDK;
4. service client;
5. application service;
6. workflow engine;
7. agent.

This creates retry amplification.

An agent may see one timeout and call a tool again, unaware that:

- the SDK already retried;
- the gateway retried;
- the workflow retried;
- the provider completed the first request.

Therefore agent-facing tools should not expose raw retry decisions unless the agent possesses the semantic guarantees necessary to make them.

## Recommended rule

Transport-level retry policy should be encoded centrally.

Agent-visible action should distinguish:

```text
RetrySameSemanticOperation
```

from:

```text
StartNewSemanticOperation
```

These are fundamentally different capabilities.

---

# 19. Capability implications

The state-constrained capability model fits this problem extremely well.

Before effect:

```text
Available:
    StartRefund
```

After authoritative failure where policy permits retry:

```text
Available:
    StartRefund
```

After `OutcomeUnknown`:

```text
Unavailable:
    StartNewRefund

Available:
    QueryRefundStatus
    ReconcileRefund
    EscalateRefund
```

Potentially:

```text
RetrySameRefundOperation
```

but only where:

- same semantic operation ID is retained;
- provider guarantee supports deduplication/idempotency;
- retry policy permits it.

This is stronger than prompting the agent:

```text
Be careful not to retry a refund after certain kinds of timeout.
```

The unsafe action can be structurally absent.

---

# 20. Obligation implications

The natural companion rule is:

```text
EffectOutcome = OutcomeUnknown
    ->
ReconcileEffectOutcome obligation
```

The obligation should contain:

- semantic operation ID;
- effect type;
- subject;
- last known execution state;
- provider operation ID if known;
- authoritative evidence sources;
- reconciliation policy;
- available capabilities;
- deadline;
- escalation path;
- policy version.

Satisfaction should be machine-checkable where possible:

```text
outcome in {
    Succeeded,
    Rejected,
    KnownFailed,
    AdministrativelyResolved
}
```

A timeout should therefore not merely remove one capability.

It should create explicit unresolved work.

---

# 21. Agent tool-interface implications

Raw exceptions are a poor abstraction for consequential agent actions.

Weak interface:

```text
refund(...) -> throws TimeoutError
```

The model must infer:

- whether request was sent;
- whether it was accepted;
- whether it executed;
- whether it is safe to retry.

Better interface:

```text
RefundAttemptResult {
    semanticOperationId
    transportStatus
    effectOutcome
    authoritative
    providerOperationId?
    availableNextActions[]
}
```

Example:

```text
effectOutcome = OutcomeUnknown
authoritative = false

availableNextActions =
    QueryRefundStatus
    ReconcileSettlement
```

The agent receives semantic meaning rather than protocol residue.

This is especially important because language models are trained to interpret "error" and "failure" conversationally, while distributed systems require more precise distinctions.

---

# 22. Context/token implications

This hypothesis is plausible but not yet strongly quantified.

Compare two contexts.

## Conventional

Agent receives:

- timeout stack trace;
- API docs;
- refund history;
- SDK retry policy;
- provider logs;
- payment records;
- prior attempts;
- prompt rules.

It must infer the operational state.

## Semantic

Agent receives:

```text
RefundEffect:
    OutcomeUnknown
    semanticOperationId = X

Obligation:
    EstablishRefundOutcome

Available:
    QueryProvider
    ReconcileSettlement

Forbidden:
    StartNewRefund
```

The second representation is a form of semantic compression.

It removes the need for the model to repeatedly reconstruct the critical fact:

> we do not yet know whether the refund happened.

The expected benefits are:

- fewer context tokens;
- fewer documentation lookups;
- fewer invalid retry attempts;
- fewer reasoning branches.

Direct empirical token-cost evidence for this exact architecture is still weak.

---

# 23. Smaller-model hypothesis

The hypothesis is plausible:

```text
strong semantic environment + smaller model
```

may outperform:

```text
weak environment + larger model
```

for safety-critical recovery tasks.

Why?

The larger model is otherwise required to infer:

- failure semantics;
- retry safety;
- idempotency contract;
- unresolved work;
- correct next action.

If the environment supplies those facts deterministically, the remaining problem becomes narrower.

However, this remains a **research hypothesis**, not an established result.

The 2026 verification-aware tool-call study supports the general direction: reliability improved through stronger tool semantics without changing the underlying model.

A controlled cross-model experiment remains necessary.

---

# 24. Security implications

Explicit effect identity and uncertainty handling improve security in several ways.

## Duplicate-effect abuse

An attacker may intentionally create ambiguous client conditions and request repeat operations.

Examples:

- repeat refund;
- repeat payout;
- repeat coupon issuance;
- repeat provisioning;
- duplicate entitlement.

Stable semantic operation identity can prevent a new consequential effect from being created while an earlier one remains unresolved.

## Tool manipulation

An agent receiving adversarial instruction:

```text
keep retrying until it works
```

should still lack the capability to create a new semantic operation while outcome is unknown.

## Reconciliation spoofing

Reconciliation itself becomes a trust boundary.

The system must define which evidence sources are authoritative.

A random webhook payload should not automatically resolve financial truth unless:

- authenticity is verified;
- the provider contract treats it as authoritative;
- ordering/version checks are satisfied.

---

# 25. Economic analysis

The explicit model adds cost:

- state modeling;
- semantic operation IDs;
- status persistence;
- reconciliation logic;
- queue/obligation infrastructure;
- provider-specific policies;
- observability.

The savings come from:

- avoided duplicate payments/refunds;
- avoided duplicate infrastructure;
- lower incident cost;
- fewer manual reconciliations;
- fewer support cases;
- fewer agent retries;
- reduced supervision;
- less context reconstruction.

## Economic formula

A useful comparison is:

```text
Expected Conventional Cost =
    NormalExecutionCost
  + P(Ambiguity) * (
        DuplicateEffectCost
      + IncidentCost
      + HumanReconciliationCost
      + CustomerImpact
      + AgentRecoveryCost
    )
```

versus:

```text
Expected Explicit-Uncertainty Cost =
    NormalExecutionCost
  + ModelingAmortization
  + P(Ambiguity) * (
        ReconciliationCost
      + AddedLatencyCost
      + HumanEscalationCost
    )
```

The model is especially attractive where:

```text
P(Ambiguity) * Consequence
```

is materially larger than reconciliation overhead.

For a $100,000 payout, even rare ambiguity matters.

For a disposable analytics event, it probably does not.

---

# 26. Counterarguments

## 1. "Idempotency already solves this."

Partially false.

Idempotency can make retry of the same semantic operation safe.

It does not necessarily tell the caller the current outcome.

It also has scope, retention, and provider-contract limits.

**Conclusion:** idempotency reduces the need to block retries but does not eliminate outcome uncertainty.

## 2. "Durable workflow engines solve this."

False as a general claim.

Temporal and Azure documentation explicitly require external activities to be idempotent because durable replay/retry does not make external non-idempotent effects safe.

**Conclusion:** durable execution solves local workflow continuity, not arbitrary external outcome ambiguity.

## 3. "OutcomeUnknown creates too much state."

Potentially true.

The answer is not to force every operation into an elaborate model.

Use risk-based effect classification and reusable primitives.

## 4. "Most APIs document retry behavior."

Even well-documented providers use idempotency because retry behavior is not trivial.

Documentation must also be correctly interpreted at every retry layer.

Encoding the contract once in an effect policy is more robust than asking every agent to reread it.

## 5. "Agents can follow prompt rules."

Possible, but structurally weaker.

A prompt is advisory.

A capability restriction is enforceable.

Recent 2026 empirical work on non-atomic tool failures provides direct evidence that naive agent retry behavior can duplicate actions.

## 6. "Reconciliation is too slow."

Sometimes.

Strong idempotency can allow immediate retry of the **same semantic operation**, avoiding a full reconciliation delay.

The architecture should not equate `OutcomeUnknown` with "never retry."

## 7. "Unknown state hurts user experience."

It can.

But falsely reporting failure or success can be worse.

Interfaces should communicate:

```text
We're confirming the transaction outcome.
Do not submit again.
```

## 8. "Some systems cannot be reconciled."

True.

Those require terminal administrative dispositions such as:

```text
PermanentlyIndeterminate
WrittenOff
AdministrativelyResolved
```

with authority and provenance.

## 9. "The generic model will become integration-specific."

Partly true.

The generic invariant can be shared:

```text
unknown != failure
```

while effect profiles define provider-specific states and evidence sources.

## 10. "Unknown is rare."

Frequency alone is insufficient.

Expected consequence matters.

Rare duplicate monetary or physical-world effects can dominate cost.

---

# 27. Proposed experiments

## Experiment A — refund response loss

Provider executes refund, response is dropped.

Compare:

A. generic exception handling  
B. explicit OutcomeUnknown + restricted capabilities

Measure:

- duplicate refund rate;
- retry count;
- tokens;
- tool calls;
- resolution time;
- correctness.

## Experiment B — authoritative rejection

Provider rejects refund before effect.

Expected:

```text
Rejected / KnownFailed
```

not `OutcomeUnknown`.

Measure false-unknown rate and unnecessary reconciliation.

## Experiment C — strong idempotent retry

Provider supports durable dedupe.

After timeout, expose only:

```text
RetrySameSemanticOperation
```

Measure:

- latency;
- duplicate rate;
- reconciliation avoidance.

## Experiment D — no idempotency

Timeout with non-idempotent API.

Architecture should remove new-operation capability.

## Experiment E — delayed webhook

Timeout:

```text
OutcomeUnknown
```

Later trusted webhook:

```text
Succeeded
```

Verify no duplicate action occurred.

## Experiment F — conflicting evidence

Webhook says succeeded; provider status says failed.

Expected:

```text
ReconciliationConflict
```

not arbitrary selection.

## Experiment G — adversarial agent

Prompt:

```text
Keep retrying until it succeeds.
```

Measure whether the architecture prevents duplicate semantic effects.

## Experiment H — restart

Crash agent after timeout.

New agent receives either:

A. logs/history  
B. explicit effect + reconciliation obligation

Measure:

- context tokens;
- duplicate attempts;
- completion correctness.

## Experiment I — smaller models

Run the same tasks with multiple model classes.

Compare:

```text
raw errors + broad tools
```

with:

```text
semantic effect results + constrained capabilities
```

Measure cost per correctly resolved effect.

---

# 28. Metrics

Primary metrics:

### Duplicate Effect Rate

```text
duplicated consequential effects
---------------------------------
semantic effect requests
```

### Unsafe Retry Rate

```text
unsafe retry attempts
---------------------
uncertain outcomes
```

### Outcome Misclassification Rate

Track separately:

- unknown -> failed;
- unknown -> succeeded;
- failure -> unknown;
- pending -> unknown;
- partial -> failure.

### Reconciliation Success Rate

```text
authoritatively resolved unknown outcomes
-----------------------------------------
unknown outcomes requiring reconciliation
```

### Mean Time to Known Outcome

Time from initial ambiguity to authoritative resolution.

### Tool Calls per Reconciled Effect

### Tokens per Reconciled Effect

### Human Interventions per Unknown Effect

### Stuck OutcomeUnknown Rate

### Cost per Correctly Resolved Effect

The most important economic metric is not cheapest first attempt.

It is:

```text
total execution + remediation cost
----------------------------------
correctly resolved consequential effects
```

---

# 29. Static-analysis / compiler opportunities

The proposed architecture is unusually suitable for static diagnostics.

Recommended diagnostics:

```text
SC-EFFECT-001
Consequential external effect has no OutcomeUnknown branch.
```

```text
SC-EFFECT-002
OutcomeUnknown has no reconciliation or authorized terminal path.
```

```text
SC-EFFECT-003
New semantic operation is legal while an equivalent prior operation remains OutcomeUnknown.
```

```text
SC-EFFECT-004
Effect marked automatically retryable without declared idempotency/deduplication guarantee.
```

```text
SC-EFFECT-005
Succeeded state can be reached without authoritative evidence.
```

```text
SC-EFFECT-006
KnownFailed can be reached from a transport timeout without authoritative failure evidence.
```

```text
SC-EFFECT-007
Retry creates a new semanticOperationId.
```

```text
SC-EFFECT-008
Consequential effect lacks stable operation identity.
```

```text
SC-EFFECT-009
Reconciliation evidence source has no declared authority/freshness policy.
```

```text
SC-EFFECT-010
Compensating effect lacks uncertainty handling.
```

These checks could catch dangerous integration semantics before an AI agent is involved.

---

# 30. Formal verification opportunities

TLA+ and Alloy are both plausible tools.

## TLA+

Particularly suitable for:

- transition systems;
- retries;
- concurrent observations;
- distributed protocol behavior;
- liveness;
- safety invariants.

Example safety property:

```text
NoDuplicateSemanticEffect ==
    for every semanticOperationId,
    consequential business effect count <= 1
```

Possible invariant:

```text
OutcomeUnknown(op)
    =>
not CanStartEquivalentNewOperation(op.subject)
```

Possible liveness property:

```text
OutcomeUnknown(op)
    ~>
Resolved(op) \/ Escalated(op)
```

assuming reconciliation mechanisms eventually respond.

Gray and Lamport's use of TLA+ for transaction commit provides particularly relevant precedent.

## Alloy

Useful for:

- state-space relationships;
- reachability;
- missing legal paths;
- contradictory capability policies;
- bounded counterexamples.

A compiler could model-check:

- every unknown state has a legal resolution path;
- success requires authoritative evidence;
- duplicate semantic operations cannot coexist under defined uniqueness rules.

---

# 31. When OutcomeUnknown is required

Explicit unknown outcome handling should normally be required when all or most of these apply:

1. External write crosses a failure boundary.
2. Effect is consequential.
3. Duplicate execution matters.
4. Caller cannot atomically commit with provider.
5. Provider response can be lost after effect execution.
6. Retry is not inherently harmless.
7. Effect may be asynchronous.
8. External truth can differ from local invocation result.

Strong examples:

- charge;
- refund;
- payout;
- transfer;
- shipment;
- tax filing;
- medical order transmission;
- access/credential change;
- account closure;
- cloud provisioning;
- production deployment;
- destructive infrastructure operation.

---

# 32. When explicit OutcomeUnknown is unnecessary

A full semantic effect record is probably unnecessary when:

- operation is a pure read;
- repeated execution has no meaningful consequence;
- provider offers a truly authoritative synchronous transaction within the same trust/transaction domain;
- lost acknowledgement cannot cause harmful duplicate effects;
- the effect is intentionally best-effort;
- the cost of tracking uncertainty exceeds its consequence.

Examples may include:

- disposable telemetry;
- cache warming;
- some analytics events;
- low-value non-critical notifications;
- stateless read requests.

Even here, ordinary transient-error handling may remain useful.

The architecture should therefore classify **effects by consequence**, not universally impose heavyweight reconciliation.

---

# 33. Architecture changes recommended

## 1. Introduce semantic operation identity

Every consequential external write should have stable semantic identity.

## 2. Separate invocation state from effect outcome

Do not allow:

```text
TimeoutError -> Failed
```

as a default domain translation.

## 3. Make `OutcomeUnknown` first-class

It should be representable in:

- domain integration model;
- tool result;
- persistence;
- UI;
- policy;
- audit history.

## 4. Add `Pending` separately

Confirmed pending is knowledge, not uncertainty.

## 5. Add partial/conflict representations where required

Do not distort rich external outcomes into ternary states.

## 6. Generate reconciliation obligations

```text
OutcomeUnknown
    ->
ReconcileEffectOutcome
```

## 7. Constrain capabilities

While unknown, default to:

- observe;
- reconcile;
- escalate.

Hide:

- create new equivalent semantic effect.

## 8. Allow explicit same-operation retry

Only when provider policy guarantees safe deduplication/idempotency.

## 9. Encode provider guarantees as policy

Example:

```text
EffectPolicy {
    provider
    idempotencyScope
    idempotencyRetention
    sameOperationRetryAllowed
    authoritativeStatusSource
    webhookAuthority
    reconciliationStrategy
    uncertaintyDeadline
}
```

## 10. Treat compensation as another effect

Compensation can itself become unknown.

## 11. Generate agent tools from state

Expose only legal tools for the current effect state.

## 12. Preserve observations

Store:

- what was attempted;
- when;
- operation identity;
- transport result;
- provider response;
- reconciliation observations;
- source authority;
- timestamps/version.

## 13. Add compiler diagnostics

Especially:

- missing unknown branch;
- missing reconciliation path;
- retry without idempotency;
- new operation allowed while unknown.

## 14. Separate discovery from execution semantics

Raw logs may help discovery, but authoritative effect state should control consequential action.

---

# 34. Final verdict

## Is OutcomeUnknown a real and distinct distributed-systems condition?

**Strongly established**

The condition appears across RPC semantics, transaction processing, database error taxonomies, distributed commit, payment integration, messaging, and cloud API design.

## Should consequential external effects model it explicitly?

**Yes**

For consequential effects crossing unreliable external boundaries, the distinction should be explicit somewhere in the authoritative execution model.

## Does explicit modeling reduce unsafe retries?

**Strong evidence**

Distributed-system practice strongly supports the mechanism through idempotency, deduplication, retry contracts, and transaction identity. Recent agent-specific empirical work directly reports duplicate-action reductions from verification-aware retry behavior.

## Does it improve AI-agent safety specifically?

**Moderate evidence**

There is now direct experimental evidence on non-atomic tool failures and duplicate actions, but the research base is still small and does not yet validate this complete architecture across real production environments.

## Does it reduce agent reasoning/context cost?

**Weak-to-moderate evidence**

The mechanism is credible: semantic state eliminates repeated reconstruction of timeout/retry meaning. But direct quantitative evidence for token reduction from an `OutcomeUnknown` control surface remains limited.

## Is a three-state model sufficient?

**Sometimes**

Three states are enough to establish the critical principle, but not enough as a universal external-effect model.

## Closest established concept

**In-doubt / uncertain transaction outcome combined with idempotent operation identity and reconciliation**

## Best terminology

**OutcomeUnknown** for general developer/agent architecture.

Use **InDoubt** for transaction-specific contexts where that language is already established.

## Strongest prior art

A combination of:

- transaction-resolution-unknown / in-doubt transaction semantics;
- classic RPC execution semantics;
- Gray & Lamport transaction commit work;
- idempotency tokens in AWS and Stripe;
- durable workflow requirements for idempotent external Activities;
- messaging deduplication semantics;
- recent verification-aware LLM tool-call research.

## Most important implementation rule

> **A transport failure must never by itself authorize a new consequential semantic operation.**

Determine whether the same operation can be safely retried or whether its outcome must first be reconciled.

## Biggest complexity risk

Over-modeling every integration and producing a state explosion of provider-specific execution states.

The solution is a reusable generic effect primitive plus risk-based effect profiles.

## Most important missing experiment

A controlled benchmark comparing:

```text
raw exception + broad retry tools
```

against:

```text
typed effect outcome + semantic operation identity + dynamically constrained capabilities + reconciliation obligation
```

across:

- refund;
- cloud provisioning;
- message delivery;
- deployment;

with multiple LLM sizes.

Primary outcomes:

- duplicate effect rate;
- unsafe retry rate;
- correctness;
- tokens;
- tool calls;
- recovery latency;
- total cost per correct outcome.

## Recommended generic effect model

```text
Effect<TCommand, TResult, TFailure> {
    semanticOperationId
    command
    policyVersion
    executionState
    providerOperationId?
    attempts
    observations
    reconciliationState
}
```

with an outcome family approximately:

```text
NotStarted
Requested
Accepted
Pending
Succeeded
Rejected
KnownFailed
PartiallySucceeded
OutcomeUnknown
ReconciliationConflict
AdministrativelyResolved
```

The exact states should be selected by effect profile rather than imposed universally.

---

# Evidence classification

## Strongly established

- Timeouts do not prove remote non-execution.
- Distributed calls can have ambiguous/unknown outcomes.
- Transaction systems explicitly represent unresolved/in-doubt conditions.
- Idempotency/deduplication is necessary for many safe retry scenarios.
- Durable workflows do not automatically make arbitrary external effects safe to retry.
- Message systems can redeliver and therefore require idempotent processing.
- Compensation is a new semantic action rather than literal rollback.
- Operation identity is a standard mechanism across major production systems.

## Supported architectural inference

- `OutcomeUnknown` should become a reusable semantic state in agent-oriented architectures.
- Capability restriction after unknown outcome is stronger than prompt-only guidance.
- An explicit reconciliation obligation is a natural durable representation of unresolved effect truth.
- Agent tools should expose semantic effect results rather than raw transport exceptions.
- Static analyzers can detect missing uncertainty/reconciliation paths.

## Emerging empirical support

- Verification-before-retry and idempotency-aware tool handling can reduce duplicate actions by LLM agents under non-atomic failures.

## Still speculative

- Exact token savings.
- Exact cost reduction.
- Smaller-model substitution.
- Optimal generic effect-state algebra.
- The degree to which one compiler-generated abstraction can cover diverse providers without excessive complexity.

---

# Research synthesis

The most important conceptual change produced by this research is that the architecture should **not** model external execution primarily as an error-handling problem.

It is an epistemic-state problem.

After a timeout, the key question is not:

```text
Did the call fail?
```

It is:

```text
What do we currently know about the external effect?
```

That suggests a more general principle for agent-safe software:

> **Authoritative state should represent not only what the system believes happened, but the strength and source of the evidence supporting that belief.**

`OutcomeUnknown` is therefore not merely an extra error enum.

It is the external-effect counterpart of epistemic state.

And once that is explicit, the rest of the architecture follows naturally:

```text
uncertain outcome
    ->
restricted capabilities
    ->
reconciliation obligation
    ->
authoritative observation
    ->
resolved semantic state
```

This is substantially more defensible than allowing either ordinary software or an AI agent to infer:

```text
timeout = failure = retry
```

That inference is exactly where duplicate consequential effects are born.

---

# Key sources

## Foundational distributed systems / transactions

1. Andrew D. Birrell and Bruce Jay Nelson, **Implementing Remote Procedure Calls**.  
   Cornell course copy:  
   https://www.cs.cornell.edu/courses/cs614/2006fa/Slides/Implementing%20Remote%20Procedure%20Calls.pdf

2. Jim Gray and Leslie Lamport, **Consensus on Transaction Commit**.  
   Microsoft Research:  
   https://www.microsoft.com/en-us/research/publication/consensus-on-transaction-commit/  
   arXiv:  
   https://arxiv.org/abs/cs/0408036

3. Hector Garcia-Molina and Kenneth Salem, **Sagas**. ACM SIGMOD 1987.  
   https://dl.acm.org/doi/10.1145/38713.38742

## Database / transaction terminology

4. PostgreSQL error codes — includes **08007 TRANSACTION RESOLUTION UNKNOWN**.  
   https://www.postgresql.org/docs/8.0/errcodes-appendix.html

## Payments / idempotency

5. Stripe, **Designing robust and predictable APIs with idempotency**.  
   https://stripe.com/blog/idempotency

6. Stripe, **Payment Intents API**.  
   https://docs.stripe.com/payments/payment-intents

7. Stripe, **Error handling**.  
   https://docs.stripe.com/error-handling

## Cloud APIs / operation identity

8. AWS EC2, **Ensuring idempotency in Amazon EC2 API requests**.  
   https://docs.aws.amazon.com/ec2/latest/devguide/ec2-api-idempotency.html

9. AWS EC2, **RunInstances API**.  
   https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_RunInstances.html

## Messaging / exactly-once scope

10. Apache Kafka documentation.  
    https://kafka.apache.org/documentation/

11. Apache Kafka producer configuration — idempotence.  
    https://kafka.apache.org/41/configuration/producer-configs/

12. Amazon SQS, **At-least-once delivery**.  
    https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/standard-queues-at-least-once-delivery.html

13. Amazon SQS, **Exactly-once processing in FIFO queues**.  
    https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/FIFO-queues-exactly-once-processing.html

## Durable workflows / retry

14. Temporal, **Activity Definition — Idempotency**.  
    https://docs.temporal.io/activity-definition

15. Microsoft Azure Architecture Center, **Retry pattern**.  
    https://learn.microsoft.com/en-us/azure/architecture/patterns/retry

16. Microsoft Azure Architecture Center, **Compensating Transaction pattern**.  
    https://learn.microsoft.com/en-us/azure/architecture/patterns/compensating-transaction

17. Microsoft Azure Architecture Center, **Saga pattern**.  
    https://learn.microsoft.com/en-us/azure/architecture/patterns/saga

## Agent-specific empirical evidence

18. Isham Kalappurackal Mansoor, Abhishek Phadke, Pratip Rana,  
    **Verified Tool Calls Improve LLM Agent Reliability Under Non-Atomic Failures**, 2026.  
    https://arxiv.org/abs/2608.02645

    Important limitation: this is recent empirical research and should be treated as emerging evidence rather than a mature literature base.

19. Abel Yagubyan,  
    **How Consistent Are LLM Agents? Measuring Behavioral Reproducibility in Multi-Step Tool-Calling Pipelines**, 2026.  
    https://arxiv.org/abs/2605.28840

---

# Final research judgment

The research mission's central hypothesis survives skeptical review.

The weakest claim would be:

> Add an `OutcomeUnknown` enum case.

The stronger and better-supported architectural conclusion is:

> **Consequential external operations need explicit semantic representation of what is known about their effects, stable operation identity across retries, and deterministic restrictions on what actions are legal while the outcome remains unresolved.**

That model is well aligned with decades of distributed-systems practice and increasingly aligned with the specific failure modes of autonomous AI agents.

The remaining research question is no longer mainly:

```text
Is OutcomeUnknown real?
```

It is.

The important unresolved question is:

```text
How much correctness, token, latency, supervision, and economic benefit
does a first-class effect-uncertainty control surface provide to AI agents
compared with conventional idempotency + retry implementations?
```

That is experimentally testable.
