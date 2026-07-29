# ET-004-P01 Integrity Audit

## Designer Review

| Question | Finding |
|---|---|
| Outcome observable? | Yes; all hard requirements map to file-state checks. |
| Hidden enforced requirements? | No known hidden semantic requirement. |
| Alternative implementations accepted? | Partially; reordered and rephrased evidence language passes. |
| Material requirements covered? | Yes for the stated prompt. |
| Can incomplete work pass? | The incomplete polished probe fails because status remains draft. |
| Can correct work fail? | Possibly: novel synonyms that omit the literal words “observable evidence” can fail despite semantic correctness. |
| Hidden context required? | No. |
| Initial state reproducible? | Yes; base fixture is versioned and hashed by the tool. |
| Contamination risk? | High if the agent can read `outcomes/`; isolation is required. |
| Project relevance? | High for bounded repository editing. |

## Mechanical Probe Review

- Complete outcome: expected to pass.
- Alternative-correct outcome: expected to pass.
- Incomplete-polished outcome: expected to be partial.
- Regressive outcome: expected to be regressive.

## Disposition

**Provisionally validated for grader development; not independently human-validated.**

Before a capability baseline, move the base fixture into a disposable directory without probe outcomes and obtain an independent reviewer’s audit. The literal semantic check is acceptable for the narrow pilot but not a general prose grader.

