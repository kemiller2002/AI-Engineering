# ROS Historical Work Index

## Purpose and boundary

This index reconstructs material repository work completed before ROS was
installed. It does **not** claim that the work originally followed ROS.
Machine-readable attribution lives in
`.ros/history/historical-work.jsonl`; live transitions remain in
`.ros/events/events.jsonl`.

The inspected historical interval is the initial commit on 2026-07-20 through
commit `b2877f1cdc87f9ab0df732947b78354b789ba986` on 2026-08-17. ROS was installed
by the next commit, `4f8b816480d1c27780e6f594d846ba33ebe325d3`.
The interval contains 20 commits and 521 tracked paths at its endpoint. Git
showed no tags and no branch tips beyond `main`/`origin/main` at migration time.

The post-install publishing normalization in commit
`7892bbead6d447e620ae870c60a38ad59274b4d6` is excluded from historical
backfill because live ROS events already attribute it.

## Authority and interpretation

- Root `CURRENT-STATE.md` is the authoritative current-state record.
- `context/CURRENT-STATE.md` is a compact derived ROS entry point.
- Git commits prove repository snapshots, commit metadata, and recorded author;
  they do not prove the full duration of human effort or independent approval.
- Existing validation reports are evidence of what was recorded at the time.
  A reported historical pass is not represented as a migration-time rerun.
- Generated registries, publisher output, inventories, and build reports are
  secondary discovery aids or generator-run evidence, not independent evidence
  for research conclusions.
- Current canonical paths are used where later compatibility-preserving moves
  retained content. Import and organization audits preserve legacy paths.

The governing decision is
`DF-ROS-HISTORY-2026-0001` in
`research/decisions/DF-ROS-HISTORY-2026-0001--historical-attribution-policy.md`.

## Reconstructed work

| Migration ID | Reconstructed work item | Type | State | Observed dates | Commits | Confidence | Disposition |
|---|---|---|---|---|---:|---|---|
| HWM-001 | HIST-REPOSITORY-BOOTSTRAP | maintenance | complete | 2026-07-20–2026-07-21 | 2 | high | grouped-historical-work |
| HWM-002 | HIST-INPUT-DOCUMENTS-IMPORT | maintenance | complete | 2026-07-22 | 3 | high | reconstructed-from-documents |
| HWM-003 | HIST-AI-RESEARCH-MISSION-CYCLE-001 | research | complete | 2026-07-23–2026-07-26 | 3 | high | reconstructed-from-documents |
| HWM-004 | HIST-EVALUATION-CYCLES-002-003-AND-FRONTIER | research | complete | 2026-07-28 | 1 | high | grouped-historical-work |
| HWM-005 | HIST-RESEARCH-INTEGRITY-VALIDATION | engineering | complete | 2026-07-30 | 1 | high | directly-mapped |
| HWM-006 | HIST-RESEARCH-PUBLISHER | engineering | complete | 2026-08-04 | 3 | high | grouped-historical-work |
| HWM-007 | HIST-STATE-CONSTRAINED-ARCHITECTURE-RESEARCH | research | complete | 2026-08-13–2026-08-15 | 5 | medium | grouped-historical-work |
| HWM-008 | HIST-STATE-CORPUS-ORGANIZATION | maintenance | complete | 2026-08-17 | 2 | high | compatibility-preserved |

### HWM-001 — Repository bootstrap

- **Observed work:** initialized Git and added the first repository orientation,
  state, and roadmap documents.
- **Actor:** Kevin Miller is the observed Git author.
- **Evidence/tests:** commit trees only; no original tests or approval record
  were found.
- **Grouping:** the placeholder initial commit and root-document bootstrap are
  one coherent initialization objective.
- **Gap:** the actual start of the human work and any external work item are
  unknown.

### HWM-002 — Input corpus import and normalization

- **Observed work:** imported the bootstrap kit, handbook, course, mobile,
  prompt, template, and knowledge-platform sources; normalized canonical paths;
  archived the Chapter 1 derivative; and removed the nested intake tree.
- **Decisions:** seven recorded import decisions cover destination authority,
  duplicate REP handling, root controls, placeholders, archive treatment,
  lesson-draft status, and empty research directories.
- **Evidence:** the 50-row file manifest, SHA-256 observations, and validation
  report under `docs/repository/imports/2026-07-22-input-documents-import/`.
- **Limitation:** the historical validation explicitly says no repository
  validator or build existed; no stronger test claim is inferred.

### HWM-003 — AI research mission and evaluation Cycle 001

- **Observed work:** created the state-of-field REP, gap analysis, priority
  matrix, research roadmap, evaluation charter, task suite, registries, failure
  taxonomy, journal, and Cycle 001 record.
- **Conclusion:** long-horizon repository-agent evaluation was selected as the
  highest-value mission; the cycle established an audit-first design and did not
  claim capability evidence.
