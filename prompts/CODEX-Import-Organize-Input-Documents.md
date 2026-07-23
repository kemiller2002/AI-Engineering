# Codex Task — Import, Evaluate, Consolidate, and Empty `input-documents`

**Task ID:** CODEX-TASK-IMPORT-001  
**Status:** Ready for execution  
**Execution mode:** Autonomous repository maintenance and information architecture  
**Primary target:** The current AI-ROS repository  
**Source location:** `input-documents/`  

---

## Mission

Inspect everything currently inside `input-documents/`, including the expanded `AI-ROS-Bootstrap-Kit-v1.0` directory and every other file or directory present.

Evaluate all material against the current repository, preserve every unique and useful piece of information, integrate it into the correct canonical locations, resolve duplicates and conflicts deliberately, update navigation and project-state artifacts, and leave `input-documents/` empty and ready for future unprocessed documents.

Do not merely move files mechanically.

Treat this as a repository ingestion, reconciliation, normalization, and cleanup operation.

Work autonomously. Make reasonable decisions without asking for permission unless a genuinely destructive ambiguity cannot be resolved through repository evidence, Git history, document metadata, or conservative preservation.

---

## Non-Negotiable Outcomes

At completion:

1. Every file originally present in `input-documents/` MUST be accounted for.
2. Every unique, useful, or historically relevant item MUST be preserved in an appropriate repository location.
3. Existing canonical documents MUST NOT be blindly overwritten.
4. Duplicate and conflicting documents MUST be compared substantively, not only by filename.
5. The expanded `AI-ROS-Bootstrap-Kit-v1.0` MUST be integrated into the repository rather than left as a nested standalone repository copy.
6. The repository MUST have a clear canonical structure after consolidation.
7. Links, indexes, manifests, roadmaps, and current-state files MUST be updated where needed.
8. Validation and tests MUST pass, or remaining failures MUST be fully documented with corrective next steps.
9. `input-documents/` MUST contain no unprocessed files or directories at the end.
10. Keep `input-documents/.gitkeep` only if needed to preserve the empty directory in Git.
11. Produce a complete ingestion report and commit-ready summary.

---

## Governing Principles

Follow these priorities in order:

1. Preserve unique knowledge.
2. Preserve provenance and traceability.
3. Protect stronger canonical content.
4. Reduce duplication and ambiguity.
5. Improve discoverability and navigation.
6. Maintain repository consistency.
7. Prefer simple, reversible changes.
8. Avoid unnecessary restructuring outside the scope of this import.

Git history is part of the preservation strategy, but do not rely on Git history as an excuse to destroy unique content before confirming it has been retained elsewhere.

---

## Safety Rules

You MUST:

- Begin from the repository root.
- Confirm the current Git branch and working-tree status.
- Inspect repository-specific instructions such as `AGENTS.md`, `CONTRIBUTING.md`, `README.md`, constitutions, architecture documents, Codex instructions, and validation commands before changing files.
- Preserve unrelated pre-existing user changes.
- Use `git mv` when relocating tracked files where practical.
- Use content hashes and substantive comparison to detect duplicates.
- Create a pre-import inventory before moving or deleting anything.
- Never overwrite an existing file solely because an incoming file has the same path or name.
- Prefer merge, rename, supersede, or archive decisions based on content and canonical status.
- Keep all changes inside the current repository.
- Avoid introducing new dependencies unless clearly justified and documented.

You MUST NOT:

- Delete unique content.
- Reset, clean, stash, or discard unrelated work.
- Force-push or rewrite Git history.
- treat newer filesystem timestamps as proof that a document is more current.
- create a second nested AI-ROS root inside the repository.
- retain the bootstrap kit as an unexplained duplicate directory after its contents have been integrated.
- leave unresolved files in `input-documents/` merely because classification is difficult.
- invent document authority, version, or status not supported by evidence.

When uncertain, preserve the item conservatively in a clearly labeled archive or review location and record why.

---

## Required Initial Inspection

Before modifications, inspect:

- the complete repository tree;
- all files under `input-documents/`, recursively;
- Git status and recent history;
- existing canonical documents;
- existing directory conventions;
- stable identifier conventions;
- validation scripts and CI workflows;
- current roadmap, master plan, current-state, decision log, idea registry, and manifests;
- existing files that resemble incoming files by name, title, identifier, purpose, or content.

