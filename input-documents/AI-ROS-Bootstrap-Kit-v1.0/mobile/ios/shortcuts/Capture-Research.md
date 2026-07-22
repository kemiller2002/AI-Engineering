# Shortcut Specification: Capture Research

**Version:** 1.0  
**Goal:** Capture a research question as Markdown and save it into the repository inbox.

## Preconditions

- Working Copy has cloned `ai-research-os`.
- Its document provider is enabled in Files.
- The repository contains `research/inbox/`.

## Build Actions

### 1. Ask for Input

- Action: `Ask for Input`
- Type: Text
- Prompt: `Research topic or question`

The output variable may appear as `Provided Input` or `Ask for Input`.

### 2. Current Date

- Action: `Current Date`

### 3. Format Date for File Name

- Action: `Format Date`
- Input: Current Date
- Format: Custom
- Pattern: `yyyy-MM-dd-HHmmss`

### 4. Format Date for Metadata

Add a second `Format Date` action:

- Input: Current Date
- Format: ISO 8601, or custom `yyyy-MM-dd'T'HH:mm:ssZZZZZ`

### 5. Text

Insert this content. Replace bracketed labels by inserting the blue variable tokens, not by typing the brackets literally.

```markdown
---
type: research-question
created: [Formatted ISO Date]
status: inbox
priority: untriaged
---

# Research Question

## Question

[Provided Input]

## Why It Matters

## Context

## Suggested Next Action

Triage this question against the current roadmap and existing research.
```

### 6. Set Name

- Action: `Set Name`
- Input: Text from step 5
- Name: `[Formatted File Date]-research-question.md`

Insert the formatted date variable, followed by the literal suffix.

### 7. Save File

- Action: `Save File`
- Input: Renamed file
- Ask Where to Save: **On** for the first version
- Choose: `Working Copy → ai-research-os → research → inbox`
- Overwrite If File Exists: Off

After this works reliably, set a fixed destination if your iOS version permits it.

### 8. Show Notification

- Text: `Research question saved to inbox.`

### 9. Open App

- Optional action: `Open App`
- App: Working Copy

## Acceptance Test

1. Run the shortcut.
2. Enter `Does REP overhead reduce research throughput?`
3. Verify a `.md` file appears in `research/inbox/`.
4. Open it and confirm the question and real timestamp were inserted.
5. Open Working Copy and confirm the file appears as an uncommitted change.
6. Commit and push it.

## Known Failure Modes

- Typing `[[Current Date]]` produces literal text; variables must be inserted as tokens.
- Saving to an ordinary Files folder bypasses the intended repository.
- A fixed filename causes accidental overwrites.
