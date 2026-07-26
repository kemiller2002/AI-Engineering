---
identifier: RP-2026-07-23-003
title: AI Research Priority Matrix
version: 1.0.0
status: complete
as_of: 2026-07-23
---

# AI Research Priority Matrix

## Scoring

Scores use 1–5 scales. **Value** combines engineering impact, business impact, competitive advantage, long-term value, and cross-disciplinary leverage. **Urgency** combines rate of change and cost of delay. **Uncertainty** captures missing or conflicting knowledge. **Tractability** estimates whether a bounded mission can produce decision-grade evidence. **Dependency** measures downstream questions unlocked. **Obsolescence risk** is reported separately; high risk favors adaptable experiments over fixed architecture.

Priority score = `Value × Urgency × Uncertainty × Tractability × Dependency`.

The arithmetic orders candidates; classification also considers repository readiness and research maturity.

| Rank | Topic | Value | Urgency | Uncertainty | Tractability | Dependency | Obsolescence | Score | Class | Decision |
|---:|---|---:|---:|---:|---:|---:|---:|---:|---|---|
| 1 | Long-horizon agent evaluation & verification | 5 | 5 | 5 | 5 | 5 | 3 | 3125 | Critical | Execute now; prerequisite for credible engineering |
| 2 | Context compilation & state management | 5 | 5 | 5 | 4 | 5 | 4 | 2500 | Critical | Begin after eval baseline; test policies empirically |
| 3 | Agent security, permissions & auditability | 5 | 5 | 4 | 4 | 5 | 3 | 2000 | Critical | Co-design with evaluation threat cases |
| 4 | Human-agent escalation & verification economics | 5 | 4 | 5 | 4 | 5 | 2 | 2000 | High | Measure review time and intervention benefit |
| 5 | Evidence quality, provenance & research continuity | 5 | 4 | 4 | 5 | 5 | 1 | 2000 | High | Embed in every mission and validate its effect |
| 6 | Observability, failure taxonomy & recovery | 5 | 4 | 4 | 4 | 5 | 2 | 1600 | High | Derive from evaluation traces |
| 7 | Retrieval/RAG for repository knowledge | 4 | 4 | 4 | 5 | 4 | 3 | 1280 | High | Build task-specific test collection first |
| 8 | Agent orchestration and multi-agent ROI | 4 | 4 | 5 | 4 | 4 | 4 | 1280 | High | Compare only after single-agent baseline |
| 9 | MCP/tool interoperability and identity | 4 | 5 | 4 | 3 | 4 | 5 | 960 | High | Research contracts/security, avoid vendor lock-in |
| 10 | Model routing and verified-outcome cost | 4 | 5 | 4 | 4 | 3 | 5 | 960 | High | Benchmark using the common task suite |
| 11 | Browser/computer-use reliability | 4 | 5 | 5 | 3 | 3 | 5 | 900 | High | Bounded perturbation tests |
| 12 | Durable memory architecture | 4 | 4 | 5 | 3 | 3 | 4 | 720 | Medium | Wait for context/state findings |
| 13 | Coding-agent specialization | 4 | 4 | 3 | 4 | 3 | 4 | 576 | Medium | Treat as application of eval framework |
| 14 | Multimodal document/UI reasoning | 3 | 4 | 4 | 3 | 2 | 5 | 288 | Medium | Define internal use cases before broad research |
| 15 | Knowledge graphs/ontologies | 3 | 2 | 4 | 3 | 2 | 2 | 144 | Low | Do not build until retrieval task evidence requires it |
| 16 | Local/open model deployment | 3 | 3 | 4 | 2 | 2 | 5 | 144 | Monitor | Quarterly scorecard; avoid fixed architecture |
| 17 | Synthetic data and reinforcement learning | 3 | 3 | 5 | 1 | 2 | 5 | 90 | Monitor | Requires validated eval data first |
| 18 | Inference optimization internals | 2 | 4 | 3 | 1 | 1 | 5 | 24 | Monitor | Consume provider progress; research routing instead |
| 19 | Prompt tricks without system evaluation | 1 | 3 | 2 | 5 | 1 | 5 | 30 | Ignore | Only test prompts as controlled system variables |
| 20 | Broad autonomous swarm architecture now | 2 | 3 | 5 | 2 | 1 | 5 | 60 | Ignore | Premature without coordination ROI evidence |

## Classification Rationale

### Critical

These topics directly govern whether AI-ROS can trust and scale autonomous work. They have high dependency value and can be tested with present repository tasks.

### High

These are major multipliers or risks, but their experiments depend on the evaluation foundation or a stable task corpus.

### Medium

These matter, but narrower upstream questions should be resolved first. Work should remain use-case-driven.

### Low

Knowledge graphs are potentially valuable, but immediate implementation would encode an unvalidated information model and create maintenance debt.

### Monitor

Local models, training methods, and inference internals change quickly and are not current AI-ROS bottlenecks. Track representative outcomes rather than research the entire fields.

### Ignore

Prompt folklore and premature swarm architecture have low durable value unless evaluated as components of a controlled system.

## Selected Mission

**Build an evidence-traceable evaluation and verification framework for long-horizon AI-ROS repository agents.**

This mission ranks first because it:

- tests the repository’s candidate first principles;
- creates the measurement layer required by every other priority;
- is tractable using existing repository work;
- resists model and vendor obsolescence;
- exposes context, security, orchestration, and cost tradeoffs in one shared task environment.

