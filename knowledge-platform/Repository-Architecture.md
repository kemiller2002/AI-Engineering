# Repository Architecture

## Executive Recommendation

Do not optimize the long-term repository around a folder tree or a website generator.

Optimize it around three layers:

1. Canonical knowledge artifacts in Git-managed Markdown with strict front matter.
2. Generated structured data products such as manifests, registries, graph edges, and search indexes.
3. Derived presentation surfaces such as a website, dashboards, graph views, and reading paths.

This keeps the source of truth stable while allowing search, visualization, and AI retrieval systems to evolve independently.

## Evidence From The Current Repository

- The corpus is small but already heterogeneous: handbook parts, lesson material, research artifacts, governance, and a packaged archive.
- The repository currently has no machine-readable metadata, no internal links, and no explicit knowledge relationships.
- Canonical and derived artifacts are mixed together.
- Project, discipline, and artifact-type dimensions are encoded inconsistently in filenames rather than metadata.

The repository is therefore conceptually coherent but structurally pre-platform.

## Canonical Model

The repository should distinguish:

- canonical knowledge: handbook parts, concept pages, ADRs, evidence records, hypotheses, experiment reports, decision records
- project/course artifacts: lessons, workbooks, presentations, roadmaps, teaching notes
- derived artifacts: packaged zips, exported PDFs, generated websites, generated diagrams
- system data: repository manifests, graph edges, embeddings, search documents, validation reports

Only canonical knowledge and project/course artifacts should be hand-authored.

Everything else should be generated.

## Recommended Directory Architecture

```text
/content
  /concepts
  /disciplines
    /ai-engineering
      /handbook
  /projects
    /ai-engineering-course
      /governance
      /roadmaps
      /chapter-01
        /research
        /derived
  /registries
    /evidence
    /hypotheses
    /experiments
    /decisions
  /archive
    /packages

/data
  /manifests
  /graph
  /search
  /validation

/scripts
  /inventory
  /metadata
  /graph
  /search
  /site
```

## Organization Strategy

The best long-term organization is hybrid:

- discipline-first for durable bodies of knowledge
- project-first for work products and courseware
- artifact registries as cross-cutting generated views

Do not use artifact-first as the primary top-level structure. It scales badly for readers and makes concept discovery difficult.

Do not use project-first alone. It causes duplication when the same concept appears across books, courses, and research programs.

## Systems Of Record

Use two systems of record:

1. Repository Manifest
   Contains inventory, quality signals, storage locations, and lifecycle state.
2. Knowledge Genome
   Contains concepts, relationships, lineage, and canonical concept assignments.

Neither the website nor the search index should be treated as authoritative.

## Canonical Artifact Rules

- Every major concept gets one canonical concept page.
- Lessons, cheat sheets, workbooks, and presentations should link to concept pages instead of redefining terms.
- Research briefs and research notes remain separate artifacts.
- Derived archives are immutable outputs and belong under `/content/archive` or an external release store.
- Historical reasoning is preserved through supersession metadata, not deletion.

## Lifecycle States

Use explicit states:

- seed
- draft
- review
- accepted
- superseded
- archived

This is required for search filtering, AI retrieval weighting, and website trust cues.

## Scalability View

At 1,000 documents:

- local manifests, graph JSON, and lightweight search are sufficient

At 10,000 documents:

- automated metadata enforcement and generated registries become mandatory

At 100,000 documents:

- client-only indexing is no longer enough
- hybrid search with a dedicated search service becomes necessary
- graph data should be materialized explicitly rather than inferred at render time

At 1,000,000 documents:

- sharded indexing, archival tiering, and strict lifecycle governance are required

## Highest-Risk Future Bottlenecks

- absent metadata
- duplicated concept explanations
- weak supersession handling
- client-side-only search
- coupling canonical storage to one specific site generator

The architecture should fix those before the corpus grows, not after.
