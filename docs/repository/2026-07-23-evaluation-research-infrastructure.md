# Evaluation Research Infrastructure Decision

## Decision

Create a minimal active research workspace at `research/evaluation/` containing a charter, task manifest, evaluation specification, evidence/hypothesis/experiment registries, failure taxonomy, immutable cycle reports, and a conspicuous next-agent handoff.

## Rationale

These artifact types are required by the canonical REP specification and immediately prevent observed failure modes: loss of evidence, task defects being counted as agent failures, hypothesis drift, and difficult continuation.

## Constraint

The structure is experimental. Do not add more registries or automation until repeated cycles demonstrate need.

## Provenance

The structure implements `prompts/AI-Research-Mission.md` and follows `content/disciplines/ai-engineering/research-relay-system.md`.

## Reversal Condition

Merge or remove artifacts if two completed cycles show duplication without improving reconstruction, traceability, or decisions. Preserve history and record any migration.