- **Decisions:** mission execution and evaluation-infrastructure records under
  `docs/repository/`.
- **Gap:** no independent review, capability baseline, or stochastic estimate
  existed at this point.

### HWM-004 — Evaluation Cycles 002–003 and repository frontier

- **Observed work:** ran task-integrity pilots, calibrated declared probes,
  exported blind fixtures, added evaluation architecture and threat modeling,
  canonicalized root case collisions, and established the ten-item frontier.
- **Original identifier:** `RP-RFA-2026-001` is recorded for the frontier subset.
- **Conclusion:** the 7/7 calibration was dependent and in-sample; pilots
  remained provisional pending independent review and unseen-outcome challenge.
- **Grouping:** one large commit captured the related evaluation-roadmap update.
  Separate decision files preserve its evaluation, collision, and frontier
  outcomes.

### HWM-005 — Research-integrity validation

- **Original identifier:** `RFR-009`.
- **Observed work:** added identifier, explicit-link, and frontier consistency
  validation plus four seeded tests and a machine-readable inventory.
- **Recorded historical evidence:** the 2026-07-30 decision reports four tests,
  38 identifier-bearing artifacts, no unexplained collisions, no broken explicit
  Markdown links, and a consistent 10-node/12-edge frontier.
- **Gap:** full metadata coverage and semantic provenance were explicitly outside
  scope; those limits remain preserved.

### HWM-006 — Research Publisher and Pages workflow

- **Observed work:** generated the initial site, added the npm dependency and
  scripts, configured broad Markdown discovery, and added GitHub Pages CI.
- **Evidence:** configuration, lockfile, workflow, and generated build reports.
- **Evidence boundary:** generated `dist/` and publisher data are derivatives.
- **Gap:** no repository record confirms the first successful remote deployment.

### HWM-007 — State-constrained architecture research

- **Observed work:** developed predecessor notes, a benchmark prompt bundle, a
  12-prompt/12-report series, synthesis, architecture proposals, proposed
  experiments, and Time Entry application inputs.
- **Conclusion:** the corpus is primarily literature synthesis, design work, and
  proposed experiments; it does not establish independent replication.
- **Confidence:** medium because terse commits and a single large import-like
  research commit do not identify the authoring sequence or external approvals.
- **Compatibility:** current paths under `research/state-constrained-architecture/`,
  `docs/architecture/semantic-control/`, and `content/projects/time-entry/` map
  back to the original `state-machine-documents/` paths through the later audit.

### HWM-008 — Corpus organization and metadata diagnostics

- **Original identifier:** `RFR-009` applies to the metadata-diagnostic subset.
- **Observed work:** separated research, generic architecture, and Time Entry;
  retained 52 unique artifacts from 54 source paths; consolidated two verified
  byte-identical duplicates; extended metadata/relationship diagnostics; and
  rebuilt publisher output.
- **Decisions/evidence:** the 2026-08-15 organization decision and validation
  records plus the RFR-009 investigation.
- **Compatibility:** accepted identifiers and substantive content were retained;
  the move changed location and navigation, not research authority.

## Grouping and compatibility rules

1. Merge commits are included in lineage where they fall inside a coherent
   interval, but they are not independent evidence.
2. Trivial cleanup, visualization-label, and generated-output follow-ups are
   grouped with the objective they complete.
3. A large commit may remain one historical unit when splitting it would require
   invented authorship, timing, or transition boundaries. Separate artifacts
   and decisions remain enumerated.
4. Legacy artifact IDs remain valid. This migration introduces no identifier
   rename and therefore no identifier migration map.
5. Historical semantic state `complete` means the reconstructed repository
   change was committed, not that every research claim was proven or every
   follow-up was completed. Research conclusions and gaps qualify that state.

## Remaining gaps

- No external issue tracker, pull-request review, approval, or work-item export
  was present in the inspected repository, so original work-item identity is
  usually unknown.
- Git author timestamps are exact repository observations but may not equal the
  actual start and completion of human effort.
- Commit authorship does not establish the authorship of every imported or
  generated document.
- Historical test outcomes exist only where reports record them. Missing results
  remain “not found,” not passed.
- No successful GitHub Pages deployment receipt was found.
- The state-constrained corpus lacks one execution journal that reconstructs the
  authorship and evidence-gathering sequence for all 12 missions.
- Several legacy metadata and identifier formats remain intentionally compatible
  rather than migrated; current validators still report diagnostic coverage
  gaps outside the strict ROS artifact directories.

## Fresh-agent reconstruction path

1. Read root `CURRENT-STATE.md` for present authority and next work.
2. Read this index for the pre-ROS history and confidence boundaries.
3. Inspect `.ros/history/historical-work.jsonl` for machine attribution.
4. Follow each record's `decisions` and `evidence` paths for primary repository
   support.
5. Read `.ros/events/events.jsonl` only for live ROS-era transitions.
6. Run `./ros validate` before relying on historical attribution.
