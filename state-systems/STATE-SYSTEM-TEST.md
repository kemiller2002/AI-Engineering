# STATE-SYSTEM-TEST

## Purpose

This is an agent-executable architectural test for state-system applications.

Use it to evaluate a proposed design, an existing codebase, or a partially implemented feature against the project's state-system architecture.

This test is adversarial.

Do not merely describe the state model. Attempt to prove that it is coherent, complete, reachable, deterministic where required, non-stuck, safe, and explicit enough that a future human or AI agent does not need to reconstruct business semantics from implementation accidents.

The test should be used together with the canonical "Four Layers of State in a State-System Application" guide when available.

The four classification layers are:

1. Domain / Entity State
2. Workflow / Process State
3. Effect / External Operation State
4. Presentation / Interaction State

These are classification dimensions, not necessarily four separate state machines.

Domain, workflow, and effect state may form orthogonal semantic regions of a complete system configuration. Presentation state normally remains outside the semantic core unless it changes application meaning or legal behavior.

---

# 1. Operating Rules

You are an architectural test agent.

Your job is to FIND defects, ambiguity, hidden state, missing transitions, unsafe paths, and unnecessary complexity.

Do not optimize for agreeing with the implementation.

Do not assume code that exists is intentional.

Do not assume tests prove the model is correct.

Do not infer business meaning from implementation when an explicit semantic artifact should exist.

Distinguish carefully between:

- observed implementation behavior;
- documented intended behavior;
- inferred behavior;
- unknown behavior.

Label inference as inference.

If requirements, documentation, code, diagrams, and tests disagree, record the contradiction.

Do not silently choose one as authoritative unless repository instructions establish precedence.

Prefer evidence from:

1. explicit domain/state specifications;
2. transition definitions;
3. invariants and guards;
4. executable domain types;
5. tests;
6. application code;
7. UI behavior;
8. comments/naming;
9. inference.

Adjust this ordering if the repository explicitly defines another source of truth.

---

# 2. Required Repository Discovery

Before testing the state system:

1. Identify repository root.
2. Read repository instructions.
3. Read README/architecture/bootstrap documents.
4. Locate state-system guidance.
5. Locate domain models.
6. Locate workflow definitions.
7. Locate transition/command handlers.
8. Locate effects.
9. Locate projections.
10. Locate capabilities.
11. Locate obligations/evidence structures.
12. Locate relevant tests.
13. Locate diagrams and execution/source maps.
14. Run existing validation/tests when safe and practical.
15. Record the baseline.

Do not perform repository-wide exploration indefinitely.

Once the relevant semantic boundary is identified, constrain inspection to the files required to test it.

---

# 3. Define the System Under Test

Before analysis, state explicitly:

System / feature:
Boundary:
Authoritative state owner:
External systems:
Primary actors:
Initial entry point:
Expected successful outcome(s):
Expected terminal outcome(s):
Files inspected:
Tests inspected:
Documentation inspected:
Known uncertainties:

If the system boundary cannot be identified, record that as an architectural finding.

---

# 4. Inventory All State

Enumerate every state-bearing concept discovered.

Classify each as:

DOMAIN STATE
WORKFLOW STATE
EFFECT STATE
PRESENTATION STATE
ORDINARY DATA
DERIVED DATA
CAPABILITY
OBLIGATION
EVIDENCE
AUTHORITY / POLICY
UNKNOWN / AMBIGUOUS

For each proposed explicit state, answer:

1. What does this state mean?
2. What makes it observably different from neighboring states?
3. Which legal actions differ?
4. Which invariants differ?
5. Which transition rules differ?
6. Which authority requirements differ?
7. Which evidence requirements differ?
8. Which safety behavior differs?

If none differ, challenge whether the state should exist.

Required output:

STATE INVENTORY

Name:
Classification:
Owner:
Meaning:
Legal actions:
Invariants:
Evidence:
Authority:
Why explicit state is justified:
Confidence:
Source:

---