At minimum, run equivalent checks to:

```bash
pwd
git status --short --branch
git log --oneline -10
find . -maxdepth 3 -type f | sort
find input-documents -type f -print | sort
```

Use repository-appropriate alternatives when needed.

---

## Phase 1 — Create a Complete Intake Inventory

Create an inventory before altering source files.

Recommended output:

```text
docs/repository/imports/YYYY-MM-DD-input-documents-import/
├── INVENTORY.md
├── FILE-MANIFEST.csv
├── DECISIONS.md
└── VALIDATION.md
```

If the repository already has a canonical import/audit location, use that instead.

For every source file, record:

- original relative path;
- filename;
- extension or artifact type;
- byte size;
- SHA-256 hash where tooling permits;
- detected title;
- detected version;
- detected status;
- apparent purpose;
- likely canonical destination;
- possible existing counterpart;
- preliminary classification;
- final disposition;
- notes on unique content or risk.

Suggested classifications:

- `canonical-new`
- `canonical-update-candidate`
- `supplemental`
- `template`
- `prompt`
- `mobile-workflow`
- `tooling`
- `test-or-ci`
- `duplicate-exact`
- `duplicate-near`
- `conflicting-version`
- `historical`
- `archive-only`
- `needs-merge`

The inventory MUST include all files, including hidden files and `.gitkeep` placeholders.

---

## Phase 2 — Determine the Canonical Repository Model

Infer the current repository's intended structure from its existing content and instructions.

Do not assume the bootstrap kit's structure automatically wins.

Compare the incoming kit against the repository's current organization and decide whether each incoming artifact should:

- fill a missing canonical slot;
- update an existing canonical document;
- be merged into an existing document;
- be renamed to follow current conventions;
- be retained as a template or example;
- be moved into mobile documentation;
- be moved into prompts or Codex task definitions;
- be preserved as historical material;
- be omitted as an exact duplicate after verified equivalence.

Document the resulting destination map before executing the bulk move.

---

## Phase 3 — Integrate `AI-ROS-Bootstrap-Kit-v1.0`

The incoming expanded kit may include materials such as:

- `README.md`
- `CURRENT-STATE.md`
- `ROADMAP.md`
- `CHANGELOG.md`
- `BOOTSTRAP-MANIFEST.md`
- engineering constitution;
- REP specification;
- bootstrap and research prompts;
- research artifact directories;
- templates;
- mobile iOS setup and Shortcut documentation;
- tools, tests, website, and CI placeholders.

For each item:

### Root documents

Compare incoming root documents against existing repository equivalents.

- Do not replace stronger current documents with older bootstrap versions.
- Merge unique intent, requirements, milestones, or setup information into the appropriate current canonical document.
- If a bootstrap root document is superseded but historically useful, preserve it in the import archive with a clear status banner.
- Avoid creating competing `README`, `ROADMAP`, or `CURRENT-STATE` documents with unclear authority.

### Constitution

Compare the incoming constitution with the current canonical constitution.

- Preserve unique principles or requirements.
- Resolve duplicate wording.
- Maintain normative language and version metadata.
- Record substantial changes in the changelog or decision log.
- Do not silently downgrade a more mature constitution.

### REP specification

Compare by content, version, and status.

- There MUST be one clearly canonical REP specification for the same version.
- If files are byte-identical or substantively identical, retain only the canonical copy.
- If they differ, create a structured comparison, preserve all unique requirements, and either merge into the canonical version or preserve the alternative as a dated historical source.
- Do not create two active REP v2 specifications.

### Prompts

Place reusable prompts under the repository's canonical prompt hierarchy.

- Normalize names and metadata.
- Preserve specialized distinctions.
- Remove redundant copies after verified consolidation.
- Link prompts to the constitution, REP specification, and expected outputs rather than duplicating large canonical texts where practical.

### Templates

Move templates into the canonical templates area.

- Compare against existing templates.
- Preserve the more complete metadata and sections.
- Ensure names, IDs, and front matter match current standards.
- Merge useful fields rather than choosing arbitrarily.

### Research directories

Do not replace populated research registries with empty bootstrap directories.

- Move only useful placeholder files when needed to preserve empty directories.
- Do not allow `.gitkeep` files to overwrite or interfere with real content.

