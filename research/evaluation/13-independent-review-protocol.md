---
identifier: RP-2026-07-28-EVAL-REVIEW
title: Independent Task-Integrity Review Protocol
version: 0.1.0
status: ready
---

# Independent Task-Integrity Review Protocol

## Purpose

Determine whether a task and grader support a fair capability inference without relying on the task author’s judgment.

## Reviewer Qualifications

A reviewer should be able to understand the repository task and evaluation contract but must not have designed the task, probes, or grader. Record relevant expertise and conflicts.

## Blinding Order

1. Review the visible task and initial fixture.
2. Record ambiguities and an expected outcome contract before seeing the reference probes.
3. Review grader rules and identify hidden or overly narrow requirements.
4. Classify the supplied probes independently.
5. Only then compare with designer labels.

## Required Review Record

Copy this block into a dated file under `research/evaluation/reviews/`:

```yaml
review_id:
reviewer:
date:
task_id:
relevant_expertise:
conflicts:
task_validity: valid | revise | quarantine
confidence: low | medium | high
```

Answer with evidence:

1. What capability does the task measure?
2. Is the initial state reproducible?
3. Is every enforced hard requirement visible or reasonably inferable?
4. Can a semantically correct alternative fail?
5. Can incomplete or unsafe work pass?
6. Does success require hidden context?
7. Can the agent access gold outcomes, graders, or expected labels?
8. Are regression and prohibited-action checks sufficient?
9. Is the task representative of a decision AI-ROS needs to make?
10. What is the strongest reason to quarantine it?

Then classify every probe without seeing designer labels:

| Probe | Classification | Evidence | Confidence |
|---|---|---|---|
| complete | | | |
| alternative-correct | | | |
| incomplete-polished | | | |
| regressive or defect | | | |

## Agreement and Adjudication

- Preserve both original reviews unchanged.
- Compare validity labels, probe classifications, and cited failure IDs.
- Do not reduce disagreements to a single percentage alone.
- Adjudicate with a third reviewer when a disagreement can change task status or capability scoring.
- Revise the task contract and rerun probes after any material change.

## Promotion Criteria

A task may move from provisional to validated only when:

- two independent reviewers select valid after any revisions;
- all material disagreements are resolved or explicitly retained;
- complete and alternative-correct probes pass;
- incomplete/regressive probes fail appropriately;
- blind export and containment checks pass.

If these conditions fail, revise or quarantine the task. Do not average away the defect.

