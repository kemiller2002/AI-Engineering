# Time Entry System — Large-View Architecture v0.1

Date: 2026-08-14
Status: Initial architecture
Purpose: Record the high-level architecture for the first implementation of the time-entry system while preserving a strict separation between presentation, application/domain semantics, infrastructure/services, and persistence.

This document describes HOW the current implementation is organized.

It does not replace the business requirements or the application-specific state model.

Core architectural rule:

> WASM owns application meaning. TypeScript and GitHub do not.

A second important rule:

> Logical architectural layers do not have to be separate deployment processes.

The service layer may initially run in the browser while remaining architecturally distinct from presentation and domain code.

---

# 1. Large-View Architecture

The first implementation has four logical layers:

    1. Presentation
       HTML / CSS / minimal TypeScript

    2. Application + Domain
       WASM
       application-specific semantic state and behavior

    3. Infrastructure / Services
       persistence coordination
       GitHub repository adapter
       synchronization
       authentication boundary
       version / conflict handling

    4. Persistence
       GitHub repository
       JSON documents
       Git SHAs / versions
       commit history

High-level flow:

    ┌─────────────────────────────────────────────┐
    │              Browser Application            │
    │                                             │
    │  HTML / CSS                                 │
    │  Minimal TypeScript Kernel                  │
    │  WASM Application / Domain Core             │
    └──────────────────────┬──────────────────────┘
                           │
                           │ application commands / queries
                           ▼
    ┌─────────────────────────────────────────────┐
    │                Service Layer                │
    │                                             │
    │  application operations                     │
    │  persistence coordination                   │
    │  version / conflict handling                │
    │  GitHub protocol                            │
    │  authentication boundary                    │
    └──────────────────────┬──────────────────────┘
                           │
                           │ GitHub API
                           ▼
    ┌─────────────────────────────────────────────┐
    │             GitHub Data Store               │
    │                                             │
    │  JSON documents                             │
    │  Git versions / SHAs                        │
    │  commits / history                          │
    └─────────────────────────────────────────────┘

---

# 2. Layer 1 — Presentation

The presentation layer consists of:

    HTML
    CSS
    minimal TypeScript

The presentation layer is responsible for browser interaction and visual behavior.

It is NOT the authoritative business/domain layer.

## Presentation responsibilities

TypeScript may own:

- DOM event handling;
- DOM updates;
- rendering;
- route/history handling if needed;
- browser-native fetch;
- WASM bootstrap;
- serialization bridge;
- browser cache;
- ephemeral UI state.

Examples of acceptable UI-only state:

- selected day;
- active tab;
- open modal;
- focused control;
- scroll position;
- current route;
- temporary input before submission.

## Presentation must NOT own

TypeScript must not independently implement:

- time-entry lifecycle rules;
- six-minute invariants;
- overlap rules;
- project eligibility rules;
- split legality;
- correction legality;
- totals as an authoritative business calculation;
- capability derivation;
- semantic transition validity.

If a business rule exists in WASM/domain code, do not duplicate it in TypeScript.

---

# 3. Layer 2 — Application + Domain in WASM

WASM is the semantic center of the application.

This is where application-specific meaning lives.

The domain should be represented directly using application-specific types and operations.

Examples:

    TimeEntry
    Project
    Label
    Person

    CreateTimeEntry
    CorrectTimeEntry
    SplitTimeEntry
    VoidTimeEntry

Do not implement a generic metadata-driven state engine in place of these concepts.

## WASM responsibilities

WASM should own:

- TimeEntry domain types;
- Project domain types;
- Label domain types;
- Person domain types;
- TimeEntryStatus;
- ProjectStatus;
- six-minute unit representation;
- domain invariants;
- transition requirements;
- split logic;
- correction logic;
- void/supersede logic;
- overlap detection;
- totals;
- domain projections;
- capability derivation;
- structured domain diagnostics;
- validation of persistence data into domain types where practical.

## WASM should not know GitHub details

The domain/application layer should not depend directly on:

- GitHub REST URL paths;
- GitHub repository layout details;
- GitHub HTTP headers;
- GitHub token format;
- GitHub Contents API implementation details.

Conceptually, the domain/application layer should work with service-level operations such as:

    LoadWeek
    SaveWeek
    LoadProjects
    SaveProject

rather than:

    PUT /repos/.../contents/...

