# Research TODO Backfill Validation

Date: 2026-08-17

## Inventory result

- Proposed ROS backlog missions: 11.
- Frontier coverage: RFR-001 through RFR-010, one mission each.
- Additional experiment coverage: NX-005 audit/no-audit counterfactual.
- Mission status: 11 proposed, 0 active, 0 completed.
- Generated registry: `registries/missions.json`.

Duplicate roadmap checkboxes and NX aliases were consolidated according to
`docs/repository/2026-08-17-research-todo-backfill.md`. Engineering/product
items and illustrative/template TODOs were excluded from the research backlog.

## Commands and results

```bash
./ros registry build
./ros registry check
./ros validate --json
jq '{count:length, ids:map(.id), statuses:(group_by(.status)|map({key:.[0].status,value:length})|from_entries)}' registries/missions.json
npm test
npm run research:validate
git diff --check
```

Results:

- ROS generated one updated registry, `registries/missions.json`.
- Registry check passed.
- ROS validation returned `valid: true` with no findings.
- Registry count was 11 with IDs `MS-AIRES-2026-0001` through
  `MS-AIRES-2026-0011`, all `proposed`.
- Six historical-attribution tests and seven repository-integrity tests passed.
- Research Publisher validation passed.
- Diff whitespace validation passed.

## Manual checks

- Every mission uses the ROS mission ID and filename convention.
- Every mission records objective, scope, hypotheses, required evidence,
  constraints, deliverables, success criteria, stop conditions, and handoff.
- Dependencies match the frontier critical path and containment prerequisite.
- No mission was marked active merely because its source RFR is open.
- RFR-009's remaining work is represented without erasing its completed
  validation progress.
