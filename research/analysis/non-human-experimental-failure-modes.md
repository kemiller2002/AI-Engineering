---
identifier: RP-2026-07-30-NHE-FAILURES
title: Non-Human Experimental Failure-Mode Taxonomy
version: 1.0.0
status: complete
confidence: medium-high
---

# Non-Human Experimental Failure-Mode Taxonomy

Frequency is the number of distinct affected experimental activities, not the
number of documents that mention the issue.

| ID | Failure mode | Affected | Frequency | Severity | Detectability | Likely cause / confidence | Existing mitigation / evidence | Next test |
|---|---|---:|---:|---|---|---|---|---|
| NFM-001 | Researcher circularity: same party designs task, probes, labels, and grader | EX-E002–004 | 3 | High | Medium | Workflow concentration / high | Independent-review protocol; not executed | Two blinded independent reviews plus unseen cases |
| NFM-002 | Gold/probe co-location creates contamination | EX-E002, EX-E003 | 2 | High | High | Convenience of local fixtures / high | EX-E007 exporter | Adversarial content- and path-level leakage audit |
| NFM-003 | Literal semantic checks reject valid paraphrases | EX-E002, EX-E003, EX-E004 | 3 | High | Medium | Deterministic substring rules / high | One alternative per pilot; human adjudication proposed | Blinded diverse paraphrase mutations |
| NFM-004 | Known-case calibration overstates external validity | EX-E004 | 1 | High | High to reviewers | In-sample optimization / high | Scope warnings | Frozen grader on unseen agent and mutation outputs |
| NFM-005 | Missing immutable run metadata | EX-E004, EX-E007 | 2 | Medium | High | Runner/results schema not built / high | Versioned sources, narrative results | Persist run JSON, environment, commit, hashes, timestamps |
| NFM-006 | Narrow leakage detector misses semantic/content leaks | EX-E007 | 1 | High | Low without adversarial audit | Filename heuristic / high | Physical file selection | Seed disguised gold strings, symlinks, metadata, and content matches |
| NFM-007 | No stochastic/capability observations | EX-E005 | 1 blocked program | Critical for capability claims | High | Review and infrastructure prerequisites / high | Claims explicitly withheld | Contained repeated baseline after task review |
| NFM-008 | Taxonomy mapping lacks item-level provenance | EX-E001 | 1 | Medium | Medium | Design summary, no extraction dataset / medium | Commit and narrative preserved | Re-run inventory with inclusion log if taxonomy is used quantitatively |
| NFM-009 | Negative tests proposed but left unexecuted | EX-E005, EX-E006; prose-only false-accept | 3 | Medium | High | Correct stop boundary plus missing external evidence / high | Explicit negative-result records | Prioritize only decision-changing blocked tests |
| NFM-010 | Reporting-status ambiguity | EX-E001–003, EX-E007 | 4 | Medium | Medium | “Complete,” “valid,” and “blind” used at different levels / high | Scope warnings | Add controlled vocabulary for design/preflight/validated/replicated |

## Negative and null-result synthesis

- No independent reviewer was available.
- No agent baseline ran.
- No human agreement, cost, token, latency, retry, or intervention measurement
  exists.
- The prose-only false-accept prediction was not tested.
- No grader-generalization or transfer test exists.
- No result is a scientific null: the missing experiments cannot be interpreted
  as no effect.

Negative reporting is unusually visible relative to the small corpus. However,
successful setup/calibration work has richer raw artifacts than abandoned or
blocked investigations, so a mild success-documentation bias remains.
