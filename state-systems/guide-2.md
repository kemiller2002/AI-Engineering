<!--
CHANGE MARKUP:
> **Change notation:** `<del>deleted text</del>` marks deletions/replacements; `<ins>added text</ins>` marks additions/replacements. These tags render as strikethrough/inserted text in Markdown viewers that support inline HTML.

  <del>...</del> = deleted/replaced text
  <ins>...</ins> = added/replacement text
These HTML tags are valid inside Markdown and render clearly on GitHub and most Markdown viewers.
-->

# Four Layers of State in a State-System Application
**Redline Corrections and Extensions**
Purpose: preserve the original guide while marking corrections and additions needed to incorporate finite-automata, statechart, and transition-system concepts.
**Legend: **<del>deleted / replaced text</del>    <ins>added / replacement text</ins>

A state-system architecture should not treat every changing value as the same kind of state.
Different kinds of state exist for different reasons, and each belongs at a different architectural level.
The four primary layers are:
1. Domain / Entity State
2. Workflow / Process State
3. Effect / External Operation State
4. Presentation / Interaction State
<ins>The four layers are </ins><ins>not four mutually exclusive machines or a complete definition of a state system. </ins><ins>They are a classification model for deciding where changing conditions belong. Domain, workflow, and effect state can form orthogonal semantic regions of one system configuration; presentation state usually remains outside the semantic core unless it changes application meaning.</ins>
The central rule is:
Create a new explicit state when a condition changes the meaning of the system, the legal action space, the applicable invariants, or what can safely happen next.
Do not create a new state merely because some value changed.
<ins>A complete state system must additionally define its initial configuration, commands/events, legal transitions, guards, terminal conditions, invariants, effects, and system-level properties such as reachability and progress.</ins>

## 1. Domain / Entity State
Domain state describes what a business or domain object currently is.
It represents meaningful lifecycle distinctions in the problem domain.
Examples:
Invoice
Draft
Submitted
Approved
Paid
Cancelled
Or:
TimeEntry
Draft
Recorded
<del>Corrected</del>
Voided
<ins>Correction is often better modeled as a transition/revision while the entry remains Recorded, unless “Corrected” itself changes future legal behavior.</ins>
Or:
MedicalRecord
Imported
NeedsReview
Verified
Superseded
### When to create a new domain state
Create a new domain state when the object has entered a condition where one or more of these change:
- which operations are legal;
- which invariants apply;
- what the object means;
- who may act on it;
- what evidence is required;
- whether something may still be changed;
- whether a transition has irreversible consequences.
- <ins>which future states are reachable from it;</ins>
- <ins>whether it is terminal or intentionally irreversible.</ins>
For example:
Draft Invoice
may allow:
Edit
Delete
Submit
while:
Submitted Invoice
may allow:
Approve
Reject
Withdraw
Those are meaningfully different domain conditions.
Therefore:
Draft
and:
Submitted
deserve separate explicit states.
### Example: time entry
Suppose a time entry can be changed freely before submission, but after submission a change must become an auditable correction.
That suggests:
<del>Draft
    ↓ submit
Recorded
    ↓ correct
Corrected</del>
<ins>Draft
    ↓ submit
Recorded
    ↓ correct / create revision
Recorded</ins>
The distinction matters because:
Draft
might permit:
UpdateDuration
ChangeProject
Delete
Submit
whereas:
Recorded
might permit:
Correct
Split
Void
but not arbitrary mutation.
That is exactly the sort of distinction explicit domain states should capture.
<ins>A transition does not require a different destination state. A self-transition such as Recorded --Correct--> Recorded is valid when the lifecycle meaning remains Recorded while revision history changes.</ins>
### When NOT to create a domain state
Do not create:
TimeEntryWithDescription
TimeEntryWithoutDescription
TimeEntryWithThreeLabels
TimeEntryWithFourLabels
unless those conditions fundamentally alter the object’s legal behavior.
Those are normally data properties.
A good test is:
If I changed this value, would I expect a different set of legal domain commands?
If no, it probably does not need to become a domain state.
<ins>Also ask whether two proposed states are behaviorally distinguishable. If they have the same legal commands, invariants, transition behavior, and observable consequences, the distinction may belong in data or evidence rather than lifecycle state.</ins>