GitHub is an infrastructure implementation detail.

---

# 4. Layer 3 — Service / Infrastructure Layer

The service layer coordinates communication between the application/domain and external persistence.

This is a logical architectural layer.

It does not necessarily require a separate server process in v0.1.

## Service responsibilities

The service layer owns:

- loading weekly documents;
- loading project documents;
- loading labels;
- saving weekly documents;
- saving projects;
- GitHub API interaction;
- serialization/deserialization coordination;
- expected Git SHA / version tracking;
- optimistic concurrency;
- conflict detection;
- write reconciliation;
- authentication handoff;
- synchronization state;
- mapping GitHub failures into meaningful application-facing results.

## Example conceptual service operations

    LoadWeek(personId, weekStarting)

    SaveWeek(
        expectedVersion,
        weeklyDocument
    )

    LoadProject(projectId)

    SaveProject(
        expectedVersion,
        projectDocument
    )

These are conceptual application/infrastructure operations.

Their concrete implementation may use GitHub REST APIs.

---

# 5. Logical Service Layer vs Physical Server

The service layer does NOT have to be a standalone backend in the first version.

Initial deployment may be:

    Browser
        ├── HTML / CSS
        ├── TypeScript kernel
        ├── WASM domain/application
        └── GitHub service adapter
                 │
                 ▼
               GitHub

This keeps the experiment small.

The service layer remains architecturally distinct even when it executes inside the browser.

Later, authentication or multi-user requirements may justify:

    Browser
       │
       ▼
    Small Service
       │
       ▼
    GitHub

That deployment change should not alter domain meaning.

Important principle:

> Service boundary and deployment boundary are not the same thing.

---

# 6. Layer 4 — GitHub Persistence

GitHub is the persistent datastore.

GitHub stores:

- JSON documents;
- Git object versions / SHAs;
- commit history;
- authorship/timestamps from Git operations.

GitHub persistence must not become application meaning.

## Persistence flow

    GitHub JSON
        ->
    service layer
        ->
    parse / schema validation
        ->
    WASM domain construction
        ->
    domain operations
        ->
    serialization
        ->
    service layer
        ->
    GitHub JSON

Raw JSON must not be manipulated as if it is authoritative domain state.

---

# 7. Persistence Document Partition

Recommended initial layout:

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

The week is the natural initial persistence boundary because it aligns with:

- weekly review;
- weekly totals;
- overlap validation;
- conflict scope;
- future approval;
- Git write locality.

---

# 8. Versioning and Optimistic Concurrency

The service layer must retain the GitHub file/blob SHA or equivalent version when loading a document.

Saving is conceptually:

    SaveWeek(expectedVersion, updatedWeek)

If the remote version has changed:

    Conflict

not:

    silently overwrite

Last-write-wins is not allowed for semantic data.

The Git SHA acts as an authoritative external version token for persistence concurrency.

---

# 9. Unknown Write Outcomes

A network failure after a GitHub write is sent does not prove that the write failed.

The infrastructure layer therefore needs explicit execution state:

    Clean
    ModifiedLocally
    Saving
    SaveFailed
    SaveOutcomeUnknown
    Conflict

Important distinction:

    TimeEntryStatus

is domain state.

    SyncState

is execution/persistence state.

Do not combine them.

## OutcomeUnknown flow

    write sent
        ->
    response becomes indeterminate
        ->
    SaveOutcomeUnknown
        ->
    inspect GitHub state
        ->
    determine whether intended write exists
        ->
    resolve to Clean or ModifiedLocally

Do not blindly resend while the previous operation's outcome is unknown.

---

# 10. Conflict Resolution

On Git SHA/version conflict:

    1. fetch latest remote state
    2. compare with expected base
    3. identify semantic differences
    4. merge only when explicitly safe
    5. otherwise surface conflict

Example potentially mergeable:

    local:
        correct description on Entry A

    remote:
        add unrelated Entry B

Example semantic conflict:

    local:
        split Entry A

    remote:
        change Entry A duration

Do not assume a generic JSON merge is semantically safe.

---

# 11. Dependency Direction

Preferred conceptual dependency direction:

    Presentation
        ↓
    Application / Domain
        ↓
    Service abstraction
        ↓
    GitHub implementation

The domain should not depend upward on:

- UI concerns;
- DOM;
- browser widgets;
- GitHub API mechanics.

