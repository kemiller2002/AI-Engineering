# Import Decisions

## D-001: Use the migration-plan content model for subject matter

- Issue: The repository already contained `knowledge-platform/Migration-Plan.md` with explicit destination paths for the handbook and course materials, while the bootstrap kit proposed a different root structure.
- Evidence: The migration plan is repository-local, current, and specifically maps the imported handbook and course files into `content/`.
- Decision: Use the migration-plan destinations for handbook and course artifacts.
- Consequences: The imported learning content now lives under `content/`, while bootstrap governance and operational docs were integrated elsewhere.
- Reversibility: High. Paths can be moved again later if a stronger canonical model emerges.

## D-002: Keep the existing REP v2 file as canonical

- Issue: The bootstrap kit included `specifications/research/Research-Execution-Package-Specification-v2.md`, but the repository already had `ai-prompts/Research-Execution-Package-Specification-v2.md`.
- Evidence: The files share the same SHA-256 hash, `eff69198cdce0e874d8fa66195d81be96aa122362f08ac1ead6469c82b0a82b0`.
- Decision: Keep the existing `ai-prompts/Research-Execution-Package-Specification-v2.md` as the sole active canonical REP v2 file and remove the duplicate intake copy.
- Consequences: No duplicate active REP v2 artifacts remain.
- Reversibility: High.

## D-003: Promote bootstrap repository controls into active root/docs locations

- Issue: The repository lacked root entry-point documents such as `README.md`, `CURRENT-STATE.md`, `ROADMAP.md`, and `CHANGELOG.md`.
- Evidence: The bootstrap kit supplied these artifacts, and no stronger competing canonical versions existed in the repository.
- Decision: Move the bootstrap entry-point documents into active repository locations, then patch references to the actual canonical paths.
- Consequences: The repository now has live project controls and agent instructions.
- Reversibility: High.

## D-004: Preserve bootstrap placeholders as historical scope markers

- Issue: The bootstrap kit included placeholder README files for CI workflows, tests, tools, and website generation.
- Evidence: The files are minimal and do not represent active implementations, but they do capture intended scope.
- Decision: Preserve them under `docs/repository/` with bootstrap-placeholder names instead of treating them as active directories.
- Consequences: Scope intent is retained without implying implemented tooling.
- Reversibility: High.

## D-005: Preserve the Chapter 1 ZIP as derived historical output

- Issue: `Chapter-01-Why-AI-Engineering-Is-Different.zip` is a packaged derivative rather than canonical source material.
- Evidence: The ZIP contents are chapter deliverables derived from the same lesson and research material already imported as Markdown.
- Decision: Archive the ZIP under `archive/packages/ai-engineering-course/`.
- Consequences: Provenance is preserved without elevating the archive to canonical source status.
- Reversibility: High.

## D-006: Preserve the lesson draft as a draft, not a second canonical lesson

- Issue: `Lesson 2.md` is internally titled `Lesson 1 (Working Draft)`.
- Evidence: Filename and internal title conflict; content is too short to establish an authoritative second lesson.
- Decision: Preserve it as `content/projects/ai-engineering-course/chapter-01/drafts/lesson-01-working-draft.md`.
- Consequences: The draft remains available without competing with the canonical lesson.
- Reversibility: High.

## D-007: Recreate the empty research directories outside the intake area

- Issue: The bootstrap kit shipped only `.gitkeep` placeholders for research working directories.
- Evidence: The directories communicate the intended operating model, but leaving them under `input-documents/` would violate the cleanup requirement.
- Decision: Recreate the placeholder directories under `research/` and remove the intake copies.
- Consequences: The canonical repository model now includes empty working locations without retaining a nested bootstrap tree.
- Reversibility: High.
