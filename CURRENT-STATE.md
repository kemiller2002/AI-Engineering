# Current State

## Objective

Validate AI-ROS through evidence-traceable evaluation of long-horizon repository agents.

## Current Phase

Evaluation research Cycles 001–003 complete; independent review and contained baseline are next.

## Active Work

- Obtain independent reviews of ET-004-P01 and ET-014-P01.
- Freeze one agent-system configuration for a contained exploratory baseline.
- Capture final state, actions, runtime, retries, cost, and human intervention.
- Maintain the research frontier records under `research/frontier/`; RFR-001 and RFR-002 align with Cycle 004.

## Next Task

Follow `research/evaluation/NEXT-AGENT-START-HERE.md`; independently review the pilots, then run contained exploratory baselines if they pass.

## Risks

- Public benchmark validity may not transfer to repository tasks.
- Model and harness changes can obsolete baselines.
- Human review capacity may constrain evaluator calibration.
- The current repository is documentation-heavy and may not represent production coding work.
- Repository-native tasks may inherit hidden context, narrow graders, or answer leakage.
- Evaluated agents may exploit benchmark or infrastructure exposure.
- Probe calibration may overfit designer-created outcomes.
- Additional architecture work now risks replacing empirical learning with speculation.

## Open Questions

- Which measures best predict verified repository outcomes?
- Which context policy provides the best reliability-adjusted cost?
- When does multi-agent coordination produce net value?
- Does a knowledge graph earn its maintenance cost?

## Completed Work

- Executed the AI Research Mission Generator.
- Created the 2026-07-23 state-of-field REP, gap analysis, priority matrix, and research roadmap.
- Selected long-horizon agent evaluation and verification as the highest-ROI next mission.
- Completed Evaluation Research Cycle 001.
- Defined the evaluation charter, constructs, outcome classes, sixteen candidate task families, audit protocol, and initial registries.
- Challenged the assumptions that repository-native tasks are inherently valid, more graders are always better, and three runs support stable rankings.
- Completed task-integrity pilots ET-004-P01 and ET-014-P01.
- Implemented a dependency-free evaluator and blind fixture exporter.
- Calibrated seven declared outcome probes and verified two blind exports.
- Added a decision framework, threat model, evaluation architecture, teaching guide, and research/engineering roadmap v2.
- Moved containment and runtime monitoring into the evaluation foundation rather than postponing security.
- Resolved three root case-only Git collisions by retaining the governance-defined uppercase canonical paths and preserving prior variants in Git history.
- Completed repository frontier analysis RFA-2026-001 with ten traceable open RFRs, document frontiers, health metrics, and a dependency graph.

## Largest Unknown

Whether independent reviewers agree with the pilot contracts and how much variance appears in real contained agent runs.

## Next-Agent Handoff

**Start at `research/evaluation/NEXT-AGENT-START-HERE.md`. No capability baseline has been run; current results calibrate fixtures and graders only.**
