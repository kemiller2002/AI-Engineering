#!/usr/bin/env bash
set -Eeuo pipefail

PROJECT_DIR="${1:-ai-research-os}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

log() { printf '\n\033[1;34m==> %s\033[0m\n' "$*"; }
warn() { printf '\n\033[1;33mWARNING: %s\033[0m\n' "$*"; }
fail() { printf '\n\033[1;31mERROR: %s\033[0m\n' "$*" >&2; exit 1; }

command -v git >/dev/null 2>&1 || fail "git is required"
command -v python3 >/dev/null 2>&1 || fail "python3 is required"

if [[ -e "$PROJECT_DIR" && -n "$(ls -A "$PROJECT_DIR" 2>/dev/null || true)" ]]; then
  fail "Target directory '$PROJECT_DIR' already exists and is not empty."
fi

log "Creating AI-ROS repository at $PROJECT_DIR"
mkdir -p "$PROJECT_DIR"
cd "$PROJECT_DIR"

git init -b main >/dev/null 2>&1 || { git init >/dev/null; git branch -M main; }

mkdir -p \
  .devcontainer \
  .github/workflows \
  .github/ISSUE_TEMPLATE \
  codex/tasks \
  constitution \
  strategy \
  architecture/decisions \
  handbooks \
  implementation \
  registries/ideas \
  registries/decisions \
  registries/theories \
  registries/evidence \
  registries/concepts \
  research/journals \
  research/packages \
  research/experiments \
  research/questions \
  prompts/bootstrap \
  prompts/research \
  prompts/engineering \
  prompts/review \
  specifications \
  schemas \
  templates \
  tools \
  tests/fixtures/valid \
  tests/fixtures/invalid \
  mobile/ios/shortcuts \
  mobile/ios/workflows \
  docs \
  site

cat > README.md <<'EOF'
# AI Research Operating System (AI-ROS)

AI-ROS is a documentation-as-code and knowledge-engineering platform for durable, traceable, autonomous research and engineering.

## Canonical entry points

1. [`strategy/0000-AI-ROS-Master-Plan.md`](strategy/0000-AI-ROS-Master-Plan.md)
2. [`constitution/000-Engineering-Constitution.md`](constitution/000-Engineering-Constitution.md)
3. [`architecture/Architecture-Handbook.md`](architecture/Architecture-Handbook.md)
4. [`handbooks/Research-Handbook.md`](handbooks/Research-Handbook.md)
5. [`implementation/Implementation-Guide.md`](implementation/Implementation-Guide.md)
6. [`registries/ideas/IDEA-REGISTRY.md`](registries/ideas/IDEA-REGISTRY.md)
7. [`registries/decisions/DECISION-LOG.md`](registries/decisions/DECISION-LOG.md)

## Quick start

```bash
./setup.sh
./tools/validate.py
```

Markdown is the canonical source of truth. Generated sites, indexes, graphs, and dashboards are disposable outputs.
EOF

cat > CURRENT-STATE.md <<'EOF'
---
document_type: project-state
version: 0.1.0
status: active
updated: 2026-07-21
---

# Current State

## Active objective

Bootstrap AI-ROS as a working, version-controlled research operating system.

## Current phase

Milestone 0: repository foundation.

## Completed

- Initial repository structure
- Seven canonical living documents
- REP v2 integration point
- Codex task framework
- Basic validation tooling
- GitHub Actions validation
- Codespaces configuration

## Largest remaining uncertainty

The smallest useful knowledge schema that preserves traceability without creating excessive authoring friction.

## Next highest-value action

Execute `codex/tasks/TASK-001-FOUNDATION-REVIEW.md`, challenge the bootstrap architecture, and update the canonical documents before building advanced tooling.

## Required context for the next agent

Read `AGENTS.md`, the seven canonical documents, `specifications/Research-Execution-Package-Specification-v2.md`, and this file.
EOF

cat > ROADMAP.md <<'EOF'
# Roadmap

## Milestone 0 — Bootstrap

- [x] Repository structure
- [x] Canonical documents
- [x] Codex execution framework
- [x] Basic validator
- [x] CI and Codespaces
- [ ] Foundation review and correction

## Milestone 1 — Artifact model

- [ ] Define minimal common metadata
- [ ] Define schemas for REP, evidence, theory, concept, decision, and journal artifacts
- [ ] Implement ID allocation and collision checks
- [ ] Add artifact generators
- [ ] Add fixture-based tests

## Milestone 2 — Repository intelligence

