# Research Integrity Validation Decision

## Decision

Add `tools/repository/validate_research_integrity.py` as the canonical
dependency-free validator for stable front-matter identifiers, explicit local
Markdown links, and structural frontier consistency. Invoke it from the
existing `evalctl.py repo-audit` entry point.

## Scope and provenance

This implements the first validation slice of RFR-009 using the canonical rules
in `knowledge-platform/Metadata-Standard.md` and the manifest/graph separation
in `knowledge-platform/Repository-Architecture.md`.

Calibration outcomes and base snapshots under
`research/evaluation/fixtures/` intentionally retain their source identifier,
so those copies are excluded from global collision detection. Authored
documents, frontier records, and templates remain included.

## Evidence

On 2026-07-30:

- four seeded tests passed;
- 38 identifier-bearing authored/template artifacts were inventoried;
- zero unexplained identifier collisions were found;
- zero broken explicit local Markdown links were found;
- 10 frontier records, index entries, and graph nodes agreed;
- 12 graph edges referenced declared nodes.

The generated observation is preserved at
`data/validation/research-integrity-inventory.json`.

## Limits and reversal conditions

This decision does not claim full metadata coverage or semantic provenance
validation. Replace or extend the parser if Markdown constructs, relationship
metadata, or scale make the dependency-free implementation materially
inaccurate. Do not enforce the complete metadata schema until a measured
migration policy exists.
