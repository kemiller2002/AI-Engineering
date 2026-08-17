# Research Report — State-Constrained Modularity, Context Reduction, and Agent Execution Cost

**Execution date:** 2026-08-14  
**Research specification:**
[`state-modularity-agent-context-token-cost-research-prompt.md`](../prompts/state-modularity-agent-context-token-cost-research-prompt.md)

## 1. Executive conclusion

### Current verdict

**Promising, but not yet proven.**

The available evidence supports a narrower claim with reasonable confidence:

> Mechanically supplied structural information and selective repository context can reduce coding-agent exploration, context consumption, and sometimes total cost without sacrificing correctness.

There is direct empirical support for graph-guided retrieval, dependency-aware retrieval, static-analysis-assisted prompting, hierarchical localization, and structured repository representations.

There is **not yet direct empirical evidence** establishing the stronger causal claim:

> Explicit ownership of consequential domain state and legal transitions produces stronger semantic module boundaries that reduce total tokens and dollars per correct agent task.

That stronger claim is plausible and now experimentally well motivated, but remains a hypothesis.

The important synthesis is that state-constrained architecture could contribute something that existing repository graphs generally do not: a **higher-level semantic dependency graph derived from domain authority, legal transitions, capabilities, obligations, claims, and effects**, rather than primarily from source-level references/imports/dataflow.

If that graph reliably identifies a smaller sufficient context than code-level retrieval, it could create three simultaneous effects:

1. **Context compression** — fewer irrelevant implementation tokens.
2. **Action-space reduction** — fewer plausible but illegal edits/actions.
3. **Localization improvement** — fewer repository-search and repair iterations.

The economics are likely to be dominated by the second and third effects, and potentially by **smaller-model substitution**, rather than raw input-token reduction alone.

---

## 2. Research status labels

This report uses four evidence labels:

- **MEASURED — EXTERNAL:** directly measured in published work.
- **SOURCED:** supported by primary literature or official provider documentation.
- **INFERENCE:** a conclusion connecting sourced evidence to the proposed architecture.
- **HYPOTHESIS:** requires direct testing.

No percentage in this report is presented as a measured benefit of state-constrained architecture unless such an experiment has actually been run.

---

## 3. State of existing research

### 3.1 Classical modularity

Parnas's 1972 information-hiding work established a critical principle: good decomposition hides design decisions rather than simply mirroring procedural steps. The purpose is to reduce the amount of knowledge that must cross module boundaries and localize the effect of change.

**SOURCED:** D. L. Parnas, *On the Criteria To Be Used in Decomposing Systems into Modules*, Communications of the ACM, 1972.

This supports the architectural half of the theory: a module is valuable when a change inside it does not require consumers to understand the hidden decision.

It does **not** by itself establish that an LLM consumes fewer tokens.

### 3.2 Typestate and legal-operation modeling

Typestate research formalizes the fact that available operations depend on an object's state. Later typestate-oriented programming work makes legal operation availability an explicit property of the programming model.

**SOURCED:** Strom & Yemini typestate line of work; Aldrich et al. typestate-oriented programming; subsequent work on typestate and borrowing.

This supports the proposition that state-dependent legality can be encoded mechanically rather than rediscovered by an agent.

It does **not** show an inference-cost reduction.

### 3.3 Repository retrieval and structural context

Current AI software-engineering research provides much more direct evidence for the context side of the hypothesis.

#### GraphCoder

GraphCoder uses a code-context graph containing control-flow and data/control dependence to retrieve repository-specific context. It reported higher code and identifier exact-match performance than retrieval baselines.

**MEASURED — EXTERNAL:** GraphCoder, arXiv:2406.07003.

#### DraCo

DraCo constructs a repository-specific context graph from extended dataflow analysis and retrieves relevant background knowledge for completion. It reported average improvements of 3.43 percentage points in exact match and 3.27 points in identifier F1 over the state-of-the-art comparison in its evaluation.

**MEASURED — EXTERNAL:** DraCo, arXiv:2405.19782.

#### STALL+

STALL+ studies static-analysis integration in repository-level code completion. It reports that file-level dependency information in the prompting phase is particularly effective and that static analysis and RAG can be complementary and cost-effective.

**MEASURED — EXTERNAL:** STALL+, arXiv:2406.10018.

