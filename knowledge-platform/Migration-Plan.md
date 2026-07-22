# Migration Plan

## Strategy

Do not rewrite the repository in one pass.

Use a four-track migration:

1. metadata and IDs
2. canonical path normalization
3. relationship extraction
4. generated platform outputs

## Phase 1: Stabilize Canonical Inventory

- Keep all current artifacts.
- Treat `knowledge-platform/repository.json` and `knowledge-platform/knowledge-genome.json` as the initial temporary system-of-record outputs.
- Add front matter to every Markdown file before moving large numbers of files.
- Mark the ZIP archive as derived and archived.

## Phase 2: Normalize Paths

Move current files to these target paths:

- `input-documents/AI-Engineering-Handbook-Part-01-Foundations.md`
  -> `content/disciplines/ai-engineering/handbook/foundations.md`
- `input-documents/AI-Engineering-Handbook-Part-02-Agent-Architecture.md`
  -> `content/disciplines/ai-engineering/handbook/agent-architecture-and-coordination.md`
- `input-documents/AI-Engineering-Handbook-Part-03-Engineering-Workflows.md`
  -> `content/disciplines/ai-engineering/handbook/engineering-workflows.md`
- `input-documents/AI-Engineering-Handbook-Part-04-Research-Engineering.md`
  -> `content/disciplines/ai-engineering/handbook/research-engineering.md`
- `input-documents/AI-Engineering-Handbook-Part-05-Token-Economics-and-Context-Engineering.md`
  -> `content/disciplines/ai-engineering/handbook/token-economics-and-context-engineering.md`
- `input-documents/Chapter 1/Course-Constitution.md`
  -> `content/projects/ai-engineering-course/governance/course-constitution.md`
- `input-documents/Chapter 1/Course-Roadmap.md`
  -> `content/projects/ai-engineering-course/roadmaps/course-roadmap.md`
- `input-documents/Chapter 1/Lesson.md`
  -> `content/projects/ai-engineering-course/chapter-01/lesson-01-why-ai-sometimes-feels-like-magic-and-sometimes-feels-completely-useless.md`
- `input-documents/Chapter 1/Research-Package-001.md`
  -> `content/projects/ai-engineering-course/chapter-01/research/research-package-001-brief.md`
- `input-documents/Chapter 1/Research.md`
  -> `content/projects/ai-engineering-course/chapter-01/research/research-package-001-notes.md`
- `input-documents/Chapter 1/CheatSheet.md`
  -> `content/projects/ai-engineering-course/chapter-01/derived/lesson-01-cheat-sheet.md`
- `input-documents/Chapter 1/Workbook.md`
  -> `content/projects/ai-engineering-course/chapter-01/derived/lesson-01-workbook.md`
- `input-documents/Chapter 1/Notes.md`
  -> `content/projects/ai-engineering-course/chapter-01/derived/lesson-01-notes.md`
- `input-documents/Chapter 1/Chapter-01-Why-AI-Engineering-Is-Different.zip`
  -> `content/archive/packages/ai-engineering-course/chapter-01-why-ai-engineering-is-different.zip`

## Phase 3: Resolve Current Structural Defects

### Defect 1

`Lesson 2.md` is internally titled `Lesson 1 (Working Draft)`.

Resolution:

- compare content against the canonical lesson
- if it is a second lesson, retitle and move it to `chapter-02`
- if it is an alternate draft, mark it as draft and attach `superseded_by`

### Defect 2

`Research-Package-001.md` and `Research.md` share the same visible title.

Resolution:

- keep both
- rename them according to function: brief and notes
- add explicit relationship metadata

### Defect 3

No internal links exist.

Resolution:

- add concept links from lessons to handbook concepts
- add research links from lessons to supporting research
- add supersession and related links in front matter

## Phase 4: Establish Canonical Concept Pages

Create concept pages first for:

- context-engineering
- durable-artifacts
- validated-engineering-progress
- research-engineering
- task-contracts
- evidence-hierarchy
- token-economics

Then refactor lessons and handbook parts to link to those pages instead of repeating definitions.

## Phase 5: Automate Platform Outputs

Build generators for:

- manifest refresh
- front matter validation
- concept graph export
- registries
- search documents
- static site pages

## Non-Goals For The First Migration Pass

- no deletion of historical artifacts
- no forced conversion of archives into canonical sources
- no graph database dependency on day one
- no large manual taxonomy exercise before metadata exists

## Success Criteria

- every canonical Markdown file has valid front matter
- every document has a stable ID
- concept pages exist for major recurring ideas
- generated registries replace manual list maintenance
- search can filter by status, type, project, and confidence
- the website is derived from the repository, not vice versa
