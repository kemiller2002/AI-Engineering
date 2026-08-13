# Non-Human Experimental Comparative Review Decision

## Decision

Add `research/analysis/` as the canonical location for this cross-experiment
analysis and `research/packages/RP-2026-07-30-NHE-COMPARATIVE-REVIEW.md` as its
canonical REP. Preserve the historical evaluation records unchanged.

## Rationale

The analysis spans several evaluation artifact types and needs stable separation
from immutable cycle records. The repository contains seven registered
experiment items but only four executed empirical/preflight activities, all
within one dependent lineage. Canonicalizing the synthesis prevents later agents
from counting documents, probes, or registry rows as independent evidence.

## Consequences

- Existing experiment and cycle records retain provenance.
- The new JSON matrix is the machine-readable comparative index, not a generated
  replacement for source artifacts.
- Cycle 004 should apply confidence updates to active registries; this review
  does not rewrite historical claims.
- Independent review plus unseen frozen-grader testing remains the next gate.

## Alternatives considered

- Add the analysis inside `research/evaluation/`: rejected because the mission is
  repository-wide and the deliverables form a separate synthesis layer.
- Rewrite existing registries: rejected because it would obscure historical
  interpretation and provenance.
- Create a universal evidence score: rejected because metrics and units are not
  comparable.

## Reversal condition

Move or supersede this structure if repository governance adopts a different
canonical analysis/package hierarchy with an explicit migration and preserved
history.
