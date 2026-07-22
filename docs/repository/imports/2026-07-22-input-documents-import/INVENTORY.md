# 2026-07-22 Input Documents Import Inventory

## Scope

- Source root: `input-documents/`
- Inventory timestamp: 2026-07-22
- Original source files inventoried before cleanup: 50

## Canonical Model Used

- `content/` for handbook, course, research-program, and research-relay content
- `ai-prompts/` for reusable prompts and the canonical REP v2 specification
- `docs/` for governance, mobile workflows, repository operations, and audit records
- `templates/` for reusable artifact templates
- `research/` for canonical empty working directories preserved with `.gitkeep`
- `archive/` for derived packages and historical materials

## Disposition Summary

- `canonical-new`: 31 files moved into their canonical repository locations
- `supplemental`: 8 files preserved as supporting or historical repository documents
- `template`: 6 template files moved into `templates/`
- `mobile-workflow`: 5 files moved into `docs/mobile/ios/`
- `duplicate-exact`: 1 file removed after SHA-256 verification against the existing canonical REP v2 specification
- `archive-only`: 1 derived ZIP package preserved under `archive/packages/`
- `placeholder-directory`: 7 empty bootstrap `.gitkeep` files recreated under `research/` and removed from the intake area

## Notes

- The canonical REP v2 file remained `ai-prompts/Research-Execution-Package-Specification-v2.md`.
- Bootstrap placeholder README files for CI, tests, tools, and website generation were preserved under `docs/repository/` as historical scope markers, not active implementations.
- `knowledge-platform/repository.json`, `knowledge-platform/repository.csv`, and `knowledge-platform/knowledge-genome.json` were not regenerated in this task; they remain pre-import generated snapshots.

## Detailed Manifest

See `FILE-MANIFEST.csv`.
