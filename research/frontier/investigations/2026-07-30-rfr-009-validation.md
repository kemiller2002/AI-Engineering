---
id: RFI-2026-001
title: RFR-009 Stable Identifier and Reference Integrity Validation
status: accepted
as_of: 2026-07-30
confidence: high-within-declared-scope
---

# RFR-009 Stable Identifier and Reference Integrity Validation

## Summary

RFR-009 advanced from Idea/Open to Validation. A dependency-free repository
validator now inventories front-matter identifiers, detects unexplained
identifier collisions, checks explicit local Markdown link targets, and verifies
agreement among frontier record files, the frontier index, graph nodes, and
graph edge endpoints.

## Major findings

- 38 authored or template Markdown artifacts currently expose an `id` or
  `identifier` in front matter.
- No unexplained duplicate identifiers were found.
- No broken explicit local Markdown links were found.
- All 10 frontier record files agree with the frontier index and graph nodes.
- All 12 frontier graph edges reference declared nodes.
- Four tests detect seeded duplicate-ID, broken-link, and invalid-edge defects
  and preserve a passing control.

The clean result is evidence about structural integrity in the validator's
declared scope. It is not evidence that the repository has complete metadata or
that every prose reference is resolvable.

## Confidence

High for the implemented checks because they are deterministic and calibrated
against seeded failures. Medium-low for repository-wide provenance traversal
because identifier adoption is incomplete and many references are prose or
backtick paths rather than explicit links.

## Limitations and remaining unknowns

- Markdown without front matter is inventoried only for links, not assigned an
  identifier.
- Calibration fixture snapshots intentionally reuse source identifiers and are
  excluded from collision checks.
- The link checker verifies target existence, not heading fragments.
- Bare paths, abbreviated filenames, evidence IDs, hypothesis IDs, and
  supersession relationships in prose are not resolved.
- The validator does not yet enforce the complete metadata schema in
  `knowledge-platform/Metadata-Standard.md`.
- No CI workflow exists in this checkout, so enforcement is local through
  `evalctl.py repo-audit`.

## Supporting evidence

- `data/validation/research-integrity-inventory.json`
- `tools/repository/validate_research_integrity.py`
- `tools/repository/test_validate_research_integrity.py`
- `knowledge-platform/Metadata-Standard.md`
- `knowledge-platform/Repository-Architecture.md`

## Follow-on research

1. Measure metadata coverage by artifact class and define an incremental
   adoption target before enforcing required fields.
2. Add heading-fragment and declared `related`/`supersedes` target validation
   when those relationships are adopted.
3. Compare explicit-link traversal with bare-path/reference extraction on a
   sampled handoff task before expanding the validator.
4. Add the repository audit to CI when a workflow and permission policy exist.

## Roadmap and repository impact

The repository-fitness check is implemented, removing a tooling prerequisite
for RFR-004 and RFR-010. RFR-009 remains in Validation until metadata coverage
and relationship validation are sufficient for provenance traversal. No other
repository is directly impacted.

## Recommended engineering work

Keep `python3 tools/evaluation/evalctl.py repo-audit` as the single local
fitness entry point. Next, add coverage reporting before making metadata fields
mandatory; immediate strict enforcement would reject a large legacy corpus
without first establishing a migration policy.
