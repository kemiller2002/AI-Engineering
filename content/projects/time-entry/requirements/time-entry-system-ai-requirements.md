# Time Entry System — AI Implementation Requirements

Date: 2026-08-14
Status: Initial implementation specification

## Purpose

Build a simple, reliable time-entry application for recording project work in exact six-minute increments.

This document intentionally separates:

1. Business/Product Requirements
2. Domain Rules and Invariants
3. Architecture/Implementation Requirements
4. Acceptance Criteria
5. Non-Goals and Future Experiments

An implementing AI must not blur these categories.

A business requirement defines what the application must mean or do.
An architectural requirement defines how this implementation is currently intended to satisfy those business requirements.

Core principles:

> Genericize the mechanics. Specialize the semantics.

> If metadata required to explain a generic abstraction approaches the complexity of the domain model it replaces, the abstraction has failed.

Do not build a generic timekeeping platform or generic state-machine framework.

---

# PART A — BUSINESS AND PRODUCT REQUIREMENTS

## 1. Native time unit

### BR-TIME-001 — Six-minute unit

The authoritative unit of time is six minutes.

    1 unit  = 6 minutes = 0.1 hour
    5 units = 30 minutes = 0.5 hour
    10 units = 60 minutes = 1.0 hour

Store and calculate authoritative duration as integer six-minute units.

Do not store authoritative duration as floating-point decimal hours.

Reasons:
- exact arithmetic;
- no rounding ambiguity;
- exact splitting;
- exact totals;
- direct match to intended reporting.

---

## 2. Time blocks

### BR-TIME-010 — Time entries are blocks

A time entry represents a specific block of work time.

A time entry contains:
- stable entry ID;
- person;
- date;
- start time;
- duration in six-minute units;
- project;
- non-blank description;
- zero or more labels.

End time is derived from start + duration.

### BR-TIME-011 — Six-minute grid

Start times must fall on six-minute boundaries:

    09:00
    09:06
    09:12
    09:18

Duration must be one or more whole units.

### BR-TIME-012 — No cross-midnight entry

One entry may not span two calendar days.

Work crossing midnight must be represented as two entries.

### BR-TIME-013 — No overlapping active time

Active entries for the same person may not overlap.

The same six-minute unit may not be counted twice for one person.

If overlapping allocation is ever allowed, it must be an explicit later business rule.

---

## 3. Persons

### BR-PERSON-001

Every time entry belongs to exactly one person.

Minimum person data:

    personId
    displayName
    active

GitHub identity may be associated with the person, but GitHub identity is not automatically the business-domain identity.

---

## 4. Projects

### BR-PROJECT-001

Every active time entry belongs to exactly one project.

Project is a first-class business concept, not merely a string label.

### BR-PROJECT-002 — Stable identity

Projects have stable IDs independent of names.

Recommended fields:

    projectId
    code
    name
    description?
    status

### BR-PROJECT-003 — Status

Initial project status:

    Active
    Archived

Active projects may receive new entries.

Archived projects:
- remain historically resolvable;
- remain reportable;
- cannot receive ordinary new entries.

Do not add additional project states until they change legitimate future behavior.

---

## 5. Labels

### BR-LABEL-001

Labels are distinct from projects.

Project answers:

    What body of work was this for?

Label answers:

    What kind of work was performed?

Example:

    Project: HelixNote
    Labels: Architecture, Research, UI

### BR-LABEL-002

An entry may have zero or more labels.

Labels have stable IDs independent of names.

Suggested fields:

    labelId
    name
    description?
    active

Inactive labels remain historically resolvable but should not normally be assignable to new entries.

---

## 6. Description

### BR-DESC-001

Every active entry must have a non-blank human-readable description.

Description answers:

    What work was actually performed?

Example:

    Research semantic dependency handling for state splits

Project and labels do not replace the description.

---

## 7. Create entry

### BR-ENTRY-001

The user must be able to manually create a time block.

Required:
- date;
- start;
- duration or end;
- project;
- description.

Optional:
- labels.

All domain rules must be validated before acceptance.

---

## 8. Correct entry

### BR-CORRECT-001

An existing entry can be corrected.

