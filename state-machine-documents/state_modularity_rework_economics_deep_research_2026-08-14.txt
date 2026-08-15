# Deep Research Addendum: Rework Economics Without Explicit Semantic Constraints

**Date:** 2026-08-14  
**Scope:** Literature-based synthesis only. No new experiments were run.  
**Research focus:** Factor the cost of rework into the economic case for explicit state ownership, legal transitions, invariants, capabilities, obligations, and semantic dependency modeling.

---

## Executive Conclusion

Once rework is included, the economic hypothesis becomes substantially more important than the token-saving hypothesis by itself.

But there is an important constraint: we cannot take broad software-industry claims such as “30–50% of software effort is rework” and assume that the proposed architecture eliminates that amount of cost. Much rework comes from changed requirements, product learning, infrastructure failures, dependency changes, UX problems, misunderstood customer needs, and other causes that explicit semantic constraints would not prevent.

The better question is:

> **How much rework is caused by uncertainty about consequential system behavior—and how much of that uncertainty could be eliminated by explicit state ownership, legal transitions, invariants, dependencies, capabilities, and obligations?**

That creates a much stronger and more defensible economic model.

The core conclusion is:

> **AI makes software change dramatically cheaper to generate, but not necessarily cheaper to understand, verify, repair, or maintain. As change volume rises, rework can become the limiting cost. Explicit semantic ownership and mechanically enforced transitions may shift correctness work from repeated probabilistic discovery and repair into deterministic validation before the change propagates.**

The key economic metric should therefore be:

\[
\boxed{\text{Cost of Correct Change}}
\]

rather than:

\[
\text{Cost of Code Generation}
\]

Raw token savings remain relevant, but they may be one of the smaller economic effects.

---

# 1. The Original Cost Model Is Incomplete

A narrow AI-agent cost model might look like:

\[
C_{task}
=
C_{tokens}
+
C_{tools}
+
C_{tests}
+
C_{retries}
\]

That is too small.

A more realistic model is:

\[
C_{change}
=
C_{initial}
+
C_{agent\ rework}
+
C_{review\ rework}
+
C_{integration\ rework}
+
C_{production\ rework}
+
C_{architecture\ rework}
+
C_{future\ change\ amplification}
\]

The last several terms may eventually dwarf inference spend.

DORA's current work explicitly measures **deployment rework rate**: the percentage of deployments consisting of unplanned work to fix bugs. DORA added this because change-failure rate was only an indirect proxy for how much remediation teams were doing.

That supports an important distinction:

> **Productive change and corrective change are not economically equivalent.**

---

# 2. Six Different Kinds of Rework

The proposed architecture should be evaluated against different categories of rework separately.

Not all rework is addressable by better semantic structure.

---

## 2.1 Agent-Trajectory Rework

This is the most immediate form of AI rework:

> search → guess → edit → test → fail → search more → reconsider → edit again

Current coding-agent literature shows that this can be enormous.

AgentLens studied successful SWE trajectories and reported radically different computational paths leading to the same binary “pass.”

Examples reported in the study include:

- minimal successful solutions averaging about **34K tokens**
- brute-force convergence averaging about **857K tokens**
- excessive-exploration trajectories averaging about **1.38 million tokens**
- one agent consuming **2.62 million tokens for a one-line fix**

The important implication is not merely that agents use many tokens.

It is:

> **A large fraction of agent cost may be probabilistic exploration rather than productive implementation.**

This is already rework.

It simply occurs inside the agent rather than appearing as a ticket or human correction.

A state-constrained semantic system could theoretically replace some of this search.

Instead of:

> “Find out what controls refunds.”

the agent could query:

```text
RefundExecution owner?
```

and receive:

```text
Owner: Payment

Current:
    OutcomeUnknown

Legal:
    ReconcileRefund
    InvestigateRefund

Forbidden:
    RequestRefund

Obligation:
    ReconcileRefund
```

Potentially unnecessary work then disappears:

- repository search
- status inference
- retry reasoning
- duplicate-effect speculation
- trial edits
- failed tests
- repeated tool calls

The key economic quantity becomes:

> **probabilistic work that never occurs**

rather than merely:

> tokens removed from the initial prompt

---

# 3. Implementation Rework

Implementation rework occurs when the first attempted change is incomplete or incorrect.

Recent real-world AI-agent evidence shows that this remains significant.

A 2026 study examined roughly **33,000 agent-authored GitHub pull requests**.