# 5. Test Domain / Entity State

For every domain entity:

Identify:

- lifecycle states;
- initial state;
- terminal states;
- absorbing/irreversible states;
- legal transitions;
- illegal transitions;
- invariants by state;
- commands available by state.

Ask:

Does this state describe what the domain object IS?

Attempt to find:

- lifecycle meaning represented only by booleans;
- lifecycle meaning represented by strings;
- null combinations encoding hidden state;
- duplicated state fields;
- impossible combinations;
- states differing only by irrelevant data;
- technical/process states incorrectly embedded in the entity.

Flag patterns such as:

isSubmitted
isApproved
isRejected

when combinations can create invalid conditions.

Attempt to construct invalid but type-representable entities.

Example:

submitted = true
approved = true
rejected = true

If an invalid semantic configuration can be constructed through public/domain APIs, record it.

---

# 6. Test Workflow / Process State

For every meaningful multi-step process:

Identify:

- initial workflow state;
- intermediate semantic states;
- terminal states;
- cancellation/abandonment paths;
- commands;
- events;
- guards;
- effects;
- human intervention points.

Ask:

Does each workflow state represent meaningful process progression?

Challenge technical states such as:

Reading
Parsing
Validating
Saving
Rendering

These are not automatically workflow states.

Determine whether they are instead:

- implementation activity;
- effect state;
- derived status;
- diagnostic information.

A workflow state is justified when it changes what can meaningfully happen next.

Attempt to find workflows that can enter a state but cannot progress or terminate.

---

# 7. Test Effect / External Operation State

Inventory all external effects:

- HTTP;
- database;
- filesystem;
- browser storage;
- payments;
- email;
- queues;
- LLM calls;
- GitHub;
- authentication;
- external services;
- device APIs;
- other non-deterministic boundaries.

For each effect determine whether the system distinguishes:

NOT STARTED / IDLE
PENDING
SUCCEEDED
FAILED
OUTCOME UNKNOWN

Not every effect requires all five.

However, explicitly test whether OutcomeUnknown is possible.

Ask:

Could the external operation have succeeded while confirmation was lost?

If yes, treating the result as ordinary Failed is potentially unsafe.

For every OutcomeUnknown condition identify:

- safe next actions;
- unsafe next actions;
- reconciliation mechanism;
- obligation created;
- retry policy;
- idempotency mechanism if relevant.

Flag any OutcomeUnknown with no reconciliation path.

---

# 8. Test Presentation / Interaction State

Inventory presentation state.

Examples:

- expanded panel;
- focus;
- hover;
- selected tab;
- scroll position;
- animation;
- temporary popover;
- open date picker.

Verify that presentation-only state does not leak into authoritative domain semantics.

Then inspect apparently presentational values such as:

selectedPatient
selectedAccount
activeProject
selectedDateRange

Ask:

Does changing this value alter:

- which entity commands operate on;
- which data is authoritative;
- which actions are legal;
- which effects occur;
- which workflow is active?

If yes, it may actually be semantic application state.

Flag semantic state hidden inside UI state.

---

# 9. Commands vs Events Test

Create separate inventories.

COMMANDS represent intent:

Submit
Approve
Correct
Retry
Cancel

EVENTS represent facts:

SaveSucceeded
SaveFailed
PaymentConfirmed
TimeoutOccurred
FileSelected

For each input determine whether it is a command or event.

Flag ambiguous constructs where intent and fact are conflated.

Commands may be rejected.

Events must be interpreted as facts that occurred.

Test whether external effect results enter the system as events/results rather than pretending to be user commands.

---

# 10. Transition Table Test

Construct a transition table for every semantic state machine or region.

Required columns:

Current State
Input
Input Type (Command/Event)
Guard
Legal?
Next State
Domain Changes
Effects Emitted
Obligations Created/Resolved
Capabilities Changed
Evidence Required
Failure Result

For every accepted command/event, determine behavior in every relevant source state.