## 2. Workflow / Process State
Workflow state describes where a process currently is.
It is different from entity state.
An entity can remain in the same domain state while a process involving that entity moves through multiple workflow states.
Example:
<del>Import Workflow
WaitingForFile
Reading
Parsing
Validating
Persisting
Complete</del>
<ins>Import Workflow
WaitingForSource
SourceReceived
ReviewRequired
ReadyToCommit
Complete</ins>
<ins>Reading, parsing, validating, and persisting may be implementation activities rather than meaningful workflow states. Promote them only when being in that condition changes legal behavior, required input, safety, or what can happen next.</ins>
The imported record itself might not have corresponding domain states for each workflow step.
The workflow needs explicit states only where the process must distinguish what can legally happen next.
### When to create a workflow state
Create a workflow state when the process reaches a step that changes:
- what operation is expected next;
- what inputs are required;
- which transitions are legal;
- which effects can occur;
- whether the process can continue;
- whether human intervention is required.
- <ins>which completion or abandonment paths remain reachable;</ins>
- <ins>whether unresolved work has become an obligation.</ins>
Example:
<del>Time Entry Submission
Editing
    ↓ submit
Validating
    ↓
ReadyToSave
    ↓
Saving
    ↓
Complete</del>
<ins>Time Entry Submission
Editing
    ↓ Submit
ReadyToCommit
    ↓ persistence effect requested
Complete</ins>
<ins>Validation is normally a guard or deterministic computation; Saving is normally effect state. They should become workflow states only if they represent meaningful process conditions with distinct legal behavior.</ins>
Workflow state should represent semantic process progression, not merely technical activity.
### Example: time-entry correction
SelectEntry
    ↓
EnterCorrection
    ↓
ReviewCorrection
    ↓
SubmitCorrection
    ↓
Complete
The underlying time entry might remain:
Recorded
until the correction is committed.
This separation prevents the entity model from being polluted with process-specific states such as:
RecordedButCurrentlyBeingCorrected
unless that distinction actually matters to the domain.
### Workflow state vs domain state
Ask:
Is this condition describing what the object is, or what the process is doing?
If it describes the object:
Domain state
If it describes a multi-step operation around the object:
Workflow state
Example:
Invoice = Approved
is domain state.
PaymentWorkflow = AwaitingBankConfirmation
is workflow/effect-related state.
The invoice does not become:
ApprovedAndAwaitingBankConfirmation
unless the domain genuinely considers that a distinct invoice state.

## 3. Effect / External Operation State
Effect state describes what is known about an operation outside the deterministic domain system.
Examples include:
- database writes;
- HTTP requests;
- payment processing;
- sending email;
- writing to GitHub;
- calling an LLM;
- uploading a file;
- browser storage;
- communicating with another system.
A useful generic model is:
NotStarted
Pending
Succeeded
Failed
OutcomeUnknown
### Why effect state deserves its own layer
External effects behave differently from domain state.
Inside the domain kernel:
state + command → deterministic result
But external systems may:
- fail;
- timeout;
- respond slowly;
- succeed without acknowledgment;
- acknowledge an operation that later rolls back;
- become unreachable after receiving a request.
That means external effects introduce epistemic uncertainty.
<ins>The kernel should remain deterministic about uncertainty: the world may be nondeterministic, but the kernel should deterministically represent what it knows (for example, OutcomeUnknown) rather than hide uncertainty in control flow.</ins>
Example:
Save Time Entry
     ↓
HTTP request sent
     ↓