A notable result is that static-analysis value differs between Java and Python because static dependency analysis is more reliable in the statically structured setting. This is directly relevant to the separate hypothesis that stronger language semantics may improve agent context selection.

#### RepoGraph

RepoGraph builds repository-wide structural graphs and adds graph-derived context to existing software-engineering systems.

Published results include:

- average relative performance improvement reported across integrated systems: **32.8%**
- Agentless baseline: **27.33% resolve**, **42,376 tokens**, **$0.34**
- Agentless + RepoGraph: **29.67% resolve**, **47,323 tokens**, **$0.39**
- SWE-agent baseline: **18.33% resolve**, **245,008 tokens**, **$2.51**
- SWE-agent + RepoGraph: **20.33% resolve**, **262,512 tokens**, **$2.69**

This is extremely useful counterevidence to a simplistic "structure always saves tokens" claim. RepoGraph sometimes improved correctness while **increasing** tokens and cost.

RepoGraph also tested graph representation size:

- 1-hop flattened: ~**2,310.7 tokens**
- 1-hop summarized: ~**717.5 tokens**
- 2-hop flattened: ~**10,505.3 tokens**
- 2-hop summarized: ~**1,229.2 tokens**

The 2-hop flattened version performed worse than the 1-hop variants. More structural information was not automatically better.

**MEASURED — EXTERNAL:** RepoGraph, arXiv:2410.14684.

#### Agentless

Agentless uses a deliberately simple three-stage pipeline: localization, repair, validation. On SWE-bench Lite it reported:

- **32.0%** resolved
- **78,166** average tokens
- **$0.70** average historical inference cost

Compared with SWE-agent results reported in the same paper, the simple localized pipeline used dramatically fewer tokens while remaining competitive or better on that benchmark.

**MEASURED — EXTERNAL:** Agentless, arXiv:2407.01489.

This supports a general lesson: reducing autonomous exploration and making localization explicit can materially alter cost per task.

#### SeeRepo / "LLM Agents Can See Code Repositories"

A 2026 study tested structural repository visualization as supplementary context on SWE-bench Verified. For GPT-5-mini, the reported comparison was:

| Setting | Pass@1 | Input tokens | Output tokens | Cost |
|---|---:|---:|---:|---:|
| Text baseline | 55.0% | 193,157 | 8,188 | $0.031 |
| + graph view | 55.4% | 144,403 | 6,958 | $0.023 |

That is roughly:

- **25% fewer input tokens**
- **15% fewer output tokens**
- **26% lower reported cost**
- no observed accuracy loss in that configuration

The authors attribute much of the gain to better localization and fewer redundant navigation steps.

Across evaluated models, cost changes varied; one configuration reduced cost substantially with a small accuracy decline, emphasizing the need for cost-per-correct-completion rather than token count alone.

**MEASURED — EXTERNAL:** *LLM Agents Can See Code Repositories*, arXiv:2606.14061.

### 3.4 What the literature establishes

The literature supports:

1. Repository structure is useful to LLMs.
2. Retrieval quality matters more than raw repository size.
3. Explicit localization can shorten trajectories.
4. Static dependencies can improve completion.
5. Structured context can reduce tokens in some systems.
6. More context can hurt.
7. Representation format materially changes token cost.
8. Tool/agent complexity can add cost without proportional correctness gains.

### 3.5 What the literature does not establish

The literature does not yet establish:

1. Domain state ownership is the best semantic partition.
2. State-transition contracts produce smaller MSSC than code graphs.
3. Capabilities/obligations reduce repair loops.
4. Semantic module boundaries remain stable under repeated AI edits.
5. State-constrained systems have lower total lifecycle cost.
6. They enable reliable substitution of a smaller model.

Those are the key research gaps.

---

## 4. Theory connecting state ownership to agent cost

The proposed causal chain should be tested as separate links:

### Link A — explicit state ownership -> stronger semantic boundaries

If exactly one module owns an authoritative state family, other code must observe, request transitions, or consume events rather than mutate it arbitrarily.

**INFERENCE:** this should reduce hidden write coupling.

### Link B — stronger boundaries -> smaller dependency closure

If consequential dependencies are declared as transition guards, capabilities, obligations, claims, events, and effects, the system can derive a semantic dependency graph.

**HYPOTHESIS:** the graph may be smaller and more task-relevant than repository-wide lexical or import retrieval.

### Link C — smaller dependency closure -> smaller MSSC

