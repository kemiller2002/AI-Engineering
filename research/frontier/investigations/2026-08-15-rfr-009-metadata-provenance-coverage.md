---
id: RFI-2026-002
title: RFR-009 Metadata and Provenance Coverage Measurement
status: accepted
as_of: 2026-08-15
confidence: high-within-declared-scope
---

# RFR-009 Metadata and Provenance Coverage Measurement

## Summary

The research-integrity validator now measures canonical metadata adoption by
artifact class and resolves non-empty declared `related`, `related_documents`,
`supersedes`, and `superseded_by` targets by stable identifier or repository
path. Coverage and unresolved relationships are diagnostic rather than blocking
until an incremental migration policy is approved.

## Measured baseline

The authored Markdown scope excludes Git internals, dependencies, generated
publisher/build output, archives, intake material, and copied calibration
outcomes. Within that declared scope:

- 131 authored Markdown artifacts were measured.
- 48 artifacts have front matter (36.6%).
- 47 artifacts expose a stable `id` or legacy `identifier` (35.9%).
- 45 declare `status` (34.6%) and 44 declare `title` in front matter (33.8%).
- No artifact currently declares canonical `abstract`, `document_type`,
  `evidence_level`, `canonical`, or `reading_time_minutes` metadata.
- Research has the highest meaningful identifier adoption: 42 of 62 artifacts
  (67.7%). Content has 0 of 17; documentation has 1 of 25.
- Five non-empty relationships are declared and all five resolve to repository
  paths. They use the legacy `related_documents` spelling.
- No active `related`, `supersedes`, or `superseded_by` edge is currently
  declared; the two documents containing supersession fields use null or empty
  values.

The machine-readable baseline is
`data/validation/research-integrity-inventory.json` schema version 1.1.

## Implementation and calibration

`tools/repository/validate_research_integrity.py` now:

- excludes dependency and generated-output trees from authored-document checks;
- reports required-field counts and percentages overall and by top-level
  artifact class;
- accepts `identifier` as a measured legacy alias for `id`;
- inventories declared relationship edges;
- resolves relationship targets by stable ID or repository-relative path; and
- reports unresolved targets without failing the repository audit.

Seven tests pass. The three added probes verify per-class coverage measurement,
ID/path/unresolved relationship classification, and exclusion of generated and
dependency trees. Existing duplicate-ID, broken-link, invalid-frontier-edge, and
passing controls remain green.

## Interpretation

The repository has a reliable structural validator but not a metadata-complete
knowledge graph substrate. Enforcing the full metadata standard now would reject
most authored artifacts and create a broad migration disconnected from measured
retrieval value. The correct next step is a bounded adoption policy for current
canonical research and content, followed by supersession-edge calibration when
real edges exist.

## Remaining uncertainty

- Which artifact classes should be required to adopt the complete canonical
  schema first?
- Does stable metadata improve real handoff/retrieval performance enough to
  justify migration cost?
- Should `related_documents` remain a supported alias or be migrated to
  canonical `related`?
- How should path relationships behave across renames compared with stable-ID
  relationships?
- Heading fragments, prose paths, evidence/hypothesis references, and reciprocal
  supersession consistency remain outside the enforced scope.

## Decision

RFR-009 remains in Validation. Measurement and declared-relationship diagnostics
are complete, but metadata adoption and real supersession coverage are too low
to claim a complete provenance substrate.