connection disappears
Did the save happen?
There may be three meaningful answers:
Succeeded
Failed
OutcomeUnknown
Treating OutcomeUnknown as Failed can be dangerous.
Retrying a payment, submission, or irreversible command after an uncertain outcome may duplicate the operation.
### When to create effect state
Create explicit effect state when the external operation changes:
- what retry behavior is safe;
- whether the system should wait;
- whether reconciliation is needed;
- whether the user can proceed;
- what the system actually knows.
Example:
SaveEffect
Idle
Pending
Succeeded
Failed
OutcomeUnknown
Capabilities could then differ:
Idle:
    Save
Pending:
    Cancel maybe
    Wait
Failed:
    Retry
OutcomeUnknown:
    Reconcile
    CheckStatus
This is a meaningful action-space difference and therefore deserves explicit state.
### Do not merge effect state unnecessarily with domain state
Avoid:
Draft
DraftSaving
DraftSaveFailed
DraftSaveUnknown
Submitted
SubmittedSaving
SubmittedSaveFailed
SubmittedSaveUnknown
That creates a Cartesian explosion.
Prefer:
DomainState:
    Draft
    Submitted
    Approved
PersistenceState:
    Idle
    Pending
    Failed
    OutcomeUnknown
These dimensions can coexist without being collapsed into one giant discriminated union.
<ins>In statechart terms, these are orthogonal regions. The complete semantic configuration is their combination, but the implementation should not manufacture a named state for every Cartesian-product combination.</ins>

## 4. Presentation / Interaction State
Presentation state describes temporary browser or user-interface conditions.
Examples:
selected tab
open dropdown
hovered row
focused control
expanded section
scroll position
animation progress
temporary tooltip
Most of this state should remain outside the domain kernel.
For a browser application, it often belongs in the browser or TypeScript bridge.
### When presentation state should remain local
Suppose a user opens a project dropdown.
The domain does not care whether the dropdown is physically open.
Therefore:
projectDropdownOpen = true
does not belong in domain state.
Similarly:
mouseIsOverRow
is not meaningful application state.
### When presentation state becomes semantic state
Sometimes something that looks like UI state actually has domain meaning.
Example:
selectedPatient
If selecting a patient determines which patient’s data commands will operate on, that may be application state rather than merely presentation state.
The question is not:
Does the UI display it?
The question is:
Does changing it alter application meaning or legal behavior?
For example:
ActivePatient = Patient123
may determine:
which medical records are visible
which commands are available
where imported data belongs
which reports can be generated
That is probably semantic application state.
By contrast:
PatientPanelExpanded = true
is probably presentation state.
<ins>Presentation state is not normally part of the semantic system configuration used for reachability, safety, or liveness analysis unless presentation behavior itself has semantic consequences.</ins>

## <ins>5. State-System Structure Beyond the Four Layers</ins>
<ins>The four layers answer where state belongs. They do not by themselves specify whether the resulting state system is complete or correct.</ins>
<ins>Every significant state system or workflow should additionally identify:</ins>
- <ins>initial state or initial configuration;</ins>
- <ins>commands (requested actions);</ins>
- <ins>events (facts that occurred);</ins>
- <ins>legal transitions;</ins>
- <ins>guards and required evidence;</ins>
- <ins>terminal / final states;</ins>
- <ins>intentionally absorbing states, if any;</ins>
- <ins>effects and effect-result events;</ins>
- <ins>state and transition invariants;</ins>
- <ins>capabilities and obligations derived from the current configuration.</ins>
### <ins>Commands vs Events</ins>
<ins>A command expresses intent: “please attempt this action.” An event reports a fact: “this occurred.” A command may be rejected; an event must be interpreted according to the current state.</ins>
<ins>Command: SubmitEntry
Event: SaveSucceeded
Event: SaveFailed
Event: PersistenceOutcomeUnknown</ins>
<ins>Agents and users normally issue commands. External systems and completed effects normally produce events.</ins>
### <ins>Run-to-Completion Semantics</ins>
<ins>Process one semantic command/event atomically: evaluate guards, perform the transition, derive capabilities/obligations, and emit effects/projections before processing the next semantic input. Half-transitioned state should not be externally observable.</ins>
<ins>receive input
    ↓