Correction may change:
- start;
- duration;
- project;
- labels;
- description.

Correction must preserve all domain invariants.

### BR-CORRECT-002

The business operation is conceptually:

    CorrectTimeEntry

not an unrestricted arbitrary persistence PATCH.

The UI may edit fields, but the resulting domain change must be validated as one legitimate correction.

### BR-CORRECT-003

Corrections must not erase prior recorded values from history.

The current version is authoritative for current reporting, while historical versions remain recoverable through audit/persistence history.

A correction reason may initially be optional.

---

## 9. Split entry

### BR-SPLIT-001

The user must be able to split one time block into two adjacent blocks.

Example:

Original:

    09:00–10:30
    15 units

Split at 10:00:

    09:00–10:00
    10 units

    10:00–10:30
    5 units

### BR-SPLIT-002 — Split requirements

A valid split:
- occurs strictly inside the original interval;
- occurs on a six-minute boundary;
- creates two non-zero blocks;
- preserves total duration exactly;
- preserves original interval coverage exactly;
- creates no gap;
- creates no overlap;
- preserves person and date.

Children initially inherit:
- project;
- labels;
- description.

Either child may then be corrected independently.

### BR-SPLIT-003 — Provenance

Both child entries retain explicit provenance linking them to the source entry.

Do not rely only on visual similarity or Git history.

### BR-SPLIT-004 — Source ceases to count

After split, the original source entry must no longer contribute to totals.

Do not destructively erase historical meaning merely to simplify current totals.

---

## 10. Adjust split boundary — later feature

### BR-SPLIT-010

Later, allow the split point between two adjacent split-derived entries to move.

Example:

    09:00–10:00
    10:00–11:00

becomes:

    09:00–09:48
    09:48–11:00

Requirements:
- combined interval unchanged;
- each result >= 1 unit;
- split remains on six-minute boundary;
- no overlap introduced.

May be deferred beyond v0.1.

---

## 11. Merge — later feature

### BR-MERGE-001

Later, support merging adjacent entries.

Minimum:
- same person;
- same date;
- first ends exactly where second begins.

If project, labels, or descriptions differ, do not silently choose values.

Resulting metadata must be explicitly selected.

May be deferred beyond v0.1.

---

## 12. Void/delete

### BR-VOID-001

Persisted/reported history should not be silently erased.

A persisted entry removed from current totals should be voided/superseded/corrected rather than destructively deleted.

A voided entry:
- remains historically recoverable;
- contributes zero to current totals.

### BR-VOID-002

An unsaved entry that never became meaningful persisted history may simply be discarded.

Do not create a complex Draft lifecycle unless required later.

---

## 13. Views

### BR-VIEW-001 — Day view

Provide a chronological daily timeline.

Show:
- start;
- end;
- duration;
- project;
- description;
- labels;
- correction/void status where relevant.

Splitting should be visually understandable.

### BR-VIEW-002 — Week view

Provide a week-oriented view with:
- total per day;
- total for week;
- entries accessible/grouped by day.

Week is a primary review/reporting unit.

---

## 14. Reporting and search

### BR-REPORT-001

Totals must derive exclusively from integer six-minute units.

Initial totals:
- day;
- week;
- project;
- label.

### BR-REPORT-002

Support date-range reporting.

### BR-REPORT-003

Support description text search.

### BR-REPORT-004

Useful filters:
- date range;
- project;
- label;
- person when applicable;
- text.

Search/filter should normally operate locally on already retrieved data when practical.

---

## 15. Initial business scope

Version 0.1 includes:
- Person
- Project
- Label
- manual blocks
- six-minute native units
- required description
- project assignment
- labels
- correction
- split
- void
- no overlap
- day view
- week view
- exact totals
- basic filtering/search

Do not add approval, billing, payroll, invoicing, budgets, timers, or complicated permissions until explicitly required.

---

## 16. Payroll boundary

This is initially a project/work-time allocation system, not an authoritative payroll time clock.

Do not silently treat these records as statutory wage/payroll truth.

If payroll, overtime, employee clocking, or wage compliance enters scope, revisit the domain and legal requirements explicitly.



