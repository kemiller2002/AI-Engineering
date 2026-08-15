# AI Research Mission 05 — Epistemic State, Evidence, and Agent Truth Control

## Central question

**Can explicit claims, evidence, provenance, and epistemic authority prevent AI agents from turning uncertain assumptions into durable system truth—without creating a knowledge-representation system so complex that it costs more than it saves?**

---

# 1. Executive verdict

The central concern is well founded:

> An AI-generated, imported, reported, or inferred proposition should not acquire greater epistemic authority merely because it has been stored, repeated, copied, summarized, or reused by later agents.

Existing work in truth-maintenance systems, belief revision, provenance, paraconsistent logic, clinical information modeling, uncertainty research, and argumentation strongly supports separating:

- the proposition,
- its sources,
- its derivations,
- its support and opposition,
- its provenance,
- its verification procedure,
- freshness,
- confidence,
- and the authority required to act on it.

However, the proposed eight-state model:

`Unknown`
`Reported`
`Assumed`
`Inferred`
`Supported`
`Verified`
`Contradicted`
`Invalidated`

is **not a good single authoritative state machine**.

The categories mix several different dimensions.

For example:

- `Reported` describes **origin**.
- `Assumed` describes **reasoning posture/context**.
- `Inferred` describes **derivation method**.
- `Supported` describes **evidential relation**.
- `Verified` describes **successful satisfaction of a procedure/policy**.
- `Contradicted` describes **presence of opposing evidence**.
- `Invalidated` may describe **evidence status**, not claim status.
- `Unknown` describes **absence or insufficiency of information**.

These are not mutually exclusive.

A claim can simultaneously be:

- reported by a hotel,
- probabilistically inferred by a model,
- supported by a photograph,
- contradicted by a traveler report,
- and previously verified under an obsolete policy.

Trying to collapse those facts into one enum creates information loss and ambiguous transitions.

The strongest architecture emerging from prior art is therefore:

> **Claims and evidence are authoritative records. Epistemic summaries are derived views. Verification is a policy-relative record, not a declaration of metaphysical truth.**

A minimal architecture should distinguish at least:

1. **Claim identity**
2. **Evidence**
3. **Provenance**
4. **Support/opposition**
5. **Derivation/origin**
6. **Verification record**
7. **Freshness/effective scope**
8. **Derived usability for a particular action**

The architecture should generally avoid storing `Verified` as a freely mutable field.

Instead:

`Evidence + Provenance + VerificationPolicy + Authority + Time`
→
`VerificationRecord`
→
`Derived epistemic view`
→
`Capabilities / Obligations`

The strongest AI-specific benefit is not philosophical truth representation.

It is **preventing assumption laundering**.

An agent should not be able to turn:

`model guessed X`

into:

`database contains X`

into:

`later agent assumes X was verified`

into:

`consequential action relies on X`.

That failure mode is structurally plausible and the proposed architecture provides a direct mechanism for stopping it.

The evidence for **correctness, traceability, retraction, contradiction preservation, and auditability** is strong.

The evidence that this will **reduce LLM token cost or enable smaller models** is plausible but still indirect. That requires dedicated experiments.

---

# 2. Formal definition of a Claim

A useful working definition is:

> **A Claim is an addressable proposition about a specific subject and scope whose acceptance, rejection, or uncertainty may affect reasoning, policy, capabilities, obligations, or consequential decisions.**

A Claim should not itself encode:
- whether it is true,
- whether it is believed,
- who reported it,
- how confident a model is,
- whether it has been verified.

Those belong to associated records.

## 2.1 Minimum fields

```text
Claim {
    claimId
    propositionType
    subjectId
    parameters
    effectiveScope?
    subjectVersion?
}
```

Example:

```text
Claim:
    claimId: C-217-DOOR
    propositionType: BathroomDoorWidthAtLeast
    subjectId: HotelRoom:217
    parameters:
        inches: 32
    subjectVersion: RenovationVersion:2026-04
```

This is superior to a vague claim such as:

`HotelIsAccessible`

because the latter hides many independently relevant propositions.

---

# 3. Formal definition of Evidence

A useful definition is:

> **Evidence is an addressable observation, testimony, record, measurement, credential, artifact, or derived result that may bear on one or more claims.**

Evidence is not synonymous with truth.

Evidence can be:
- incorrect,
- stale,
- forged,
- ambiguous,
- duplicated,
- derived from another source,
- attached to the wrong subject,
- superseded.

## 3.1 Minimum evidence fields

```text
Evidence {
    evidenceId
    evidenceType
    contentRef
    source
    observedAt
    recordedAt
    subjectScope
    provenance
    validity
}
```

Relations should be separate:

```text
EvidenceRelation {
    evidenceId
    claimId
    relation: Supports | Opposes | Relevant
    derivationRule?
}
```

Why separate the relation?

The same evidence may support one proposition while opposing another.

---

# 4. The eight-state model: critique

The proposed state list contains useful concepts but combines incompatible axes.

| Proposed value | What it actually describes |
|---|---|
| Unknown | information sufficiency |
| Reported | origin / testimony |
| Assumed | reasoning context |
| Inferred | derivation |
| Supported | evidential relation |
| Verified | procedural qualification |
| Contradicted | evidence conflict |
| Invalidated | evidence/verification validity |

This means a single enum cannot faithfully represent real cases.

Consider:

> Hotel reports a roll-in shower. A photograph appears consistent. A traveler reports a tub. A third-party inspection six months earlier passed under Policy@7, but Policy@8 now requires current measurements.

What is the single state?

- Reported?
- Supported?
- Contradicted?
- Verified?
- Invalidated?

All describe part of the situation.

The correct answer is not one state.

The correct answer is a **multi-dimensional epistemic record**.

---

# 5. State machine vs lattice analysis

A state machine is appropriate when:
- states are mutually exclusive,
- transitions represent meaningful lifecycle changes,
- one state summarizes the authoritative situation.

Epistemic information often does not have this shape.

## 5.1 Why a linear ordering fails

There is no safe ordering such as:

`Reported < Inferred < Supported < Verified`

because:
- a certified report may be stronger than a weak inference,
- a deterministic inference from verified measurements may be stronger than a human report,
- `Contradicted` does not mean "less than Supported"; both may be present,
- `Assumed` is not naturally above or below anything.

## 5.2 Lattice usefulness

Belnap-style four-valued logic offers a useful submodel for **evidence polarity**:

- neither support nor opposition,
- support for proposition,
- support for negation,
- support for both.

This represents:

- Unknown,
- SupportedTrue,
- SupportedFalse,
- Conflicted.

That is much better than forcing contradictions into binary truth.

But even this is not enough to represent:
- source authority,
- confidence,
- freshness,
- verification procedure,
- origin.

Therefore the best architecture is not "use a lattice for everything."

It is:

> **Use a small lattice where the semantics are genuinely lattice-shaped, embedded inside a multi-dimensional record.**

---

# 6. Recommended epistemic decomposition

A claim should expose several orthogonal dimensions.

## Dimension A — Evidence polarity

```text
NoEvidence
SupportOnly
OppositionOnly
Conflicted
```

## Dimension B — Origin / derivation

Potential values:

```text
HumanReported
ExternalSystemReported
SensorObserved
Imported
DeductivelyDerived
ProbabilisticallyInferred
HeuristicallyInferred
ModelGenerated
```

Multiple origins may exist.

## Dimension C — Verification

Do not model this as truth.

Model verification records:

```text
VerificationRecord {
    claimId
    policyVersion
    verifier
    method
    evidenceSet
    grantedAt
    validUntil?
    subjectVersion
    status
}
```

## Dimension D — Confidence / probability

Optional and method-specific.

Do not use a universal confidence score unless the producing method gives it a defensible interpretation.

## Dimension E — Freshness

Freshness should be evaluated relative to the consuming policy.

Evidence does not necessarily become false merely because it becomes too old for a transaction.

## Dimension F — Availability for action

Derived from the requirements of the particular action.

Example:

```text
CanShip =
    current verification record satisfies ShippingPolicy
    AND no disqualifying contradiction
    AND evidence freshness acceptable
    AND subject version matches
```

This is more useful than asking whether the claim is simply "Verified."

---

# 7. Status vs confidence

The prompt correctly treats this as a critical distinction.

`95% confidence`

does not imply:

`Verified`.

And:

`VerifiedUnderPolicy`

does not imply:

`95% probability objectively true`.

These answer different questions.

## Confidence asks

> How uncertain is an estimator about this proposition?

## Verification asks

> Has a declared procedure been satisfied?

## Evidence strength asks

> What support exists and how good is it?

## Source authority asks

> What authority or reliability does the source have under this domain's policy?

## Freshness asks

> Is the evidence sufficiently current for this use?

These should not be collapsed.

LLM calibration research reinforces this separation. Modern models can be systematically overconfident, and verbalized confidence may not reliably track correctness. Model confidence therefore should never be treated as evidence authority.

---

# 8. Unknown is not false

This is one of the strongest principles in the specification.

The distinction is formal and widely recognized.

In open-world reasoning:

> failure to establish P does not establish ¬P.

Example:

No measurement exists for room 217 bathroom door.

Correct representation:

`DoorWidthAtLeast32: unknown`

Incorrect representation:

`DoorWidthAtLeast32: false`

Why it matters:

A false negative may trigger:
- rejection of an accessible room,
- incorrect medical inference,
- denied transaction,
- false compliance failure.

Likewise treating unknown as true can produce unsafe action.

## 8.1 Recommended rule

Closed-world behavior should be explicit and policy-scoped.

Example:

```text
For Capability CanShip:
    absence of FraudClear verification => capability unavailable
```

That does **not** mean:

`FraudClear = false`.

It means:

`required evidence condition not satisfied`.

This is a critical architectural distinction.

---

# 9. Reported vs verified

A report is evidence about a claim.

It should not normally be an epistemic state of the claim.

Example:

```text
Evidence E17:
    type: HumanOrOrganizationReport
    source: Hotel
    proposition: RoomHasRollInShower
```

A verification process may decide that hotel testimony is enough under one policy.

Another policy may require:
- independent measurement,
- photograph,
- inspector certification.

Therefore:

> **"Reported" belongs primarily to evidence provenance. "Verified" belongs to verification procedure.**

The claim itself should not need to "transition from Reported to Verified."

Instead:

1. report evidence added,
2. verification policy evaluated,
3. verification record created if requirements satisfied.

This eliminates an artificial lifecycle.

---

# 10. Assumption modeling

Assumptions are especially dangerous because they are useful.

Agents must be able to reason hypothetically.

But assumptions should not become authoritative evidence.

Truth-maintenance research, especially assumption-based TMS work, provides a close conceptual match.

An assumption should belong to a **reasoning context**.

Example:

```text
Scenario S42:
    assume PolicyResponseIsCurrent
```

Claims derived in S42 should retain dependency on that assumption.

They should not automatically enter authoritative claim state.

## Recommended rule

**Assumptions belong in planning/simulation contexts unless explicitly promoted through a separate authorized evidence process.**

This permits:
- counterfactual reasoning,
- planning,
- what-if analysis,

without laundering assumptions into persistent truth.

---

# 11. Inference modeling

`Inferred` is too broad.

At minimum distinguish:

## Deductive derivation

Example:

```text
MeasuredWidth = 36
Requirement = width >= 32
therefore
DoorWidthMeetsRequirement
```

Given correct premises and rule, the derivation is deterministic.

## Probabilistic inference

Example:

```text
symptoms + labs -> 0.78 probability of condition
```

## Heuristic inference

Example:

Rule-of-thumb reasoning.

## Model-generated inference

An LLM produces a proposition based on unstructured evidence.

These have different reliability and verification implications.

Recommended derivation record:

```text
Derivation {
    claimId
    method
    ruleOrModel
    inputs
    producedAt
    modelVersion?
    confidence?
}
```

Again: derivation method should not be the claim's singular state.

---

# 12. Supported

`Supported` is useful as a derived summary, but dangerous as an authoritative mutable status.

A claim is supported when current admissible evidence provides support under some evidence interpretation.

But this can coexist with opposition.

Therefore use:

```text
supportPresent: true
oppositionPresent: true
```

which may derive:

`ConflictState = Contested`

rather than overwriting "Supported" with "Contradicted."

The derived view can still expose user-friendly labels:
- Unsupported
- Supported
- Opposed
- Contested

but the evidence graph remains authoritative.

---

# 13. Verified

The term `Verified` creates semantic risk because people naturally read it as "true."

The architecture can only guarantee:

> A verification procedure accepted a claim under a particular policy, using a particular evidence set, at a particular time.

Therefore the more precise internal concept is:

`VerificationSatisfied`

or:

`VerifiedUnderPolicy`.

Recommended record:

```text
VerificationRecord {
    claim
    policy: AccessibilityPolicy@8
    evidence: [E17, E21]
    verifier: AccessibilityVerifier@3
    decision: Satisfied
    verifiedAt
    validUntil
    subjectVersion
}
```

User interfaces may still say "Verified" where appropriate, but APIs and internal architecture should preserve policy relativity.

---

# 14. Contradiction modeling

Contradiction should not force immediate binary resolution.

This is a major insight from paraconsistent approaches.

Example:

Hotel:
`RollInShower = yes`

Inspection:
`RollInShower = no`

A conventional system may:
- overwrite one record,
- choose latest,
- choose higher priority,
- accidentally treat inconsistency as corruption.

A better system preserves:

```text
Support: E1
Opposition: E2
Conflict: true
```

Policy can decide:
- block action,
- prefer a particular source,
- require review,
- request fresh evidence.

This separates:

**preserving disagreement**

from:

**resolving disagreement**.

---

# 15. Invalidation modeling

The prompt identifies another crucial correction.

`Invalidated` is usually more naturally a status of:

- evidence,
- derivation,
- verification record,

than a primitive status of the claim.

Example:

A sensor is discovered to have been miscalibrated.

What becomes invalid?

The measurement evidence.

Then:

1. evidence validity changes,
2. dependent derivations recalculate,
3. verification records depending on it may become unsatisfied/revoked,
4. capabilities may disappear,
5. obligations may arise.

The claim may remain true in the world.

We simply no longer have sufficient justification for using it.

This distinction is essential.

---

# 16. Truth-maintenance systems comparison

Truth Maintenance Systems are among the closest intellectual ancestors of the proposed design.

Doyle's classic TMS work focuses on recording justifications for beliefs and maintaining their status as justifications change.

Assumption-Based Truth Maintenance Systems extend this by tracking sets of assumptions under which propositions hold and supporting reasoning across inconsistent or alternative contexts.

Key architectural lessons:

## A. Store justifications

Do not store only the current conclusion.

## B. Track dependencies

If justification J disappears, dependent conclusions must be reconsidered.

## C. Retraction is first-class

Changing evidence should propagate.

## D. Assumptions remain explicit

They should not be indistinguishable from established premises.

## E. Multiple contexts can coexist

This maps directly to:
- agent planning,
- simulation,
- counterfactual reasoning.

The proposed epistemic architecture can be seen as a modern, application-focused TMS combined with provenance and runtime capability enforcement.

---

# 17. Belief-revision comparison

AGM belief revision formalizes operations such as:

- expansion,
- contraction,
- revision.

It asks how a rational belief set should change when new information arrives.

This is valuable conceptually but does not directly solve the application architecture.

Why?

The proposed system is less concerned with:

> What should an ideal rational agent believe?

and more concerned with:

> What propositions may an operational system treat as sufficiently justified for a particular consequential action?

Those are different.

AGM contributes principles for:
- revision after contradiction,
- minimal disturbance,
- explicit contraction.

But application-level evidence provenance requires more operational metadata than classical AGM theory supplies.

Recommended use:

**Borrow revision concepts, not the entire belief-set abstraction.**

---

# 18. Epistemic logic comparison

Epistemic logic introduces operators such as:

`K_A(P)` — actor A knows P.

