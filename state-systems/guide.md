Four Layers of State in a State-System Application

A state-system architecture should not treat every changing value as the same kind of state.

Different kinds of state exist for different reasons, and each belongs at a different architectural level.

The four primary layers are:

1. Domain / Entity State
2. Workflow / Process State
3. Effect / External Operation State
4. Presentation / Interaction State

The central rule is:

Create a new explicit state when a condition changes the meaning of the system, the legal action space, the applicable invariants, or what can safely happen next.

Do not create a new state merely because some value changed.

⸻

1. Domain / Entity State

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
Corrected
Voided

Or:

MedicalRecord
Imported
NeedsReview
Verified
Superseded

When to create a new domain state

Create a new domain state when the object has entered a condition where one or more of these change:

* which operations are legal;
* which invariants apply;
* what the object means;
* who may act on it;
* what evidence is required;
* whether something may still be changed;
* whether a transition has irreversible consequences.

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

Example: time entry

Suppose a time entry can be changed freely before submission, but after submission a change must become an auditable correction.

That suggests:

Draft
    ↓ submit
Recorded
    ↓ correct
Corrected

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

When NOT to create a domain state

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

⸻

2. Workflow / Process State

Workflow state describes where a process currently is.

It is different from entity state.

An entity can remain in the same domain state while a process involving that entity moves through multiple workflow states.

Example:

Import Workflow
WaitingForFile
Reading
Parsing
Validating
Persisting
Complete

The imported record itself might not have six corresponding domain states.

The workflow needs them because the process must know what can happen next.

When to create a workflow state

Create a workflow state when the process reaches a step that changes:

* what operation is expected next;
* what inputs are required;
* which transitions are legal;
* which effects can occur;
* whether the process can continue;
* whether human intervention is required.

Example:

Time Entry Submission
Editing
    ↓ submit
Validating
    ↓
ReadyToSave
    ↓
Saving
    ↓
Complete

But even here, be careful.

Some of those may be better represented at another layer.

For example:

Saving

may actually belong to effect state rather than workflow state.

That leads to an important rule:

Workflow state should represent semantic process progression, not merely technical activity.

Example: time-entry correction

A correction workflow might be:

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

Workflow state vs domain state

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

⸻

3. Effect / External Operation State

Effect state describes what is known about an operation outside the deterministic domain system.

Examples include:

* database writes;
* HTTP requests;
* payment processing;
* sending email;
* writing to GitHub;
* calling an LLM;
* uploading a file;
* browser storage;
* communicating with another system.

A useful generic model is:

NotStarted
Pending
Succeeded
Failed
OutcomeUnknown

Why effect state deserves its own layer

External effects behave differently from domain state.

Inside the domain kernel:

state + command → deterministic result

But external systems may:

* fail;
* timeout;
* respond slowly;
* succeed without acknowledgment;
* acknowledge an operation that later rolls back;
* become unreachable after receiving a request.

That means external effects introduce epistemic uncertainty.

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

When to create effect state

Create explicit effect state when the external operation changes:

* what retry behavior is safe;
* whether the system should wait;
* whether reconciliation is needed;
* whether the user can proceed;
* what the system actually knows.

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

Do not merge effect state unnecessarily with domain state

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

⸻

4. Presentation / Interaction State

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

When presentation state should remain local

Suppose a user opens a project dropdown.

The domain does not care whether the dropdown is physically open.

Therefore:

projectDropdownOpen = true

does not belong in domain state.

Similarly:

mouseIsOverRow

is not meaningful application state.

When presentation state becomes semantic state

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

⸻

The Core Classification Test

Whenever a developer or agent wants to create a new state, ask these questions in order.

Question 1: Does this change domain meaning?

Example:

Draft → Approved

Yes.

Use:

Domain state

⸻

Question 2: Does this describe progress through a meaningful process?

Example:

GatheringEvidence → ReviewingEvidence

Yes.

Use:

Workflow state

⸻

Question 3: Does this describe what is known about an external operation?

Example:

SavePending → SaveOutcomeUnknown

Yes.

Use:

Effect state

⸻

Question 4: Is it merely a temporary UI condition?

Example:

SidebarExpanded

Yes.

Use:

Presentation state

⸻

The Legal Action Space Test

The most useful general rule is:

A new explicit state is justified when being in that condition changes the legal action space.

Consider:

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

⸻

The Invariant Test

Another reason to introduce a state is when different invariants apply.

Example:

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

For example:

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

⸻

The Boolean Smell

Boolean flags are frequently hidden state machines.

Consider:

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

Use the rule:

new boolean flag
      ↓
Can combinations with other flags create illegal or ambiguous states?
      ↓
YES
      ↓
consider an explicit state model

Booleans are fine when they genuinely represent independent facts.

Example:

isPinned

might be completely independent of document lifecycle.

Do not convert every Boolean into a discriminated union.

⸻

Avoiding State Explosion

State-oriented architecture can fail when every dimension gets multiplied together.

Suppose we have:

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