# PART B — DOMAIN RULES AND INVARIANTS

## Core time invariants

### INV-TIME-001

    durationUnits > 0

### INV-TIME-002

Duration is an integer number of six-minute units.

### INV-TIME-003

Start time lies on a six-minute boundary.

### INV-TIME-004

An entry does not cross a calendar-day boundary.

### INV-TIME-005

Active entries for the same person do not overlap.

### INV-TIME-006

Every active entry references an existing project.

### INV-TIME-007

New ordinary entries reference active projects only.

### INV-TIME-008

Every label reference resolves to a known label.

### INV-TIME-009

Description is not blank/whitespace.

### INV-TIME-010

Voided/superseded entries do not count in totals.

## Split invariants

### INV-SPLIT-001

Split point > original start.

### INV-SPLIT-002

Split point < original end.

### INV-SPLIT-003

Split point lies on six-minute boundary.

### INV-SPLIT-004

Left duration + right duration = original duration exactly.

### INV-SPLIT-005

Children exactly cover original interval with no gap or overlap.

### INV-SPLIT-006

Source entry ceases contributing to totals.

### INV-SPLIT-007

Both children preserve source-entry provenance.

## Project invariants

### INV-PROJECT-001

Project identity survives rename.

### INV-PROJECT-002

Archived projects remain historically resolvable.

### INV-PROJECT-003

Archived projects cannot receive ordinary new time.

## Label invariants

### INV-LABEL-001

Label identity survives rename.

### INV-LABEL-002

Inactive labels remain historically resolvable.



# PART C — ARCHITECTURE AND IMPLEMENTATION REQUIREMENTS

## 17. Domain-model rule

### AR-001 — Application-specific semantics

Model this application directly.

Preferred concepts:

    TimeEntry
    Person
    Project
    Label
    CorrectTimeEntry
    SplitTimeEntry
    VoidTimeEntry

Do not implement application meaning as:

    GenericStateMachine<TimeEntry>

or a large generic metadata structure describing states/transitions/rules.

### AR-002 — Genericize mechanics only

Generic/shared machinery may support:
- semantic IDs;
- transition validation;
- version checking;
- capability derivation;
- dependency tracking;
- structured diagnostics;
- persistence adapters;
- serialization;
- synchronization.

It must not define generic business meaning.

---

## 18. WASM / TypeScript boundary

The UI is an experiment in:
- application/domain semantics in WASM;
- minimal browser/platform kernel in TypeScript.

Do not add SPA or client-state frameworks unless genuinely necessary.

### AR-WASM-001 — WASM owns business semantics

WASM owns:
- TimeEntry types;
- Project types;
- Label types;
- six-minute unit;
- validation;
- overlap detection;
- splitting;
- correction validation;
- void/supersede behavior;
- totals;
- capability derivation;
- domain projections;
- validation of persistence data into domain types where practical.

Business rules must not be independently duplicated in TypeScript.

### AR-TS-001 — TypeScript owns browser/platform mechanics

TypeScript owns:
- WASM bootstrap;
- DOM events;
- DOM rendering/update;
- browser routing/history if needed;
- fetch;
- GitHub API communication;
- authentication handoff;
- local browser cache;
- serialization/bridge;
- ephemeral UI state.

TypeScript must not become a second business/domain implementation.

### AR-TS-002 — Ephemeral UI state is allowed

Examples:
- selected tab;
- open dialog;
- route;
- focus;
- scroll position;
- temporary form state.

UI state must not redefine domain truth.

---

## 19. Minimal dependencies

### AR-DEP-001

Default to no external libraries unless necessary.

Prefer:
- browser APIs;
- language/runtime standard libraries;
- native WASM facilities;
- explicit simple code.

Do not add frameworks solely for convenience.

---

## 20. Persistence

GitHub is the persistent datastore.

JSON files are the persistent representation.

GitHub JSON is not the domain model.

Required flow:

    GitHub JSON
        -> parse
        -> schema validate
        -> construct application-specific domain types
        -> apply domain operations
        -> serialize
        -> persist to GitHub

Do not treat arbitrary raw JSON/dictionaries as authoritative domain state.