This is useful for distributed/multi-agent reasoning but should not become the default representation.

Operational systems often need more precise statements:

- Agent A observed evidence E.
- System currently accepts VerificationRecord V.
- Agent B's context version predates E.
- Policy P requires V.

This is more concrete than:

`Agent A knows X`.

Recommended principle:

> **Use epistemic logic where actor-specific information state matters; use provenance/evidence records for authoritative operational truth control.**

---

# 19. Multi-agent epistemics

A key AI-agent problem is that an agent's local context is not authoritative epistemic state.

Example:

```text
Authoritative claim version: 19
Agent A context: version 19
Agent B context: version 17
```

Agent B should not be treated as "wrong" merely because it has older information.

It is stale.

This suggests versioned epistemic reads.

A capability issued against claim version 18 should become invalid if evidence changes and the relevant epistemic state becomes version 19.

This connects naturally with version-bound capability design.

---

# 20. Provenance

W3C PROV is highly relevant and should be adopted conceptually rather than reinvented.

W3C PROV distinguishes:
- **Entities**
- **Activities**
- **Agents**

and relations describing:
- generation,
- derivation,
- attribution,
- usage.

For the proposed architecture:

```text
EvidenceEntity
    wasGeneratedBy
ExtractionActivity
    used
SourceDocument
    wasAssociatedWith
OCRSystem
```

This allows the system to reconstruct:

tax return
→ OCR
→ extracted amount
→ normalized income
→ claim
→ verification
→ loan capability.

If the OCR output is invalidated, downstream dependencies can be located.

The key lesson:

> Provenance should be a composable graph, not a human-readable source string.

---

# 21. Data lineage

Lineage is particularly important for derived evidence.

Example:

```text
TaxReturn.pdf
  -> OCR_v3
  -> "annual income = 120000"
  -> currency normalization
  -> income threshold rule
  -> IncomeAboveThreshold
```

If OCR is later corrected to 12,000:

the architecture should not merely update one number.

It should invalidate/recompute downstream claims and decisions.

This is exactly the kind of dependency propagation studied in:
- provenance,
- incremental computation,
- build systems,
- truth maintenance.

---

# 22. AI-generated claims

AI output requires two separate concepts:

## Origin

`GeneratedByModel`

## Epistemic authority

Usually:
- proposed,
- inferred,
- unverified.

These must remain distinct.

A model may produce a deductively correct conclusion from verified evidence.

Conversely, a human may provide an unreliable report.

Therefore origin alone does not define evidence quality.

But model origin is important for:
- audit,
- reproduction,
- model-version tracking,
- policy restrictions,
- calibration.

Recommended metadata:

```text
generation {
    model
    modelVersion
    prompt/context reference
    generatedAt
    toolEvidenceRefs
}
```

An LLM-generated assertion should not become trusted evidence merely because it is persisted.

---

# 23. Model confidence

Current evidence strongly argues against using self-reported LLM confidence as a verification mechanism.

Empirical work continues to find:
- overconfidence,
- miscalibration,
- sensitivity to elicitation method,
- imperfect connection between verbalized confidence and actual correctness.

Therefore:

```text
modelConfidence = 0.97
```

should mean only:

> this confidence estimator produced 0.97 under this calibration method.

It should not mean:
- source authority,
- verified,
- true,
- independently supported.

Model confidence may be useful for:
- routing to review,
- deciding whether to retrieve more evidence,
- abstention,
- prioritizing checks.

It should not grant consequential capabilities by itself unless policy explicitly accepts that model and threshold.

---

# 24. Evidence authority

There is no universal evidence hierarchy.

A calibrated sensor can be authoritative for:
- temperature,

but irrelevant for:
- whether a patient feels pain.

A patient's self-report may be the strongest evidence for subjective symptoms.

A government database may be authoritative for:
- licensing status,

but not necessarily current physical accessibility.

Therefore source authority should be **claim/policy-specific**.

Recommended policy pattern:

```text
AccessibilityPolicy@8:
    RollInShower:
        acceptedEvidence:
            IndependentMeasurement
            CertifiedInspection
        optionalSupportingEvidence:
            HotelReport
            TravelerPhoto
```

Avoid:

`sourceAuthority = 0.86`

as a universal scalar.

---

# 25. Freshness

Freshness is a use requirement, not necessarily truth decay.

Example:

A fraud assessment from 31 minutes ago may still accurately describe the assessment at its observation time.

But if the payment policy requires:

`age <= 30 minutes`

it is no longer sufficient for approval.

Therefore preserve:

```text
observedAt
validFor?
```

and evaluate:

```text
isFreshEnoughFor(policy, now)
```

Do not mutate the claim to `Invalidated` solely because a consuming policy's freshness window expired.

---

# 26. Policy-relative verification

Verification is inherently policy-relative.

Example:

```text
AccessibilityPolicy@7:
    hotel self-report sufficient

AccessibilityPolicy@8:
    independent measurement required
```

A historical verification under @7 should remain historically accurate:

> The claim satisfied Policy@7 at time T.

It does not imply:

> The claim satisfies Policy@8 now.

Therefore the verification record must preserve:

- policy ID,
- policy version,
- evidence set,
- verifier,
- timestamp,
- subject version.

This is essential for auditability.

---

# 27. Claim dependency and cascade model

A useful dependency chain:

```text
Evidence E1
    ->
Claim A support

Claim A + Rule R
    ->
Claim B

Claim B verified under Policy P
    ->
Capability C

Capability C
    ->
Action A17
```

If E1 is invalidated:

```text
E1 invalid
    ->
Claim A support recomputed
    ->
Claim B derivation becomes unsupported
    ->
verification record no longer current
    ->
Capability C removed
    ->
pending plan invalid
    ->
ReverifyClaim obligation created
```

This is one of the architecture's strongest ideas.

It makes epistemic change operational.

---

# 28. Epistemic cascade

Recommended architecture:

```text
EvidenceChanged
    ↓
RecomputeAffectedClaimViews
    ↓
ReevaluateVerificationRecords
    ↓
RecalculateCapabilities
    ↓
InvalidateStalePlans
    ↓
GenerateEpistemicObligations
```

Potential obligations:

- RefreshEvidence
- ReverifyClaim
- ResolveContradiction
- RequestHumanReview
- ReassessDependentDecision

The dependency graph should allow incremental recomputation rather than global re-evaluation.

---

# 29. AI-agent assumption drift

The specific AI risk can be called **assumption laundering** or **assumption inheritance**.

Pattern:

```text
Agent 1:
    "Probably X."

Agent 1 writes:
    X=true

Agent 2 sees:
    X=true

Agent 2 infers:
    "Someone verified X."

Agent 3 builds:
    behavior depending on X
```

The key problem is not merely hallucination.

It is **persistence converting provenance-free inference into apparent authority**.

Traditional hallucination mitigation often operates within one response.

This architecture targets a longer timescale:

> What happens when uncertain model output survives into future agent contexts?

That is a distinct and under-tested risk.

---

# 30. Assumption debt

"Assumption Debt" is a useful operational concept if defined narrowly.

Recommended definition:

> **Assumption Debt is consequential system behavior that depends on propositions whose evidential or verification authority is below the level required by the relevant decision policy.**

Possible metric:

```text
AssumptionDebt =
    count or weighted value of
    consequential dependencies
    on insufficiently justified claims
```

Weight by:
- consequence,
- age,
- fan-out,
- number of downstream capabilities,
- correction cost.

Do not count every unknown fact.

Only count epistemically insufficient dependencies that matter.

---

# 31. Epistemic requirements for capabilities

Do not use:

`atLeast Verified`

unless there is a well-defined order.

Instead specify exact requirements.

Example:

```text
CanApproveLoan requires:
    Identity:
        activeVerification(policy = IdentityPolicy@4)

    Income:
        supportingEvidence(
            type in ApprovedIncomeSources,
            maxAge = 90d)

    FraudRisk:
        assessment(
            model in ApprovedModels,
            maxAge = 30m,
            score < threshold)
```

This avoids pretending all epistemic states form one scale.

---

# 32. Four-valued / paraconsistent model

