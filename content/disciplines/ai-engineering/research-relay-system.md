# The Research Relay System

## A Practical Operating Model for Iterative Autonomous Research Agents

## Executive Conclusion

The right solution is not a single “autonomous research prompt.”

It is a **research relay system** built around durable artifacts, bounded autonomous work cycles, explicit decision authority, and standardized handoffs.

The agent should be allowed to independently:

- decompose the assigned objective;
- choose research methods;
- pursue promising leads;
- revise its plan when evidence changes;
- make reversible working decisions;
- create and update project artifacts;
- decide the highest-value next action;
- complete several connected steps without repeatedly asking permission.

The agent should pause only when:

- a decision would materially change project scope;
- two plausible paths require a value judgment rather than an evidence judgment;
- an action is irreversible, costly, legally sensitive, or externally consequential;
- required information cannot be reasonably inferred;
- the current research cycle has reached a useful review boundary;
- evidence indicates that the original objective itself may be wrong.

The central design rule is:

> The chat is the control surface. The files are the project memory.

Each research run reads the current project state, performs a bounded but meaningful cycle of work, records what happened, updates the project state, creates a reviewable Markdown deliverable, and leaves an exact continuation instruction for the next run.

---

# 1. Why Ordinary Agent Prompts Fail

Most “go research this autonomously” prompts fail for structural reasons rather than model capability.

## 1.1 The conversation becomes the only memory

A long chat gradually accumulates:

- outdated assumptions;
- discarded directions;
- duplicated findings;
- unmarked corrections;
- decisions mixed with speculation;
- large amounts of irrelevant context.

The model must repeatedly reconstruct the true project state from conversational history. Eventually, it either loses coherence or prematurely wraps up.

## 1.2 The agent does not know what it may decide

Prompts often say both:

- “work autonomously,” and
- “do not make assumptions.”

Those instructions conflict.

Research requires provisional decisions. The agent must choose:

- which uncertainty matters most;
- which sources deserve priority;
- when evidence is sufficient;
- whether a failed hypothesis should be abandoned;
- what to investigate next.

Without a decision policy, the agent either asks too many questions or silently makes decisions it should have surfaced.

## 1.3 “Continue until complete” has no operational meaning

Open-ended completion criteria encourage one of two failure modes:

- stopping too early after producing a plausible summary;
- continuing indefinitely without producing reviewable progress.

The agent needs both:

- a definition of overall completion;
- a definition of a useful cycle boundary.

## 1.4 The deliverable and the working state are mixed together

A polished report is not a sufficient handoff artifact.

A report explains what was learned, but often omits:

- what remains uncertain;
- what was attempted and failed;
- which decisions were provisional;
- what evidence would reverse the conclusion;
- what exact task should happen next.

The project therefore needs separate artifacts for knowledge, state, history, and presentation.

## 1.5 Self-review is too forgiving

An agent grading its own work tends to accept weak synthesis, incomplete coverage, and unsupported confidence. A separate skeptical review pass is more effective than simply telling the same agent to “be critical.”

---

# 2. The Recommended Architecture

Use a **single research agent with an internal evaluator loop**, supported by durable Markdown artifacts.

Do not begin with a complicated swarm of specialized agents. Multi-agent systems add coordination cost, duplication, and synthesis problems. Add separate agents only when parallelism or genuine independence produces measurable value.

The system has six layers.

## Layer 1: Research Charter

Defines the enduring mission, scope, standards, constraints, and authority.

This should change rarely.

File:

`00-research-charter.md`

## Layer 2: Research Journal

The append-only scientific record.

It records:

- observations;
- searches performed;
- evidence found;
- hypotheses considered;
- failures;
- contradictions;
- interpretation changes;
- decisions and their rationale;
- remaining uncertainties.

File:

`01-research-journal.md`

The journal is authoritative history. Never rewrite old entries. Add corrections as new entries.

## Layer 3: Current State

A compact, replaceable snapshot of the project as it is currently understood.

It contains:

- current objective;
- accepted findings;
- active hypotheses;
- rejected hypotheses;
- open questions;
- current constraints;
- decisions already made;
- unresolved decisions;
- current work queue;
- recommended next action.

File:

`02-current-state.md`

This is the first file a new agent run should read after the charter.

## Layer 4: Evidence Registry

A structured index of evidence so the agent does not repeatedly rediscover the same material.

File:

`03-evidence-registry.md`

Suggested fields:

| ID | Claim or Question | Source | Source Type | Date | Finding | Reliability | Supports | Contradicts | Notes |
|---|---|---|---|---|---|---|---|---|---|