Infrastructure may depend on abstractions exposed by the application/service boundary, not the reverse.

---

# 12. Browser/WASM Interaction Pattern

Example:

    User clicks Split at 10:00
        ->
    TypeScript captures UI event
        ->
    TypeScript invokes WASM SplitTimeEntry command
        ->
    WASM validates:
        current state
        six-minute boundary
        source duration
        split invariants
        overlap
        provenance
        ->
    WASM returns:
        valid updated projection
        OR structured diagnostic
        ->
    TypeScript renders result

TypeScript must not independently decide whether 10:00 is a legal split.

---

# 13. State Ownership

The architecture intentionally separates state dimensions.

## Domain state

Owned by WASM/domain:

    TimeEntryStatus
        Recorded
        Voided
        Superseded

    ProjectStatus
        Active
        Archived

## Execution/synchronization state

Owned by service/infrastructure:

    Clean
    ModifiedLocally
    Saving
    SaveFailed
    SaveOutcomeUnknown
    Conflict

## Ephemeral UI state

Owned by TypeScript/presentation:

    selected day
    active tab
    modal open
    focus
    route
    scroll position

Do not create one global application state object containing all three dimensions unless it is merely a projection/composition for rendering.

Authority remains separated.

---

# 14. No Duplicate Business Semantics

The same business rule must not be reimplemented in:

    WASM
    TypeScript
    JSON metadata
    GitHub adapter

Example:

The rule:

    Recorded entries for the same person may not overlap

belongs in the domain/application layer.

TypeScript may display an overlap error, but must not independently establish the authoritative rule.

GitHub persistence must store the result, not independently reinterpret the rule.

---

# 15. Minimal Dependencies

Default to no external libraries unless genuinely required.

Prefer:

- browser-native APIs;
- standard library;
- native language/runtime features;
- explicit code;
- WASM standard interop.

Do not add:

- React;
- Redux;
- Vue;
- Angular;
- generic client state framework;
- workflow framework;
- generic state-machine framework

unless a later explicit requirement justifies it.

---

# 16. Authentication Boundary

For a trusted single-user experimental version, a narrowly scoped GitHub credential may be used.

The browser architecture must not assume this is the final production authentication model.

If multi-user or broader deployment emerges, the service layer can move behind:

- GitHub App;
- OAuth;
- short-lived credentials;
- minimal server/token exchange.

This should not require rewriting domain logic.

---

# 17. Why This Architecture Is Being Tested

This application is also an architecture experiment.

We are testing whether:

    application-specific domain semantics in WASM

combined with:

    minimal TypeScript browser mechanics

and:

    explicit service/persistence boundaries

produce software that is:

- easier for AI agents to understand;
- harder for AI agents to mutate incorrectly;
- lower in duplicated semantics;
- simpler to change;
- safer under concurrent writes;
- safer under uncertain external outcomes;
- less dependent on large SPA frameworks.

The experiment should remain small enough that these claims can be evaluated honestly.

---

# 18. Architecture Non-Goals

Do not turn the first version into:

- microservices;
- distributed service mesh;
- generic domain framework;
- generic semantic runtime;
- generic state engine;
- event-sourcing platform;
- generalized workflow engine;
- large SPA framework;
- metadata-driven application builder.

The architecture should be only as complicated as required by:

    browser
        +
    WASM domain/application
        +
    service/infrastructure adapter
        +
    GitHub JSON persistence

---

# 19. Current Large-View Architecture Summary

The system is:

    Browser Application
        |
        |-- HTML / CSS
        |
        |-- Minimal TypeScript Kernel
        |       browser events
        |       DOM
        |       rendering
        |       fetch
        |       WASM bridge
        |
        |-- WASM Application / Domain Core
                TimeEntry
                Project
                Label
                Person
                state machines
                transitions
                invariants
                capabilities
                totals
                diagnostics
        |
        v
    Service / Infrastructure Layer
        GitHub adapter
        load/save coordination
        optimistic concurrency
        authentication handoff
        synchronization
        conflict detection
        OutcomeUnknown reconciliation
        |
        v
    GitHub Data Store
        JSON files
        SHAs / versions
        commits
        history

Final governing principle:

> The WASM application/domain layer owns meaning.
> The TypeScript layer owns browser mechanics.
> The service layer owns external coordination.
> GitHub owns durable persistence and history.