Belnap's four-valued logic is particularly useful for evidence conflict.

Interpret a proposition using two independent questions:

- Is there support for P?
- Is there support for not-P?

This yields:

| Support P | Support ¬P | State |
|---|---|---|
| No | No | Unknown |
| Yes | No | Supported-P |
| No | Yes | Supported-not-P |
| Yes | Yes | Conflict |

This handles contradictory information without explosion or forced overwrite.

But it should be a **derived evidence polarity**, not the entire epistemic model.

---

# 33. Open-world vs closed-world

The default for consequential claims should generally be:

> absence of evidence is absence of knowledge.

Not:

> absence means false.

But some application domains legitimately use closed-world rules.

Example:

A permission system may say:

> No explicit permission record => permission denied.

That is a policy decision.

It should not be generalized into epistemology.

Recommended design:

```text
Claim layer:
    open-world by default

Policy/capability layer:
    may use explicit closed-world rules
```

This avoids conflating:
- "we do not know X"
with:
- "policy forbids acting unless X is established."

---

# 34. Healthcare case study

Healthcare provides strong evidence that epistemic and clinical status should be separated.

HL7 FHIR explicitly distinguishes a condition's:
- clinical status,
- verification status.

FHIR verification statuses include concepts such as:
- provisional,
- differential,
- confirmed,
- refuted,
- entered-in-error.

This is very close to the problem being studied.

Crucially, a diagnosis can be:
- clinically active,
- but only provisional.

That supports the architectural principle:

> Domain state and epistemic status are different axes.

It also warns against inventing one universal epistemic vocabulary.

Clinical systems already have domain-specific verification concepts.

The general platform should support policy-specific status vocabularies rather than replacing them.

---

# 35. Accessibility case study

Claim:

`Room217HasRollInShower`

Evidence:
- E1 hotel report,
- E2 hotel photograph,
- E3 traveler report,
- E4 independent measurement.

A good record might expose:

```text
Evidence polarity:
    support: E1, E2
    opposition: E3

Conflict:
    true

Verification:
    no current verification under AccessibilityPolicy@8

Required:
    IndependentMeasurement
```

This is far safer than:

`RoomAccessible = true`.

It also demonstrates why claim granularity matters.

"Accessible" is not one physical property.

---

# 36. Finance / fraud case study

Claim:

`TransactionLowRisk`

This may be generated by an ML model.

The system should preserve:

```text
model
modelVersion
score
inputDataVersion
producedAt
calibration
```

The policy might require:

```text
approved model version
score < threshold
assessment age < 30 minutes
identity verification present
```

The risk score is a prediction.

It should not be represented as a verified fact that the transaction is objectively safe.

---

# 37. Software deployment case study

Claim:

`BuildEligibleForDeployment`

Evidence:
- test suite result,
- security scanner,
- review approval,
- artifact hash,
- provenance from build pipeline.

Suppose the security scanner is later found compromised.

The correct behavior is:

1. scanner evidence invalidated,
2. build verification recomputed,
3. future deployment capability removed,
4. prior deployment decisions remain historically recorded,
5. obligation created to reassess affected artifacts.

This illustrates why historical truth and current usability must be distinct.

---

# 38. Research/scientific case study

Scientific claims expose the danger of the word `Verified`.

A hypothesis may be:
- supported by evidence,
- replicated,
- contradicted by other studies,
- uncertain under model assumptions.

Science rarely converts a proposition into permanently verified truth.

This suggests the architecture should reserve strong verification terminology for procedural contexts.

For broader knowledge claims, use:
- support,
- opposition,
- provenance,
- uncertainty.

---

# 39. False verification

The system cannot guarantee objective truth.

If bad evidence satisfies a bad policy:

the claim can become procedurally accepted.

Therefore always preserve:

```text
verificationRecord.policy
verificationRecord.evidence
verificationRecord.verifier
```

The guarantee is:

> verification procedure satisfied.

Not:

> reality is necessarily as represented.

This should be explicit in documentation and user-facing semantics.

---

# 40. Verification authority

Consequential verification should require protected constructors.

An ordinary agent should not be able to create:

```text
Verified<Identity>
```

simply because it decides the evidence looks convincing.

Instead the agent can:

- submit evidence,
- request verification,
- propose a conclusion.

An authorized verification component then evaluates policy.

Possible verification authorities:
- deterministic verifier,
- credential validator,
- approved expert,
- trusted external system,
- composite workflow.

This applies the same capability principle to epistemic authority.

---

# 41. Machine-checkable verification taxonomy

## Type 1 — Deterministic verification

Example:
`36 >= 32`

## Type 2 — Credential verification

Example:
signed certification from approved authority.

## Type 3 — Expert attestation

Example:
clinician diagnosis.

## Type 4 — Probabilistic assessment

Example:
fraud model below threshold.

## Type 5 — Composite verification

Combination of:
- measurements,
- credential,
- human approval,
- model output.

Policies should declare which type they accept.

---

# 42. Evidence quality

Avoid a universal evidence-quality score.

Evidence quality can depend on:

- directness,
- measurement error,
- source competence,
- authority,
- freshness,
- independence,
- reproducibility,
- subject match.

And the relative importance of these varies by domain.

Recommended approach:

> **Policies define admissibility and sufficiency criteria over evidence attributes.**

Do not reduce everything to:

`quality = 0.83`

unless a domain has a validated scoring model.

---

# 43. Independence of evidence

This is a major provenance benefit.

Suppose:

```text
Hotel page S1
    -> Travel site A copies S1
    -> Blog B copies A
    -> Model summary C summarizes B
```

Without lineage:

the system sees four apparent reports.

With provenance:

they form one evidence family derived from S1.

Therefore:

> **Evidence count should never substitute for evidence independence.**

This directly supports the prompt's principle:

**Repetition does not increase epistemic authority automatically.**

---

# 44. Evidence deduplication

A practical mechanism is provenance-root grouping.

For each evidence item, compute or retain:

- originating source,
- derivation chain,
- source content hash where appropriate,
- transformation activities.

Then group evidence sharing a common root.

This need not perfectly solve source dependence.

But it can stop obvious amplification through copying.

---

# 45. Contradiction resolution

The architecture should not require the agent to resolve every conflict.

Permissible outcomes include:

- unresolved conflict,
- requires review,
- insufficient evidence,
- action blocked,
- lower-trust source ignored by policy,
- fresh evidence required.

The key is:

> **Preserving a contradiction is a valid system result.**

Forced certainty is often more dangerous than temporary inability to act.

---

# 46. Argumentation frameworks

Dung-style abstract argumentation models arguments and attack relationships.

Structured argumentation systems extend this toward:
- premises,
- rules,
- defeasible inference,
- support/attack.

These are useful for complex domains where:
- evidence supports competing arguments,
- rules have exceptions,
- conflicts require explicit reasoning.

However, they risk turning a practical architecture into a research platform.

Recommendation:

Do not start with a full argumentation engine.

Introduce support/attack graphs only when:
- policy cannot be expressed cleanly as evidence sufficiency,
- conflict resolution itself must be explained formally.

---

# 47. Dempster-Shafer evidence theory

Dempster-Shafer theory can explicitly represent:
- belief,
- plausibility,
- ignorance,
- combined evidence.

That makes it conceptually attractive.

But its evidence-combination rules introduce complexity, especially with dependent or conflicting evidence.

The architecture does not need Dempster-Shafer merely to preserve:
- unknown,
- conflict,
- evidence provenance.

Recommendation:

**Do not adopt Dempster-Shafer in v0.1.**

Use it only if a target domain has a justified need for evidence fusion.

---

# 48. Bayesian models

Bayesian reasoning is appropriate when:
- probabilities have meaningful interpretation,
- likelihood models exist,
- evidence dependencies are understood.

But:

`posterior probability = 0.96`

does not mean:

`verified`.

A hybrid architecture is more appropriate:

```text
probabilistic assessment
+
provenance
+
policy
+
verification record
```

Example:

```text
FraudRisk = 0.03
model = M17
calibration = C4
age = 8m
```