## Layer 5: Decision Log

Records decisions separately from discoveries.

File:

`04-decision-log.md`

Suggested fields:

| ID | Decision | Status | Basis | Alternatives | Reversal Trigger | Date |
|---|---|---|---|---|---|---|

Statuses:

- proposed;
- provisional;
- accepted;
- superseded;
- rejected.

## Layer 6: Cycle Deliverables

Each run creates a self-contained review packet.

Directory:

`cycles/`

Examples:

- `cycles/2026-07-21-cycle-001.md`
- `cycles/2026-07-21-cycle-002.md`

These are immutable snapshots. They let you download, save, compare, and resume the work even when the conversation changes.

---

# 3. The Research Relay Loop

Every run follows the same sequence.

## Phase A: Rehydrate

The agent reads, in order:

1. `00-research-charter.md`
2. `02-current-state.md`
3. the most recent cycle report
4. relevant sections of the journal
5. relevant evidence and decision entries

It should not reread the entire project blindly. The current-state file tells it what historical material is relevant.

## Phase B: Select the highest-value uncertainty

The agent identifies the uncertainty whose resolution would most improve the project.

Use this priority function:

> Expected research value = decision impact × uncertainty × tractability × dependency value

Where:

- **decision impact** means how much the answer changes what should be done;
- **uncertainty** means how weak or conflicting current knowledge is;
- **tractability** means whether useful evidence can realistically be obtained;
- **dependency value** means how many later questions depend on this answer.

This prevents the agent from pursuing interesting but low-leverage tangents.

## Phase C: Plan a bounded research cycle

The agent creates a private or explicit work plan containing:

- target question;
- current hypothesis;
- competing hypotheses;
- evidence needed;
- likely sources;
- falsification attempt;
- stopping condition;
- expected artifact updates.

A cycle should normally include several connected steps, not just one search.

## Phase D: Execute autonomously

The agent searches, compares, calculates, tests, or analyzes as needed.

It may change tactics without asking permission when the change is:

- reversible;
- within scope;
- evidence-driven;
- not materially more costly or risky.

It should maintain a lightweight task queue and update it as evidence changes.

## Phase E: Skeptical evaluation

Before reporting, the agent switches roles from researcher to reviewer.

The evaluator asks:

- Did the work answer the target question?
- Are important claims traceable to evidence?
- Were primary sources used where available?
- Were contradictory sources addressed?
- Was the strongest alternative explanation tested?
- Did the agent confuse absence of evidence with evidence of absence?
- Are confidence levels justified?
- Did the agent stop because the question was answered or because the cycle became long?
- What would a hostile expert criticize?
- What evidence could reverse the conclusion?

When possible, use a separate model invocation or fresh context for this evaluation.

## Phase F: Persist state

The agent:

1. appends a journal entry;
2. updates the current-state snapshot;
3. adds evidence registry entries;
4. adds or updates decision records;
5. creates the cycle report;
6. identifies the recommended next cycle.

## Phase G: Return a review packet

The response to you should be compact. The detailed material belongs in the Markdown file.

The response should state:

- what the agent accomplished;
- what changed;
- the strongest conclusion;
- the largest remaining uncertainty;
- the exact recommended next step;
- what decision, if any, requires you;
- a link to the cycle Markdown file.

---

# 4. Decision Authority

The agent needs a written authority model.

## The agent may decide without asking

- search terms and source order;
- decomposition of the research question;
- reversible research methods;
- which hypotheses to test first;
- how to organize working files;
- whether to abandon a disproven hypothesis;
- whether to conduct an additional verification pass;
- whether to follow an evidence-based tangent that remains within scope;
- which next step offers the highest research value;
- how much detail belongs in a cycle report;
- provisional conclusions, clearly labeled as provisional.

## The agent must pause or flag for review

- expanding or redefining the project’s objective;
- accepting a conclusion based primarily on values, risk tolerance, or organizational preference;
- spending money or invoking paid resources beyond an established budget;
- communicating externally;
- making legal, medical, financial, security, or production decisions;
- deleting or rewriting authoritative records;
- choosing between materially different strategic directions when evidence does not dominate;
- proceeding when the user’s original objective appears unsafe, impossible, or internally contradictory.

## The agent should not ask merely because

- several reasonable methods exist;
- information is imperfect;
- the next step was not explicitly named;
- a provisional assumption is necessary;
- the work requires multiple searches;
- one source conflicts with another;
- the research plan needs revision.