Each State × Input combination should resolve explicitly to:

LEGAL TRANSITION
EXPLICIT REJECTION
JUSTIFIED NO-OP

Flag:

- undefined fallthrough;
- silently ignored commands;
- missing handlers;
- behavior dependent on hidden mutable state;
- multiple possible results without explicit cause.

---

# 11. Determinism Test

For each semantic transition ask:

Given the same:

current semantic configuration
+ command/event
+ explicit inputs
+ explicit evidence

does the kernel/domain produce the same semantic result?

If not, identify the source of nondeterminism.

Distinguish:

INTERNAL NONDETERMINISM
from
EXTERNAL UNCERTAINTY

External uncertainty is acceptable when modeled explicitly.

Internal semantic nondeterminism should normally be treated as a defect unless deliberately specified.

Principle:

The semantic system should remain deterministic even when the outside world is not.

---

# 12. Run-to-Completion Test

Determine whether semantic transitions are atomic from the perspective of other semantic commands/events.

Expected conceptual sequence:

receive input
→ evaluate guards
→ perform semantic transition
→ preserve invariants
→ derive capabilities/obligations
→ emit effects/projection
→ transition completes

Another semantic input should not observe an invalid half-transitioned state.

Attempt to identify:

- reentrant handlers;
- asynchronous mutation during transitions;
- partially committed domain changes;
- interleaving commands;
- effect callbacks mutating state outside the transition mechanism.

Record any violation.

---

# 13. Initial-State Test

Every workflow/state region must have a defined initialization rule.

Identify:

- initial state;
- required initial data;
- hydration rules;
- validation of persisted state;
- behavior when persisted state is invalid.

Flag state machines where the starting condition is implicit.

---

# 14. Terminal and Absorbing-State Test

Identify intentional terminal states.

Examples:

Completed
Cancelled
Archived

Determine whether each is:

TERMINAL
ABSORBING
REOPENABLE

If absorbing, verify that no outgoing semantic transition exists unless explicitly intended.

Distinguish intentional terminal states from accidental dead states.

---

# 15. Reachability Test

For every non-initial state ask:

Can this state be reached from a valid initial configuration through legal transitions?

Produce a path where possible.

Example:

Draft
→ Submit
→ Submitted
→ Approve
→ Approved

Classify every state:

REACHABLE
UNREACHABLE
UNKNOWN

Unreachable states are findings unless deliberately reserved and documented.

Also test important desired outcomes:

Can every intended terminal state actually be reached?

---

# 16. Dead-State / Dead-End Test

For every reachable nonterminal state ask:

Is there at least one legal path toward resolution, progress, cancellation, reconciliation, or another intended terminal state?

Classify:

PROGRESSABLE
INTENTIONAL TERMINAL
ACCIDENTAL DEAD STATE
UNKNOWN

Pay special attention to:

Pending
Failed
OutcomeUnknown
NeedsReview
AwaitingEvidence
PartiallyCompleted

A valid state with no safe next action is still an architectural defect unless deliberately terminal.

---

# 17. Path-Constraint Test

Some rules concern paths rather than individual transitions.

Identify requirements such as:

Approved must only be reachable through Submitted.

Paid must only be reachable after Approval.

Correction cannot bypass Recorded.

Reconciliation must occur before retry after OutcomeUnknown.

Attempt to find a legal-looking transition sequence that violates required history/path constraints.

Record every path-level invariant.

---

# 18. Orthogonal-State Test

Identify state dimensions that vary independently.

Typical examples:

Domain lifecycle
Workflow progression
Persistence/effect status

Do not automatically multiply them into one flat state machine.

Prefer:

DomainState = Recorded
WorkflowState = Correcting
PersistenceState = Idle

over:

RecordedCorrectingIdle

unless the combination itself has distinct domain meaning.

For each pair of state dimensions ask:

Can these vary independently?

If yes, model them as orthogonal regions/dimensions.

If no, document why they are coupled.

---

# 19. Cartesian Explosion Test