If an agent receives the owned module plus declared consequential dependencies, it may not need unrelated implementation.

**HYPOTHESIS.**

### Link D — smaller MSSC -> fewer tokens/tool calls

This relationship has adjacent empirical support from repository-localization research, but must be measured for the proposed architecture.

### Link E — smaller action space -> fewer failures

If illegal states and transitions cannot be constructed, some classes of hallucinated edits become compiler/validator failures instead of silently valid code.

**HYPOTHESIS with strong programming-language plausibility; not yet measured economically.**

### Link F — fewer failures -> lower cost per correct completion

Mathematically true if the added validation/retrieval overhead is smaller than the avoided retry cost.

Whether that condition holds is empirical.

---

## 5. Definition of semantic module

A useful working definition:

> A **semantic module** is the smallest architectural unit that owns one or more authoritative state families and controls consequential changes to them through declared transitions, while exposing only the claims, events, capabilities, obligations, and effect contracts required by other modules.

A semantic module contains:

- authoritative state families
- legal state cases
- legal transitions
- transition guards/invariants
- transition inputs
- evidence requirements
- capabilities
- obligations
- emitted trusted events
- effect ports
- public claims
- module version/hash
- declared semantic dependencies
- mapping to implementation locations

A semantic module should not expose:

- arbitrary status mutation
- raw table mutation as an inter-module API
- private SDK details
- private persistence mechanics
- irrelevant internal helper functions

This definition deliberately separates **semantic ownership** from deployment. A semantic module may live inside a modular monolith.

---

## 6. Minimum Sufficient Semantic Context (MSSC)

### Definition

> **MSSC** is the smallest mechanically or empirically identified context set from which an agent can complete a specific task while satisfying the required semantic correctness criteria.

MSSC is task-dependent.

Represent it as:

`MSSC(T) = {semantic nodes + required implementation + direct evidence needed to satisfy task T}`

Measure:

- uncached input tokens
- cached input tokens
- bytes
- files
- implementation files
- contracts
- semantic graph nodes
- modules
- tool calls required to obtain the context

### Important distinction

The smallest successful context from one run is not necessarily the true MSSC. A rigorous estimate requires repeated ablation:

1. find a successful context
2. remove one context element
3. repeat task
4. test correctness
5. continue until additional removals materially reduce success

This converts MSSC from an architectural assertion into an experimental variable.

---

## 7. Semantic dependency/context-slicing model

Model the semantic system as a typed directed graph.

### Node types

- Module
- StateFamily
- StateCase
- Transition
- Guard
- Capability
- Obligation
- Claim
- Event
- Policy
- Effect
- EvidenceType
- ImplementationUnit

### Edge types

- owns
- exports
- requests
- requires
- authorizes
- observes
- emits
- satisfies
- blocks
- triggers
- affects
- implementedBy
- dependsOn

### Initial slice algorithm

For task `T`:

1. map task terms to candidate semantic subjects
2. identify owning module(s)
3. include affected state families/transitions
4. include guards/capabilities/obligations on those transitions
5. include exported contracts changed by the task
6. include consumers of changed exported semantics
7. include implementation units for selected semantic nodes
8. exclude implementation behind unchanged neighboring contracts
9. execute
10. lazily expand only on:
   - compiler diagnostics
   - failed tests
   - unresolved declared dependencies
   - explicit tool request by the agent

This is more conservative than "load only the module." It intentionally includes consequential consumers when a public contract changes.

---

## 8. Metrics

### Context Size Ratio

`CSR = semantic-context tokens / conventional-context tokens`

### Context Reduction

`CR = 1 - CSR`

### Implementation Exposure Ratio

`IER = unrelated implementation tokens supplied / total implementation tokens supplied`

### Semantic Dependency Fan-Out

Number of directly affected semantic modules.

### Semantic Transitive Fan-Out

Number of modules in the consequential dependency closure.

### Module Escape Rate

Percentage of tasks initially classified local that require an additional module.

### Lazy Expansion Count

Number of additional semantic slices retrieved after first execution.

### Tokens Per Correct Completion

`TPC = total tokens across all attempts / correct completions`

### Dollars Per Correct Completion

`DPC = total measured execution cost / correct completions`

### Semantic Correctness

A completion is correct only when it satisfies:

- functional tests
- semantic invariants
- transition legality
- declared obligations
- relevant integration tests
- no forbidden direct state mutation

