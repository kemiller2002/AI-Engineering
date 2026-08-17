# ROS Historical Migration Validation

Date: 2026-08-17

## Scope

This validates the historical attribution schema, the eight reconstructed
records covering the pre-install interval, registry determinism, compatibility,
and the live/historical transition boundary. It does not retroactively validate
the substantive historical research or prove missing approvals and tests.

## Inventory reconciliation

- Historical cutoff: `b2877f1cdc87f9ab0df732947b78354b789ba986`.
- ROS installation commit: `4f8b816480d1c27780e6f594d846ba33ebe325d3`.
- Pre-install commits: 20.
- Historical records: 8.
- Unique commits referenced by records: 20.
- `comm` comparison between `git rev-list b2877f1` and JSONL commit references:
  no differences.
- Unique attributed path groups: 35.
- Reconstruction confidence: 7 high, 1 medium.
- Tags found: 0.
- Side branch tips found: 0; only `main` and its remote-tracking references were
  present.

## Commands and results

### Historical validator tests

```bash
npm run test:ros
```

Passed 6/6 tests:

1. valid records parse and preserve legacy compatibility metadata;
2. duplicate migration IDs fail;
3. malformed and unknown commit hashes fail with Git history available;
4. invalid semantic states fail; and
5. historical records cannot contain live transition authority fields; and
6. valid history can satisfy dirty-path attribution while invalid history cannot.

### Existing repository-integrity tests

```bash
python3 -m unittest tools.repository.test_validate_research_integrity
```

Passed 7/7 tests.

### Combined project test command

```bash
npm test
```

Passed: 6 ROS history tests plus 7 repository-integrity tests.

### Research Publisher validation

```bash
npm run research:validate
```

Passed. Compatibility-mode metadata diagnostics remain warnings rather than
strict failures.

### Repository audit

```bash
python3 tools/evaluation/evalctl.py repo-audit
```

Passed. It reported no case collisions, duplicate identifiers, broken explicit
local Markdown links, or frontier structure errors. Relationship and metadata
coverage diagnostics remain non-blocking and include known legacy gaps.

### ROS registries and validation

```bash
./ros registry build
./ros registry check
./ros validate
./ros registry build --dry-run
```

Results:

- `registries/decisions.json` was rebuilt by ROS to include
  `DF-ROS-HISTORY-2026-0001`.
- Registry check passed.
- ROS validation passed.
- The subsequent dry run reported `0 registry file(s) would change`, confirming
  deterministic regeneration for the current tree.

An intermediate `./ros validate --json` correctly failed only because the new
Decision Record made `registries/decisions.json` stale before the required
registry rebuild. The rebuild resolved that expected finding.

### Diff and coverage checks

```bash
git diff --check
comm -3 <(git rev-list --reverse b2877f1 | sort) \
  <(jq -r '.commits[]' .ros/history/historical-work.jsonl | sort -u)
```

Both completed without output. No historical commit was omitted or added, and
no whitespace error was found in tracked diffs.

## Fresh-agent reconstruction check

The repository now provides a conversation-independent path:

1. root `CURRENT-STATE.md` for present authority;
2. `docs/repository/ros-migration/HISTORICAL-WORK-INDEX.md` for the human
   reconstruction and grouping rationale;
3. `.ros/history/historical-work.jsonl` for machine attribution;
4. record-level decision and evidence paths for supporting artifacts; and
5. `.ros/events/events.jsonl` for live ROS-era transitions only.

The index states all known gaps and distinguishes commit observation from
inferred work boundaries.

## Preserved limitations

- No external issues, pull requests, approvals, or work-item export were found.
- Missing historical test results remain “not found,” never “passed.”
- Generated output is not counted as independent research evidence.
- Git author timestamps do not prove the full duration of human work.
- The state-constrained research sequence remains medium-confidence as a grouped
  reconstruction because its commits do not expose a complete authoring journal.