Calculate the theoretical product size of major state dimensions.

Example:

3 domain states
× 5 effect states
× 4 workflow states
= 60 possible configurations

Do NOT assume all combinations are legal.

Identify:

- impossible combinations;
- invalid combinations;
- meaningful combinations;
- combinations prevented by type/model structure.

Flag systems that materialize large numbers of composite state names unnecessarily.

---

# 20. Hierarchical-State Test

Look for groups of states sharing behavior.

Example:

Active
  Draft
  Submitted

Resolved
  Approved
  Rejected
  Cancelled

Hierarchy may be useful when child states genuinely share:

- commands;
- invariants;
- transition behavior;
- lifecycle meaning.

Do not introduce hierarchy merely to make diagrams prettier.

Ask:

Would hierarchy remove duplicated semantic rules without hiding important differences?

If yes, recommend it.

If no, keep states flat.

---

# 21. State-Equivalence / Minimization Test

For each pair of suspiciously similar states ask:

Do they have the same:

- legal commands;
- invariants;
- authority rules;
- evidence requirements;
- transition behavior;
- observable consequences?

If future behavior cannot meaningfully distinguish them, challenge why both states exist.

Classify:

DISTINCT
POSSIBLY EQUIVALENT
EQUIVALENT / MERGE CANDIDATE

Do not mechanically minimize domain models.

Use equivalence analysis to expose accidental state proliferation.

---

# 22. Capability Test

For every state/configuration derive the legal action space.

Capabilities answer:

What can happen now?

They should generally be derived from:

state
+ authority
+ policy
+ evidence
+ relevant external/effect condition

Verify that UI, agents, and alternate hosts do not independently reconstruct capability logic.

Flag:

- UI-only permission rules;
- duplicated capability checks;
- agent prompts encoding rules absent from the kernel;
- commands exposed when guards can never succeed.

Attempt to issue every unavailable command and verify explicit rejection.

---

# 23. Derived-Data Test

Inventory values such as:

hasErrors
isValid
total
visibleCount
dailyTotal
filteredCount
canSubmit

Ask:

Can this be deterministically calculated from authoritative state?

If yes, challenge independent storage.

Flag duplicated authoritative state that can drift.

---

# 24. Obligation Test

Inventory unresolved required work.

Examples:

NeedsHumanReview
NeedsEvidence
NeedsReconciliation
MissingInformation
ExternalOutcomeMustBeChecked

For each obligation identify:

- creation condition;
- owner/eligible actor;
- resolution commands;
- resolution condition;
- whether it blocks capabilities;
- whether it can become permanently orphaned.

Do not automatically turn obligations into entity states.

Test whether every obligation has a legal resolution path.

This is also a liveness test.

---

# 25. Evidence Test

Inventory evidence required for decisions/transitions.

For each evidence item identify:

- what claim/transition it supports;
- source;
- validity rules;
- freshness/version if relevant;
- whether absence blocks a transition;
- whether contradictory evidence is possible.

Verify that evidence does not create unnecessary combinatorial states such as:

SubmittedWithPO
SubmittedWithPOAndApproval
SubmittedWithPOApprovalAndDelivery

when evidence can remain an orthogonal collection.

---

# 26. Safety-Property Test

Define explicit safety properties.

Safety means:

Something bad must never happen.

Examples:

A Recorded time entry never contains an invalid duration.

An Approved document never transitions directly to Draft.

A payment is never automatically retried after OutcomeUnknown without reconciliation.

An unauthorized actor never receives Approve capability.

A split never creates or destroys time.

For each safety property:

1. state it precisely;
2. identify enforcement mechanism;
3. identify tests;
4. attempt to violate it through legal-looking command sequences.

Required output:

SAFETY PROPERTY
Property:
Enforced by:
Test evidence:
Counterexample found:
Verdict:

---

# 27. Liveness / Progress Test

Define explicit liveness properties.

Liveness means:

Required progress remains possible.

Examples:

