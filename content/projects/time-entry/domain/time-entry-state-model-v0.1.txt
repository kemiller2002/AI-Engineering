# Time Entry System — State Model v0.1

Date: 2026-08-14
Status: Initial semantic model
Purpose: Define the first application-specific state machines, transitions, requirements, invariants, and derived capabilities for the time-entry system.

This document is intentionally separate from the business requirements.

Business requirements define what the product must do.
This document defines the current semantic/state model used to implement those requirements.

Core rule:

> States describe durable semantic conditions.
> Transitions describe legal changes.
> Requirements describe conditions for a specific transition.
> Invariants describe truths that must always hold.
> Capabilities are derived legal actions, not additional state.

Do not add states merely because a value can be represented as an enum.
A state should exist because it changes legitimate future behavior.

---

# 1. TimeEntry State Family

## TimeEntryStatus

    Recorded
    Voided
    Superseded

### Recorded

Meaning:

The entry is part of the presently authoritative allocation of time.

Consequences:

- contributes to totals;
- may be corrected;
- may be split when splittable;
- may be voided.

### Voided

Meaning:

The entry was intentionally withdrawn from current reported time.

Consequences:

- does not contribute to totals;
- remains historically recoverable;
- has no ordinary v0.1 transitions.

### Superseded

Meaning:

The entry was replaced by one or more new entries that now represent the same underlying time allocation more accurately.

Typical cause:

- SplitTimeEntry

Consequences:

- does not contribute to totals;
- replacement entries are authoritative;
- remains historically recoverable;
- has no ordinary v0.1 transitions.

Voided and Superseded are intentionally different.

Voided means:

    this entry should no longer count

Superseded means:

    this time still exists, but this representation has been replaced

---

# 2. TimeEntry Transition Table

| Source | Operation | Result |
|---|---|---|
| none | CreateTimeEntry | Recorded |
| Recorded | CorrectTimeEntry | Recorded |
| Recorded | SplitTimeEntry | source Superseded + two Recorded children |
| Recorded | VoidTimeEntry | Voided |
| Voided | none in v0.1 | terminal |
| Superseded | none in v0.1 | terminal |

---

# 3. CreateTimeEntry

Transition:

    none -> Recorded

Inputs:

    PersonId
    Date
    Start
    DurationUnits
    ProjectId
    Labels[]
    Description

Requirements:

- person exists;
- person is active;
- project exists;
- project is Active;
- selected labels exist;
- selected labels are active;
- durationUnits > 0;
- duration is integral six-minute units;
- start is on a six-minute boundary;
- interval does not cross midnight;
- description is non-blank;
- interval does not overlap another Recorded entry for the same person.

Produces:

- new stable TimeEntryId;
- status = Recorded;
- initial revision/version;
- creation provenance.

---

# 4. CorrectTimeEntry

Transition:

    Recorded -> Recorded

A semantic transition does not have to change an enum value.

Correctable values:

- date;
- start;
- durationUnits;
- project;
- labels;
- description.

Requirements:

- source entry is Recorded;
- resulting durationUnits > 0;
- resulting start is on a six-minute boundary;
- resulting interval does not cross midnight;
- resulting interval does not overlap another Recorded entry for the same person;
- resulting description is non-blank;
- selected labels exist;
- newly assigned labels are active;
- project exists.

Project rule:

An archived project cannot be newly assigned.

However, an existing entry that already references a project later archived may retain that historical project association while correcting unrelated fields.

If the correction changes ProjectId, the destination project must be Active.

Produces:

- same TimeEntryId;
- status remains Recorded;
- revised values;
- revision/version increment;
- historical change remains recoverable.

---

# 5. SplitTimeEntry

Transition:

    Recorded source
        ->
    Superseded source
    + Recorded left child
    + Recorded right child

Inputs:

    SourceEntryId
    SplitPoint

Requirements:

- source.status = Recorded;
- split point > source start;
- split point < source end;
- split point lies on six-minute boundary;
- both resulting entries have duration >= 1 unit.