Instead, it should choose a reasonable path, state the assumption, and test it.

---

# 5. Checkpoint Policy

Do not force the agent to stop after every step.

Use three checkpoint types.

## Completion checkpoint

Stop when the assigned objective meets its success criteria.

## Decision checkpoint

Stop when progress requires a human value judgment or consequential authorization.

## Review checkpoint

Stop after a meaningful research unit when:

- the cycle has resolved its target uncertainty;
- the remaining work changes direction;
- a major assumption has been overturned;
- the next cycle would consume substantially more resources;
- a reusable intermediate artifact is complete;
- the user would benefit from reviewing direction before further investment.

A checkpoint is not “I completed one search.”

It is “I completed a coherent unit of learning.”

---

# 6. The Continuation Protocol

Your follow-up should not require a new long prompt.

Every cycle report ends with a machine-readable handoff section.

```markdown
## Continuation Handoff

### Project state
- Current objective:
- Current phase:
- Last completed cycle:
- Most important conclusion:
- Confidence:
- Largest unresolved uncertainty:

### Recommended next cycle
- Objective:
- Why this is next:
- Proposed method:
- Expected output:
- Stop condition:

### Decisions required from the user
- None
```

Then your normal continuation message can be:

> Continue with the recommended next cycle. Read the project artifacts first, perform the work autonomously, update all required files, and return the next review packet.

Other useful control commands:

### Approve the next recommendation

> Continue with the recommended next cycle.

### Redirect priority

> Continue, but prioritize `[question]` before the recommended next cycle. Preserve the current recommendation in the backlog.

### Challenge a conclusion

> Reopen decision `[ID]`. Attempt to falsify it using the strongest contrary evidence you can find. Record whether the decision survives.

### Expand depth

> Run another cycle on the same question. Focus on evidence gaps, conflicting sources, and reversal conditions rather than repeating the existing summary.

### Produce a synthesis

> Using the journal and current state, produce a consolidated synthesis. Do not conduct new research unless needed to resolve a contradiction discovered during synthesis.

### Reset context

> Start a fresh run using only the project artifacts as authoritative context. Do not rely on conversational memory.

---

# 7. The Bootstrap Prompt

Use this prompt to start a new research project.

```markdown
# Autonomous Research Relay Agent

You are the research agent for this project.

Your responsibility is to increase reliable understanding of the assigned topic through repeated, evidence-driven research cycles.

You are not merely writing a report. You are maintaining a durable scientific and engineering record that another agent or researcher can continue without access to this conversation.

## Primary objective

[INSERT THE RESEARCH OBJECTIVE]

## Desired outcome

[DESCRIBE THE DECISION, DESIGN, GUIDE, THEORY, OR KNOWLEDGE THE RESEARCH SHOULD ENABLE]

## Constraints

[INSERT IMPORTANT SCOPE, TIME, SOURCE, COST, TECHNICAL, OR AUDIENCE CONSTRAINTS]

## Operating model

Work autonomously within the defined objective.

You may:

- decompose the objective;
- select research methods;
- choose source order;
- create and revise hypotheses;
- follow evidence-based lines of inquiry;
- make reversible working decisions;
- revise the plan when evidence changes;
- complete multiple connected steps in one cycle;
- decide the highest-value next action.

Do not ask for permission merely because several reasonable approaches exist.

Choose the approach with the best expected research value, state material assumptions, and test them.

Pause only when:

- the objective or scope must materially change;
- the next action requires a human value judgment;
- an action would be irreversible, costly, sensitive, or externally consequential;
- missing information cannot be safely or reasonably inferred;
- the current cycle has reached a meaningful review boundary.

## Required project artifacts

Maintain these Markdown files:

1. `00-research-charter.md`
2. `01-research-journal.md`
3. `02-current-state.md`
4. `03-evidence-registry.md`
5. `04-decision-log.md`
6. one immutable report per cycle in `cycles/`

If the files do not exist, create them.

The journal is append-only. Never erase prior mistakes or failed hypotheses. Record corrections and why understanding changed.

The current-state file is a concise replaceable snapshot. Keep it accurate enough that a fresh agent can resume the project by reading it.

## Research cycle

For each cycle:

1. Read the charter, current state, latest cycle report, and relevant journal, evidence, and decision entries.
2. Identify the highest-value unresolved uncertainty.
3. Define the target question and competing hypotheses.
4. Specify what evidence would support or contradict each hypothesis.
5. Conduct several connected research steps.
6. Prefer primary and authoritative sources.
7. Compare conflicting evidence.
8. Attempt to falsify the leading conclusion.
9. Assess confidence and identify reversal conditions.
10. Append the research journal.
11. Update current state, evidence registry, and decision log.
12. Create a downloadable Markdown cycle report.
13. Recommend the highest-value next cycle.

## Evidence discipline

Separate:

- observation;
- source evidence;
- inference;
- hypothesis;
- conclusion;
- decision.

Do not present inference as directly observed fact.

For important claims, record the source and explain why it is relevant.

Prefer:

- original research;
- standards;
- official documentation;
- government or institutional data;
- patents;
- technical books;
- high-quality systematic reviews;
- direct measurements or experiments.

Use secondary sources for orientation, not as the only basis for consequential conclusions when primary evidence is available.

Actively look for disconfirming evidence.

## Completion criteria

The project is complete only when:

- the primary objective has been answered at the required level;
- important claims are supported by traceable evidence;
- major competing explanations have been considered;
- the largest material uncertainties are resolved or clearly bounded;
- remaining unknowns are unlikely to change the practical recommendation;
- the final recommendation includes confidence and reversal conditions;
- another researcher can reconstruct the reasoning from the artifacts.

Do not claim completion merely because a polished report exists.

## Review output

At the end of each cycle, return:

1. a brief summary of work completed;
2. what changed in the project’s understanding;
3. the strongest current conclusion;
4. the largest remaining uncertainty;
5. decisions requiring user input, or `None`;
6. the recommended next cycle and why;
7. links to every Markdown file created or updated.

The detailed research belongs in the cycle report and project artifacts, not only in the chat response.

Begin now. Create or read the project artifacts, then complete the first meaningful research cycle.
```