---

## 21. JSON partitioning

Avoid:
- one giant time-entries.json;
- one entry file per record in one flat directory.

Recommended initial organization:

    /data/
        projects/
            <project-id>.json

        labels/
            labels.json

        people/
            <person-id>/
                <year>/
                    <month>/
                        <week-start>.json

Example:

    /data/people/kevin/2026/08/2026-08-10.json

Week is the recommended time-entry persistence boundary because it aligns with:
- normal review;
- weekly totals;
- overlap validation;
- later approval;
- conflict scope;
- Git write locality.

---

## 22. Weekly JSON shape

Recommended concept:

    {
      "schemaVersion": 1,
      "semanticVersion": 1,
      "personId": "kevin",
      "weekStarting": "2026-08-10",
      "documentRevision": 17,
      "entries": [...]
    }

schemaVersion describes physical persistence representation.

semanticVersion describes business interpretation.

Do not assume they are permanently the same concept.

---

## 23. Identity

Every entry, project, label, and person needs a stable unique ID.

Entry identity survives ordinary corrections.

Split creates new child entry IDs and records source provenance.

Never use array position as identity.

---

## 24. GitHub optimistic concurrency

When loading a GitHub JSON document, retain its current file/blob SHA or equivalent version.

Saving should conceptually be:

    save(expectedVersion, updatedDocument)

If remote content changed since load, do not silently overwrite.

Return a conflict and reconcile.

Never use last-write-wins for semantic data.

---

## 25. Conflict resolution

On version conflict:

1. fetch current remote state;
2. compare against expected base;
3. identify whether changes are semantically independent;
4. merge only when explicitly safe;
5. otherwise surface a deliberate conflict.

Likely safe example:

    local changes description on Entry A
    remote adds unrelated Entry B

Likely semantic conflict:

    local splits Entry A
    remote changes Entry A duration

Do not use a generic JSON merge as proof of semantic safety.

---

## 26. One semantic operation, one logical write where possible

Operations within one weekly document should be persisted as one logical GitHub update.

SplitTimeEntry should not require separate remote delete/create operations if all affected entries belong to one week file.

If a later operation genuinely needs multi-file atomic change, evaluate Git blob/tree/commit/ref APIs so one Git commit represents the complete change.

Do not build multi-file transaction machinery before required.

---

## 27. Git history and audit

Use Git commits as durable persistence/audit history.

Examples:

    time: add 1.5h to HelixNote on 2026-08-14
    time: split TE-923 at 10:00
    time: correct TE-924 project HelixNote -> Echelon
    project: archive HELIX

Do not rewrite Git history to hide corrections.

---

## 28. GitHub authentication

For a trusted single-user experiment, a fine-grained GitHub token restricted to the data repository may be acceptable.

Do not:
- hard-code a broad token into source;
- assume a browser-embedded long-lived PAT is suitable for multi-user production.

Future multi-user options may include:
- GitHub App;
- OAuth;
- short-lived user tokens;
- tiny token exchange/proxy.

GitHub remains the datastore unless business requirements change.

---

## 29. Remote efficiency

Do not make a GitHub request for every UI interaction.

Preferred flow:

    load relevant week
        -> validate into domain state
        -> operate locally
        -> persist meaningful semantic changes

Use local caching.

Search/filter already retrieved data locally.

---

## 30. Synchronization state is not business state

Synchronization may have states like:

    Clean
    ModifiedLocally
    Saving
    SaveFailed
    SaveOutcomeUnknown
    Conflict

These are execution/synchronization states.

They are not TimeEntry business states.

Keep dimensions separate.

---

## 31. Unknown GitHub write outcome

A lost connection after sending a GitHub write does not prove the write failed.

If the response is indeterminate:

    SaveOutcomeUnknown

Then:
1. inspect repository/branch/file/commit state;
2. determine whether the intended write occurred;
3. only then decide whether another write is appropriate.

Do not convert timeout directly into authoritative failure.

This is intentionally a real test of external-effect uncertainty handling.

---

## 32. Keep current business state minimal

Do not introduce:

    Draft
    Submitted
    Approved
    Locked
    Billed

