# State-Machine Documents Organization Decisions

Date: 2026-08-15

## Scope

This migration classified the tracked corpus formerly under
`state-machine-documents/`. It changed paths and navigation, not research
findings or architecture decisions.

## Decisions

### D-001: Separate reusable research from current architecture

The numbered research prompts, reports, synthesis, experiments, working notes,
and references moved to `research/state-constrained-architecture/`. Current
generic architecture constraints moved to `docs/architecture/semantic-control/`.
Reports remain evidence; they do not acquire specification authority from their
new location.

### D-002: Preserve the numbered 01–12 pairing

Every known mission now has one clearly named prompt and one clearly named
report. Prompts 06, 09, and 11 were removed from the former results folder.
The cross-mission synthesis remains separate under `synthesis/`.

### D-003: Treat exploratory predecessors as historical context

The original state-machine exploration, continuation notes, outline, semantic
closure note, and risk-assessment notes moved to `working-notes/`. They were not
rewritten or silently reconciled with later reports and specifications.

### D-004: Keep Time Entry application-specific

The three unique Time Entry documents moved to `content/projects/time-entry/`
and were separated into requirements, domain, and architecture locations. No
named but absent specification documents were invented.

### D-005: Consolidate only byte-identical duplicates

Two duplicate pairs were verified by SHA-256 before consolidation:

- The Time Entry copy of `dependency-minimal-browser-kernel-architecture-policy.txt`
  matched the generic copy (`6993d4d35c0389bdcbfc9f1bcca7e7c14e1f39494190be6b34ca952d809c37e9`).
- `state_modularity_literature_deep_research_2026-08-14 2.txt` matched the
  unsuffixed file (`2e57aea1cd25cf02a0c567397d008f7bf0326c8f543160b96005b7071b35a8df`).

One canonical copy of each remains. All substantively distinct artifacts were
preserved.

## Provenance

Tracked files were moved with `git mv` where practical. The two exact duplicate
paths were removed with `git rm`; their prior content remains in Git history.
No commit or push was performed.