ApplicationState
    DomainState
    PersistenceState
    PresentationState

Then define rules governing interactions between them.

For example:

CanSubmit =
    DomainState = Draft
    AND
    PersistenceState != Pending

That capability is derived.

It does not require creating:

DraftAndNotPending

as another state.

⸻

State vs Capability

A capability answers:

What can happen now?

A state answers:

What condition is the system in?

Do not create states solely to express permissions.

Example:

Instead of:

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

Example:

CanApprove =
    State = Submitted
    AND
    UserHasApprovalAuthority
    AND
    RequiredEvidencePresent

No new state is necessary.

⸻

State vs Derived Data

Derived values should usually not become independent state.

Suppose time entries contain:

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

The rule is:

If the value can be deterministically calculated from authoritative state, prefer deriving it rather than creating another authoritative state variable.

⸻

State vs Obligation

An obligation represents:

Something that must still be resolved.

Example:

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

Examples:

NeedsHumanReview
NeedsEvidence
NeedsReconciliation
MissingRequiredInformation
ExternalOutcomeMustBeChecked

Do not turn every unresolved task into an entity state.

⸻

State vs Evidence

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

⸻

State vs Data

Data describes attributes.

Example:

TimeEntry
project
date
duration
description
labels

Those values belong inside a state.

Do not confuse:

different data

with:

different state

A time entry having:

Project A

instead of:

Project B

does not necessarily mean it has entered a new lifecycle state.

The distinction is:

Data answers:
    What information does the object contain?
State answers:
    What meaningful condition is the object currently in?

⸻

Detailed Time Entry Example

Consider the time-entry application.

A reasonable design might have:

TimeEntryState
Draft
Recorded
Voided

Corrections might be modeled through revisions rather than turning each corrected entry into another large lifecycle branch.

For example:

TimeEntry
id
state
currentRevision
revisionHistory

Creation:

Draft
    ↓ Validate
Recorded

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

⸻

Detailed Effect Example

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

⸻

Detailed Workflow Example

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

Example:

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

⸻

Detailed Presentation Example

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

Because changing:

hoveredEntry

has no semantic effect.

Changing:

selectedDateRange

changes the collection being requested and perhaps the derived totals shown to the user.

Whether query/filter state lives in the kernel should depend on whether it is considered meaningful application state.

In this architecture, domain-relevant list filtering and sorting generally belong in the kernel because agents, alternate hosts, and UI clients should receive the same collection semantics.

⸻

A Practical Decision Tree

Use this when deciding where something belongs.

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

⸻

Rules for Creating a New Explicit State

A proposed new state should generally satisfy at least one of these tests.

1. Different legal actions

Draft

allows actions that:

Approved

does not.

Good state distinction.

2. Different invariants

Draft

may be incomplete.

Submitted

must be complete.

Good state distinction.

3. Different transition rules

From:

Submitted

you may transition to:

Approved
Rejected

but not:

Deleted

Good state distinction.

4. Different authority requirements

A particular state may require another role/capability to advance.

Potentially meaningful state distinction.

5. Different evidence requirements

The next transition requires evidence specifically because of the current condition.

Potentially meaningful state distinction.

6. Different uncertainty/safety behavior

Failed

and:

OutcomeUnknown

have different safe next actions.

Good effect-state distinction.

If none of these apply, question whether the proposed state should exist.

⸻

Warning Signs of Too Many States

Watch for names like:

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

⸻

Warning Signs of Too Few States

The opposite failure is also common.

Example:

status: string

with values determined by conventions scattered through code.

Or:

if approved && !deleted && !processing && ...

This indicates meaningful states exist but are implicit.

Other warning signs:

* many Boolean flags interact;
* commands contain repeated checks for the same combinations;
* agents must infer legal behavior from conditional code;
* illegal combinations regularly appear;
* tests repeatedly reconstruct the same state rules;
* UI code independently decides which buttons should appear.

In those cases, promote the hidden state model into explicit representation.

⸻

State Granularity Principle

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

⸻

Independence Principle

When two state dimensions can vary independently, strongly prefer modeling them independently.

Example:

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

⸻

Capabilities as the Public Consequence of State

A powerful way to prevent UI and AI agents from reconstructing rules is to expose capabilities derived from state.

Example:

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

⸻

Final Design Principle

The purpose of explicit state is not to describe everything that is currently true.

The purpose is to make meaningful behavioral boundaries explicit.

Use:

Domain state

for what something is.

Use:

Workflow state

for where a meaningful process is.

Use:

Effect state

for what is known about interaction with the outside world.

Use:

Presentation state

for temporary UI mechanics.

Then use:

data
derived values
capabilities
evidence
obligations

for everything that does not deserve another lifecycle state.

The strongest rule is:

If introducing a new state does not change legal behavior, invariants, transition rules, authority, evidence requirements, or safety behavior, it probably should not be a new state.

And the complementary rule is:

If meaningful legal behavior depends on a condition that currently exists only as scattered booleans, null checks, strings, or conventions, that condition probably should become explicit state.