Compilation alone is insufficient.

---

## 9. Experimental architecture

Construct equivalent commerce domains in two implementations.

### A. Conventional competent implementation

Use normal commercial patterns, not a straw man:

- services
- status enums
- repositories
- validation
- tests
- ORM
- events where natural
- ordinary module/package boundaries

Allow realistic distributed rule placement.

### B. State-constrained semantic implementation

Same business behavior, but:

- single owner per authoritative state family
- typed/explicit legal transitions
- protected write paths
- generated semantic contracts
- declared cross-module claims/events
- explicit capabilities
- explicit obligations
- semantic dependency graph
- implementation mapping

### Recommended language matrix

Start with C# and F# or C# alone with two architectural styles, because using a completely different language risks confounding architecture with language.

Then add TypeScript as a secondary experiment to test whether weaker static semantics increase escape rate and retrieval burden.

Do not begin by comparing F# against JavaScript and attribute all differences to state ownership.

---

## 10. Required task suite

Use at least these task classes:

1. local transition addition
2. local state addition
3. internal adapter refactor
4. exported contract change
5. cross-module policy change
6. state split
7. post-event blocking rule
8. unknown external effect
9. persistence replacement
10. cross-cutting reporting requirement

Include deliberately difficult tasks in which semantic boundaries are expected to provide little advantage.

---

## 11. Context strategies to compare

For the same architecture and task:

### Strategy A — broad repository agent

Normal repository search/navigation.

### Strategy B — lexical/search retrieval

Text/symbol search.

### Strategy C — static dependency retrieval

Imports/calls/type relationships.

### Strategy D — semantic dependency slice

State/transition/capability/obligation graph.

### Strategy E — semantic slice + lazy expansion

Minimum initial semantic context; additional retrieval only when required.

The key comparison is not merely conventional architecture vs state architecture. It is a factorial design:

`architecture × retrieval strategy × model`

That allows separation of:

- architecture effect
- retrieval effect
- interaction effect

---

## 12. Tokenizer experiment design

The research specification correctly requires actual model tokenizers.

### This execution

An attempt was made to install an OpenAI-compatible tokenizer locally. The execution environment had no network package access and no compatible tokenizer package already installed.

Therefore **no tokenizer-derived measurements are being reported here**. Character or word-count proxies would violate the requested research standard.

### Required implementation

For each provider/model:

1. use provider tokenizer/token-count API or officially supported tokenizer
2. store tokenizer/model version
3. tokenize:
   - implementation
   - tests
   - prose docs
   - verbose semantic JSON
   - compact semantic IR
   - generated agent projection
4. store raw count and content hash
5. rerun when provider tokenizer changes

This matters because Anthropic's current pricing documentation states that Claude 4.7+ uses a newer tokenizer that can produce approximately 30% more tokens for the same text, depending on workload.

---

## 13. Semantic representation experiment

For the same rule:

> Ship only if Customer is Verified, Order is Approved, Payment is Captured, and Shipment is Ready.

Compare:

### Source form
Full implementation + guard calls + associated types.

### Test form
Tests encoding all valid/invalid combinations.

### Prose form
Natural-language rules.

### Verbose semantic IR
Structured identifiers, provenance, versions, dependencies.

### Compact agent projection

Example:

```text
Shipment.Ship
requires:
  Customer=Verified
  Order=Approved
  Payment=Captured
  Shipment=Ready
effects:
  Shipment -> Shipped
```

The winning representation is not necessarily the smallest token count. It must maximize:

`correct task completions / total token-and-tool cost`

---

## 14. Cost model

For one attempt:

`AttemptCost = U*Pu + C*Pc + W*Pw + O*Po + ToolCost + ComputeCost`

Where:

- `U` = uncached input tokens
- `C` = cached input tokens
- `W` = cache-write tokens where provider charges separately
- `O` = output/reasoning-billed tokens
- `Pu/Pc/Pw/Po` = prices per token

For repeated attempts:

`TaskCost = sum(AttemptCost_i) + retrieval + CI + human-intervention cost`

### Cost per correct completion

For a population:

`DPC = total task execution cost / number of semantically correct completions`

This should be the primary economic metric.

---

## 15. Current verified model-price snapshot

Prices below are provider-published API prices as of 2026-08-14 and should be treated as time-stamped inputs, not constants.

### OpenAI standard short-context pricing