A valid Draft can eventually become Recorded.

A Failed save has a retry or recovery path.

OutcomeUnknown has a reconciliation path.

NeedsReview can eventually be resolved.

For every reachable nonterminal state ask:

What legal sequence allows progress?

Flag states that are safe but permanently stuck.

Required output:

LIVENESS PROPERTY
Property:
Progress path:
Blocking conditions:
Counterexample found:
Verdict:

---

# 28. Fairness / Starvation Test

Use when the system contains schedulers, queues, obligations, or autonomous agents.

Ask:

Can a valid work item remain perpetually eligible but never selected?

Examples:

reconciliation work
human review
low-priority maintenance
agent work queues

Identify scheduling rules.

Flag starvation risks.

Do not require complex formal fairness proofs unless the system warrants them.

---

# 29. Conflicting / Simultaneous Input Test

Identify inputs that may arrive close together.

Examples:

Cancel + SaveSucceeded
Timeout + Success
Approve + Withdraw
Retry + LateSuccess

Determine:

- event ordering rule;
- atomicity rule;
- stale-event handling;
- version checks;
- transition priority if one exists.

Attempt both orderings.

The resulting behavior must be deliberate.

Flag accidental order-dependent semantics.

---

# 30. Behavioral Equivalence Test

When multiple implementations, languages, hosts, or refactors exist, compare them as transition systems.

Feed equivalent:

initial state
command/event sequence
evidence
effect results

Compare observable:

domain state
workflow state
effect state
capabilities
obligations
effects emitted
projections

Differences must be intentional.

This can be used to compare:

F#
C#
Rust
TypeScript
reference model
old implementation
new implementation

Behavioral equivalence is especially valuable when testing a language-independent WASM/application protocol.

---

# 31. Adversarial Invalid-Configuration Test

This test is mandatory.

Attempt to construct states the architecture claims should be impossible.

Use:

- public constructors;
- deserialization;
- persistence hydration;
- API inputs;
- test helpers;
- direct record creation where allowed;
- stale versions;
- contradictory flags;
- null/missing values;
- invalid enum/string values;
- impossible orthogonal combinations.

Examples:

Approved + MissingRequiredEvidence

RecordedTimeEntry + DurationNotDivisibleBySixMinutes

SaveSucceeded + ReconciliationRequired

Voided + EditableCapability

If construction succeeds, determine whether:

- the state is actually legal;
- validation catches it before becoming authoritative;
- the type model is too weak;
- hydration is unsafe.

Record the exact counterexample.

---

# 32. Adversarial Command-Sequence Test

Attempt to break the system using individually plausible commands.

Examples:

Submit twice.

Approve before Submit.

Correct after Void.

Retry after OutcomeUnknown without reconciliation.

Apply stale effect success after cancellation.

Split an already superseded entry.

Cancel after irreversible external success.

For every counterexample record:

Initial configuration
Command/event sequence
Observed result
Expected rule
Severity
Suggested correction

---

# 33. Serialization / Hydration State Test

A strongly modeled runtime can still accept impossible state through persistence.

Inspect:

- JSON decoding;
- database hydration;
- WASM boundary decoding;
- API DTO conversion;
- version migration.

Ask:

Can persisted/external data bypass constructors, guards, or invariants?

Test invalid serialized states.

The boundary must either:

REJECT
MIGRATE
QUARANTINE
EXPLICITLY REPRESENT UNKNOWN/LEGACY CONDITION

Never silently accept invalid semantic state.

---

# 34. Diagram Test

Generate or verify a state diagram for each meaningful workflow/state region.

The diagram must show enough to expose:

- initial state;
- terminal states;
- legal transitions;
- important guards;
- external effects;
- failure/unknown paths.

Do not create giant diagrams merely to satisfy the test.

If a diagram is too large to understand, record that as possible modeling complexity.

Also create/verify a project workflow map showing major business workflows.

---

# 35. Execution / Source Map Test

For every major workflow identify where its semantics live.