evaluate guard
    ↓
transition atomically
    ↓
derive capabilities / obligations
    ↓
emit effects / projection</ins>
### <ins>Transition Completeness</ins>
<ins>For every accepted command type and current state, behavior must be explicit. The result should be a legal transition, an explicit rejection, or a deliberately specified no-op. Undefined fall-through behavior is not acceptable.</ins>
<ins>Approved + Edit
    → Reject(CommandNotAvailableInState Approved)</ins>

## The Core Classification Test
Whenever a developer or agent wants to create a new state, ask these questions in order.
### Question 1: Does this change domain meaning?
Example:
Draft → Approved
Yes.
Use:
Domain state
### Question 2: Does this describe progress through a meaningful process?
Example:
GatheringEvidence → ReviewingEvidence
Yes.
Use:
Workflow state
### Question 3: Does this describe what is known about an external operation?
Example:
SavePending → SaveOutcomeUnknown
Yes.
Use:
Effect state
### Question 4: Is it merely a temporary UI condition?
Example:
SidebarExpanded
Yes.
Use:
Presentation state
### <ins>Question 5: Is this actually a state, or is it a command, event, guard, derived value, evidence item, capability, or obligation?</ins>
<ins>Do not promote a concept into state merely because it appears in a sequence diagram or because implementation code needs to mention it.</ins>

## The Legal Action Space Test
The most useful general rule is:
A new explicit state is justified when being in that condition changes the legal action space.
Document
Draft
Submitted
Approved
Capabilities might be:
Draft
    Edit
    Delete
    Submit
Submitted
    Withdraw
    Approve
    Reject
Approved
    Archive
Because the available actions change substantially, these states are meaningful.
Now consider:
DocumentDescriptionLength = 42
versus:
DocumentDescriptionLength = 45
If the available domain actions remain the same, these do not deserve different explicit states.
They are simply data.
## The Invariant Test
Another reason to introduce a state is when different invariants apply.
DraftTimeEntry
might allow:
Project optional
Description incomplete
Duration temporarily empty
while:
RecordedTimeEntry
requires:
Project exists
Duration > 0
Duration divisible into 6-minute units
Date exists
If the invariants differ enough, separate types/states can make invalid combinations impossible.
DraftEntry
and:
RecordedEntry
may contain different data structures.
This is often stronger than:
TimeEntry {
    project?: Project
    duration?: int
    submitted: bool
}
because the second representation permits nonsense such as:
submitted = true
duration = null
project = null
The state model should make these illegal combinations difficult or impossible to construct.

## The Boolean Smell
Boolean flags are frequently hidden state machines.
isSubmitted
isApproved
isRejected
Possible combinations include:
false false false
true  false false
true  true  false
true  false true
false true  true
true  true  true
Most of those combinations probably make no sense.
That suggests these booleans actually represent:
Draft
Submitted
Approved
Rejected
new boolean flag
      ↓
Can combinations with other flags create illegal or ambiguous states?
      ↓
YES
      ↓
consider an explicit state model
Booleans are fine when they genuinely represent independent facts.
isPinned
might be completely independent of document lifecycle.
Do not convert every Boolean into a discriminated union.

## Avoiding State Explosion
State-oriented architecture can fail when every dimension gets multiplied together.
Domain:
Draft
Submitted
Approved
Save:
Idle
Pending
Failed
Unknown
UI:
Collapsed
Expanded
A naïve combined model creates:
3 × 4 × 2 = 24 states
such as:
DraftSavingExpanded
DraftSavingCollapsed
DraftFailedExpanded
SubmittedSavingExpanded
ApprovedUnknownCollapsed
...
This is usually wrong.
Keep orthogonal state dimensions separate.
<del>ApplicationState
    DomainState
    PersistenceState
    PresentationState</del>