| Model | Input / 1M | Cached input / 1M | Cache write / 1M | Output / 1M |
|---|---:|---:|---:|---:|
| GPT-5.6 Sol | $5.00 | $0.50 | $6.25 | $30.00 |
| GPT-5.6 Terra | $2.00 | $0.20 | $2.50 | $12.00 |
| GPT-5.6 Luna | $0.20 | $0.02 | $0.25 | $1.20 |

Long-context pricing is higher.

### Anthropic

| Model | Input / 1M | Cache hit / 1M | Output / 1M |
|---|---:|---:|---:|
| Claude Opus 5 | $5.00 | $0.50 | $25.00 |
| Claude Sonnet 5 | $2.00 | $0.20 | $10.00 |
| Claude Haiku 4.5 | $1.00 | $0.10 | $5.00 |

Cache-write prices differ from cache-hit prices and must be counted explicitly.

---

## 16. Adjacent empirical cost sensitivity

This is **not a state-constrained architecture result**.

Use the measured GPT-5-mini token counts from the 2026 SeeRepo experiment only to estimate the order of magnitude of structural-context savings under today's price schedules.

Measured external token counts:

- baseline: 193,157 input; 8,188 output
- graph-assisted: 144,403 input; 6,958 output

If those exact token volumes were priced today at the listed uncached rates:

| Model price schedule | Baseline | Graph-assisted | Difference |
|---|---:|---:|---:|
| GPT-5.6 Sol | ~$1.211 | ~$0.931 | ~$0.281 |
| GPT-5.6 Terra | ~$0.485 | ~$0.372 | ~$0.112 |
| GPT-5.6 Luna | ~$0.0485 | ~$0.0372 | ~$0.0112 |
| Claude Sonnet 5 | ~$0.468 | ~$0.358 | ~$0.110 |
| Claude Haiku 4.5 | ~$0.234 | ~$0.179 | ~$0.055 |

The percent reduction is about 23–24% under these simplified price substitutions.

Again: this table demonstrates economic sensitivity to token volume. It does **not** demonstrate that state-modular architecture will achieve the same reduction.

### Scale implication

At 10,000 tasks/day, a $0.11 reduction per task is roughly $1,100/day before retries, tool cost, caching, CI, or human cost.

But at GPT-5.6 Luna pricing, the same token reduction is only around one cent per task.

Therefore the architecture's financial case cannot rest on input-token compression alone as model prices fall.

---

## 17. The more important economic hypothesis: model substitution

The current OpenAI short-context price spread is large:

- GPT-5.6 Sol input/output: $5 / $30 per MTok
- GPT-5.6 Luna input/output: $0.20 / $1.20 per MTok

If a constrained semantic representation allows a cheaper model to achieve the same semantic correctness, the model substitution effect could be much larger than shaving 20–30% from context on the same model.

This should become a first-class experiment.

Required comparison:

1. frontier model + conventional retrieval
2. frontier model + semantic slice
3. medium model + semantic slice
4. small model + semantic slice

The strongest economically meaningful result would be:

> smaller model + semantic constraints ≥ larger model + conventional context in semantic correctness, at materially lower DPC.

---

## 18. Caching implications

State/module contracts are unusually cache-friendly if they are:

- stable
- deterministically generated
- ordered consistently
- versioned
- placed in stable prompt prefixes

Current provider pricing makes cache hits roughly one tenth of ordinary input price for several models.

This means two architectural choices interact:

1. reduce how much context is needed
2. make the remaining repeated context stable enough to cache

However cache writes are not free. The experiment must count:

- cache-write cost
- cache-read cost
- cache lifetime
- invalidation frequency
- number of reuses before invalidation

A frequently changing semantic contract may save fewer dollars than expected.

---

## 19. Break-even model

Let:

- `E0` = upfront engineering cost of semantic architecture/tooling
- `S` = measured savings per correct agent task
- `N` = correct agent tasks per month attributable to the system

Simple break-even:

`months = E0 / (S * N)`

This is intentionally incomplete.

A better model includes:

`NetMonthlyBenefit = inference savings + retry savings + defect savings + human-review savings - semantic-tooling operations`

Then:

`BreakEvenMonths = E0 / NetMonthlyBenefit`

No break-even claim should be made until the task experiments yield DPC measurements.

---

## 20. Key counterevidence / failure modes

### 20.1 Structural metadata can increase tokens