Derived values:

    left.start = source.start
    left.end = splitPoint

    right.start = splitPoint
    right.end = source.end

Strong postconditions:

    left.durationUnits + right.durationUnits
        =
    source.durationUnits

Children must exactly cover the original interval.

No gap.
No overlap.

Both children preserve:

- personId;
- date.

Both initially inherit:

- projectId;
- labels;
- description.

Provenance:

    left.splitFrom = source.id
    right.splitFrom = source.id

Recommended reverse relationship:

    source.supersededBy = [left.id, right.id]

Produces:

    source.status = Superseded
    left.status = Recorded
    right.status = Recorded

The source no longer contributes to totals.

---

# 6. VoidTimeEntry

Transition:

    Recorded -> Voided

Inputs:

    EntryId
    Reason?  # optional initially

Requirements:

- entry.status = Recorded.

Produces:

- status = Voided;
- void timestamp;
- optional reason;
- version/revision increment.

Consequences:

The entry stops contributing to:

- day totals;
- week totals;
- project totals;
- label totals.

Voided is terminal in v0.1.

Do not add RestoreTimeEntry until a real product requirement justifies it.

---

# 7. Derived TimeEntry Capabilities

Capabilities are not states.

They are derived from state plus other requirements.

## Recorded entry

Generally available:

    CanCorrect
    CanVoid

## Recorded entry with durationUnits >= 2

Additionally:

    CanSplit

## Recorded entry with durationUnits = 1

    CanSplit = false

because no legal interior six-minute boundary exists.

## Voided

No ordinary v0.1 capabilities.

## Superseded

No ordinary v0.1 capabilities.

Do not create states such as:

    RecordedSplittable
    RecordedNotSplittable

Splittable is a derived capability, not lifecycle state.

---

# 8. TimeEntry Invariants

These must hold regardless of which transition produced current state.

## TIME-001

    durationUnits > 0

for every Recorded entry.

## TIME-002

Duration is an integer number of six-minute units.

## TIME-003

Start lies on a six-minute boundary.

## TIME-004

A Recorded entry does not cross midnight.

## TIME-005

Recorded entries for the same person do not overlap.

## TIME-006

Every Recorded entry references an existing project.

## TIME-007

Every label reference resolves to a known label.

## TIME-008

Description is non-blank.

## TIME-009

Voided and Superseded entries do not contribute to current totals.

---

# 9. State vs Requirement vs Invariant

Example state:

    entry.status = Recorded

Example transition requirement:

    SplitPoint lies strictly inside the entry interval

Example invariant:

    Recorded entries for the same person do not overlap

Do not create lifecycle states for:

    NonOverlapping
    ValidProject
    HasDescription
    Splittable

Those are invariants or derived conditions.

---

# 10. Project State Family

## ProjectStatus

    Active
    Archived

### Active

- accepts new ordinary time entries;
- may be corrected;
- may be archived.

### Archived

- remains historically resolvable;
- remains reportable;
- may not receive newly assigned ordinary time entries.

Potential Reactivate behavior must be an explicit product decision.

---

# 11. Project Transitions

## CreateProject

    none -> Active

## CorrectProject

    Active -> Active

Potentially allow limited corrections to Archived projects if needed for historical metadata, but do not assume this without a requirement.

## ArchiveProject

    Active -> Archived

## ReactivateProject

Not required in v0.1 unless explicitly approved.

---

# 12. Cross-State Semantic Dependencies

TimeEntry and Project remain separate state families.

Do not combine them into a single mega-state.

Example:

    CreateTimeEntry

requires:

    Project(projectId).status = Active

This is a semantic dependency:

    TimeEntry.Create
        depends on
    Project.Active

CorrectTimeEntry has a related dependency:

If ProjectId changes:

    destination Project.status must be Active

An existing historical reference to an Archived project remains legitimate.

---

# 13. Synchronization State Family

Synchronization state is not TimeEntry business state.

## SyncState

    Clean
    ModifiedLocally
    Saving
    SaveFailed
    SaveOutcomeUnknown
    Conflict

