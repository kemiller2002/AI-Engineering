# Research TODO Backfill

## Decision

Represent the repository's actionable research backlog as proposed ROS mission
artifacts under `missions/backlog/`. Do not create active ROS transitions for
work that has not started.

The canonical `research/frontier/` already deduplicates most roadmap checkboxes,
open questions, and workstream language into ten RFRs. Each RFR therefore maps
to one backlog mission. NX-005 remains separate because its audit/no-audit
counterfactual is not represented by a dedicated frontier record.

## Mapping

| Mission | Canonical source | Consolidated TODOs |
|---|---|---|
| MS-AIRES-2026-0001 | RFR-001 / NX-001 | independent pilot reviews and blinded review-label comparison |
| MS-AIRES-2026-0002 | RFR-002 / NX-002 | contained repeated baseline and exploratory variance |
| MS-AIRES-2026-0003 | RFR-003 / NX-001 | unseen-outcome and natural-outcome grader validation |
| MS-AIRES-2026-0004 | RFR-004 / NX-004 | representative suite and independent code/automation replication |
| MS-AIRES-2026-0005 | RFR-005 | context, state, memory, and retrieval-compiled policy comparison |
| MS-AIRES-2026-0006 | RFR-006 | total verified-cost and reviewer-burden measurement |
| MS-AIRES-2026-0007 | RFR-007 | fixed versus risk-triggered human escalation |
| MS-AIRES-2026-0008 | RFR-008 / NX-003 | containment, gold separation, monitoring, pause, and rollback validation |
| MS-AIRES-2026-0009 | RFR-009 | bounded metadata adoption and real supersession-edge calibration |
| MS-AIRES-2026-0010 | RFR-010 | knowledge-graph value experiment |
| MS-AIRES-2026-0011 | NX-005 | audit/no-audit decision counterfactual |

## Grouping rules

- Duplicate checklist language is consolidated under the matching RFR mission.
- A mission may cover multiple experiment aliases when they share one decision
  gate, but its body preserves the component evidence and success requirements.
- Dependency order follows the frontier graph and evaluation critical path.
- All new missions are `proposed`; beginning one requires a future authorized
  ROS work transition and prerequisite check.
- Publishing deployment confirmation and Time Entry contract authoring remain
  engineering/product work and are not mislabeled as research missions.
- Governance template checkboxes are completion criteria, not repository TODOs.
- Illustrative uses of “TODO” inside research prompts and reports are examples,
  not actionable repository work.

## Deferred broad themes

Model routing, interface-agent testing, orchestration variants, and general
retrieval benchmarking remain roadmap themes rather than separately actionable
missions because the current frontier makes them dependent on RFR-004 and later
evidence. They should receive new RFRs and missions only when their prerequisites
are met and a bounded decision question is defined.

## Validation

The ROS mission registry must be generated with `./ros registry build`. The
backlog is valid only when `./ros registry check`, `./ros validate`, and the
project test suite pass.
