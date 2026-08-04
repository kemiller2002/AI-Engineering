---
identifier: RP-2026-07-30-NHE-CONTRADICTIONS
title: Non-Human Experimental Contradiction Registry
version: 1.0.0
status: complete
confidence: high
---

# Non-Human Experimental Contradiction Registry

No executed experiments produce a direct numerical contradiction. The material
conflicts are between status/interpretation claims and the implemented evidence.

| ID | Conflicting claims/evidence | Experiments | Likely explanation | Class | Resolution |
|---|---|---|---|---|---|
| CR-NHE-001 | Pilot tables call contracts complete while promotion rules require two independent reviews | EX-E002, EX-E003 | “Complete” refers to required fields and known probes, not scientific validity | Documentation/measurement difference | Resolved by interpreting status as provisional; labels should remain explicit |
| CR-NHE-002 | HY-E003 says layered graders reduce false acceptance, but the only calibration used one deterministic grader | EX-E004 | Evidence supports probe separation by deterministic checks, not benefit from added layers | Unsupported inference | Unresolved; needs a paired grader experiment |
| CR-NHE-003 | “Blind fixture” language suggests gold isolation while the detector checks only exported filenames for three substrings | EX-E007 | Operational definition is narrower than the construct | Measurement difference | Partially resolved by narrowing the supported claim |
| CR-NHE-004 | Cycle 002 says both pilots needed design changes, but immutable pre-change task/grader versions are absent | EX-E002, EX-E003 | Design iteration was summarized after the fact | Provenance/documentation defect | Unresolved; cannot quantify what the audit prevented |
| CR-NHE-005 | The roadmap marks blind fixture export as both done in results and unchecked in A2/B0 | EX-E007 | Roadmap lag or distinction between prototype preflight and baseline-ready system | Temporal/documentation defect | Treat prototype exporter as executed, baseline infrastructure as incomplete |
| CR-NHE-006 | Registry calls EX-E001 an experiment while its result is taxonomy construction without trials | EX-E001 | Broad use of “experiment” for design work | Classification difference | Resolved in this review: design study, not controlled experiment |
| CR-NHE-007 | Current evidence says task audit is valuable; no control shows conclusions without audit | EX-E002, EX-E003 | Process observation is being used as causal support | Design limitation | Unresolved; retain as suggestive only |

## Contradiction matrix

| Contradiction | Evidence A | Evidence B | Likely explanation | Resolution status |
|---|---|---|---|---|
| Grader layering benefit | HY-E003 | EX-E004 deterministic-only success | Hypothesis outruns experiment | Unresolved |
| Blindness strength | EX-E007 name/result | Narrow substring implementation | Construct–metric mismatch | Claim narrowed |
| Pilot validity | Complete contract/probe results | Missing independent review/unseen cases | Different validity levels | Provisional only |
| Audit causal value | Design defects reported repaired | No preserved counterfactual or control | Post-hoc process evidence | Suggestive |

The repository correctly preserves most of these caveats in prose. The risk is
not erased disagreement but readers treating headings, completion states, or
ratios as stronger claims than the adjacent limitations allow.
