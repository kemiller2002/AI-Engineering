# Build Pipeline

## Pipeline Recommendation

```text
Repository
  -> Inventory
  -> Metadata validation
  -> Content normalization
  -> Concept extraction
  -> Relationship extraction
  -> Registry generation
  -> Search indexing
  -> Website generation
  -> Validation
  -> Publication
  -> Version archive
```

## Stage Definitions

### 1. Inventory

Scan every artifact and produce:

- `repository.json`
- `repository.csv`
- file hashes
- basic content metrics
- duplicate and missing-metadata signals

### 2. Metadata Validation

Validate front matter:

- required fields
- controlled vocabularies
- supersession references
- relationship references

Fail the build on invalid canonical artifacts.

### 3. Content Normalization

Normalize:

- headings
- dates
- IDs
- slug generation
- line ending consistency

Derived archives should be excluded from canonical ingestion but included in archive reporting.

### 4. Concept Extraction

Generate:

- concept candidates
- document-to-concept mappings
- canonical concept assignments

This starts as rules plus curated mappings and later adds model-assisted extraction.

### 5. Relationship Extraction

Generate edges from:

- explicit links
- front matter relations
- supersession chains
- citations
- semantic similarity
- manual curation

Store confidence for each edge.

### 6. Registry Generation

Generate:

- evidence registry
- hypothesis registry
- experiment registry
- decision registry
- chronology views

These should never be hand-maintained.

### 7. Search Indexing

Produce:

- document records
- heading-aware chunks
- embeddings
- lexical index payloads
- facet metadata

### 8. Website Generation

Build:

- concept pages
- artifact pages
- registry pages
- graph data bundles
- timeline data bundles

### 9. Validation

Check:

- missing pages
- broken relations
- orphaned canonical pages
- search document coverage
- duplicate IDs
- invalid metadata

### 10. Publication

Publish:

- static site
- search index updates
- manifest snapshots

### 11. Version Archive

Persist:

- build metadata
- manifest snapshot
- graph snapshot
- search snapshot version

This is required for historical comparison and reproducibility.

## Automation Priority

Automate in this order:

1. inventory
2. metadata validation
3. registry generation
4. search indexing
5. website generation
6. graph enrichment