Policy determines whether that is sufficient for an action.

---

# 49. Epistemic state as context compression

The architecture could materially reduce context.

Instead of giving an agent:

- 5 source documents,
- 3 summaries,
- 2 old reports,
- previous agent reasoning,

give:

```text
Claim: Room217HasRollInShower
Evidence polarity: Conflicted

Supporting:
    E17 HotelReport
    E21 Photo

Opposing:
    E33 TravelerReport

Current verification:
    None under AccessibilityPolicy@8

Missing:
    IndependentMeasurement

Evidence available lazily.
```

This can compress:
- provenance,
- conflict,
- verification,
- required next step.

But compression is safe only if:
- the summary is generated deterministically,
- underlying evidence remains retrievable,
- the agent knows when raw evidence is necessary.

---

# 50. Token-cost hypothesis

Two environments should be compared:

## A. Raw evidence

Agent reconstructs:
- what sources exist,
- which are duplicates,
- what supports/opposes,
- what is current,
- what was previously verified.

## B. Epistemic summary

Agent receives:
- derived status,
- evidence references,
- conflicts,
- verification record,
- missing requirements.

Measure:

- input tokens,
- evidence retrieval calls,
- false certainty,
- decision accuracy,
- omissions.

This claim is plausible but currently under-demonstrated in AI-agent literature.

---

# 51. Lazy evidence retrieval

A strong design is:

## Initial context

```text
claim
current evidence summary
verification status
conflict flag
policy requirements
```

## Tool

```text
getEvidence(claimId)
getEvidence(evidenceId)
getProvenance(evidenceId)
```

This preserves context economy without hiding raw sources.

The model retrieves details only where needed.

This resembles query planning:

do not load the whole epistemic graph into every prompt.

---

# 52. Smaller-model hypothesis

The strongest economic experiment is:

### Environment A

Large model + raw evidence corpus.

### Environment B

Small/medium model + structured epistemic summary + lazy retrieval.

Ask both to make consequential decisions.

Measure:
- correct abstention,
- unsupported certainty,
- correct capability choice,
- tokens,
- tool calls,
- dollar cost.

Why this may work:

The larger model currently spends capability on:
- source comparison,
- provenance reconstruction,
- contradiction detection,
- freshness checking.

A deterministic system can precompute part of that.

But the smaller model must still understand:
- what action is desirable,
- whether semantic policy is appropriate,
- ambiguous evidence.

Therefore smaller-model substitution is **plausible, not established**.

---

# 53. Human review

Structured epistemics can change human review from:

> "Please reread all these documents and tell me why we believe this."

to:

> "Here is the claim, supporting/opposing evidence, provenance, policy, and verification record."

This should reduce reconstruction burden.

Humans still need to review:
- ambiguous evidence,
- expert judgments,
- policy quality,
- conflicts,
- specification errors.

The likely benefit is **review compression**, not elimination.

---

# 54. Auditability

For each consequential action, record epistemic dependencies.

Example:

```text
Decision: ApproveShipment A778

Required claim:
    FraudClear

Verification:
    V103

Policy:
    FraudPolicy@12

Evidence:
    RiskAssessment E99

Claim version:
    18
```

Historical audit can then answer:

- what the system accepted,
- why,
- under which policy,
- using which evidence,
- at what time.

This is much stronger than recording only the final action.

---

# 55. Historical truth

Two propositions must be separated:

A.

> At 10:15, the system had sufficient evidence under Policy@7 to accept C.

B.

> C is objectively true now.

Historical audit requires A even if B later becomes false or unknown.

This suggests bitemporal thinking:

- when was the underlying observation valid?
- when did the system know/record it?

At minimum store:
- observed/effective time,
- recorded time.

---

# 56. Policy evolution

When Policy@8 replaces Policy@7, choose an explicit migration posture.

## Prospective

Only future verifications use @8.

## Reassessment-triggering

Existing relevant claims become obligations for re-verification.

## Retroactive invalidation

Historical decisions are treated as invalid under the new policy.

These have radically different semantics.

Do not let policy deployment implicitly choose one.

---

# 57. Epistemic obligations

Evidence changes naturally create work.

Examples:

```text
O-71 ReverifyIdentity
O-72 ResolveEvidenceConflict
O-73 RefreshFraudAssessment
O-74 RequestIndependentMeasurement
```

This is a strong connection between epistemic architecture and obligation-driven agents.

The agent no longer needs to discover every downstream problem by open-ended exploration.

The system exposes unresolved epistemic work.

---

# 58. Epistemic capabilities

Capabilities should depend on **requirements**, not vague claim labels.

Example:

```text
CanApproveLoan
requires:
    Identity verification current under Policy@5
    Income evidence sufficient under Policy@3
    Fraud assessment fresh under Policy@11
```

If evidence changes:

the capability disappears automatically.

This makes uncertain knowledge operationally safe.

---

# 59. Prompt rule vs runtime enforcement

Compare:

### Prompt

"Make sure identity is verified."

The model must:
- remember rule,
- reconstruct status,
- interpret evidence,
- obey.

### Runtime

`ApproveLoan` tool is unavailable unless identity verification requirements are satisfied.

The model still chooses whether approval is desirable.

But it cannot bypass the legality condition.

This is the same useful split:

**runtime answers MAY**

**model answers SHOULD**

---

# 60. Cross-agent consistency

Agents should read from one authoritative epistemic service or versioned snapshot.

They may still disagree about:
- interpretation,
- recommendation,
- policy critique.

They should not independently invent current verification state.

Important:

consistency of stored epistemic state does not imply correctness of the stored evidence/policy.

It only prevents avoidable drift across agents.

---

# 61. Staleness and versioning

Every derived epistemic view should have a version.

Example:

```text
ClaimViewVersion = 18
```

A capability may be bound to:

```text
FraudClaimVersion = 18
```

Evidence added:

```text
ClaimViewVersion = 19
```

The old capability is rejected.

This prevents an agent operating on cached epistemic state from committing an action after the evidence basis changes.

---

# 62. Claim identity

Stable claim identity is essential.

Avoid:

`HotelAccessible`

Prefer:

```text
subject = Room217
predicate = BathroomDoorWidthAtLeast
object/parameter = 32 inches
effectiveScope = current configuration
```

This resembles RDF/knowledge-graph proposition modeling.

But the project should not require RDF infrastructure in v0.1.

Stable IDs and typed propositions are enough to begin.

---

# 63. Subject versioning

Evidence must bind to the relevant version of a subject.

Example:

```text
Room217
RenovationVersion 4
```

A measurement taken before renovation should not automatically verify the post-renovation room.

Other examples:
- software artifact hash,
- policy version,
- medical episode,
- account snapshot,
- device configuration.

This is critical for stale-proof reasoning.

---

# 64. Semantic granularity

Too coarse:

`HotelAccessible`

Too fine:

thousands of microclaims no decision ever uses.

The correct granularity is decision-driven.

Create a claim when its truth/justification can independently affect:

- a capability,
- obligation,
- verification policy,
- consequential decision,
- explanation.

This provides a practical stopping rule.

---

# 65. Ontology risk

A rich epistemic architecture can easily become:

- RDF platform,
- ontology engine,
- universal evidence graph,
- argumentation system,
- probabilistic logic engine,
- temporal database.

That would likely kill v0.1.

The product should not attempt universal knowledge representation.

The right question is:

> What is the smallest structure needed to stop unsupported propositions from gaining operational authority?

---

# 66. Minimum viable epistemic model

Recommended v0.1:

```text
Claim {
    id
    subject
    proposition
    subjectVersion?
}

Evidence {
    id
    type
    source
    observedAt
    recordedAt
    subjectVersion?
    validity
    provenanceRoot?
}

EvidenceRelation {
    evidenceId
    claimId
    relation: Supports | Opposes
}

VerificationPolicy {
    id
    version
    rules
}

VerificationRecord {
    id
    claimId
    policyVersion
    evidenceIds
    verifier
    grantedAt
    validUntil?
    subjectVersion
    status
}
```

Derived:

```text
ClaimView {
    evidencePolarity:
        Unknown | SupportOnly | OppositionOnly | Conflicted

    currentVerifications
    freshness
    missingRequirements
}
```

This captures most of the value without building a universal epistemology engine.

---

# 67. State machine vs derived view

Recommendation:

**Derived state.**

Do not allow:

```text
claim.status = Verified
```

as a general mutation.

Instead:

```text
deriveClaimView(claim, evidence, verificationRecords, now, policy)
```

Benefits:
- no drift between status and evidence,
- automatic downgrade after invalidation,
- reproducible reasoning,
- easier audit,
- simpler agent authority rules.

Events can remain authoritative while views are projections.

---

# 68. Event sourcing

Event sourcing fits naturally.

Possible events:

```text
ClaimDeclared
EvidenceAdded
EvidenceRelationAdded
EvidenceRetracted
EvidenceInvalidated
VerificationGranted
VerificationRevoked
PolicyActivated
SubjectVersionChanged
```

Derived views can be rebuilt.

However:

event sourcing is not required for the epistemic model to work.

Do not force it if the existing system does not benefit from event sourcing generally.

The important property is **immutable provenance of important changes**, not adherence to a specific persistence pattern.

---

# 69. Semantic compiler checks

Useful static checks could include:

- capability requires undefined claim,
- capability requires impossible verification policy,
- verification policy has no authorized producer,
- current verification references invalidated evidence,
- evidence missing provenance where policy requires it,
- derived claim cycle with no base evidence,
- policy requires mutually impossible conditions,
- model-generated evidence treated as trusted without authorization,
- wildcard/default epistemic handling,
- subject version missing for version-sensitive claims.

This is feasible without theorem proving.

---

# 70. Claim policy

A small DSL may eventually be useful:

```text
claim FraudClear {
    verify with FraudPolicy@12 {
        requires RiskAssessment {
            producer in ApprovedRiskModels
            maxAge 30m
        }
    }
}
```

But begin with typed configuration/code.

A DSL should emerge only if repeated patterns justify it.

---

# 71. Single-source-of-truth risk

If one verification policy is wrong:

- all agents can be consistently wrong,
- all generated capabilities can be wrong,
- all generated tests can reinforce the same mistake.

This is correlated semantic failure.

Mitigation:

- independent policy review,
- external acceptance examples,
- mutation testing,
- evidence audits,
- differential validation,
- provenance,
- human authority for high-consequence changes.

The architecture increases consistency.

Consistency is useful only when the policy is correct.

---

# 72. False-certainty risk

The label "Verified" invites overconfidence.

Recommendation:

### Internal representation

`VerificationSatisfied(policy, evidence, time)`

or:

`VerifiedUnderPolicy`.

### Human interface

"Verified" may be acceptable if the UI exposes:
- what was verified,
- under which policy,
- when,
- evidence age,
- conflicts.

This makes the bounded meaning visible.

---

# 73. False-negative risk

A claim can be true yet unsupported.

Example:

The room really does have a roll-in shower.

But no acceptable evidence exists.

System says:

`not currently verified`.

That is not equivalent to:

`false`.

Policies must allow responses such as:
- request evidence,
- escalate,
- proceed under explicit risk authority,
- remain unable to act.

---

# 74. Agent gaming

If an agent is rewarded for:

"Get claim verified"

it may seek shortcuts.

Threats include:
- choosing low-authority source,
- duplicating evidence,
- modifying policy,
- fabricating report,
- ignoring opposition,
- reusing stale evidence.

Therefore:

- agents should not control verification policy and evidence authority in the same capability scope,
- evidence constructors should be protected,
- provenance should be mandatory for trusted evidence,
- policy changes should require separate authority.

This is separation of duties for epistemics.

---

# 75. Evidence fabrication

Trusted evidence paths should use mechanisms appropriate to the source:

- authenticated API response,
- signed credential,
- content hash,
- sensor identity,
- human attestation,
- artifact hash,
- protected ingestion pipeline.

An AI-generated summary can reference evidence.

It should not become the evidence root unless policy explicitly permits that.

---

# 76. External-source uncertainty

Even a trusted API can be wrong.

Therefore provenance allows the system to say:

> According to trusted source S at time T, value V was returned.

It does not guarantee:

> Reality must equal V.

This again separates:
- provenance authenticity,
- procedural verification,
- objective truth.

---

# 77. Human testimony

Evidence policy must respect domain semantics.

Examples where self-report is legitimate:
- pain,
- fatigue,
- preference,
- subjective experience.

Therefore never hardcode:

`HumanReport < SensorData`.

Evidence authority is contextual.

---

# 78. Privacy implications

Explicit evidence systems create substantial privacy costs.

Risks:
- more retained sensitive data,
- longer provenance chains,
- easier reconstruction of personal history,
- overcollection "for audit."

Mitigations:

- data minimization,
- evidence references instead of prompt duplication,
- retention policies,
- access control,
- selective disclosure,
- redaction,
- cryptographic commitments where appropriate,
- separate claim summary from raw sensitive evidence.

This is a real tradeoff.

Epistemic traceability and privacy can conflict.

---

# 79. Security implications

The evidence layer becomes a high-value target.

Threats:

- evidence injection,
- source spoofing,
- replay,
- stale credential reuse,
- provenance tampering,
- verifier compromise,
- policy downgrade,
- evidence deletion,
- subject misbinding.

Therefore the trusted semantic core must include:
- source authentication,
- integrity,
- versioning,
- authorization,
- audit trails.

A claim system without protected evidence ingestion may produce a false sense of safety.

---

# 80. Experiment — assumption promotion

Setup:

Source says:
"Feature X is probably available."

### Conventional system

Agent records/use X.

Later agents receive resulting artifacts.

### Epistemic system

Evidence remains a report/inference with no verification.

Run 20–50 downstream tasks.

Measure:
- how often X becomes treated as fact,
- number of consequential dependencies,
- repair cost after correction,
- tokens.

Primary metric:

**Assumption Survival Rate.**

---

# 81. Experiment — repeated report

Use one originating source copied through five derivative channels.

Compare agent judgments with and without provenance.

Measure:

- perceived corroboration,
- decision confidence,
- verification errors,
- source-count errors.

This directly tests whether provenance prevents repetition from masquerading as independence.

---

# 82. Experiment — evidence invalidation

Start with:

```text
Verification V1
depends on E1
Capability C exists
```

Invalidate E1.

Measure whether:
- V1 becomes unusable,
- C disappears,
- plans using C become stale,
- obligation generated,
- old actions rejected.

This should be almost fully deterministic.

---

# 83. Experiment — contradictory evidence

Provide:
- strong supporting evidence,
- strong opposing evidence.

Compare:

A. ordinary agent memory/database,

B. explicit evidence-polarity model.

Measure:
- fabricated resolution,
- false certainty,
- appropriate abstention,
- human escalation,
- tokens.

---

# 84. Experiment — policy change

Change:

`Policy@7 -> Policy@8`

Measure:
- affected claims found,
- re-verification obligations,
- incorrect reinterpretation of historical decisions,
- context/tool cost.

This tests the value of policy-relative verification.

---

# 85. Experiment — agent restart

Agent 1 spends substantial context investigating a claim.

Agent 2 starts fresh.

### A

Give raw history.

### B

Give structured ClaimView + provenance links.

Measure:
- reconstruction tokens,
- duplicate source retrieval,
- disagreement,
- decision quality,
- latency.

This may be the clearest direct test of epistemic context compression.

---

# 86. Experiment — small model

Compare:

```text
Frontier model
+
raw evidence corpus
```

against:

```text
smaller model
+
structured epistemic view
+
lazy evidence retrieval
```

Use tasks requiring:
- conflict recognition,
- source independence,
- freshness,
- verification-policy application.

This directly tests model substitution.

---

# 87. Metrics

## Verification Precision

```text
claims marked verification-satisfied
that satisfy reference standard
/
all claims marked verification-satisfied
```

## Verification Recall

```text
reference-verifiable claims
correctly marked verification-satisfied
/
all reference-verifiable claims
```