<ins>SemanticConfiguration
    DomainState
    WorkflowState
    EffectState

PresentationState  // separate unless it changes semantic behavior</ins>
Then define rules governing interactions between them.
CanSubmit =
    DomainState = Draft
    AND
    PersistenceState != Pending
That capability is derived.
It does not require creating:
DraftAndNotPending
as another state.
<ins>This is the statechart notion of orthogonal regions: the combined configuration exists, but the implementation need not enumerate every combination as a separate named state.</ins>

## State vs Capability
A capability answers: What can happen now?
A state answers: What condition is the system in?
Do not create states solely to express permissions.
EditableDraft
NonEditableDraft
perhaps the correct design is:
State:
Draft
Capability:
CanEdit = true/false
depending on authority or policy.
Capabilities should generally be derived from:
state
+ authority
+ policy
+ evidence
+ external conditions
<ins>More precisely, derive capabilities from the complete semantic configuration plus authority, policy, and evidence - not merely from one entity-state value.</ins>
CanApprove =
    State = Submitted
    AND
    UserHasApprovalAuthority
    AND
    RequiredEvidencePresent
No new state is necessary.
## State vs Derived Data
Derived values should usually not become independent state.
12 units
6 units
4 units
The total is:
22 units
Do not independently store:
totalUnits = 22
unless persistence or performance creates a compelling reason.
Instead:
TotalUnits = sum(entries)
Likewise:
hasErrors
isValid
visibleCount
dailyTotal
filteredCount
are often derived.
If the value can be deterministically calculated from authoritative state, prefer deriving it rather than creating another authoritative state variable.
## State vs Obligation
An obligation represents: Something that must still be resolved.
TimeEntry = Recorded
but:
Obligation:
MissingProjectClassification
The time entry does not necessarily need another state:
RecordedButMissingProjectClassification
Instead:
State:
Recorded
Obligations:
[
    MissingProjectClassification
]
Obligations are particularly useful for AI systems because they naturally form bounded work queues.
NeedsHumanReview
NeedsEvidence
NeedsReconciliation
MissingRequiredInformation
ExternalOutcomeMustBeChecked
Do not turn every unresolved task into an entity state.
<ins>Obligations also connect to liveness: a system should provide a legal path by which required obligations can eventually be discharged, or explicitly expose escalation/abandonment semantics.</ins>
## State vs Evidence
Evidence describes what supports a decision or transition.
Suppose an invoice is:
Submitted
and approval requires:
PurchaseOrder
ManagerAuthorization
DeliveryConfirmation
Those pieces of evidence do not necessarily create states such as:
SubmittedWithPO
SubmittedWithPOAndAuthorization
SubmittedWithPOAuthorizationAndDelivery
Instead:
State:
Submitted
Evidence:
    PurchaseOrder
    ManagerAuthorization
    DeliveryConfirmation
The transition guard becomes:
Submitted
    ↓ approve
    [required evidence present]
Approved
This avoids combinatorial state growth.
## State vs Data
Data describes attributes.
TimeEntry
project
date
duration
description
labels
Those values belong inside a state.
Do not confuse different data with different state.
A time entry having Project A instead of Project B does not necessarily mean it has entered a new lifecycle state.
Data answers:
    What information does the object contain?
State answers:
    What meaningful condition is the object currently in?

## <ins>6. System-Level Verification Rules</ins>
<ins>After deciding what the states are, validate the transition system as a graph and behavioral model.</ins>
### <ins>Initial and Terminal States</ins>
<ins>Every workflow/state machine should identify its initial state or initial configuration and its intentional terminal states. Distinguish successful completion, cancellation/abandonment, and failure when those have different semantics.</ins>
<ins>If a state is intentionally irreversible, mark it as absorbing and validate that no outgoing transition exists.</ins>
### <ins>Reachability</ins>
<ins>Every modeled state should be reachable from an initial configuration through legal transitions unless it is deliberately reserved. A type-valid but unreachable state is usually an orphan or modeling defect.</ins>
<ins>Initial → ... → State?
If no legal path exists, flag it.</ins>
### <ins>Dead-State / Dead-End Detection</ins>
<ins>Distinguish intentional terminal states from accidental dead states. A nonterminal state with no legal progress path is a defect unless the model explicitly requires waiting for an external event.</ins>
<ins>OutcomeUnknown
    → Reconcile
    → CheckStatus
    → Escalate</ins>