Required mapping:

Workflow
→ Domain state/types
→ Commands/events
→ Transition implementation
→ Guards/invariants
→ Effects
→ Projections
→ Host/browser adapter
→ Tests

A new agent should not need repository-wide search to locate a known workflow.

If implementation cannot be mapped cleanly, record architectural diffusion.

---

# 36. Test Coverage Against the State Graph

Do not count tests only by file or line coverage.

Compare tests to the semantic graph.

For each transition identify:

HAPPY PATH TEST
GUARD FAILURE TEST
ILLEGAL SOURCE STATE TEST
EFFECT SUCCESS TEST if applicable
EFFECT FAILURE TEST if applicable
OUTCOME UNKNOWN TEST if applicable
INVARIANT TEST

Identify untested transitions and untested states.

Prioritize semantic coverage over line coverage.

---

# 37. System-Level Completion Test

A state model is NOT complete merely because all states have names.

Before PASS, verify:

[ ] Initial configuration defined
[ ] Terminal states identified
[ ] Commands identified
[ ] Events identified
[ ] Commands and events distinguished
[ ] Legal transitions explicit
[ ] Illegal commands explicitly rejected
[ ] Guards explicit
[ ] Invariants explicit
[ ] Effects explicit
[ ] OutcomeUnknown considered where relevant
[ ] Capabilities derivable
[ ] Obligations resolvable
[ ] Evidence requirements explicit
[ ] All intended states reachable
[ ] No unexplained unreachable states
[ ] No accidental dead states
[ ] Required progress paths exist
[ ] Safety properties defined and tested
[ ] Liveness properties defined and tested
[ ] Orthogonal dimensions not unnecessarily multiplied
[ ] Equivalent/redundant states challenged
[ ] Run-to-completion behavior preserved
[ ] Conflicting event ordering considered
[ ] Serialization/hydration cannot silently create illegal state
[ ] State/workflow diagrams exist
[ ] Execution/source map exists
[ ] Tests cover semantic transitions

Any unchecked item must appear in findings.

---

# 38. Severity Classification

Classify findings as:

CRITICAL
The system can enter unsafe/invalid state, perform an irreversible illegal action, corrupt authoritative state, or cannot distinguish dangerous uncertainty.

HIGH
A reachable state is dead, important transitions are undefined, authority/evidence rules can be bypassed, or core semantics are duplicated/ambiguous.

MEDIUM
Hidden state, unnecessary state proliferation, incomplete tests, architectural diffusion, unclear ownership, or recoverable ambiguity exists.

LOW
Naming, documentation, diagram, or maintainability issue that does not currently threaten semantic correctness.

OBSERVATION
Useful architectural note without a demonstrated defect.

---

# 39. Final Verdict

Return exactly one overall verdict:

PASS

PASS WITH FINDINGS

FAIL

Use PASS only when no material state-system defect remains within the tested boundary.

PASS WITH FINDINGS means the model is usable but contains non-critical deficiencies or unresolved evidence gaps.

FAIL means one or more critical/high-confidence defects undermine the semantic model, safety, reachability, determinism, or recoverability.

Do not lower severity merely because the implementation currently "works."

---

# 40. Required Final Report

Produce:

# STATE-SYSTEM TEST REPORT

## 1. Verdict

PASS / PASS WITH FINDINGS / FAIL

Confidence:
Scope tested:

## 2. Executive Summary

Explain whether the system's semantics are explicit and trustworthy.

## 3. System Under Test

Feature:
Boundary:
Authoritative state owner:
Initial configuration:
Terminal conditions:

## 4. State Inventory

Domain:
Workflow:
Effect:
Presentation:
Derived:
Capabilities:
Obligations:
Evidence:

## 5. Transition Summary

Number of semantic states:
Number of commands:
Number of events:
Number of legal transitions:
Number of explicit rejection paths:
Unknown/undefined transitions:

## 6. Reachability

Reachable states:
Unreachable states:
Unknown states:

## 7. Dead States

Intentional terminal states:
Absorbing states:
Accidental dead states:

## 8. Determinism

Deterministic transitions:
Nondeterministic transitions:
External uncertainty points:

## 9. Safety Properties

Property:
Verdict:
Evidence:

## 10. Liveness Properties

Property:
Verdict:
Progress path:

## 11. State Explosion / Orthogonality

Independent dimensions:
Unnecessary composite states:
Invalid combinations:

## 12. Hidden / Implicit State

Booleans:
Strings:
Null combinations:
UI-derived semantics:
Other:

## 13. Effect Safety

Effects inspected:
OutcomeUnknown cases:
Reconciliation paths:
Unsafe retries:

## 14. Adversarial Counterexamples

For each:

Initial state:
Sequence:
Observed:
Expected:
Severity:

## 15. Serialization / Hydration

Invalid-state construction attempts:
Boundary protections:
Findings:

## 16. Capability Analysis

Duplicated rules:
Unavailable commands correctly rejected:
UI/agent reconstruction found:

## 17. Obligation / Evidence Analysis

Unresolvable obligations:
Missing evidence rules:
Orphan work:

## 18. Diagrams / Source Mapping

Workflow maps:
State diagrams:
Execution maps:
Missing artifacts:

## 19. Test Coverage

Transitions covered:
Transitions untested:
States untested:
Failure paths untested:

## 20. Findings

For each finding:

ID:
Severity:
Title:
Evidence:
Why it matters:
Counterexample:
Required correction:
Suggested ROS work item:

## 21. Required Corrections

Order corrections by dependency and risk.

## 22. Residual Unknowns

State exactly what could not be proven.

## 23. Final Assessment

Answer:

1. Can illegal semantic states be represented?
2. Can illegal transitions execute?
3. Can the system become accidentally stuck?
4. Can external uncertainty be mistaken for failure?
5. Can capabilities be reconstructed incorrectly outside the kernel?
6. Are meaningful states hidden in booleans/strings/nulls?
7. Are independent state dimensions improperly multiplied?
8. Are all intended outcomes reachable?
9. Are safety properties protected?
10. Are progress/liveness properties protected?
11. Could a fresh agent understand and safely modify this state system without reconstructing semantics from scattered code?

---

# 41. ROS Follow-Up

If the repository uses ROS or another work-order system, do not leave findings only in the report.

For every actionable unresolved finding:

1. inspect the repository's ROS instructions;
2. create or propose the appropriate bounded work item according to those instructions;
3. include:
   - finding ID;
   - objective;
   - current state;
   - desired state;
   - relevant files/context;
   - dependencies;
   - acceptance criteria;
   - validation required;
   - risk/severity;
4. preserve dependency order;
5. do not mark corrective work complete until validated.

Do not invent ROS identifiers when the system provides an allocator.

---

# 42. Governing Principles

The purpose of explicit state is not to describe everything that is true.

The purpose is to make meaningful behavioral boundaries explicit.

A state system should make it difficult for humans, software, and AI agents to:

- construct illegal configurations;
- request illegal actions;
- confuse intent with fact;
- mistake uncertainty for failure;
- bypass required evidence;
- become trapped without a recovery path;
- reconstruct business rules from UI behavior;
- infer semantics from surviving implementation accidents.

The strongest state-level rule is:

If introducing a new state does not change legal behavior, invariants, transition rules, authority, evidence requirements, or safety behavior, it probably should not be a new state.

The complementary rule is:

If meaningful legal behavior depends on a condition represented only through scattered booleans, null checks, strings, conventions, or duplicated conditionals, that condition probably should become explicit state.

The strongest system-level rule is:

A state model is not complete until its transition system has been tested for reachability, dead states, determinism, explicit rejection, safety, liveness, effect uncertainty, and recoverability.

And the adversarial rule is:

Do not merely show that the intended path works. Try to construct a legal-looking path that should never be allowed to work.
