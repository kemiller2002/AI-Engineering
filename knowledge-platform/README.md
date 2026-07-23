# Knowledge Platform Deliverables

This directory contains architecture deliverables for the repository state initially assessed on 2026-07-21 and still useful after the 2026-07-22 document-ingestion pass.

Files:

- `repository.json`: machine-readable repository manifest and health assessment
- `repository.csv`: flat catalog export for spreadsheet tooling
- `knowledge-genome.json`: concepts, relationships, clusters, and lineage
- `Repository-Architecture.md`: recommended long-term repository architecture
- `Metadata-Standard.md`: canonical front matter and controlled vocabulary
- `Search-Architecture.md`: retrieval, indexing, and query design
- `Website-Architecture.md`: generated knowledge-platform information architecture
- `Build-Pipeline.md`: end-to-end automation pipeline
- `Migration-Plan.md`: incremental migration roadmap with artifact-level actions

Current evidence summary:

- 50 source files were ingested from `input-documents/` on 2026-07-22
- handbook, course, governance, mobile, prompt, template, and research artifacts now exist in canonical locations outside `input-documents/`
- the original migration plan remains relevant for metadata normalization, relationship extraction, and generated-platform work
- `repository.json`, `repository.csv`, and `knowledge-genome.json` are pre-import generated snapshots and should be regenerated in a later automation pass
- 0 files with front matter metadata
- 0 explicit Markdown or wiki links between documents
- 1 packaged archive remains preserved as a derived historical artifact