---

# 8. The Continuation Prompt

Use this after reviewing any cycle.

```markdown
Continue the research project.

Treat the project artifacts as authoritative. Do not reconstruct state from conversational memory when the files provide it.

Read:

1. `00-research-charter.md`
2. `02-current-state.md`
3. the latest cycle report
4. relevant journal, evidence, and decision entries

Then:

- verify that the recommended next cycle is still the highest-value action;
- change course without asking if newer evidence makes another in-scope action more valuable;
- complete a meaningful multi-step research cycle;
- attempt to falsify the leading conclusion;
- update every affected project artifact;
- create the next immutable Markdown cycle report;
- return a concise review packet with links.

Do not stop after planning. Execute the research.

Do not ask for approval unless a defined decision checkpoint is reached.
```

---

# 9. Cycle Report Template

```markdown
# Research Cycle [NUMBER]

- Date:
- Research objective:
- Cycle target:
- Status: Complete | Partial | Blocked

## Executive finding

[The most important result from this cycle.]

## Why this question was selected

[Explain its decision impact, uncertainty, tractability, and dependency value.]

## Starting state

### Existing belief

### Active hypotheses

### Known evidence

### Important uncertainties

## Work performed

[Describe the connected research steps, not merely a list of searches.]

## Evidence collected

### Evidence supporting the leading conclusion

### Evidence contradicting or limiting it

### Source quality assessment

## Falsification attempt

- Strongest competing explanation:
- Test performed:
- Result:
- Did the leading conclusion survive?
- Remaining weakness:

## Findings

### Observations

### Inferences

### Conclusions

## Changes to project understanding

- Added:
- Revised:
- Rejected:
- Unchanged:

## Decisions

### Decisions made autonomously

### Decisions proposed

### Decisions requiring user input

## Confidence

- Confidence level:
- Basis:
- Main uncertainty:
- Evidence that would reverse the conclusion:

## Artifact updates

- Journal entries:
- Evidence entries:
- Decision entries:
- Current-state changes:

## Recommended next cycle

- Objective:
- Why it is highest value:
- Proposed method:
- Expected artifact:
- Stop condition:

## Continuation Handoff

### Project state
- Current objective:
- Current phase:
- Last completed cycle:
- Most important conclusion:
- Confidence:
- Largest unresolved uncertainty:

### Recommended next cycle
- Objective:
- Why this is next:
- Proposed method:
- Expected output:
- Stop condition:

### Decisions required from the user
- None
```

---

# 10. Current-State Template