### <ins>Determinism</ins>
<ins>For the same semantic configuration, command/event, and explicit inputs, the kernel should produce one defined semantic result. Hidden conditions should not select different outcomes. External uncertainty should be represented explicitly rather than becoming internal nondeterminism.</ins>
### <ins>Safety Properties</ins>
<ins>State invariants protect one state. Safety properties protect the transition system as a whole: something forbidden must never become reachable.</ins>
- <ins>A recorded time entry never has an invalid duration.</ins>
- <ins>An approved document never transitions directly to Draft unless an explicit reopening transition exists.</ins>
- <ins>An OutcomeUnknown payment is never automatically retried when retry could duplicate the effect.</ins>
- <ins>A caller without approval authority never receives the Approve capability.</ins>
### <ins>Liveness / Progress Properties</ins>
<ins>A system can be perfectly safe and still be useless if it can become stuck forever. Define the progress properties that must remain possible.</ins>
- <ins>A valid draft can eventually be submitted.</ins>
- <ins>A failed save has an explicit retry or abandonment path.</ins>
- <ins>An OutcomeUnknown state has a reconciliation or escalation path.</ins>
- <ins>Required obligations have a legal path to resolution.</ins>
### <ins>Path Constraints</ins>
<ins>Some rules concern legal paths rather than individual transitions. Example: Approved may be reachable only through Submitted. Capture such requirements explicitly instead of relying on convention.</ins>
### <ins>Behavioral Equivalence / State Minimization Test</ins>
<ins>Do not mechanically minimize business state machines, but use equivalence as a challenge test: if two states have identical legal commands, invariants, future transition behavior, and observable consequences, ask whether the distinction should instead be data/evidence.</ins>

## Detailed Time Entry Example
Consider the time-entry application.
A reasonable design might have:
TimeEntryState
Draft
Recorded
Voided
Corrections might be modeled through revisions rather than turning each corrected entry into another large lifecycle branch.
TimeEntry
id
state
currentRevision
revisionHistory
Creation:
<del>Draft
    ↓ Validate</del>
<ins>Draft
    ↓ Submit [guard: valid]</ins>
Recorded
<ins>Validation is a guard/computation, not necessarily a lifecycle state transition.</ins>
Correction:
Recorded
    ↓ Correct
Recorded
but with:
revisionHistory += Correction
Notice something important:
A transition does not always require a different named destination state.
A valid transition can be:
Recorded
    ↓ Correct
Recorded
because the domain condition is still “Recorded.”
The command changes domain data and history without changing lifecycle class.
That prevents unnecessary states like:
RecordedOnceCorrected
RecordedTwiceCorrected
RecordedThreeTimesCorrected
## Detailed Effect Example
Suppose the user saves a corrected time entry.
Domain:
TimeEntryState = Recorded

Persistence:
SaveState = Idle
User chooses:
Correct
The kernel validates the correction and emits:
PersistCorrection
Effect state becomes:
Pending
If persistence succeeds:
Succeeded
If it definitively fails:
Failed
If the connection disappears after submission:
OutcomeUnknown
Notice that the time entry itself does not need to become:
RecordedPersistenceUnknown
The dimensions remain separate.
The system might now expose:
Obligation:
ReconcilePersistenceOutcome
and:
Capabilities:
CheckPersistenceStatus
This is much cleaner than multiplying domain states.
## Detailed Workflow Example
Suppose splitting time is a guided multi-step operation.
Workflow:
NotSplitting
    ↓ StartSplit