until they affect legitimate future actions.

States must be earned.

A state deserves to exist when its value changes what may legally happen next.

---

## 33. Initial semantic operations

Likely initial TimeEntry operations:

    CreateTimeEntry
    CorrectTimeEntry
    SplitTimeEntry
    VoidTimeEntry

Do not create a semantic transition for every UI field unless behavior genuinely differs.

Likely project operations:

    CreateProject
    CorrectProject
    ArchiveProject
    ReactivateProject

Only include ReactivateProject if that behavior is intentionally allowed.

---

## 34. Capability behavior

The domain/runtime should be able to determine currently legal actions.

Example active entry:

    Correct
    Split
    Void

Example archived project, if reactivation allowed:

    Reactivate

UI or AI code should not independently rediscover legality from scattered rules.

---

## 35. Diagnostics

Validation errors should be structured.

Avoid:

    Invalid entry

Prefer:

    TIME_OVERLAP
    ExistingEntry: TE-122
    ConflictInterval: 09:30–10:00

or:

    INVALID_SPLIT_POINT
    SplitPoint: 09:57
    Reason: NotOnSixMinuteBoundary

Diagnostics should serve both UI and future AI use.



# PART D — ACCEPTANCE CRITERIA

## AC-001 — Valid entry

Given:
- active Project P1;

When creating:
- date 2026-08-14;
- start 09:00;
- duration 10 units;
- project P1;
- description "Architecture research";

Then:
- entry accepted;
- end = 10:00;
- total = exactly 1.0 hour;
- authoritative persisted duration = 10 units.

## AC-002 — Invalid start

Given start 09:05:

Then:
- reject entry;
- return six-minute-boundary diagnostic.

## AC-003 — Overlap

Given existing:

    09:00–10:00

When adding:

    09:48–10:30

for same person:

Then:
- reject;
- identify conflicting interval/entry.

## AC-004 — Split

Given:

    TE-100
    09:00–10:30
    15 units
    Project A
    Labels [Research]
    Description "Semantic architecture"

When split at 10:00:

Then:
- create two current entries;
- intervals 09:00–10:00 and 10:00–10:30;
- units 10 and 5;
- units sum to 15;
- both retain source provenance TE-100;
- source no longer contributes to totals;
- no gap;
- no overlap.

## AC-005 — Correct one split child

After AC-004, change second child project to Project B.

Then:
- first child stays Project A;
- second child is Project B;
- total remains 15 units;
- correction remains recoverable in history.

## AC-006 — Archived project

Given Project A is Archived:

When creating new ordinary time against Project A:

Then reject.

Historical entries referencing Project A remain displayable/reportable.

## AC-007 — Void

Given active entry = 10 units.

When voided:

Then:
- entry remains historically recoverable;
- current totals decrease exactly 10 units;
- persistence history records the operation.

## AC-008 — Concurrent GitHub edit

Given Client A loaded week at SHA-1.

Client B saves a change producing SHA-2.

When Client A saves against SHA-1:

Then:
- do not overwrite SHA-2;
- return conflict;
- require refresh/reconciliation.

## AC-009 — Unknown write outcome

Given a GitHub write is sent and the response is lost:

Then:
- do not immediately assume failure;
- mark synchronization outcome unknown;
- inspect remote state;
- decide retry/new operation only after reconciliation.

## AC-010 — TypeScript/WASM boundary

When a user requests a split:

TypeScript may:
- capture user input;
- invoke WASM;
- render the result.

TypeScript must not independently:
- calculate authoritative legal split points;
- implement duration invariants;
- implement overlap rules;
- mutate domain state without domain/WASM validation.



# PART E — NON-GOALS

Do not implement unless separately requested:

- payroll;
- wage/time-clock compliance;
- billing rates;
- invoicing;
- payment processing;
- expense tracking;
- employee scheduling;
- approval workflow;
- overtime calculation;
- running timers;
- calendar sync;
- broad external integrations;
- generic workflow engine;
- generic state-machine framework;
- universal semantic DSL;
- generalized rules engine;
- React;
- Redux;
- Angular;
- Vue;
- large UI framework;
- unnecessary dependency stack.