Unmerged PRs tended to:

- touch more files
- make larger changes
- fail CI more often

Bug-fix and performance tasks were among the harder categories.

A separate analysis of **8,106 AI-agent fix PRs** found test failures among the common reasons agent-generated fixes failed to integrate.

This distinction matters because generated code may be:

- syntactically correct
- locally reasonable
- stylistically acceptable

and still be semantically wrong.

Typical causes include:

- misunderstanding lifecycle state
- violating a hidden precondition
- missing a downstream consumer
- modifying data owned elsewhere
- misunderstanding partial failure
- omitting required recovery behavior

Those are precisely the categories explicit semantic structure attempts to expose.

A conventional loop may be:

```text
first implementation
    ↓
review/test failure
    ↓
second implementation
```

A constrained system attempts to move toward:

```text
legal semantic transition
    ↓
valid implementation attempt
```

But this architecture cannot eliminate all implementation rework.

It will not inherently prevent:

- wrong algorithms
- poor UI choices
- malformed SQL
- performance regressions
- memory leaks
- races not modeled semantically
- misunderstood feature intent

Therefore the economic model needs an **addressable rework fraction** rather than assuming all rework is preventable.

---

# 4. Review Rework

Human review may be more economically important than raw AI-generation cost.

Consider:

- AI writes a change in 5 minutes
- senior engineer spends 25 minutes understanding it
- engineer finds a domain violation
- sends it back
- another agent run rewrites it
- engineer rereads it
- integration tests expose another assumption

The production cost was not 5 minutes.

It was the complete loop.

DORA describes part of this dynamic as a **verification tax**:

> time saved in code generation can be spent again auditing generated changes.

METR's randomized study of experienced open-source developers working in repositories they already knew found that, using early-2025 AI tools, participants took **19% longer** with AI in that experiment.

That result should not be generalized indiscriminately to all 2026 AI development.

But it clearly demonstrates the mechanism:

> **Generation acceleration can be overwhelmed by verification and interaction cost.**

A semantic architecture could potentially change the nature of review.

Instead of asking:

> Is this state modification actually legal?

a validator could answer that mechanically.

Instead of reviewing:

```text
if payment.Status == "Captured" ...
```

against a mental reconstruction of the full payment lifecycle, a reviewer might inspect:

```text
Transition:
    Captured -> PartiallyRefunded

Guard:
    RefundableBalance > 0

Effect:
    IssueRefund

Produces:
    RefundRequested
```

while a semantic validator has already checked the structural legality.

That does not remove review.

It may shift review from:

> “Did this violate the system?”

toward:

> “Is this the business behavior we actually want?”

That distinction could be economically significant because senior-engineer attention is much more expensive than inference tokens.

---

# 5. Integration Rework

Integration rework may be one of the strongest differentiators between explicit semantic ownership and ordinary AI-assisted coding.

Consider adding:

```text
PartiallyRefunded
```

to a payment lifecycle.

The local code change may be trivial.

But now the repository may contain assumptions such as:

```text
Payment.Status == Refunded
Payment.Status != Captured
switch(payment.Status)
CASE WHEN payment_status
eligibleForShipment()
calculateOrderBalance()
```

Some dependencies will be obvious.

Some will not.

Research on semantic and historical change coupling exists precisely because important dependencies are often not completely represented by basic structural dependencies.

A standard call graph may tell us:

```text
Order -> Payment
```

but not necessarily why.

A semantic model could represent:

```text
ShipmentEligibility
requires:
    PaymentClaim = Captured
```

If the meaning of `Captured` changes, the semantic system can potentially produce an impact report:

```text
Consumers affected:

ShipmentEligibility
OrderCompletion
RefundEligibility
RevenueRecognition
```

That is not merely context compression.

It is:

> **rework prevention through change-impact completeness**

Without strong semantics, the maintenance loop may become:

```text
implement locally
    ↓
discover consumer
    ↓
fix consumer
    ↓
discover another test
    ↓
fix test
    ↓
production edge case
    ↓
hotfix
```

The desired constrained loop is:

```text
compute semantic impact closure
    ↓
perform affected changes
    ↓
validate closure
```

The value is that some downstream repair work becomes planned work.

---

# 6. Production Rework

Production rework is conceptually more expensive because the semantic mistake has escaped the development loop.

DORA's AI-era findings are relevant here.

Its research has found that increased AI adoption can correlate with higher individual productivity-related measures while also creating pressure on delivery stability.

