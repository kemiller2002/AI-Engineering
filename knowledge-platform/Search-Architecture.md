# Search Architecture

## Recommendation

Use hybrid search as the long-term default:

- BM25 or equivalent lexical ranking for exactness
- vector retrieval for conceptual similarity
- metadata filters for trust and scope control
- graph expansion for relationship-aware recall

No single method is sufficient on its own.

## Why

The current corpus already contains:

- high-value exact phrases like `validated engineering progress`
- conceptually related language that may not share exact terms
- future need for filtering by document type, status, confidence, chronology, and project

Keyword-only search misses conceptual neighbors.

Vector-only search weakens precision for names, IDs, versions, and governance states.

Graph-only traversal cannot retrieve concepts that have not yet been linked manually.

## Canonical Retrieval Stack

1. Metadata filter phase
   Restrict by `discipline`, `project`, `document_type`, `status`, `evidence_level`, and date.
2. Dual retrieval phase
   Run lexical and vector retrieval in parallel.
3. Rank fusion phase
   Merge results with reciprocal-rank fusion.
4. Graph expansion phase
   Pull directly related concept pages, superseded documents, and supporting evidence.
5. Citation packaging phase
   Return ranked passages with provenance, confidence, and canonical-source preference.

## Index Design

Maintain separate logical indexes:

- document index
- chunk index
- concept index
- relationship index

Document fields:

- id
- title
- abstract
- path
- discipline
- project
- document_type
- status
- evidence_level
- confidence
- canonical
- concepts
- modified_at

Chunk fields:

- chunk_id
- document_id
- heading_path
- content
- token_count
- embedding
- citation_span

Relationship fields:

- source_id
- target_id
- relationship_type
- confidence

## Chunking Strategy

- chunk by heading boundaries first
- preserve section titles with each chunk
- keep chunk size moderate and overlap light
- never embed raw navigation boilerplate or generated indexes

For this repository, heading-aware chunking will outperform naive fixed-window chunking because the documents are outline-driven.

## Query UX

Support search by:

- concept
- exact phrase
- handbook part
- lesson
- research package
- confidence level
- evidence level
- chronology
- canonical only
- project

## AI Consumption Pattern

For agent workflows, return:

- canonical summary
- top supporting chunks
- contradictory or superseded artifacts if present
- related concepts
- provenance and confidence

Agents should never consume bare vector hits without metadata and citations.

## Implementation Path

Near term:

- generate clean JSONL from the manifest and front matter
- use lexical plus embeddings over chunked Markdown

Scale phase:

- move to a dedicated search service with hybrid ranking, filters, and facets

Large-scale phase:

- precompute graph neighborhoods and concept-centered retrieval bundles