RepoGraph provides direct evidence: adding graph context increased average tokens in some successful integrations.

**Consequence:** semantic contracts must be measured as part of context, not treated as free metadata.

### 20.2 Larger dependency closure can hurt performance

RepoGraph's flattened 2-hop context was much larger and performed worse than smaller variants.

**Consequence:** transitive closure must be relevance-aware; "all dependencies" is not an acceptable algorithm.

### 20.3 Summarization can lose important information

RepoGraph found that summarization helped larger graph contexts but slightly hurt a compact 1-hop context.

**Consequence:** generated agent views should be deterministic projections where possible, not free-form LLM summaries.

### 20.4 Most real changes may cross semantic boundaries

If module escape rate is high, savings collapse.

**Falsification target:** explicitly measure task-locality distribution on real maintenance histories.

### 20.5 Language semantics may confound architecture

Static-analysis work suggests structural retrieval behaves differently in Java and Python.

**Consequence:** architecture and language must be varied independently.

### 20.6 Cheap models weaken pure token economics

As per-token prices decline, architectural migration justified solely by input savings may not break even.

**Consequence:** correctness, model substitution, reduced tool calls, and maintenance benefits are necessary parts of the business case.

### 20.7 Output/reasoning and tools may dominate

If most cost comes from repeated reasoning, CI, web/tool calls, or large outputs, input compression has limited effect.

### 20.8 Semantic tooling itself can decay

A semantic IR that is hand-maintained can become another stale documentation layer.

**Requirement:** the strongest design generates the agent contract from executable/validated architecture rather than requiring duplicate truth.

---

## 21. Falsification criteria

Before full experiment execution, reject or substantially weaken the **economic** hypothesis if one or more of these persist across realistic task distributions:

1. semantic context is not smaller after counting all contracts/IR
2. DPC is not lower
3. module escape rate is high enough that lazy expansion approximates broad retrieval
4. semantically constrained agents need more repair cycles
5. semantic contract maintenance adds more engineering cost than agent savings
6. smaller models do not benefit disproportionately
7. ordinary static dependency retrieval performs equally well at lower architectural cost
8. longitudinal changes cause semantic dependency fan-out to grow at the same rate as the conventional system

No arbitrary numeric rejection threshold should be chosen until pilot variance is measured.

---

## 22. Strong-result criteria

A strong result requires all of the following:

- repeated realistic repository tasks
- matched business behavior
- multiple task types
- multiple runs
- statistically meaningful correctness comparison
- measured total input/output tokens
- measured tool calls
- measured repair loops
- semantic metadata fully charged to the constrained architecture
- no reduction in semantic correctness
- lower DPC
- evidence across local and cross-module tasks
- longitudinal persistence

An especially strong result would also show smaller-model substitution.

---

## 23. Recommended pilot

### Repository

Create a medium commerce system with:

- Customer
- Order
- Payment
- Risk
- Shipment
- Refund
- Notification

Target 15–30 KLOC initially—large enough to force cross-file navigation without making experiment iteration expensive.

### Variants

- conventional competent modular code
- state-constrained semantic code

### First 12 tasks

Use 4 local, 4 boundary-changing, 4 deliberately cross-cutting tasks.

### Runs

For each:

- 3–5 repetitions per architecture/retrieval/model cell for pilot
- fresh sessions
- randomized order
- same tests
- same tool rights
- same task wording

### Models

Use one frontier, one mid-tier, one inexpensive model.

### Primary outcomes

1. semantic correctness
2. DPC
3. input tokens
4. total tokens
5. tool calls
6. repository reads
7. module escape rate
8. repair cycles

### Secondary outcomes

- elapsed latency
- files changed
- integration defects
- direct forbidden mutation attempts
- cache reuse

---

## 24. Research queue

### Priority 1 — highest falsification and economic value

1. **Does semantic dependency slicing beat ordinary static dependency slicing?**
   - falsification value: very high
   - economic importance: very high
   - feasibility: high

2. **What is the module escape rate on real commercial maintenance tasks?**
   - falsification value: very high
   - economic importance: very high
   - feasibility: medium

3. **Can a smaller model with a semantic slice match a larger model with conventional retrieval?**
   - falsification value: high
   - economic importance: extremely high
   - feasibility: high

4. **Does state ownership reduce repair loops rather than merely input context?**
   - falsification value: high
   - economic importance: very high
   - feasibility: high