This state family describes persistence/execution condition.

A TimeEntry may remain:

    Recorded

while synchronization is:

    SaveOutcomeUnknown

Do not merge these dimensions.

---

# 14. Synchronization Transitions

## LocalSemanticChange

    Clean -> ModifiedLocally

A valid local semantic transition has changed the current weekly document but has not yet been durably confirmed remotely.

## BeginSave

    ModifiedLocally -> Saving

## SaveConfirmed

    Saving -> Clean

Remote GitHub state conclusively contains intended change.

## SaveKnownFailed

    Saving -> SaveFailed

The system has authoritative evidence that the intended write did not occur.

## SaveIndeterminate

    Saving -> SaveOutcomeUnknown

The caller cannot establish whether the intended GitHub write committed.

Examples:

- connection lost after request dispatch;
- timeout before conclusive response;
- ambiguous transport failure.

## SaveConflict

    Saving -> Conflict

Expected Git SHA/version is stale.

Remote state changed concurrently.

## RetryKnownFailedSave

    SaveFailed -> Saving

Legal only when prior effect is known not to have occurred.

## ReconcileUnknownSuccess

    SaveOutcomeUnknown -> Clean

Reconciliation proves intended write already exists remotely.

## ReconcileUnknownAbsent

    SaveOutcomeUnknown -> ModifiedLocally

Reconciliation proves intended write did not occur.

Only after this transition may normal save logic create a new write attempt.

## ResolveConflict

    Conflict -> ModifiedLocally

Requires deliberate semantic resolution of local vs remote state.

---

# 15. Synchronization Capability Principles

## Saving

Do not start another equivalent semantic save while an existing save attempt is unresolved.

## SaveOutcomeUnknown

Available:

    ReconcileRemoteState

Unavailable:

    blindly create another equivalent save operation

Unknown must not collapse into failure.

## Conflict

Available:

    InspectRemote
    ResolveConflict

Do not apply generic last-write-wins.

---

# 16. Semantic Operation Identity for Persistence

A future implementation should associate a stable semantic operation ID with a meaningful save operation.

Example:

    SaveWeek:kevin:2026-08-10:<operation-id>

Transport retries are attempts of the same semantic operation.

Do not confuse:

    retry same semantic operation

with:

    create another new semantic operation

This distinction is especially important during SaveOutcomeUnknown.

---

# 17. State Families in v0.1

The current intended state families are:

    TimeEntryStatus
        Recorded
        Voided
        Superseded

    ProjectStatus
        Active
        Archived

    SyncState
        Clean
        ModifiedLocally
        Saving
        SaveFailed
        SaveOutcomeUnknown
        Conflict

These state families are intentionally independent.

Do not construct a Cartesian-product mega-state such as:

    RecordedActiveProjectSaving

Compose dimensions through requirements and dependencies instead.

---

# 18. States We Are Deliberately NOT Adding Yet

Do not currently introduce:

    Draft
    Submitted
    Approved
    Rejected
    Locked
    Billed
    Invoiced
    PendingApproval
    ReadyForBilling

These may become legitimate later if they change what actions are legally available.

Rule:

> Earn your states.

---

# 19. Future State-Migration Experiment

A later version may introduce approval state.

Example:

    Approved

may later split into:

    ManagerApproved
    ClientApproved

or:

    InternallyApproved
    ReadyForBilling

When this occurs, consequential interpretations must not silently inherit old Approved behavior.

Dependent meanings such as:

    CanEdit
    CanInvoice
    CanExport
    CanClosePeriod

must be explicitly reconsidered.

This is intended as a test of semantic dependency and migration handling.

---

# 20. Implementation Directive

Implement these state families as application-specific semantic types.

Do not create a generic metadata-driven runtime representation of business state.

The reusable architecture may understand:

- how to validate transitions;
- how to derive capabilities;
- how to version state;
- how to track semantic dependencies;
- how to produce structured diagnostics.

It should not define what Recorded, Voided, Superseded, Active, or Archived mean.

Those meanings belong to this application.
