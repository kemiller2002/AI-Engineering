---
id: DF-ROS-HISTORY-2026-0001
title: Historical ROS Attribution and Compatibility Policy
status: accepted
confidence: high
created: 2026-08-17
updated: 2026-08-17
related_documents:
  - docs/repository/ros-migration/HISTORICAL-WORK-INDEX.md
  - schemas/historical-work.schema.json
supersedes: []
superseded_by: []
tags: [ros, migration, provenance, compatibility]
---

# Historical ROS Attribution and Compatibility Policy

## Context

The repository contains material work completed before ROS installation on
2026-08-17. Treating that work as if it had emitted live ROS transitions would
fabricate process history. Ignoring it would leave future attribution and
handoff incomplete.

The repository also contains two current-state documents and legacy artifact
identifiers and filenames. A historical migration needs one authority rule and
non-destructive compatibility behavior.

## Decision

1. Historical work is reconstructed into `.ros/history/historical-work.jsonl`
   under schema version `1.0.0`. Every record sets `historical: true`, records
   its reconstruction method and confidence, and remains separate from the live
   append-only `.ros/events/events.jsonl` stream.
2. Historical records may satisfy path-attribution validation only after their
   schema, migration ID, semantic state, and referenced commits validate. They
   cannot carry live transition fields or authorize state transitions.
3. Coherent objectives are grouped when commit-level separation would create
   trivial or misleading work items. Distinct decisions, evidence limitations,
   and original identifiers remain visible in the human index and record data.
4. Root `CURRENT-STATE.md` is the authoritative repository state. The
   `context/CURRENT-STATE.md` file is a compact ROS entry point derived from and
   linking to the root record; it must not assert competing project state.
5. Existing accepted or widely referenced artifact identifiers and filenames
   remain valid. Historical records use current canonical paths while notes and
   source audits preserve legacy path provenance. Renames require an explicit
   migration map only when a future change actually alters an identifier.
6. Generated publisher output, registries, inventories, and build reports are
   derivative evidence. They may demonstrate a generator run or aid discovery,
   but they are not independent evidence for the underlying research claim.

## Alternatives Considered

- Insert synthetic events into `.ros/events/events.jsonl`: rejected because it
  would impersonate original live ROS transitions and timestamps.
- Create one record per commit: rejected because merge commits, cleanup commits,
  and publisher follow-ups would obscure coherent objectives.
- Rename legacy artifacts to the current identifier convention: rejected
  because it would create avoidable compatibility churn and weaken provenance.
- Keep both current-state files canonical: rejected because their present claims
  conflict and agents need a single authoritative continuation record.

## Consequences

- Historical attribution is queryable and validation-aware without rewriting
  Git history.
- Reconstruction confidence and missing evidence stay explicit.
- Live ROS transitions retain exclusive authority over current workflow state.
- Future agents start with root `CURRENT-STATE.md` and use the context file only
  as a concise ROS-oriented pointer.

## Reversal Conditions

Supersede this decision if ROS adopts a first-class signed historical-event
protocol with an equally strict separation from live transitions, or if the
repository adopts a different canonical state location through an accepted
governance change and migration plan.