- [ ] Cross-reference resolver
- [ ] Broken-link detection
- [ ] Orphan and duplicate detection
- [ ] Theory-to-evidence coverage checks
- [ ] Repository health report

## Milestone 3 — Publishing

- [ ] Static documentation site
- [ ] Search index
- [ ] Registry browsers
- [ ] Knowledge graph export
- [ ] GitHub Pages deployment

## Milestone 4 — Agent workflows

- [ ] Standard research agent
- [ ] Engineering agent
- [ ] Curator agent
- [ ] Red-team reviewer
- [ ] Handoff and synchronization protocol

## Milestone 5 — Mobile companion

- [ ] Working Copy workflow
- [ ] Shortcut specifications
- [ ] Capture-to-inbox flow
- [ ] Continue-research flow
- [ ] Mobile validation and publishing workflow

## Milestone 6 — AI-ROS 1.0

- [ ] End-to-end test with multiple research streams
- [ ] Migration and recovery testing
- [ ] Governance ratification
- [ ] Stable release
EOF

cat > CHANGELOG.md <<'EOF'
# Changelog

## 0.1.0 — 2026-07-21

### Added

- Initial AI-ROS repository bootstrap
- Seven canonical living documents
- REP v2 specification integration
- Codex execution tasks
- Validation script and CI workflow
- Codespaces configuration
EOF

cat > AGENTS.md <<'EOF'
# Agent Operating Instructions

All agents working in this repository MUST:

1. Read `CURRENT-STATE.md` before acting.
2. Read the canonical document relevant to the task.
3. Treat architecture and requirements as hypotheses until tested.
4. Prefer small, reviewable, reversible changes.
5. Preserve stable identifiers and provenance.
6. Record significant architectural decisions.
7. Update `CURRENT-STATE.md`, `ROADMAP.md`, and `CHANGELOG.md` when materially affected.
8. Run `python3 tools/validate.py` before declaring completion.
9. Report files changed, tests run, unresolved risks, and the next highest-value action.
10. Never claim a test or command succeeded unless it was actually executed.

## Iterative development protocol

For substantial tasks, repeat:

1. Establish the current state.
2. Identify the largest uncertainty.
3. Generate at least two credible approaches.
4. Attempt to disprove the preferred approach.
5. Implement the smallest useful slice.
6. Validate behavior and repository integrity.
7. Review for unnecessary complexity.
8. Revise documentation and decisions.
9. Continue until the acceptance criteria are met or a documented blocker remains.
EOF

cat > strategy/0000-AI-ROS-Master-Plan.md <<'EOF'
---
id: MP-0001
title: AI-ROS Master Plan
version: 0.1.0
status: experimental
---

# AI-ROS Master Plan

## Vision

Create a durable operating system for autonomous research and engineering in which evidence, theories, decisions, experiments, and implementation remain traceable and reusable across agents and time.

## Problem

AI-assisted work often accumulates documents faster than it accumulates coherent understanding. Context is lost between sessions, conclusions are rediscovered, unsupported claims persist, and generated artifacts become stale.

## Strategic response

AI-ROS makes Markdown artifacts canonical; assigns stable identifiers; records provenance, uncertainty, and decisions; validates repository integrity; generates discovery interfaces; and provides explicit agent handoffs.

## System boundaries

AI-ROS governs research and engineering knowledge. It does not replace Git, source-code hosting, external citation sources, or domain-specific experimental tools.

## Core systems

- Canonical specifications and governance
- Scientific journal and REP lifecycle
- Evidence, theory, concept, experiment, and decision registries
- Artifact schemas and validation
- Static publishing, search, and graph generation
- Agent workflows and executable handoffs
- Repository health and architectural fitness functions
- Mobile-first capture and review workflows

## Delivery strategy

Build vertically in small slices. First prove one complete flow:

`question → journal → evidence → theory update → REP → validation → generated view`

Do not build every registry or visualization before this flow works.

## Major risks

- Metadata burden exceeds research value
- Premature ontology design
- False confidence from formal structure
- Registry duplication and drift
- Agent outputs that satisfy templates without improving understanding
- Excessively broad initial implementation

## Success criteria

A new agent can reconstruct prior work, identify uncertainty, continue research, update theory, produce a valid REP, and leave the repository in a coherent state without relying on conversation history.

## Roadmap authority

`ROADMAP.md` is the operational roadmap. This document defines direction and should change less frequently.
EOF