### Priority 2

5. Which semantic contract representation minimizes DPC rather than tokens alone?
6. How much semantic metadata can be deterministically generated from types/state definitions?
7. How often do capability and obligation nodes add context that ordinary code graphs miss?
8. How does C#/F# compare with TypeScript under the same semantic architecture?
9. How cache-stable are module contracts under normal maintenance?
10. Does semantic graph density grow more slowly over 50 sequential AI changes?

### Priority 3

11. Can semantic boundaries improve parallel-agent independence?
12. What is the effect of shared-database write ownership?
13. Does a modular monolith outperform weakly bounded microservices for agent context?
14. Can historical Git changes be used to estimate "true" semantic locality before building the full benchmark?

---

## 25. Most important next experiment

The most valuable next step is **not** to build the entire proposed research program at once.

Run a discriminating 2×2 pilot:

### Architecture
- conventional
- state-constrained

### Retrieval
- ordinary static/code-graph slice
- semantic state/transition slice

Use the same model.

Why this experiment matters:

If the semantic architecture does not outperform ordinary dependency-aware retrieval, then most of the token-saving thesis belongs to better retrieval/context engineering—not to state ownership.

If it does outperform ordinary retrieval, then the architecture is contributing information that code-level graphs cannot cheaply reconstruct.

That is the causal question the research program must answer.

---

## 26. Final verdict

### What is empirically supported

**Supported:**
- repository localization matters
- graph/dependency information improves many repository-level AI tasks
- structured context can reduce navigation and tokens
- too much context can reduce performance
- representation size matters
- simple constrained workflows can be cheaper than unconstrained agent exploration
- static dependency information can improve repository-level code generation
- structural context has produced measured cost reductions in recent agent experiments

### What is strongly plausible

**Inference:**
- explicit state ownership can provide a semantic dependency graph richer than imports/calls
- legal transitions can reduce the set of plausible agent actions
- deterministic semantic contracts may be more cacheable and less drift-prone than prose summaries

### What remains unproven

**Hypothesis:**
- state-constrained modularity reduces MSSC
- it lowers total tokens on real maintenance tasks
- it lowers cost per correct completion
- it retains the advantage on cross-module changes
- it remains economical after architecture/tooling cost
- it enables smaller-model substitution

### Bottom line

The hypothesis deserves serious experimentation.

The strongest evidence discovered in this execution does **not** justify saying:

> "State machines make AI agents cheaper."

It does justify saying:

> "Current software-agent research shows that structured, selective representations of repository dependencies can reduce exploration and sometimes substantially reduce token/cost while maintaining correctness. Explicit state ownership and transition contracts are a credible candidate for producing a more semantic and mechanically reliable version of that context structure, but their incremental economic value over existing code/dependency retrieval still needs to be measured."

That is a stronger research position because it exposes the real competitor:

> **state-derived semantic slicing vs ordinary dependency-aware retrieval**

—not state architecture vs dumping an entire repository into a model.

If state-derived slicing wins that comparison, the economic thesis becomes much more credible.

---

## Primary sources consulted

1. D. L. Parnas. *On the Criteria To Be Used in Decomposing Systems into Modules.* Communications of the ACM, 1972.
2. Liu et al. *GraphCoder: Enhancing Repository-Level Code Completion via Code Context Graph-based Retrieval and Language Model.* arXiv:2406.07003.
3. Cheng et al. *Dataflow-Guided Retrieval Augmentation for Repository-Level Code Completion (DraCo).* arXiv:2405.19782.
4. Liu et al. *STALL+: Boosting LLM-based Repository-level Code Completion with Static Analysis.* arXiv:2406.10018.
5. Ouyang et al. *RepoGraph: Enhancing AI Software Engineering with Repository-level Code Graph.* arXiv:2410.14684.
6. Xia et al. *Agentless: Demystifying LLM-based Software Engineering Agents.* arXiv:2407.01489.
7. Yang et al. *SWE-agent: Agent-Computer Interfaces Enable Automated Software Engineering.* arXiv:2405.15793.
8. *LLM Agents Can See Code Repositories.* arXiv:2606.14061.
9. OpenAI. *API Pricing.* Accessed 2026-08-14.
10. Anthropic. *Claude Platform Pricing.* Accessed 2026-08-14.
11. Google. *Gemini Developer API Pricing.* Accessed 2026-08-14.