EditingSplit
    ↓ Review
ReviewingSplit
    ↓ Confirm
Complete
The time entry may remain:
Recorded
until the split is committed.
During:
EditingSplit
the workflow owns temporary split data.
Original:
10 units
Proposed:
4 units
6 units
Guard:
sum(parts) = original duration
On successful confirmation:
Original entry
    ↓
Split records created
The domain state changes appropriately.
Again:
workflow state ≠ entity state
<ins>If Confirm triggers persistence, the persistence operation remains an effect region; the workflow should not become “Saving” merely because the effect is Pending.</ins>
## Detailed Presentation Example
Suppose the UI shows the time-entry list.
Presentation state might include:
expandedRow
focusedField
openDatePicker
hoveredEntry
Kernel/application state might include:
selectedProjectFilter
selectedDateRange
sortOrder
Why the difference?
Because changing hoveredEntry has no semantic effect.
Changing selectedDateRange changes the collection being requested and perhaps the derived totals shown to the user.
Whether query/filter state lives in the kernel should depend on whether it is considered meaningful application state.
In this architecture, domain-relevant list filtering and sorting generally belong in the kernel because agents, alternate hosts, and UI clients should receive the same collection semantics.

## A Practical Decision Tree
Something changed.
      │
      ▼
Does it change what the domain object IS?
      │
   YES ─────► Domain State
      │
      NO
      ▼
Does it represent progress through a meaningful process?
      │
   YES ─────► Workflow State
      │
      NO
      ▼
Does it describe the status or certainty of an external operation?
      │
   YES ─────► Effect State
      │
      NO
      ▼
Does it only affect browser/UI interaction?
      │
   YES ─────► Presentation State
      │
      NO
      ▼
Is it deterministically calculable?
      │
   YES ─────► Derived Data
      │
      NO
      ▼
Is it something that still must be resolved?
      │
   YES ─────► Obligation
      │
      NO
      ▼
Is it information supporting a decision?
      │
   YES ─────► Evidence
      │
      NO
      ▼
Probably ordinary domain data.
<ins>Before creating any new state, also ask:
Is this actually a command, event, guard, or effect?
Would the new state be reachable?
Would it have a legal progress path?
Is it behaviorally distinguishable from an existing state?</ins>

## Rules for Creating a New Explicit State
A proposed new state should generally satisfy at least one of these tests.
### 1. Different legal actions
Draft allows actions that Approved does not. Good state distinction.
### 2. Different invariants
Draft may be incomplete. Submitted must be complete. Good state distinction.
### 3. Different transition rules
From Submitted you may transition to Approved or Rejected but not Deleted. Good state distinction.
### 4. Different authority requirements
A particular state may require another role/capability to advance. Potentially meaningful state distinction.
### 5. Different evidence requirements
The next transition requires evidence specifically because of the current condition. Potentially meaningful state distinction.
### 6. Different uncertainty/safety behavior
Failed and OutcomeUnknown have different safe next actions. Good effect-state distinction.
### <ins>7. Different future reachability</ins>
<ins>The set of legal future states differs materially from an existing state. Potentially meaningful state distinction.</ins>
### <ins>8. Different terminal/irreversibility semantics</ins>
<ins>The condition is intentionally final or absorbing, or crossing into it changes whether reversal is legal. Good state distinction when this is domain meaning.</ins>
If none of these apply, question whether the proposed state should exist.