---

# PART F — OPEN DESIGN DECISIONS

The implementation AI may choose the simplest reasonable option for:

- exact WASM implementation language;
- JSON property names;
- ID format;
- HTML/CSS structure;
- UI organization;
- repository name;
- cache mechanism;
- commit-message exact formatting;
- route structure;
- serialization API shape;
- minor file partition refinements.

These are implementation details unless given business meaning later.

Do not silently invent business rules for:

- approval;
- billing;
- locking;
- multi-user permissions;
- timers;
- payroll;
- overlapping time;
- cross-day entry;
- deletion of meaningful history;
- auto-merging conflicting entries;
- automatic semantic-conflict resolution.

If a missing business decision is required, surface it explicitly.

---

# PART G — FUTURE SEMANTIC-ARCHITECTURE EXPERIMENTS

These are later experiments, not v0.1 requirements.

## Approval / locking

Potential future state:

    Draft
    Submitted
    Approved
    Locked

Only introduce when actual business behavior needs it.

## Semantic migration

Possible future change:

    Approved
        ->
    ManagerApproved
    ClientApproved

or:

    InternallyApproved
    ReadyForBilling

The system should require explicit reconsideration of dependent meanings such as:

    CanEdit
    CanInvoice
    CanExport
    CanClosePeriod

Do not silently inherit old behavior.

## Obligations

Possible:

    Timesheet submitted
        ->
    obligation:
        ReceiveAuthorizedDisposition

Possible dispositions:

    Approved
    Rejected
    Withdrawn

The obligation is the required semantic condition, not the task assigned to a worker/agent.

## External effect

GitHub persistence already gives a real test:

    save sent
        ->
    response lost
        ->
    outcome unknown
        ->
    reconciliation

## AI-facing capabilities

Later:

    inspect(TimeEntry TE-100)

could return:

    state:
        active

    capabilities:
        Correct
        Split
        Void

An AI should not need unrestricted mutation or repository archaeology to discover legal actions.



# PART H — IMPLEMENTATION GUIDANCE

Recommended implementation order:

1. domain types;
2. six-minute unit;
3. invariants;
4. Person/Project/Label;
5. create entry;
6. correct entry;
7. split entry;
8. void entry;
9. totals;
10. weekly JSON schema;
11. GitHub read;
12. version-aware GitHub write;
13. synchronization/conflict handling;
14. WASM API;
15. minimal TypeScript browser kernel;
16. day/week UI;
17. filters/search;
18. history display if needed.

## Simplicity rule

Prefer the smallest solution that directly represents the domain.

Do not pre-build:
- hypothetical reusable platform abstractions;
- multi-tenancy;
- billing;
- approval;
- generic state engines;
- generic metadata engines;
- generalized workflow infrastructure.

## Testing rule

Maintain two conceptual classes of tests.

### Independent domain/acceptance tests

These express desired product behavior:

- six-minute intervals;
- no overlap;
- split preserves coverage/duration;
- archived project rejects new time;
- void removes entry from totals.

### Structural/conformance tests

These test implementation consistency:

- serialization round trip;
- version checks;
- GitHub conflicts;
- WASM/TS contract;
- generated/projection consistency if generation is later introduced.

Do not treat tests derived from the same implementation metadata as independent proof that a business rule is correct.

---

# FINAL DIRECTIVE TO IMPLEMENTING AI

Build the application described by the business requirements.

Do not build a generic timekeeping platform.

Do not build a generic state-machine framework.

Do not move application meaning into metadata for reuse.

Do not reproduce domain/business logic independently in TypeScript and WASM.

Keep product semantics:
- application-specific;
- explicit;
- typed;
- easy to inspect.

Use generic infrastructure only for mechanics that are genuinely reusable.

The product has two purposes:

1. provide a useful six-minute project time-entry system;
2. serve as a controlled experiment for application-specific semantic state, a minimal TypeScript browser kernel, WASM-owned domain semantics, GitHub JSON persistence, capability derivation, conflict handling, and explicit uncertain external outcomes.

When abstraction convenience conflicts with semantic clarity or correctness, prefer semantic clarity and correctness.