cat > constitution/000-Engineering-Constitution.md <<'EOF'
---
id: EC-0001
title: AI-ROS Engineering Constitution
version: 0.1.0
status: experimental
---

# Engineering Constitution

## Optimization order

1. Correctness and honest uncertainty
2. Reduction of consequential uncertainty
3. Traceability and reproducibility
4. Long-term maintainability
5. Simplicity
6. Explainability
7. Extensibility
8. Automation
9. Performance and convenience

## Constitutional principles

- Evidence MUST override preference and prior decisions.
- Agents MUST distinguish observation, evidence, assumption, inference, conclusion, and recommendation.
- Canonical knowledge MUST survive loss of conversation history.
- Significant claims SHOULD trace to evidence and affected theories.
- Changes MUST be reviewable and reversible where practical.
- Generated artifacts MUST NOT become the sole source of truth.
- Complexity MUST be justified by demonstrated need.
- The architecture MUST remain open to correction.
- Failed hypotheses and rejected alternatives MUST be preserved when they prevent repeated work.
- No agent MAY report work as complete without executing applicable validation.

## Architectural humility

At major milestones, conduct a greenfield review: if the system were started today, would the same architecture be chosen? Migration cost matters, but sunk cost is not evidence.

## Normative language

MUST and MUST NOT are mandatory. SHOULD and SHOULD NOT require documented justification when violated. MAY is optional.
EOF

cat > architecture/Architecture-Handbook.md <<'EOF'
---
id: AH-0001
title: Architecture Handbook
version: 0.1.0
status: experimental
---

# Architecture Handbook

## Architecture style

AI-ROS begins as a modular monorepository and command-line toolchain. Markdown and YAML front matter are canonical. Validation and generation are deterministic local operations suitable for CI.

## Layers

1. **Vision and constitution** — durable direction and governing constraints.
2. **Specifications** — normative artifact and workflow definitions.
3. **Canonical artifacts** — journals, REPs, evidence, theories, concepts, experiments, and decisions.
4. **Tooling** — validation, generation, indexing, migration, and health analysis.
5. **Generated interfaces** — website, search, graphs, dashboards, and reports.

## Initial architectural decisions

- Use Git for change history and synchronization.
- Use Markdown plus YAML front matter for human/machine readability.
- Use Python standard library for the first validator to minimize setup friction.
- Use fixture-based validation tests before adopting a larger framework.
- Implement a complete vertical research flow before broad platform features.

## Fitness functions

The system SHOULD continuously test that:

- identifiers are unique;
- internal references resolve;
- required metadata exists;
- important theories trace to evidence;
- generated outputs are reproducible;
- canonical files are not overwritten by generation;
- no registry silently diverges from source artifacts.

## Deferred decisions

Static-site framework, graph database, full-text search engine, and ontology tooling remain undecided until requirements are demonstrated through real repository use.
EOF

cat > handbooks/Research-Handbook.md <<'EOF'
---
id: RH-0001
title: Research Handbook
version: 0.1.0
status: experimental
---

# Research Handbook

## Research objective

Research exists to improve the project's predictive and explanatory models, not merely to collect sources.

## Research cycle

1. Review current theory and evidence.
2. Identify the largest consequential uncertainty.
3. Form falsifiable hypotheses.
4. Define supporting and contradicting evidence.
5. Gather reliable evidence and competing views.
6. Attempt to falsify the leading explanation.
7. Update confidence and theory.
8. Record failures, debt, and unresolved questions.
9. Produce an executable handoff and REP when the effort reaches a useful boundary.

## Evidence standards

Prefer primary research, standards, official documentation, original datasets, patents, and credible technical sources. Secondary synthesis MAY be used for discovery but SHOULD NOT be the sole support for important claims.

## REP integration

The canonical REP requirements are defined in `specifications/Research-Execution-Package-Specification-v2.md`. This handbook explains process; the REP specification defines required output.

## Stopping rule

Stop an iteration when the next unit of effort has lower expected information value than another available task, not merely when a plausible answer appears.
EOF

cat > implementation/Implementation-Guide.md <<'EOF'
---
id: IG-0001
title: Implementation Guide
version: 0.1.0
status: experimental
---

# Implementation Guide

## Immediate implementation sequence

1. Review and correct the bootstrap architecture.
2. Define the common artifact envelope and minimum metadata.
3. Implement validators for identifiers, front matter, and references.
4. Implement generators for one journal, evidence, theory, and REP flow.
5. Test the vertical flow with a real research topic.
6. Add repository health reporting.
7. Generate a minimal static index.
8. Expand only after observed friction or missing capability.