## False Certainty Rate

Consequential decisions where the agent treats insufficiently supported claim as established.

## Unsupported Action Rate

Consequential actions executed without required epistemic evidence.

## Contradiction Preservation Rate

Conflicted cases where the system preserves rather than invents resolution.

## Evidence Independence Error Rate

Derivative copies incorrectly treated as independent corroboration.

## Assumption Survival Rate

Unsupported assumptions still affecting consequential behavior after N downstream agent operations.

## Evidence Reconstruction Cost

Tokens/tool calls needed to answer:

"Why is this claim accepted?"

## Cost Per Justified Decision

```text
total execution cost
/
consequential decisions
meeting reference evidence requirements
```

---

# 88. Longitudinal experiment

This experiment is especially important.

Run:

50–100 sequential agent modifications/decisions.

Seed:
- ambiguous evidence,
- model inferences,
- stale sources,
- copied sources,
- policy changes.

Compare architectures.

Track over time:
- unsupported assumptions,
- assumption promotions,
- evidence lineage loss,
- stale decisions,
- correction cost,
- tokens,
- human intervention.

The key hypothesis is not merely:

"Does explicit epistemics help one task?"

It is:

> **Does it prevent semantic uncertainty from compounding across generations of agent work?**

---

# 89. Economic implications

The economic value can come from four sources.

## A. Fewer downstream errors

Unsupported claims cannot automatically authorize actions.

## B. Lower reconstruction cost

Agents do not repeatedly rediscover why a claim is accepted.

## C. Lower human audit cost

Evidence and policy are traceable.

## D. Potential smaller-model substitution

Structured epistemic state may remove source-comparison work from the model.

Costs include:

- evidence ingestion,
- provenance storage,
- policy maintenance,
- dependency propagation,
- privacy/security controls,
- ontology complexity.

Therefore the architecture should be applied selectively.

---

# 90. Cost model

For N consequential decisions:

```text
TotalCost =
    EpistemicInfrastructure
    + EvidenceMaintenance
    + AgentInference
    + EvidenceRetrieval
    + HumanReview
    + ExpectedUnsupportedDecisionCost
    + Privacy/SecurityOverhead
```

The architecture wins when reusable evidence structure lowers:

- repeated inference,
- repeated human verification,
- escaped decision errors,

more than it costs to maintain.

Break-even should occur sooner in:
- healthcare,
- finance,
- compliance,
- accessibility,
- safety,
- operational automation,
- multi-agent systems with long-lived memory.

Later or never in:
- transient UI logic,
- trivial preferences,
- low-consequence computation.

---

# 91. Where not to use explicit epistemics

Do not create claims/evidence graphs for:

- pure deterministic computation,
- transient component state,
- temporary rendering values,
- obvious derived arithmetic,
- low-consequence preferences,
- facts already enforced by authoritative deterministic systems.

Example:

`ButtonHover = true`

does not need provenance.

The trigger should be:

> Would accepting this proposition incorrectly affect a consequential decision, capability, obligation, policy, or future agent reasoning?

If no, the full epistemic machinery is probably unnecessary.

---

# 92. Counterarguments

## 1. The epistemic model becomes too complex.

**Strong risk.**

This is the largest implementation threat.

Mitigation:
- claims only for consequential propositions,
- minimal evidence graph,
- no universal ontology.

## 2. Most commercial software does not need this.

**Mostly true.**

Most individual values do not.

But specific decision boundaries may.

## 3. Verification creates false confidence.

**True if terminology is careless.**

Use policy-relative verification.

## 4. Evidence graphs consume too many tokens.

**Only if injected wholesale.**

Use derived summaries + lazy retrieval.

## 5. Agents still need raw sources.

**Yes, sometimes.**

The goal is not elimination; it is selective retrieval.

## 6. Human judgment cannot be encoded.

**Correct.**

Represent expert attestation or escalation rather than pretending to formalize the judgment.

## 7. Probability/confidence solves most of the problem.

**No.**

Probability does not capture provenance, authority, independence, freshness, or procedural verification.

## 8. Provenance is expensive.

**Yes.**

Scope it to consequential claims/evidence.

## 9. Evidence policies become brittle.

**Possible.**

Version policies and permit explicit expert/manual paths.

## 10. Contradiction logic becomes a research project.

**Avoidable.**

Start with simple support/opposition/conflict.

## 11. Knowledge graphs introduce too much infrastructure.

**True if adopted prematurely.**

Do not require a graph database for v0.1.

## 12. Model output may influence verification indirectly.

**Yes.**

Record model origin and isolate trusted verification producers.

## 13. Users dislike "unknown."

**Likely in some workflows.**

But hiding uncertainty does not remove it.

Design explicit next actions.

## 14. System may become unable to act under uncertainty.

**A policy problem.**

Allow explicit risk-authorized action where appropriate.

## 15. Structured epistemics slows product development.

**Possible.**

Apply only at consequential boundaries.

---

# 93. What existing research strongly supports

1. **Justification/dependency tracking** is a well-established method for maintaining beliefs as assumptions change.

2. **Contradictory information need not force logical collapse or immediate binary resolution.**

3. **Unknown and false are distinct under open-world reasoning.**

4. **Provenance is a mature formal concept with standardized representations such as W3C PROV.**

5. **Clinical systems already separate domain/clinical state from verification state.**

6. **LLM confidence is not a reliable substitute for evidence or verification authority.**

7. **Policy-relative acceptance is conceptually different from objective truth.**

8. **Retraction/invalidation should propagate through dependencies.**

These are strong foundations for the architecture.

---

# 94. What remains speculative

The following are not yet established by existing evidence:

1. Explicit epistemic state materially reduces LLM token cost.

2. Smaller models can reliably replace larger models when given structured epistemic views.

3. Assumption laundering is a quantitatively major source of longitudinal agent defects.

4. An epistemic evidence graph remains manageable at enterprise scale without excessive complexity.

5. Structured epistemic summaries preserve enough information to avoid harmful compression.

6. Capability gating on epistemic requirements materially lowers total cost per correct decision.

7. The proposed system produces positive lifecycle ROI outside high-consequence domains.

These should be tested rather than asserted.

---

# 95. Recommended architecture changes

## Change 1 — Abandon the single eight-state authoritative enum

Keep the concepts, separate the dimensions.

## Change 2 — Make evidence and verification records authoritative

Claim status should be derived.

## Change 3 — Rename internal `Verified`

Use:

`VerificationSatisfied`
or
`VerifiedUnderPolicy`.

## Change 4 — Put `Invalidated` on evidence/verification records

Then recalculate claim views.

## Change 5 — Put `Reported` and `Inferred` in origin/derivation metadata

Not claim lifecycle state.

## Change 6 — Keep assumptions inside explicit reasoning contexts

Do not persist them as authoritative truth.

## Change 7 — Use a four-valued evidence-polarity view

Unknown / Support / Opposition / Conflict.

## Change 8 — Bind verification to policy, time, evidence, and subject version

## Change 9 — Gate capabilities on explicit epistemic requirements

Not vague status ordering.

## Change 10 — Add version-bound epistemic snapshots for agents

## Change 11 — Use lazy evidence retrieval

Do not put the full graph in every prompt.

## Change 12 — Keep v0.1 small

No full ontology platform.
No Dempster-Shafer unless a domain proves the need.
No universal argumentation engine.

---

# 96. Minimum viable implementation

A first implementation can be surprisingly small.

```text
Claim
Evidence
EvidenceRelation
VerificationPolicy
VerificationRecord
ClaimView
```

Functions:

```text
deriveEvidencePolarity(claim)
currentVerification(claim, policy, time, subjectVersion)
missingVerificationRequirements(claim, policy)
affectedClaims(evidenceChange)
deriveCapabilities(epistemicSnapshot)
```

Events:

```text
EvidenceAdded
EvidenceInvalidated
VerificationGranted
VerificationRevoked
PolicyChanged
```

That is enough to test the hypothesis.

Do not build:
- universal ontology,
- probabilistic belief network,
- theorem prover,
- knowledge-graph product,