```markdown
# Current Research State

- Last updated:
- Latest cycle:
- Project status: Active | Paused | Complete | Blocked

## Primary objective

## Scope

### Included

### Excluded

## Current synthesis

[A compact explanation of what is presently believed.]

## Accepted findings

## Provisional findings

## Active hypotheses

## Rejected hypotheses

## Key evidence

## Important contradictions

## Decisions already made

## Decisions awaiting review

## Open questions

Rank each question:

| Priority | Question | Impact | Uncertainty | Tractability | Dependency Value |
|---|---|---:|---:|---:|---:|

## Current work queue

1.
2.
3.

## Recommended next action

## Completion assessment

- Criteria already satisfied:
- Criteria not yet satisfied:
- Why the project is not yet complete:
```

---

# 11. Journal Entry Template

```markdown
---

## Journal Entry [ID]

- Date:
- Cycle:
- Researcher:
- Target question:

### Initial understanding

### Hypotheses

### Planned evidence

### Actions taken

### Observations

### Evidence

### Contradictions

### Failed approaches

### Interpretation

### Understanding changes

### Decisions and rationale

### Remaining uncertainty

### Recommended next action

### References

---
```

---

# 12. Practical Interaction Pattern

A productive rhythm is:

## First message

Give the bootstrap prompt and the topic.

## Agent response

The agent completes Cycle 1 and returns a cycle report plus updated state artifacts.

## Your review

You examine only:

- executive finding;
- changes in understanding;
- decisions requiring input;
- recommended next cycle.

You do not need to reread every artifact after every cycle.

## Your next message

Usually:

> Continue with the recommended next cycle.

When needed:

> Continue, but first challenge conclusion D-004. I am not convinced the evidence distinguishes familiarity from objective usability.

## Agent response

The agent reads the saved state, performs Cycle 2, and generates a new Markdown file.

This creates a fast control loop:

> assign → research → persist → review → redirect → continue

---

# 13. What to Automate Later

Begin manually with Markdown files and standardized prompts. This exposes what the actual workflow needs before software hardens the wrong assumptions.

After the pattern is stable, automate:

- sequential cycle numbering;
- file naming;
- handoff extraction;
- evidence deduplication;
- citation validation;
- decision status changes;
- current-state regeneration;
- source-quality checks;
- evaluator passes;
- creation of a ZIP or repository snapshot;
- a command such as `/continue`, `/challenge D-004`, or `/synthesize`.

A lightweight implementation can use:

- a Git repository as the artifact store;
- an `AGENTS.md` or equivalent operating instruction;
- Markdown templates;
- a script that assembles the minimal context packet;
- one research model call;
- one independent evaluator call;
- a final persistence step.

Only move to a graph framework when you need reliable pause/resume, branching, retries, parallel workers, or programmatic approval gates.

---

# 14. What Not to Do

## Do not rely on one enormous master prompt

The prompt defines behavior, but it cannot substitute for externalized state.

## Do not ask the model to preserve everything in memory

Conversation memory is not a controlled scientific record.

## Do not create many agents immediately

Several agents can produce five overlapping summaries and no coherent project state.

## Do not let every run rewrite the final report

Preserve immutable cycle reports and update a separate current-state file.

## Do not use “keep researching until done” without criteria

Define both completion criteria and checkpoint criteria.

## Do not make the user approve routine research choices

Human attention should be spent on values, priorities, risk, and strategic direction—not search query selection.

## Do not accept self-assigned confidence without falsification

Require competing hypotheses, contrary evidence, and reversal conditions.

## Do not produce files only at the end

Every meaningful cycle should generate a portable artifact.

---

# 15. Recommended Initial Version

For your use case, start with the following minimal version:

```text
project/
├── 00-research-charter.md
├── 01-research-journal.md
├── 02-current-state.md
├── 03-evidence-registry.md
├── 04-decision-log.md
└── cycles/
    ├── cycle-001.md
    ├── cycle-002.md
    └── cycle-003.md
```

Use:

- one primary research agent;
- one skeptical review pass;
- one meaningful cycle per interaction;
- a standard continuation prompt;
- downloadable Markdown files every cycle;
- context reset through artifacts whenever the conversation becomes long.

This is enough to solve the majority of the problem without building a custom orchestration platform.

---

# 16. Final Recommendation

Adopt the Research Relay System as the default operating method for your research agents.

The key shift is from:

> “Give the agent a strong prompt and hope it remembers the project.”

to:

> “Give the agent bounded autonomy inside a durable, inspectable research system.”

The agent should own the next tactical decision.

You should retain control over:

- the objective;
- scope;
- values;
- risk;
- irreversible actions;
- acceptance of major strategic conclusions.

The artifacts should own continuity.

That division of responsibility provides autonomy without losing control, fast iteration without conversational drift, and Markdown outputs that remain useful beyond the chat in which they were created.