## Definition of done for each task

- Acceptance criteria are satisfied.
- Automated validation passes.
- Relevant documentation is updated.
- Alternatives and tradeoffs are recorded for significant decisions.
- No unexplained placeholder is presented as implemented behavior.
- The next highest-value task is recorded.

## Non-goals for bootstrap

- A production graph database
- Sophisticated multi-agent orchestration
- A complete ontology
- A polished web application
- Automatic trust in agent-generated metadata
EOF

cat > registries/ideas/IDEA-REGISTRY.md <<'EOF'
---
id: IR-0001
title: Idea Registry
version: 0.1.0
status: active
---

# Idea Registry

| ID | Idea | Status | Value hypothesis | Next evaluation |
|---|---|---|---|---|
| IDEA-0001 | Markdown as canonical source | accepted | Durable, portable, diffable knowledge | Reassess after scale test |
| IDEA-0002 | Theory registry | planned | Prevent conclusions from being buried in reports | Prototype in vertical slice |
| IDEA-0003 | Evidence registry | planned | Enables traceability and confidence updates | Prototype in vertical slice |
| IDEA-0004 | Knowledge graph | deferred | Improves relationship discovery | Revisit after explicit links exist |
| IDEA-0005 | Repository generator | planned | Produces searchable views from canonical files | Build minimal index first |
| IDEA-0006 | Repository health dashboard | planned | Makes knowledge debt visible | Define metrics after validator |
| IDEA-0007 | Mobile companion | planned | Enables iPhone/iPad-first operation | Implement after core file workflow |
| IDEA-0008 | Architecture fitness functions | accepted | Continuously tests architectural claims | Add incrementally to CI |
| IDEA-0009 | Specification maturity levels | accepted | Distinguishes experimental from canonical rules | Validate practical usefulness |
| IDEA-0010 | Self-improving process | experimental | Lets methodology evolve with evidence | Govern through explicit proposals |
| IDEA-0011 | Greenfield architecture reviews | accepted | Counters attachment to early design | Run at milestone boundaries |
| IDEA-0012 | Codex task queue | accepted | Makes implementation incremental and auditable | Use for all major work |
EOF

cat > registries/decisions/DECISION-LOG.md <<'EOF'
---
id: DL-0001
title: Decision Log
version: 0.1.0
status: active
---

# Decision Log

| ID | Decision | Status | Rationale | ADR |
|---|---|---|---|---|
| ADR-0001 | Markdown plus YAML front matter is canonical | accepted | Portable, reviewable, machine-readable enough for bootstrap | `architecture/decisions/ADR-0001-markdown-canonical.md` |
| ADR-0002 | Start with a vertical slice rather than all subsystems | accepted | Reduces premature architecture and creates feedback early | `architecture/decisions/ADR-0002-vertical-slice.md` |
| ADR-0003 | Use Python standard library for bootstrap validation | accepted | Works in Codespaces with minimal dependencies | `architecture/decisions/ADR-0003-python-validator.md` |
EOF

cat > architecture/decisions/ADR-0001-markdown-canonical.md <<'EOF'
# ADR-0001: Markdown and YAML Front Matter as Canonical Storage

- Status: Accepted
- Date: 2026-07-21

## Context

The system requires durable, portable, human-readable, machine-processable artifacts that work through Git and mobile clients.

## Decision

Use Markdown with YAML front matter as the canonical representation during bootstrap.

## Alternatives

- Relational database
- Graph database
- JSON-only documents
- Proprietary knowledge-management system

## Consequences

Simple authoring and diffs are gained. Strong schema enforcement, transactions, and complex queries require additional tooling. The decision may be revisited if demonstrated scale or consistency requirements exceed file-based storage.
EOF

cat > architecture/decisions/ADR-0002-vertical-slice.md <<'EOF'
# ADR-0002: Build a Vertical Research Slice First

- Status: Accepted
- Date: 2026-07-21

## Decision

Implement one complete question-to-REP flow before building all registries, graphs, dashboards, and agents.

## Rationale

Real use exposes the smallest viable metadata model and prevents architecture from being driven by imagined requirements.
EOF

cat > architecture/decisions/ADR-0003-python-validator.md <<'EOF'
# ADR-0003: Python Standard-Library Bootstrap Validator

- Status: Accepted
- Date: 2026-07-21

## Decision

Use a dependency-free Python validator for initial repository checks.

## Consequences

Setup is simple and mobile/cloud friendly. YAML parsing is intentionally limited until a schema library is deliberately adopted.
EOF