until experiments show those are necessary.

---

# 97. Final verdict

## Does explicit epistemic state reduce unsupported certainty?

**Strong evidence**, if "epistemic state" means explicit evidence/provenance/verification structure rather than a mutable confidence label.

The formal traditions behind TMS, provenance, open-world reasoning, paraconsistency, and verification status strongly support preserving justification and uncertainty instead of collapsing them.

## Does evidence provenance reduce inherited agent assumptions?

**Moderate evidence**

Provenance clearly enables lineage, source independence analysis, and retraction. The specific longitudinal AI-agent assumption-inheritance benefit is highly plausible but not yet well quantified.

## Does structured epistemic state reduce context/token cost?

**Weak-to-moderate evidence**

The compression mechanism is credible, but direct controlled evidence for this architecture is missing.

## Can it enable smaller models?

**Weak evidence / plausible hypothesis**

This is experimentally attractive but not demonstrated.

## Should epistemic status be:

**Multi-dimensional record with derived views, including a small lattice-like evidence-polarity component.**

Not a single mutable state enum.

## Should "Verified" be renamed?

**Yes, internally.**

Recommendation:

`VerificationSatisfied`

or:

`VerifiedUnderPolicy`.

This avoids conflating procedural acceptance with objective truth.

## Closest existing formalism

**Truth-maintenance systems combined with provenance and paraconsistent evidence handling.**

No single existing formalism captures the entire architecture.

## Strongest prior art

- Doyle's Truth Maintenance System
- de Kleer's Assumption-Based TMS
- AGM belief revision
- Belnap four-valued logic
- Dung-style argumentation
- W3C PROV
- HL7/FHIR separation of clinical and verification state
- modern calibration research showing model confidence cannot be equated with correctness

## Most important architecture correction

**Do not store epistemic authority as one mutable claim state. Derive it from evidence, provenance, verification records, policy, and time.**

## Biggest complexity risk

**Accidentally building a universal knowledge-representation/ontology platform.**

Keep claims narrow and decision-driven.

## Most valuable AI-specific benefit

**Preventing assumption laundering across agents and across time.**

The model may infer something.

The system preserves that it was an inference.

Future agents cannot mistake persistence for verification.

## Most important missing experiment

**A longitudinal multi-agent experiment measuring whether unsupported assumptions become durable system truth less often under explicit epistemic provenance—and whether this reduces total tokens and correction cost.**

---

# 98. Overall research decision

**Proceed, with a major architecture revision.**

The hypothesis is stronger after comparison with prior art, but the original eight-state representation should not survive unchanged.

The research suggests a cleaner principle:

> **Truth claims should not move through an authority ladder. Evidence accumulates, conflicts, expires, and is invalidated. Verification procedures evaluate that evidence. Epistemic views are derived. Actions require explicit epistemic conditions.**

This has several advantages.

It stops:
- repetition from becoming authority,
- model output from becoming evidence merely by persistence,
- unknown from becoming false,
- contradiction from being overwritten,
- stale evidence from silently authorizing action,
- invalidated evidence from leaving dependent capabilities alive.

It also preserves uncertainty rather than trying to eliminate it.

The architecture's most promising AI contribution is therefore not:

> "Teach the agent what is true."

It is:

> **"Make it impossible for the system to forget why it thinks something is true."**

That is a much more defensible objective.

And it connects directly to the larger state-constrained architecture:

```text
Evidence
    ↓
Derived epistemic view
    ↓
Verification
    ↓
Capabilities / Obligations
    ↓
Legal agent actions
```

The agent is still probabilistic.

The authority of its assumptions does not have to be.

---

# 99. Priority research agenda

The next work should happen in this order.

## Priority 1 — Longitudinal assumption-laundering benchmark

Validate that the problem is material.

## Priority 2 — Evidence-invalidation cascade prototype

Demonstrate deterministic:
- downgrade,
- capability removal,
- obligation creation.

## Priority 3 — Raw evidence vs structured epistemic context benchmark

Measure token/tool savings.

## Priority 4 — Small-model substitution experiment

Only after Priority 3 shows meaningful context reduction.

## Priority 5 — Security and privacy threat model

Before using the architecture in high-consequence domains.

## Priority 6 — Domain adapters

Test:
- accessibility,
- deployment,
- fraud,
- healthcare.

The goal should not be to prove that every fact needs epistemic machinery.

It should be to locate the narrow set of consequential claims where explicit epistemic authority creates outsized safety and economic leverage.

---

# 100. Key references

## Foundational truth maintenance and belief revision

1. Doyle, J. (1979). "A Truth Maintenance System." *Artificial Intelligence*, 12(3), 231–272.

2. de Kleer, J. (1986). "An Assumption-Based TMS." *Artificial Intelligence*, 28(2), 127–162.

3. Alchourrón, C. E., Gärdenfors, P., & Makinson, D. (1985). "On the Logic of Theory Change: Partial Meet Contraction and Revision Functions." *Journal of Symbolic Logic*, 50, 510–530.

## Paraconsistency and argumentation

4. Belnap, N. D. (1977). "A Useful Four-Valued Logic." In *Modern Uses of Multiple-Valued Logic*.

5. Dung, P. M. (1995). "On the Acceptability of Arguments and its Fundamental Role in Nonmonotonic Reasoning, Logic Programming and n-Person Games." *Artificial Intelligence*, 77(2), 321–357.

## Provenance

6. W3C (2013). *PROV-DM: The PROV Data Model*. W3C Recommendation.

7. W3C (2013). *PROV-Overview*. W3C Recommendation family overview.

## Open-world semantics

8. W3C Semantic Web / OWL materials describing open-world semantics and the distinction between missing information and negative assertions.

## Healthcare terminology

9. HL7 FHIR / HL7 Terminology. `Condition.verificationStatus` and Condition Verification Status terminology, separating clinical status from verification status.

## LLM uncertainty and calibration

10. Sun, Y.-J., Dey, S., Hakkani-Tur, D., & Tur, G. (2024). "Confidence Estimation for LLM-Based Dialogue State Tracking."

11. Yang, R., Rajagopal, D., Hayati, S. A., Hu, B., & Kang, D. (2024). "Confidence Calibration and Rationalization for LLMs via Multi-Agent Deliberation."

12. Epstein, E. L. et al. (2025). "LLMs are Overconfident: Evaluating Confidence Interval Calibration with FermiEval."

13. OpenAI researchers (2025). "Why Language Models Hallucinate." Analysis of incentives and statistical mechanisms that encourage guessing rather than uncertainty acknowledgement.

---

# 101. Evidence grading summary

| Claim | Evidence |
|---|---|
| Unknown must not automatically become false | Strong formal support |
| Contradiction can be preserved without forced resolution | Strong formal support |
| Justifications should be tracked for retractable beliefs | Strong formal support |
| Provenance should be explicit and machine-readable | Strong standards/prior-art support |
| Verification should be distinct from domain state | Strong domain precedent |
| LLM confidence should not be treated as truth authority | Strong empirical support |
| The eight-state enum is structurally inappropriate | Strong architectural inference from prior art |
| Epistemic status should be derived | Strong architectural inference |
| Provenance will reduce cross-agent assumption inheritance | Moderate/plausible |
| Structured epistemics will reduce agent tokens | Plausible, missing direct test |
| Structured epistemics will enable smaller models | Plausible, weak direct evidence |
| Full knowledge graph infrastructure is necessary | No evidence |
| Dempster-Shafer is necessary | No evidence |
| Full formal argumentation is necessary | No evidence |

---

# 102. Final architectural principle

The simplest durable rule emerging from the research is:

> **Claims do not become true because software remembers them.**

Software should remember:

- what was claimed,
- who or what produced it,
- what evidence supports it,
- what evidence opposes it,
- how it was derived,
- under which policy it was accepted,
- when that acceptance was valid,
- and what depends on it.

Then the system can decide what actions are currently justified.

That gives AI agents something far more useful than a database full of accumulated "facts":

**a machine-readable boundary between what the system has heard, what it has inferred, what it can justify, and what it is allowed to act upon.**
