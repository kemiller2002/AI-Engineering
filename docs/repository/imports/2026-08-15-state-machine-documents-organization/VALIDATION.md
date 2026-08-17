# State-Machine Documents Organization Validation

This record is completed from the post-migration checks and should be read with
`DECISIONS.md` in this directory.

- Source corpus: 54 tracked files.
- Unique source artifacts retained: 52.
- Exact duplicate paths consolidated: 2.
- Numbered research prompts present: 12 of 12.
- Numbered research reports present: 12 of 12.
- Cross-series synthesis present: yes.
- Unique Time Entry inputs present: 3.
- Separate numbered Time Entry specification set found: no.
- Research substance rewritten: no.
- Commit or push performed: no.

## Repository checks

- `git diff --check` and `git diff --cached --check`: passed.
- `npm run research:validate`: passed.
- `python3 tools/evaluation/evalctl.py repo-audit`: repository case,
  identifier, and frontier checks were clean, but the aggregate command failed
  because its link scanner includes installed `node_modules/` package READMEs
  with upstream-relative links. None of the reported paths are in this migrated
  corpus or were introduced by this organization.