DORA increasingly frames AI as an **amplifier** of the underlying software-delivery system.

Teams with:

- strong automated testing
- fast feedback
- loose coupling
- healthy delivery systems

are better positioned to translate AI acceleration into actual delivery performance.

Weak systems can translate increased change volume into increased instability.

This supports a deeper architectural concern:

\[
\text{change generation rate} \uparrow
\]

does not imply:

\[
\text{system understanding rate} \uparrow
\]

AI can therefore increase the rate at which:

- defects
- architectural inconsistencies
- hidden coupling
- invalid assumptions

enter the system.

A state-constrained architecture attempts to change the relationship:

\[
\text{AI change rate} \uparrow
\]

while mechanically constraining:

\[
\text{illegal semantic change rate}
\]

That could be more economically important than reducing an individual prompt by tens of thousands of tokens.

---

# 7. Architectural Rework

Architectural rework is the long-tail cost.

Traditional architecture research already establishes that architectural technical debt can increase future maintenance and evolution cost.

Architecture erosion has an established literature concerned with:

- detection
- repair
- prevention
- future change cost
- structural degradation

A longitudinal architectural-debt study describes a familiar pattern:

1. quick changes initially increase responsiveness
2. shortcuts accumulate
3. future changes require more effort
4. organizations eventually undertake substantial architectural repair

AI potentially increases the rate at which this process occurs.

Suppose AI reduces the local cost of a change from:

```text
2 hours -> 20 minutes
```

but the cheap change introduces hidden coupling.

Later, another task now requires:

```text
3 hours instead of 20 minutes
```

The first task looked productive.

The software system became less productive.

This is:

## Change Amplification

A local modification increases the cost or semantic reach of future modifications.

This may ultimately be more dangerous than obvious hallucination because each individual change can look locally correct.

---

# 8. The Expanded Savings Model

The initial economic theory focused heavily on token reduction.

A more complete model is:

\[
\begin{aligned}
Savings = {} &
AgentExplorationAvoided \\
&+ FailedAttemptAvoided \\
&+ ReviewReworkAvoided \\
&+ IntegrationReworkAvoided \\
&+ ProductionReworkAvoided \\
&+ ArchitectureRepairAvoided \\
&+ FutureChangeAmplificationAvoided \\
&+ TokenSavings
\end{aligned}
\]

Raw token reduction may turn out to be one of the smaller terms.

The largest possible benefits may instead come from:

- fewer failed trajectories
- less human verification
- fewer missed dependencies
- fewer production repairs
- slower architectural decay
- cheaper future changes

---

# 9. We Need to Separate Rework Types

It would be incorrect to label all repeated work as avoidable architecture failure.

Two broad categories matter.

---

## 9.1 Unavoidable / Adaptive Rework

Examples:

```text
changed requirement
new business information
unexpected external event
intentional redesign
market learning
product discovery
customer feedback
```

The proposed architecture probably does not substantially reduce these.

In many cases, this is productive learning.

---

## 9.2 Semantic Rework

A more useful category is:

> **Work performed because consequential state, legal actions, authority, dependencies, or recovery requirements were incorrectly inferred, incompletely discovered, or violated.**

Examples:

```text
wrong owner modified
illegal state reached
hidden invariant violated
consumer overlooked
partial failure misunderstood
required recovery missed
duplicate action performed
cross-module assumption missed
architecture boundary bypassed
```

This is the portion of rework the proposed architecture plausibly addresses.

---

# 10. New Metric: Semantic Rework Rate

Define:

## Semantic Rework Rate (SRR)

\[
SRR =
\frac
{\text{engineering effort spent correcting semantic misunderstandings}}
{\text{total engineering effort}}
\]

For AI-assisted work, define:

## Agent Semantic Rework Rate (ASRR)

\[
ASRR =
\frac
{\text{agent + human effort correcting agent semantic mistakes}}
{\text{total AI-assisted change effort}}
\]

Potential inputs include:

- repeated agent calls
- unnecessary repository/tool exploration
- failed tests
- reverted edits
- reviewer corrections
- missed consumers
- integration repair
- production hotfixes
- architectural cleanup

This may be a more useful KPI than:

```text
tokens per task
```

because it captures the real economic burden.

---

# 11. Rework Can Compound

There is a deeper risk when AI modifies a codebase repeatedly.

Suppose an unconstrained agent introduces an invalid abstraction today.

Tomorrow:

