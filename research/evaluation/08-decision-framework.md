---
identifier: DF-2026-0001
title: Minimum Sufficient Agent Evaluation
version: 0.1.0
status: provisional
---

# Minimum Sufficient Agent Evaluation

## Decision Rule

Choose graders from the consequence and ambiguity of the task, not from a desire to maximize instrumentation.

| Task property | Required evidence | Add only when |
|---|---|---|
| Fully executable state | Deterministic outcome + regression checks | Human review if semantics remain ambiguous |
| Evidence-backed prose | Provenance checks + calibrated semantic rubric | Expert review for consequential interpretation |
| Permission or safety boundary | Final state + trajectory/action audit | Runtime monitor for long or external actions |
| Recovery/continuation | Final state + continuation attempt | Human review when “correct next action” is value-laden |
| High consequence | All relevant layers + independent expert review | Do not automate final authority without explicit policy |
| Task-defect audit | Independent contract/test review + probe outcomes | Quarantine on unresolved disagreement |

## Outcome Policy

1. Report hard failures separately.
2. Exclude task defects and infrastructure failures from capability denominators.
3. Publish per-task outcomes before aggregates.
4. Do not score an agent when gold material, grader internals, or expected outcomes were exposed unless the experiment measures exposure.
5. Treat a successful outcome with prohibited behavior as unsafe, not complete.
6. Use human review as a calibration and escalation layer, not decorative confirmation.

## Readiness Gates

### Gate A — Task Ready

- reproducible fixture;
- observable hard requirements;
- alternative-correct probe passes;
- incomplete probe fails;
- task-integrity audit resolved;
- contamination controls documented.

### Gate B — Grader Ready

- grader version frozen;
- probe calibration passes;
- false acceptance/rejection estimated against blinded labels;
- grader cannot be modified by the evaluated agent;
- grader output is inspectable.

### Gate C — Baseline Ready

- blind fixture export;
- system configuration frozen;
- containment controls tested;
- raw state and resource telemetry captured;
- repeated-run plan justified.

### Gate D — Comparative Claim Ready

- paired configurations;
- sufficient trials based on observed variance;
- independent task sample;
- uncertainty and task mix reported;
- cost per verified outcome included;
- no unresolved task/evaluator defect capable of reversing the claim.

## Promotion Rule

No task, grader, or conclusion moves from experimental to accepted because one cycle passes. Promotion requires independent review plus replication on unseen outcomes.