cat > specifications/Research-Execution-Package-Specification-v2.md <<'EOF'
# Research Execution Package (REP) Specification

**Version:** 2.0  
**Status:** Canonical

## Purpose

The REP is the canonical artifact produced at the completion of every research effort. It serves as permanent scientific record, executable handoff, theory update, knowledge-transfer artifact, and synchronization point between autonomous research agents.

## Canonical Artifact Hierarchy

1. Scientific Research Journal
2. Research Execution Package
3. Theory Registry
4. Evidence Registry

## Stable Identifiers

| Artifact | Prefix |
|---|---|
| Research Package | RP- |
| Journal Entry | JR- |
| Evidence | EV- |
| Hypothesis | HY- |
| Theory | TH- |
| Experiment | EX- |
| Decision Framework | DF- |
| Concept | CN- |
| Glossary | GL- |

## Required Metadata

Identifier, Title, Research Area, Discipline, Author Agent, Version, Confidence, Completion, Priority, Related Projects, Related Documents, Supersedes/Superseded By, Tags, and Keywords.

## Research State Snapshot

Every REP begins with Theory Version, Knowledge Base Version, Highest Confidence Areas, Lowest Confidence Areas, Largest Remaining Unknown, Active Research Streams, Recently Invalidated Ideas, and Priority Changes.

## Mandatory Sections

Executive Summary; Original Objective; Scope; Repository Context; Current Understanding; Key Discoveries; Evidence Registry; Hypothesis Registry; Failed Assumptions; Open Questions; Recommended Next Research; Research Backlog; Suggested Specialized Research Agents; Parallel Research Opportunities; Risks; Cross-Discipline Opportunities; Knowledge Relationships; Repository Updates; Website Updates; AI Consumption Notes; Handoff Instructions; Research Journal; Appendix; Completion Checklist.

## Theory Impact Assessment

Document affected theory records, affected engineering principles, new principle candidates, deprecated principles, confidence changes, predictions created, predictions invalidated, and required theory-registry updates.

## Evidence Traceability

Every important claim should reference Evidence IDs, Hypothesis IDs, and Theory IDs.

## Research Quality Metrics

Track primary sources, independent sources, counterexamples reviewed, competing viewpoints reviewed, hypotheses tested, failed hypotheses, research completeness, confidence gain, and open questions reduced.

## Research Debt

Record missing evidence, missing experiments, missing disciplines, weak areas, replication needed, tool limitations, and assumptions awaiting evidence.

## Success Criteria

A completely different autonomous research agent should be able to reconstruct the investigation, understand the current theory, continue immediately, and produce the next REP without additional context.
EOF

cat > templates/research-journal.md <<'EOF'
---
id: JR-YYYY-NNNN
title: ""
research_area: ""
discipline: ""
author_agent: ""
version: 0.1.0
status: active
created: YYYY-MM-DD
updated: YYYY-MM-DD
---

# Journal Entry

## Objective

## Current theory

## Largest uncertainty

## Hypotheses

## Evidence gathered

## Attempts to falsify

## Interpretation

## Failed assumptions

## Decisions

## Next step
EOF

cat > templates/evidence.md <<'EOF'
---
id: EV-YYYY-NNNN
title: ""
evidence_type: ""
source: ""
source_date: ""
accessed: YYYY-MM-DD
reliability: unknown
relevance: unknown
status: active
---

# Evidence

## Claim supported or challenged

## Summary

## Method or provenance

## Limitations

## Related hypotheses

## Related theories
EOF

cat > templates/theory.md <<'EOF'
---
id: TH-YYYY-NNNN
title: ""
version: 0.1.0
status: proposed
confidence: 0
updated: YYYY-MM-DD
---

# Theory

## Statement

## Explanatory model

## Supporting evidence

## Contradicting evidence

## Predictions

## Falsification conditions

## Confidence rationale

## Revision history
EOF

cat > templates/research-package.md <<'EOF'
---
id: RP-YYYY-NNNN
title: ""
research_area: ""
discipline: ""
author_agent: ""
version: 0.1.0
confidence: 0
completion: 0
priority: medium
status: draft
created: YYYY-MM-DD
updated: YYYY-MM-DD
related_projects: []
related_documents: []
supersedes: []
superseded_by: []
tags: []
keywords: []
---

# Research Execution Package

## Research State Snapshot

## Executive Summary

## Original Objective

## Scope

## Repository Context

## Current Understanding

