---
identifier: RP-2026-07-23-001
title: AI State of the Field
research_area: AI engineering
discipline: AI engineering
author_agent: Codex
version: 1.0.0
confidence: medium-high
completion: complete
priority: critical
related_projects: [AI-ROS]
related_documents:
  - research/AI-Knowledge-Gap-Analysis.md
  - research/AI-Research-Priority-Matrix.md
  - research/AI-Research-Roadmap.md
supersedes: null
superseded_by: null
tags: [agents, evaluation, context-engineering, governance, research-roadmap]
keywords: [long-horizon agents, verification, benchmarks, MCP, autonomy]
as_of: 2026-07-23
---

# AI State of the Field

## Executive Summary

AI engineering has moved from optimizing isolated model responses to engineering systems that perform extended, tool-mediated work. Frontier agents can operate for longer periods, manipulate real environments, and increasingly serve non-developer workflows. The highest-value unsolved problem is no longer simply “make the model smarter.” It is determining whether an agent completed the intended work correctly, safely, economically, and reproducibly.

Four findings dominate:

1. **Agent capability is rising, but reliability remains horizon-dependent.** METR measures rapidly expanding task-completion horizons, while realistic long-horizon benchmarks still show substantial failure.
2. **Popular benchmark scores are not dependable proxies for production value.** OpenAI’s 2026 audit estimated that roughly 30% of SWE-Bench Pro tasks were broken. Harness choice can also materially change results.
3. **Context and state management are active engineering variables.** More context is not uniformly better; selective retention and summarization can improve both performance and cost.
4. **Autonomy increases the importance of boundaries and verification.** Sandboxing, least privilege, approvals, traceability, state inspection, and human escalation are production architecture rather than optional safety add-ons.

For AI-ROS, the single highest-ROI next mission is to build and test an **evidence-traceable evaluation and verification framework for long-horizon repository agents**. It is a dependency for credible research, theory formation, orchestration, memory, and automation.

## Research State Snapshot

- **Theory version:** Pre-theory; candidate principles only
- **Knowledge base version:** Repository state as of 2026-07-23
- **Highest-confidence areas:** artifact-based state, bounded permissions, need for executable evaluation, value of primary-source traceability
- **Lowest-confidence areas:** optimal context policy, predictive value of benchmark suites, multi-agent ROI, durable memory architecture
- **Largest remaining unknown:** which observable measures best predict successful, safe, economical completion of real repository work
- **Active research streams:** AI-ROS bootstrap, research relay, knowledge platform, AI engineering handbook
- **Recently invalidated ideas:** benchmark leaderboards alone are sufficient evidence; maximum context retention is a safe default; agent output review can be deferred until the end
- **Priority changes:** evaluation/verification moved ahead of broad knowledge-graph and multi-agent implementation

## Original Objective

Determine what AI-ROS should research next by comparing repository knowledge with the current AI field, identifying gaps, challenging assumptions, and producing an executable mission.

## Scope and Method

The review covered the repository’s constitution, research program, research relay, REP specification, handbook, knowledge-platform architecture, state, and roadmap. External evidence favored primary or first-party technical sources and current benchmark research. Claims about individual vendor systems are treated as evidence about those systems, not universal laws.

The investigation used repeated passes:

1. inventory repository claims;
2. survey current agent capability, evaluation, context, protocol, and governance evidence;
3. identify contradictions;
4. rank topics by decision impact, uncertainty, tractability, dependency value, rate of change, and obsolescence risk;
5. choose the mission that unlocks the most downstream work.

## Current Understanding

### Areas that are comparatively well understood

- LLM outputs are probabilistic and context-dependent.
- Durable external state is more reliable than conversation-only memory.
- Tool use requires explicit schemas, error handling, and observable environment state.
- High-impact actions need constrained authority and escalation paths.
- Retrieval quality depends on corpus quality, metadata, chunking, ranking, and evaluation—not embeddings alone.
- Single-turn prompt optimization cannot substitute for system-level design.
- Production agent quality must include correctness, safety, latency, cost, recoverability, and operator burden.

These are mature enough to guide provisional engineering, though not all are validated as universal theory.

### Areas changing rapidly

- frontier model reasoning and coding performance;
- autonomous task horizons;
- agent harnesses and computer-use environments;
- context compaction and memory mechanisms;
- agent interoperability protocols;
- evaluation datasets and contamination defenses;
- inference price/performance;
- model-native tool orchestration;
- governance for consequential agent actions;
- multimodal browser and desktop agents.

Architectures tightly coupled to current model limits or vendor products face high obsolescence risk.

### Areas with the greatest project impact

1. evaluation and verification;
2. long-horizon state and context management;
3. agent permissions, security, and auditability;
4. research evidence quality and provenance;
5. orchestration economics and human escalation;
6. retrieval and knowledge architecture;
7. observability and failure recovery.