### Mobile iOS materials

Place Working Copy setup, Apple Shortcuts instructions, launcher specifications, capture workflows, and mobile research-cycle documentation under the repository's canonical mobile or platform documentation area.

- Merge newer mobile guidance with bootstrap material.
- Correct stale references and paths.
- Ensure all instructions point to the current repository layout.

### Tooling, tests, website, and CI placeholders

Evaluate placeholders critically.

- Do not retain empty placeholder documentation if functioning tooling now exists and the placeholder adds no value.
- Merge any still-useful scope or future intent into current implementation documentation or backlog.
- Preserve historical placeholders only when they explain an important design decision.

---

## Phase 4 — Evaluate Every Other Input Document

Do not focus only on the bootstrap kit.

For every other document or directory in `input-documents/`:

1. Read it fully enough to understand its purpose.
2. Search the repository for related content.
3. Identify whether it is new, duplicative, contradictory, supplemental, obsolete, or improperly located.
4. Extract and preserve unique knowledge.
5. Move it to the best canonical location.
6. Merge when it belongs inside an existing living document.
7. Create a new document only when it represents a genuinely distinct artifact.
8. Archive historical or superseded originals when their provenance remains valuable.
9. Update links and indexes.
10. Record the disposition in the import manifest.

Possible destinations may include, depending on the repository's actual structure:

```text
constitution/
specifications/
docs/vision/
docs/architecture/
docs/research/
docs/implementation/
docs/governance/
docs/mobile/
prompts/
codex/tasks/
templates/
research/journals/
research/packages/
research/evidence/
research/theories/
research/decisions/
research/concepts/
ideas/
archive/imports/
tools/
tests/
website/
.github/
```

Use the repository's real conventions rather than forcing this example hierarchy.

---

## Phase 5 — Duplicate and Conflict Resolution

Use multiple signals:

- SHA-256 hash;
- normalized text comparison;
- titles and identifiers;
- version metadata;
- section structure;
- substantive claims and requirements;
- Git history;
- current canonical status;
- cross-references from other files.

### Exact duplicates

When content is identical:

- keep the copy at the canonical destination;
- record the duplicate source path and destination hash in the manifest;
- remove the redundant input copy only after verification.

### Near duplicates

When documents substantially overlap:

- identify unique sections in each;
- merge useful differences into the canonical file;
- remove redundant wording;
- preserve provenance in the import report or document history;
- validate links and metadata afterward.

### Conflicting versions

When claims or requirements conflict:

- do not silently pick one;
- determine which is more authoritative using version, status, repository references, evidence, and recency of actual content;
- preserve unresolved disagreement explicitly;
- create or update an ADR/decision record when the resolution is architecturally meaningful;
- archive the superseded version if needed for traceability.

### Filename collisions

When two distinct artifacts share a filename:

- assign descriptive, convention-compliant names;
- preserve stable identifiers where present;
- update inbound links.

---

## Phase 6 — Normalize and Improve

As files are integrated, normalize only what is necessary for repository coherence:

- headings;
- YAML front matter;
- stable identifiers;
- status and version labels;
- repository-relative links;
- naming conventions;
- terminology;
- line endings;
- obvious typos that do not alter meaning;
- index entries;
- navigation links.

Do not perform broad stylistic rewrites that obscure provenance or expand the scope unnecessarily.

Where incoming documents reveal missing repository capabilities, add recommendations to the idea registry, backlog, roadmap, or implementation guide rather than silently expanding this task into a full platform rewrite.

---

## Phase 7 — Update Canonical Project Controls

After consolidation, inspect and update as appropriate:

- `README.md` or project entry point;
- master plan;
- roadmap;
- current-state document;
- changelog;
- idea registry;
- decision log / ADR index;
- architecture handbook;
- research handbook;
- implementation guide;
- repository manifest;
- prompt index;
- template index;
- mobile documentation index;
- documentation navigation;
- validation configuration.

The current-state update should describe:

- what was imported;
- what changed;
- what became canonical;
- what was merged or archived;
- remaining uncertainty;
- the next highest-value task.

---

## Phase 8 — Clean `input-documents/`

Only after every inventory item has a recorded and verified disposition:

1. Confirm every source path appears in the final import manifest.
2. Confirm every unique item exists at its final destination or is represented in a merged canonical artifact.
3. Remove empty source directories.
4. Remove redundant source copies.
5. Preserve `input-documents/.gitkeep` if the repository tracks empty ingestion directories.
6. Verify no hidden unprocessed items remain.

Required final state:

```text
input-documents/
└── .gitkeep   # optional
```

Equivalent directories such as `.DS_Store`, archive files, expanded source folders, temporary files, and hidden metadata MUST NOT remain.

Run checks equivalent to:

```bash
find input-documents -mindepth 1 -maxdepth 1 -not -name '.gitkeep' -print
```

The command should produce no output.

---

## Phase 9 — Validation

Run all repository-provided validation, test, lint, build, and documentation commands.

Discover commands from existing repository instructions rather than assuming a particular stack.

At minimum validate:

- Git working-tree changes are intentional;
- no source item is unaccounted for;
- no broken repository-relative links were introduced;
- no duplicate stable IDs were introduced;
- no duplicate active canonical documents remain;
- Markdown or schema validation passes;
- generated indexes remain consistent;
- site or documentation generation succeeds if available;
- `input-documents/` is empty except optional `.gitkeep`;
- no nested `.git` directory from the bootstrap kit remains;
- no temporary extraction artifacts remain.

If automated validation is missing, perform the strongest reasonable manual checks and document the gap as a recommended repository improvement.

---

## Required Iterative Review

Do not accept the first organization pass automatically.

After the initial integration:

1. Re-read the repository entry points.
2. Review the final directory tree from a new contributor's perspective.
3. Search for duplicated titles, IDs, and concepts.
4. Search for stale references to the bootstrap kit or old paths.
5. Check whether any merged document became bloated or lost conceptual boundaries.
6. Challenge whether each archived file truly needs retention.
7. Challenge whether each newly created canonical file is actually distinct.
8. Simplify where possible without losing information.
9. Re-run validation.

Continue until another pass produces only marginal improvements.

---

## Required Deliverables

Create or update the repository's canonical equivalents of the following:

### 1. Import inventory

A complete list of every original source file and its disposition.

### 2. Import decision log

For significant merges, conflicts, renames, archival decisions, or canonical selections, record:

- issue;
- alternatives;
- evidence;
- decision;
- consequences;
- reversibility.

### 3. Validation report

Include:

- commands run;
- results;
- warnings;
- unresolved issues;
- manual checks;
- confirmation of the final `input-documents/` state.

### 4. Updated current-state artifact

Reflect the completed import and next work.

### 5. Final execution summary

Report:

- number of source files processed;
- files moved;
- files merged;
- exact duplicates removed;
- conflicting versions resolved;
- files archived;
- files newly created;
- canonical documents updated;
- validation results;
- remaining risks;
- next recommended task.

### 6. Suggested commit message

Use a concise Conventional Commit style message, such as:

```text
chore(repo): ingest and consolidate input documents
```

Adjust the scope if the repository uses another convention.

---

## Acceptance Criteria

This task is complete only when all of the following are true:

- [ ] The entire `input-documents/` tree was inventoried before destructive changes.
- [ ] Every original file has a documented disposition.
- [ ] The bootstrap kit is fully integrated into the repository's canonical structure.
- [ ] No unique content was lost.
- [ ] Existing canonical files were compared before replacement or merge.
- [ ] Exact duplicates were verified rather than assumed.
- [ ] Near duplicates were consolidated deliberately.
- [ ] Conflicts were resolved or explicitly recorded.
- [ ] Repository links and indexes were updated.
- [ ] Current state and roadmap controls reflect the import.
- [ ] Validation passed or all remaining failures are documented.
- [ ] No nested repository metadata remains.
- [ ] `input-documents/` is empty except optional `.gitkeep`.
- [ ] The final report identifies the next highest-value action.

---

## Final Response Format

When finished, respond with:

```markdown
# Input Document Ingestion Complete

## Result

## Repository Changes

## Canonical Documents Selected or Updated

## Duplicate and Conflict Decisions

## Archived Material

## Validation

## `input-documents/` Final State

## Remaining Risks or Questions

## Next Recommended Task

## Suggested Commit Message
```

Do not claim completion unless the acceptance criteria have been verified against the actual repository state.