## Key Discoveries

## Evidence Registry

## Hypothesis Registry

## Failed Assumptions

## Theory Impact Assessment

## Open Questions

## Recommended Next Research

## Research Backlog

## Suggested Specialized Research Agents

## Parallel Research Opportunities

## Risks

## Cross-Discipline Opportunities

## Knowledge Relationships

## Repository Updates

## Website Updates

## AI Consumption Notes

## Handoff Instructions

## Research Journal

## Research Quality Metrics

## Research Debt

## Appendix

## Completion Checklist
EOF

cat > templates/agent-handoff.md <<'EOF'
# Agent Handoff

## Objective

## Work completed

## Files changed

## Decisions made

## Evidence added

## Theories changed

## Failed approaches

## Unresolved uncertainties

## Risks

## Exact next action

## Validation performed
EOF

cat > codex/README.md <<'EOF'
# Codex Task System

Codex tasks are versioned, bounded implementation assignments. Execute them in numerical order unless `CURRENT-STATE.md` explicitly reprioritizes the queue.

For each task, Codex must:

- read `AGENTS.md` and `CURRENT-STATE.md`;
- challenge the proposed approach;
- implement and test the smallest complete solution;
- update canonical documentation;
- report the exact commands executed;
- leave an executable handoff.
EOF

cat > codex/tasks/TASK-001-FOUNDATION-REVIEW.md <<'EOF'
# TASK-001 — Foundation Review and Correction

## Objective

Critically review the bootstrapped AI-ROS repository and correct foundational mistakes before feature development.

## Required process

1. Read every canonical entry-point document and all ADRs.
2. Identify contradictions, duplication, unjustified assumptions, missing risks, and premature abstractions.
3. Generate at least two alternative repository/knowledge architectures.
4. Compare them against mobile operation, Git reviewability, agent handoff, traceability, authoring burden, migration, and scale.
5. Attempt to falsify the current architecture.
6. Make only changes whose expected long-term value exceeds migration cost.
7. Add or update ADRs for material decisions.
8. Run validation.

## Acceptance criteria

- Canonical documents are internally consistent.
- The first vertical slice is precisely defined.
- The initial artifact types and deferred capabilities are explicit.
- Risks and non-goals are documented.
- `CURRENT-STATE.md`, `ROADMAP.md`, and `CHANGELOG.md` are updated.
- `python3 tools/validate.py` succeeds.
EOF

cat > codex/tasks/TASK-002-ARTIFACT-MODEL.md <<'EOF'
# TASK-002 — Minimal Artifact Model

## Objective

Define and implement the smallest common artifact model needed for one complete research flow.

## Scope

Journal entry, evidence, hypothesis, theory, and REP only.

## Requirements

- Define required and optional metadata.
- Define identifier allocation and collision behavior.
- Define explicit relationship syntax.
- Create schemas or equivalent validators.
- Add valid and invalid fixtures.
- Implement generators for each artifact.
- Avoid designing unused artifact types.

## Acceptance criteria

A user can generate a complete vertical-slice artifact set, validate it locally, and receive actionable error messages for malformed metadata, duplicate IDs, and unresolved references.
EOF

cat > codex/tasks/TASK-003-VERTICAL-SLICE.md <<'EOF'
# TASK-003 — End-to-End Research Vertical Slice

## Objective

Prove `question → journal → evidence → hypothesis → theory update → REP → generated index` with a real research topic.

## Requirements

- Use actual repository artifacts, not only synthetic fixtures.
- Record friction and metadata burden.
- Revise schemas based on observed use.
- Produce a minimal generated index without choosing a full site framework.
- Add an integration test.

## Acceptance criteria

A different agent can continue the selected research from repository artifacts alone.
EOF

cat > prompts/bootstrap/CODEX-BOOTSTRAP-PROMPT.md <<'EOF'
# Codex Bootstrap Prompt

You are the founding implementation agent for AI-ROS.

Work directly in the repository. Begin by reading `AGENTS.md`, `CURRENT-STATE.md`, the seven canonical documents, the REP specification, all ADRs, and the active Codex task.

Do not blindly execute the existing plan. Treat it as a hypothesis. Identify foundational mistakes before extending it. Generate credible alternatives, compare tradeoffs, attempt to falsify the preferred approach, and revise when evidence supports a better design.

Operate iteratively:

1. Inspect the repository and establish the actual state.
2. Identify the largest consequential uncertainty.
3. Propose at least two approaches for substantial decisions.
4. Choose the smallest reversible implementation that tests the assumption.
5. Implement real files and executable behavior.
6. Run tests and validation.
7. Review the result for unnecessary complexity and hidden failure modes.
8. Update ADRs, canonical documents, state, roadmap, and changelog.
9. Repeat until the active task's acceptance criteria are met.

Never substitute planning prose for requested implementation. Never report a command as successful unless you executed it. Do not leave fake integrations or claim placeholders are complete.

At completion, report:

- files created, changed, and deleted;
- decisions and alternatives;
- commands and tests executed with outcomes;
- remaining risks and uncertainty;
- technical debt introduced;
- the exact next highest-value task.
EOF

cat > setup.sh <<'EOF'
#!/usr/bin/env bash
set -Eeuo pipefail

printf 'AI-ROS setup\n'
python3 --version
git --version
chmod +x tools/*.py 2>/dev/null || true
python3 tools/validate.py
printf '\nSetup complete.\n'
EOF
chmod +x setup.sh

cat > tools/validate.py <<'PY'
#!/usr/bin/env python3
"""Dependency-free bootstrap validator for AI-ROS."""
from __future__ import annotations

import re
import sys
from dataclasses import dataclass
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
IGNORE_DIRS = {".git", "site", "node_modules", ".venv"}
ID_RE = re.compile(r"^id:\s*([A-Z][A-Z0-9-]*-\d{4,})\s*$", re.MULTILINE)
LINK_RE = re.compile(r"\[[^\]]+\]\((?!https?://|mailto:|#)([^)]+)\)")
PLACEHOLDER_RE = re.compile(r"\b(TODO|TBD|FIXME)\b")

REQUIRED_FILES = [
    "README.md",
    "AGENTS.md",
    "CURRENT-STATE.md",
    "ROADMAP.md",
    "strategy/0000-AI-ROS-Master-Plan.md",
    "constitution/000-Engineering-Constitution.md",
    "architecture/Architecture-Handbook.md",
    "handbooks/Research-Handbook.md",
    "implementation/Implementation-Guide.md",
    "registries/ideas/IDEA-REGISTRY.md",
    "registries/decisions/DECISION-LOG.md",
    "specifications/Research-Execution-Package-Specification-v2.md",
]

@dataclass
class Problem:
    kind: str
    path: Path
    message: str


def markdown_files() -> list[Path]:
    files: list[Path] = []
    for path in ROOT.rglob("*.md"):
        if not any(part in IGNORE_DIRS for part in path.parts):
            files.append(path)
    return sorted(files)


def main() -> int:
    problems: list[Problem] = []

    for relative in REQUIRED_FILES:
        path = ROOT / relative
        if not path.is_file():
            problems.append(Problem("missing-file", path, "required file does not exist"))

    ids: dict[str, Path] = {}
    for path in markdown_files():
        text = path.read_text(encoding="utf-8")
        for artifact_id in ID_RE.findall(text):
            if artifact_id in ids:
                problems.append(
                    Problem("duplicate-id", path, f"{artifact_id} also exists in {ids[artifact_id].relative_to(ROOT)}")
                )
            else:
                ids[artifact_id] = path

        for raw_target in LINK_RE.findall(text):
            target = raw_target.split("#", 1)[0]
            if not target:
                continue
            resolved = (path.parent / target).resolve()
            try:
                resolved.relative_to(ROOT.resolve())
            except ValueError:
                problems.append(Problem("external-path", path, f"link escapes repository: {raw_target}"))
                continue
            if not resolved.exists():
                problems.append(Problem("broken-link", path, f"missing target: {raw_target}"))

        if path.name not in {"ROADMAP.md"}:
            for match in PLACEHOLDER_RE.finditer(text):
                line = text.count("\n", 0, match.start()) + 1
                problems.append(Problem("placeholder", path, f"{match.group(1)} at line {line}"))

    if problems:
        print(f"Validation failed with {len(problems)} problem(s):")
        for problem in problems:
            rel = problem.path.relative_to(ROOT) if problem.path.is_absolute() else problem.path
            print(f"- [{problem.kind}] {rel}: {problem.message}")
        return 1

    print(f"Validation passed: {len(markdown_files())} Markdown files, {len(ids)} unique artifact IDs.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
PY
chmod +x tools/validate.py

cat > tools/new_artifact.py <<'PY'
#!/usr/bin/env python3
"""Create an artifact from a repository template without overwriting files."""
from __future__ import annotations

import argparse
import datetime as dt
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
CONFIG = {
    "journal": ("templates/research-journal.md", "research/journals", "JR"),
    "evidence": ("templates/evidence.md", "registries/evidence", "EV"),
    "theory": ("templates/theory.md", "registries/theories", "TH"),
    "rep": ("templates/research-package.md", "research/packages", "RP"),
}


def slugify(value: str) -> str:
    value = re.sub(r"[^a-zA-Z0-9]+", "-", value.strip().lower()).strip("-")
    return value or "untitled"


def next_id(prefix: str, year: int) -> str:
    pattern = re.compile(rf"\b{prefix}-{year}-(\d{{4}})\b")
    highest = 0
    for path in ROOT.rglob("*.md"):
        text = path.read_text(encoding="utf-8")
        for match in pattern.finditer(text):
            highest = max(highest, int(match.group(1)))
    return f"{prefix}-{year}-{highest + 1:04d}"


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("kind", choices=sorted(CONFIG))
    parser.add_argument("title")
    args = parser.parse_args()

    template_path, destination_dir, prefix = CONFIG[args.kind]
    today = dt.date.today()
    artifact_id = next_id(prefix, today.year)
    content = (ROOT / template_path).read_text(encoding="utf-8")
    content = content.replace(f"{prefix}-YYYY-NNNN", artifact_id)
    content = content.replace("YYYY-MM-DD", today.isoformat())
    content = content.replace('title: ""', f'title: "{args.title.replace(chr(34), chr(39))}"', 1)

    destination = ROOT / destination_dir / f"{artifact_id}-{slugify(args.title)}.md"
    destination.parent.mkdir(parents=True, exist_ok=True)
    if destination.exists():
        raise SystemExit(f"Refusing to overwrite {destination}")
    destination.write_text(content, encoding="utf-8")
    print(destination.relative_to(ROOT))


if __name__ == "__main__":
    main()
PY
chmod +x tools/new_artifact.py

cat > .github/workflows/validate.yml <<'EOF'
name: Validate AI-ROS

on:
  push:
  pull_request:

permissions:
  contents: read

jobs:
  validate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-python@v5
        with:
          python-version: '3.12'
      - name: Validate repository
        run: python3 tools/validate.py
      - name: Smoke test artifact generator
        run: |
          python3 tools/new_artifact.py journal "CI Smoke Test"
          python3 tools/validate.py
EOF

cat > .devcontainer/devcontainer.json <<'EOF'
{
  "name": "AI-ROS",
  "image": "mcr.microsoft.com/devcontainers/python:1-3.12-bookworm",
  "postCreateCommand": "./setup.sh",
  "customizations": {
    "vscode": {
      "extensions": [
        "DavidAnson.vscode-markdownlint",
        "redhat.vscode-yaml"
      ]
    }
  }
}
EOF

cat > .gitignore <<'EOF'
.DS_Store
.venv/
__pycache__/
*.pyc
site/generated/
.cache/
EOF

cat > mobile/ios/workflows/Working-Copy.md <<'EOF'
# Working Copy Workflow

1. Clone the GitHub repository in Working Copy.
2. Pull before editing.
3. Use the Files integration or an editor to modify Markdown.
4. Review the Working Copy diff.
5. Run full validation in Codespaces or rely on GitHub Actions for small mobile changes.
6. Commit with a scoped message.
7. Push and confirm CI passes.

The iPhone or iPad is the control surface. Git is the permanent record. ChatGPT proposes changes; Working Copy reviews and transports them; Codespaces and CI validate them.
EOF

cat > mobile/ios/shortcuts/AI-ROS-Launcher.md <<'EOF'
# AI-ROS Launcher Shortcut Specification

Create a Shortcut named **AI-ROS** with a Choose from Menu action.

Menu items:

- Continue Research
- Capture Idea
- Open Working Copy
- Open GitHub Repository
- Open ChatGPT

The first implementation SHOULD only open apps and copy prepared prompts. Direct Git mutation is deferred because review and conflict handling are safer in Working Copy.
EOF

python3 tools/validate.py

git add .
git commit -m "chore: bootstrap AI-ROS repository" >/dev/null 2>&1 || true

log "Bootstrap complete"
printf '\nNext steps:\n'
printf '  cd %q\n' "$PROJECT_DIR"
printf '  ./setup.sh\n'
printf '  cat prompts/bootstrap/CODEX-BOOTSTRAP-PROMPT.md\n'
printf '  Open codex/tasks/TASK-001-FOUNDATION-REVIEW.md in Codex\n'
