# Website Architecture

## Decision

Use a custom static-first knowledge platform built on Astro as the presentation layer.

Do not use the website as the canonical repository.

Do not use Quartz as the long-term system architecture, even though some of its note-oriented features are valuable.

## Why Astro

Astro is the best fit for this repository because it separates content generation from interactive components cleanly.

That matters here because the platform needs:

- generated registries
- faceted search UI backed by an external index
- graph and timeline visualizations
- static pages for canonical content
- selective interactivity for graph views, filters, and reading paths

Astro gives a low-JavaScript static default while still allowing targeted interactive islands.

## Why Not Quartz As The Core Platform

Quartz is strong for note-native knowledge bases:

- backlinks
- graph view
- wikilinks
- fast local full-text search

But its built-in model is optimized for note graphs and client-side search rather than a 100,000+ document scientific repository with generated registries and strict metadata governance.

Use Quartz ideas, not Quartz constraints, as the long-term architecture.

## Why Not MkDocs Material As The Core Platform

MkDocs Material is excellent for structured documentation and has solid built-in local search.

Its center of gravity is still documentation publishing, not a concept graph plus research registries plus relationship-aware knowledge platform.

It is a good fit for the handbook alone, but not for the full target system.

## Why Not Docusaurus As The Core Platform

Docusaurus has strong docs ergonomics and mature hosted search integrations.

It is better suited to versioned documentation portals than to a scientific knowledge platform where content types, generated registries, and relationship models will diversify significantly.

## Recommended Information Architecture

Top-level routes:

- `/`
- `/disciplines/`
- `/projects/`
- `/concepts/`
- `/handbook/`
- `/research-journal/`
- `/evidence/`
- `/hypotheses/`
- `/experiments/`
- `/decisions/`
- `/timelines/`
- `/graph/`
- `/reading-paths/`
- `/search/`

## Page Types

Home:

- repository overview
- health status
- recent additions
- featured concepts
- active open questions

Concept page:

- canonical explanation
- related concepts
- supporting documents
- contradictory evidence
- lineage timeline

Artifact page:

- title and metadata
- canonical/derived badge
- source relationships
- backlinks
- supersession chain

Registry page:

- generated faceted table
- export links

Graph page:

- concept graph
- document graph
- local neighborhood toggle

## Search UX

The website should surface one search box but support:

- keyword
- semantic
- filters
- relationship traversal
- canonical-only mode

## Practical Build Strategy

- render canonical content statically
- hydrate only graph, filter, and search interfaces
- precompute navigation and concept adjacency during build
- rely on a dedicated search backend once the corpus outgrows local indexes