1. another agent reads it
2. assumes it is intentional
3. builds another feature around it
4. a third agent sees two examples
5. the third agent infers that this is the established pattern

The mistake becomes repository evidence.

The feedback loop becomes:

\[
Bad\ Change
\rightarrow
Repository\ Evidence
\rightarrow
Agent\ Learns\ Pattern
\rightarrow
More\ Bad\ Changes
\]

This is qualitatively important.

The codebase becomes simultaneously:

- the product
- documentation
- architectural evidence
- context substrate for the next agent

That means architectural erosion can become **self-reinforcing under AI maintenance**.

Long-horizon agent benchmarks such as SWE-EVO and other sustained-evolution work exist because isolated one-shot correctness does not capture this problem.

---

# 12. Semantic Architecture as a Ratchet

Explicit semantic authority could potentially act as an architectural ratchet.

Conceptually:

```text
legal architecture
      ↓
agent change
      ↓
semantic validator
   ↙         ↘
valid      rejected
  ↓
repository remains
inside semantic envelope
```

The model does not need to become progressively better at remembering the architecture.

The architecture prevents certain classes of change from leaving the legal region.

That suggests another important economic mechanism:

> **Preventing debt propagation may be more valuable than fixing individual mistakes faster.**

---

# 13. Constraint-Based Context Elimination

This changes the meaning of context reduction.

Without mechanical enforcement, the agent needs context partly to answer:

> What can I safely do?

With enforcement, some of that becomes:

> The system will not allow illegal actions.

That creates a different kind of compression.

Call it:

## Constraint-Based Context Elimination

If an invariant is mechanically enforced, the model may not require the complete explanation of that invariant in every task.

For example:

### Conventional prompt

```text
Do not refund a payment twice.
If a previous refund timed out, do not assume it failed.
Check the provider before retrying.
...
```

### Constrained semantic state

```text
RefundExecution=OutcomeUnknown

Available:
    ReconcileRefund

RequestRefund:
    unavailable
```

The latter reduces both:

- cognitive search
- opportunity for rework

This is more than documentation compression.

It transfers responsibility from probabilistic reasoning to the execution environment.

---

# 14. DORA's "AI as Amplifier" Framing Strengthens the Thesis

DORA's recent work increasingly frames AI as an amplifier.

AI does not automatically create high-performing software organizations.

Organizations with:

- strong delivery systems
- loose coupling
- strong testing
- fast feedback

are positioned to benefit more.

Weak systems may experience instability as AI increases throughput.

The proposed architecture extends that logic:

> **If AI amplifies the architecture, then architecture that makes consequential legality machine-enforceable should matter disproportionately in an AI-heavy organization.**

This is an inference from DORA's evidence.

DORA did not directly test explicit state ownership or semantic-transition architectures.

But the implication is consistent with its findings.

---

# 15. Provisional Ranking of Economic Effects

Based on the literature, the effects should be considered separately.

## 1. Avoided rework / failed trajectories

Potentially enormous.

Current agent trajectories already show orders-of-magnitude variation between direct and exploratory successful paths.

## 2. Avoided human verification

Potentially very large.

Senior-engineer review time is much more expensive than inference tokens.

## 3. Avoided architectural degradation

Potentially the largest long-term benefit.

Also the hardest to measure and currently the most speculative.

## 4. Smaller-model substitution

Still potentially enormous.

If semantics enable a cheaper model to perform the same task reliably, the economic effect may dwarf same-model token compression.

## 5. Fewer tool calls and repository reads

Meaningful and directly tied to deterministic localization.

## 6. Raw input-token savings

Real, but increasingly likely to be one of the least important economic effects.

---

# 16. Revised Economic Thesis

The thesis should no longer be framed primarily as:

> State-constrained architecture makes AI cheaper because it uses fewer tokens.

A stronger version is:

> **AI makes software change dramatically cheaper to generate, but not necessarily cheaper to understand, verify, repair, or maintain. As change volume rises, rework can become the limiting cost. Explicit semantic ownership and mechanically enforced transitions may shift correctness work from repeated probabilistic discovery and repair into deterministic validation before the change propagates.**

The primary economic target becomes:

\[
\boxed{\text{Cost of Correct Change}}
\]

rather than:

\[
\text{Cost of Code Generation}
\]

Token reduction becomes one consequence of a broader reduction in uncertainty and repair work.

---

# 17. Strongest Validated Mechanisms from Existing Literature