## Warning Signs of Too Many States
SubmittedWithError
SubmittedWithoutError
SubmittedWaiting
SubmittedSaving
SubmittedWithWarning
SubmittedSelected
SubmittedExpanded
This often means unrelated dimensions are being collapsed together.
Instead identify the dimensions:
Domain:
Submitted
Effect:
Pending
Validation:
Warning
Presentation:
Expanded
Then derive behavior from their combination.
<ins>Also challenge near-duplicate states with the behavioral-equivalence test: if nothing legal or observable differs, do not preserve two names merely because the implementation reached them through different paths.</ins>
## Warning Signs of Too Few States
status: string
with values determined by conventions scattered through code.
Or:
if approved && !deleted && !processing && ...
This indicates meaningful states exist but are implicit.
Other warning signs:
- many Boolean flags interact;
- commands contain repeated checks for the same combinations;
- agents must infer legal behavior from conditional code;
- illegal combinations regularly appear;
- tests repeatedly reconstruct the same state rules;
- UI code independently decides which buttons should appear.
- <ins>states are reachable only through undocumented special cases;</ins>
- <ins>nonterminal states have no legal path forward;</ins>
- <ins>the same state/command pair can produce different semantic results because of hidden mutable conditions.</ins>
In those cases, promote the hidden state model into explicit representation.

## State Granularity Principle
Model states at the smallest semantic level that changes behavior.
Do not model implementation details.
Too coarse:
Active
Inactive
when six distinct legal conditions actually exist.
Too fine:
DraftWithSevenCharactersTyped
when character count has no lifecycle meaning.
The correct granularity is where:
state
→ determines meaningful rules
→ determines legal transitions
→ determines capabilities
<ins>and where proposed states remain behaviorally distinguishable in ways the domain or workflow actually cares about.</ins>
## Independence Principle
When two state dimensions can vary independently, strongly prefer modeling them independently.
DocumentState:
Draft | Submitted | Approved
PersistenceState:
Idle | Pending | Failed | Unknown
rather than:
DraftIdle
DraftPending
DraftFailed
DraftUnknown
SubmittedIdle
SubmittedPending
...
Combine state dimensions only when the domain itself considers the combination a distinct semantic condition.
<ins>Use hierarchy when related substates share meaningful parent behavior; use orthogonal regions when dimensions evolve independently. Do not introduce hierarchy or concurrency merely to make a diagram look sophisticated.</ins>

## Capabilities as the Public Consequence of State
A powerful way to prevent UI and AI agents from reconstructing rules is to expose capabilities derived from state.
TimeEntry:
Recorded
Effect:
Idle
Authority:
CanModifyTime
Capabilities:
Correct
Split
Void
The UI does not need to know:
if entry.state == “Recorded”
    && user.permissions.includes(...)
    && saveState != “Pending”
The kernel simply says:
Correct = available
Split = available
Void = available
This reduces duplicated business reasoning.
<ins>Capabilities should be derived after each run-to-completion transition from the current semantic configuration, authority, policy, and evidence.</ins>

## Final Design Principle
The purpose of explicit state is not to describe everything that is currently true.
The purpose is to make meaningful behavioral boundaries explicit.
Use Domain state for what something is.
Use Workflow state for where a meaningful process is.
Use Effect state for what is known about interaction with the outside world.
Use Presentation state for temporary UI mechanics.
Then use data, derived values, capabilities, evidence, and obligations for everything that does not deserve another lifecycle state.
<ins>The four-layer classification must then be completed by a transition-system model: initial configuration, commands/events, transitions, guards, terminal states, effects, reachability, dead-state detection, determinism, transition completeness, safety properties, and liveness/progress properties.</ins>
The strongest rule is:
If introducing a new state does not change legal behavior, invariants, transition rules, authority, evidence requirements, or safety behavior, it probably should not be a new state.
<ins>If introducing a new state also produces no distinct future reachability or observable behavior, that is additional evidence that the distinction belongs elsewhere.</ins>
And the complementary rule is:
If meaningful legal behavior depends on a condition that currently exists only as scattered booleans, null checks, strings, or conventions, that condition probably should become explicit state.
### <ins>System-level completion rule:</ins>
<ins>A state model is not finished when every state has a name. It is finished when legal paths are explicit, every meaningful state is reachable, accidental dead ends are absent, illegal commands are explicitly rejected, uncertainty is represented honestly, safety properties cannot be violated through legal transitions, and required progress remains possible.</ins>