## Key Discoveries

### EV-001 — Benchmark validity is a first-order risk

OpenAI’s July 2026 audit estimated about 30% of SWE-Bench Pro tasks were broken because of strict tests, underspecified prompts, weak test coverage, or misleading instructions. This is direct evidence that a polished benchmark can produce invalid capability conclusions.

Source: [OpenAI, “Separating signal from noise in coding evaluations”](https://openai.com/index/separating-signal-from-noise-coding-evaluations/)

### EV-002 — Task horizon is increasing but reliability remains conditional

METR’s task-completion time-horizon work provides a useful capability measure while explicitly grounding it in success probability and human task duration. It does not eliminate the need for domain-specific evaluation.

Source: [METR, “Task-Completion Time Horizons of Frontier AI Models”](https://metr.org/time-horizons/)

### EV-003 — Real deployment is moving toward longer autonomous work

OpenAI reports increasing use of Codex for tasks estimated to represent over an hour of human work and substantial parallel agent runtime. Anthropic reports that the longest Claude Code sessions have increased in autonomous duration. These are first-party observations and may not generalize, but both indicate growing operational relevance.

Sources:

- [OpenAI, “How agents are transforming work”](https://openai.com/index/how-agents-are-transforming-work/)
- [Anthropic, “Measuring AI agent autonomy in practice”](https://www.anthropic.com/research/measuring-agent-autonomy)

### EV-004 — Context policy can outperform raw context accumulation

A 2026 enterprise workflow study found that recent-tool retention plus summarization outperformed full-history retention while using substantially fewer tokens. This is a narrow domain result, but it directly challenges the inherited assumption that retaining everything is safest.

Source: [Lodha et al., “Less Context, Better Agents”](https://arxiv.org/abs/2606.10209)

### EV-005 — The harness is part of the system under evaluation

WildClawBench reports that changing the agent harness shifted a model’s score by as much as 18 points. Therefore “model capability” cannot be cleanly separated from tools, prompts, runtime, context policy, and recovery behavior in applied engineering.

Source: [Ding et al., “WildClawBench”](https://arxiv.org/abs/2605.10912)

### EV-006 — Agent evaluation requires environment and trajectory evidence

Anthropic’s evaluation guidance emphasizes multi-turn environments, tool traces, outcome grading, and task-specific evaluators. This supports evaluating both final state and execution behavior.

Source: [Anthropic, “Demystifying evals for AI agents”](https://www.anthropic.com/engineering/demystifying-evals-for-ai-agents)

### EV-007 — Security boundaries are integral to agent architecture

OpenAI describes sandboxing, approvals, network controls, identity boundaries, managed rules, and audit telemetry for coding agents. Anthropic similarly frames human control, secure interaction, transparency, and privacy as core trustworthy-agent principles.

Sources:

- [OpenAI, “Running Codex safely at OpenAI”](https://openai.com/index/running-codex-safely/)
- [Anthropic, “Trustworthy agents in practice”](https://www.anthropic.com/research/trustworthy-agents)

### EV-008 — Protocol proliferation creates integration and security debt

MCP, A2A, and related protocols are expanding the agent integration surface. MCP’s authorization guidance prohibits token passthrough and requires audience binding in supported flows, demonstrating that interoperability cannot be evaluated separately from identity and authorization.

Sources:

- [Google, “Developer’s Guide to AI Agent Protocols”](https://developers.googleblog.com/developers-guide-to-ai-agent-protocols/)
- [MCP authorization specification](https://modelcontextprotocol.io/specification/2025-06-18/basic/authorization)

## Evidence Registry

| ID | Evidence | Reliability | Supports | Limits |
|---|---|---:|---|---|
| EV-001 | SWE-Bench Pro audit | High | HY-001 | Vendor-authored; one benchmark family |
| EV-002 | METR time horizons | High | HY-001, HY-003 | Mostly software tasks |
| EV-003 | First-party usage studies | Medium | HY-001 | Selection and vendor bias |
| EV-004 | Context pruning experiment | Medium | HY-002 | Narrow enterprise workflow |
| EV-005 | Harness-dependent benchmark results | Medium | HY-001, HY-002 | Preprint; limited task set |
| EV-006 | Agent eval engineering guidance | Medium-high | HY-001 | Practice report, not controlled trial |
| EV-007 | Production safety architectures | Medium-high | HY-004 | First-party implementation evidence |
| EV-008 | Protocol/security specifications | High for requirements | HY-004 | Does not prove adoption quality |

## Hypothesis Registry

| ID | Hypothesis | Status | Confidence | Falsification condition |
|---|---|---|---:|---|
| HY-001 | Repository-specific executable evals predict useful agent performance better than public benchmark rank | Leading | Medium-high | Public ranks consistently predict repository outcomes across models/harnesses |
| HY-002 | Selective context compilation beats full-history retention on reliability-adjusted cost | Active | Medium | Full history wins across representative tasks after cost normalization |
| HY-003 | Single-agent relay systems outperform multi-agent systems until parallel independence is measurable | Active | Medium | Multi-agent designs show repeatable net gains after coordination cost |
| HY-004 | Least-privilege action tiers reduce consequential failure without unacceptable productivity loss | Active | Medium-high | Controls add high cost without reducing observed risk |
| HY-005 | Artifact traceability improves research continuity and error detection | Active | Medium-high | Controlled relay experiments show no material improvement |

## Competing Viewpoints and Contradictory Evidence

- **Capability-first view:** stronger models may erase today’s orchestration problems. Counterpoint: faster models also expand task scope and consequence; benchmark validity and verification remain.
- **Maximum-context view:** complete history prevents omission. Counterpoint: stale or verbose context can reduce accuracy and increase cost; the correct policy is task-dependent.
- **Multi-agent-by-default view:** specialized agents improve coverage. Counterpoint: the repository’s own relay analysis and long-horizon studies indicate coordination and synthesis costs; independence must be demonstrated.
- **Human-review-is-enough view:** people can inspect final outputs. Counterpoint: long traces and high output volume make unaided review economically weak; executable checks and targeted escalation are needed.
- **Standard-protocol view:** MCP/A2A solve integration. Counterpoint: protocols standardize transport and discovery, not task correctness, trust, permissions, or ROI.

## Failed or Rejected Assumptions

- A broad state-of-the-field survey should directly trigger implementation across all topics.
- Benchmark pass rate is an objective, stable measure.
- More retained context is always safer.
- A successful final artifact proves a sound process.
- Multi-agent orchestration is necessarily the next maturity step.
- Knowledge graphs should precede evaluation infrastructure.

## Theory Impact Assessment

- **Affected candidate principles:** Context Dependence, Externalized State, Verification over Trust, Controlled Delegation, Cost-Constrained Computation, Measurable Engineering Outcomes
- **New principle candidate:** Harness–Model Coupling — applied capability is a property of the full agent system, not the model alone
- **Deprecated principles:** none; “maximum context” rejected as a default tactic
- **Confidence changes:** increased confidence in Verification over Trust and Controlled Delegation
- **Prediction created:** an evaluation suite combining final-state checks, trace checks, cost, and human intervention will reverse at least one model or architecture ranking produced by success rate alone
- **Required registry updates:** formal registries do not yet exist; establish them after the evaluation mission validates a minimal schema

## Recommended Next Research

Execute the prompt in `prompts/AI-Research-Mission.md`. It specifies a bounded empirical mission to design and test an AI-ROS evaluation framework using real repository tasks, multiple runs, outcome and trajectory measures, cost accounting, and adversarial cases.

## Research Backlog

1. context compilation policies;
2. durable memory and stale-state detection;
3. permission tiers and prompt-injection defenses;
4. agent observability and failure taxonomy;
5. human-agent escalation economics;
6. multi-agent coordination ROI;
7. retrieval evaluation and knowledge provenance;
8. protocol interoperability and identity;
9. multimodal/browser-agent reliability;
10. model routing and local/cloud tradeoffs.

## Risks and Research Debt

- Current evidence is weighted toward software and vendor ecosystems.
- Several 2026 papers are preprints without broad replication.
- The repository lacks formal evidence, hypothesis, experiment, and theory registries.
- No empirical AI-ROS task suite exists yet.
- No baseline cost or human-effort data has been captured.
- Safety, accessibility, organizational psychology, and legal disciplines need deeper coverage.

## AI Consumption Notes and Handoff

Start with the mission prompt. Treat all conclusions here as provisional until tested against repository tasks. Preserve raw run traces, environment state, model/harness versions, costs, intervention points, and failures. Do not promote a framework to accepted theory from a single model or a single run.

## Research Journal

- Pass 1: repository inventory showed strong conceptual coverage but almost no empirical validation.
- Pass 2: external survey identified long-horizon agents, evaluation validity, context policy, and governance as rapidly changing.
- Pass 3: contradictory evidence weakened benchmark-first and maximum-context assumptions.
- Pass 4: dependency analysis placed evaluation/verification ahead of memory, orchestration, and knowledge-graph implementation.
- Termination: additional topic expansion did not change the highest-value mission.

## Completion Checklist

- [x] Repository reviewed
- [x] Current primary and technical sources reviewed
- [x] Competing hypotheses recorded
- [x] Contradictory evidence preserved
- [x] Priority selected by dependency value and tractability
- [x] Executable next mission produced
- [x] Research debt and handoff recorded