The literature supports several component mechanisms.

### Supported

- software rework is economically significant
- agent trajectories can contain very large amounts of redundant exploration
- failed and inefficient agent trajectories can consume orders of magnitude more computation
- AI-authored changes still fail CI and integration
- human verification can erase some generation-time productivity gains
- architectural debt increases future change cost
- long-horizon AI maintenance remains difficult
- AI can amplify weaknesses in an organization's software-delivery system

### Strongly plausible

- explicit semantic ownership can improve change-impact analysis
- legal transitions can reject invalid edits earlier
- obligations can reduce ambiguity after uncertain effects
- capabilities can prevent unauthorized state mutation
- semantic impact closure can reduce missed consumers
- executable architecture can reduce the amount of domain legality that must live in an LLM prompt

### Not yet established

- the percentage of total software rework that is semantic rework
- the fraction of semantic rework preventable by this architecture
- the actual reduction in ASRR
- the reduction in human review time
- the reduction in downstream hotfixes
- the reduction in long-term architectural erosion
- the dollar value of avoided change amplification
- whether state-derived semantics outperform modern static analysis enough to justify implementation cost

---

# 18. The Critical Remaining Research Question

The most important number is no longer simply:

> How many context tokens disappear?

It is:

> **What fraction of software rework is semantic rework that a state/transition/capability architecture could make impossible, mechanically visible, or immediately detectable?**

That number connects:

- architecture
- agent behavior
- human review
- integration reliability
- production stability
- long-term maintenance
- economics

It may be one of the most important questions in the entire research program.

---

# 19. Recommended Updated Cost Model

For each AI-assisted change, future analysis should track:

## Initial production cost

- agent input tokens
- agent output tokens
- reasoning tokens
- tool calls
- CI/test cost
- elapsed time

## Agent rework

- failed attempts
- repeated searches
- repeated file reads
- rejected patches
- redundant tool calls
- additional model calls

## Human rework

- review time
- reviewer corrections
- clarification cycles
- manual repair
- re-review time

## Integration rework

- CI failures
- missed dependency fixes
- regression repairs
- additional integration patches

## Production rework

- hotfixes
- rollback effort
- incident response
- data repair
- recovery activity

## Architectural rework

- boundary repair
- coupling removal
- later refactors caused by earlier changes
- repeated semantic inconsistency cleanup

## Future-change amplification

Estimate whether prior changes increase:

- files touched per task
- semantic fan-out
- retrieval context
- tool calls
- repair loops
- human review time
- cost per correct change

---

# 20. Final Verdict

Factoring rework into the research makes the proposed architecture more economically interesting, not less.

However, the argument must remain narrow.

We should not claim:

> explicit state architecture eliminates software rework.

The defensible claim is:

> **Explicit semantic ownership may reduce a specific and economically important class of rework: work caused by uncertainty about consequential state, authority, legal transitions, dependencies, and required recovery actions.**

The larger economic opportunity may therefore come from:

- reducing probabilistic exploration
- preventing semantically illegal changes
- exposing impact before implementation
- reducing human verification
- preventing integration repair
- stopping architectural mistakes from becoming future repository evidence
- limiting change amplification

rather than from raw prompt compression alone.

The strongest overall theory is now:

\[
\text{Executable Semantic Structure}
\rightarrow
\text{Less Uncertainty}
\rightarrow
\text{Less Rework}
\rightarrow
\text{Lower Cost of Correct Change}
\]

That is the economic thesis worth carrying forward.

---

# Literature Referenced in the Analysis

The preceding synthesis drew on the following classes of literature and recent research:

- Boehm / Basili software-defect and rework economics
- DORA software-delivery performance and deployment-rework research
- DORA AI-era work on AI as an amplifier of software-delivery systems
- METR randomized research on AI-assisted developer productivity
- AgentLens research on coding-agent trajectory efficiency
- recent trajectory analysis of failed and redundant AI-agent behavior
- empirical studies of AI-agent-authored GitHub pull requests
- research on failed AI-agent repair PRs
- semantic and historical change-coupling research
- architectural technical debt and architecture-erosion literature
- longitudinal architectural-debt studies
- SWE-EVO and long-horizon software-evolution agent benchmarks

Evidence from these sources supports the existence and economic significance of rework, trajectory waste, verification burden, integration failure, and architectural degradation.

It does **not** directly establish the amount of rework that the proposed semantic state architecture would eliminate.

That remains the critical unmeasured variable.
