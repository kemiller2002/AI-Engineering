# Metadata Standard

## Purpose

The repository needs one canonical front matter schema for every authored Markdown artifact.

This schema must support:

- human navigation
- faceted search
- AI retrieval
- lifecycle governance
- supersession
- graph generation

## Required Fields

```yaml
id: aie-handbook-foundations
title: Part 1 - Foundations
abstract: Short canonical summary of the artifact.
author:
  - Kevin Miller
date: 2026-07-20
discipline: ai-engineering
project: ai-engineering-course
research_area: foundations
document_type: handbook-part
status: draft
confidence: 0.88
evidence_level: synthesized
canonical: true
tags:
  - context-engineering
  - durable-artifacts
keywords:
  - validated progress
  - retrieval
related: []
supersedes: []
superseded_by: []
reading_time_minutes: 4
```

## Recommended Optional Fields

```yaml
summary: One-sentence display summary.
chapter: 1
lesson: 1
sequence: 1
reviewed_on: 2026-07-21
reviewers:
  - research-reviewer
provenance:
  source_type: authored
  derived_from: []
  generated_by: null
audience:
  - researcher
  - engineer
concepts:
  - context-engineering
  - validated-progress
registries:
  evidence: []
  hypotheses: []
  experiments: []
```

## Controlled Vocabularies

`discipline`

- ai-engineering
- software-engineering
- design-research
- cognitive-science
- systems-thinking

`document_type`

- concept-page
- handbook-part
- lesson
- workbook
- cheat-sheet
- research-brief
- research-notes
- evidence-record
- hypothesis-record
- experiment-report
- decision-record
- roadmap
- governance
- notes
- packaged-archive

`status`

- seed
- draft
- review
- accepted
- superseded
- archived

`evidence_level`

- observation
- evidence
- synthesis
- hypothesis
- theory
- accepted-knowledge
- deprecated-knowledge
- open-question

## Canonical Rules

- `id` must be globally unique and stable.
- `title` is human-facing and may change.
- `id` and path slugs should not depend on titles staying constant.
- `canonical: true` is reserved for source artifacts that should receive backlinks and citation priority.
- Derived artifacts must set `canonical: false` and include `derived_from`.

## AI Retrieval Rules

- `abstract` is mandatory because it is the safest chunk-level summary seed.
- `confidence` and `evidence_level` should weight retrieval and ranking.
- `related`, `supersedes`, and `superseded_by` should be used to expand retrieval neighborhoods.
- `concepts` should map documents into the Knowledge Genome.

## Validation Rules

Reject build-time publication when:

- required metadata is missing
- `status` is invalid
- `id` collides with an existing artifact
- `supersedes` points to a missing artifact
- derived artifacts lack provenance
