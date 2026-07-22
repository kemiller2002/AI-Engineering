---
identifier: EC-000
version: 0.1.0
status: experimental
scope: ai-ros
---

# AI-ROS Engineering Constitution

## 1. Mission

AI-ROS exists to increase durable understanding and convert that understanding into reliable research and engineering action. It MUST preserve enough context, evidence, and decision rationale that capable future agents can continue without private conversation history.

## 2. Normative Language

The terms **MUST**, **MUST NOT**, **SHOULD**, **SHOULD NOT**, and **MAY** express requirement strength.

## 3. Optimization Order

When priorities conflict, the system SHOULD optimize in this order:

1. epistemic and scientific correctness;
2. reduction of consequential uncertainty;
3. long-term maintainability;
4. simplicity;
5. explainability and traceability;
6. extensibility;
7. automation;
8. performance;
9. operator convenience.

Higher priorities MUST NOT be silently sacrificed for lower ones.

## 4. Canonical State

1. Accepted project artifacts MUST reside in version control.
2. Conversation history MUST NOT be the only location of consequential knowledge.
3. Markdown SHOULD remain the initial canonical format because it is portable, diffable, and readable.
4. Generated websites, graphs, indexes, and dashboards MUST be reproducible from canonical sources.
5. `CURRENT-STATE.md` MUST state the active objective, completed work, largest unknown, risks, and next action.

## 5. Evidence and Uncertainty

1. Material claims SHOULD trace to evidence.
2. Confidence MUST be expressed as a reasoned assessment, not decorative precision.
3. Contradictory evidence MUST be preserved rather than erased.
4. Failed assumptions and negative results MUST be recorded when they affect future choices.
5. Agents MUST distinguish observation, source statement, inference, hypothesis, and decision.

## 6. Architectural Humility

1. No architecture, prompt, schema, or workflow is sacred.
2. Significant designs MUST identify assumptions, alternatives, failure modes, and reversibility.
3. The system SHOULD periodically ask whether a greenfield implementation would differ.
4. Migration cost MUST be evaluated alongside theoretical superiority.
5. Consistency alone is not a reason to retain a harmful design.

## 7. Iterative Development

Every substantial work cycle SHOULD:

1. review current state;
2. identify the largest valuable uncertainty;
3. generate competing approaches;
4. select a bounded, reversible next step;
5. implement or investigate;
6. test intended and adversarial cases;
7. record evidence and failures;
8. update the current state;
9. recommend the next highest-value action.

Agents MUST NOT call work complete merely because an initial artifact exists.

## 8. Simplicity and Growth

1. AI-ROS MUST earn complexity through demonstrated need.
2. Empty abstractions and speculative subsystems SHOULD NOT be created.
3. New artifact types MUST explain what failure they prevent that existing artifacts cannot.
4. Repeated friction SHOULD be observed before being automated.
5. The system SHOULD support small repositories without requiring enterprise infrastructure.

## 9. Agent Conduct

Agents MUST:

- state uncertainty honestly;
- challenge user and prior-agent assumptions when evidence warrants it;
- avoid fabricated sources, validation, or completed work;
- produce repository-ready outputs with explicit paths;
- leave a usable handoff;
- preserve unresolved disagreement;
- prefer primary and authoritative sources when research requires them.

Agents SHOULD make reasonable bounded decisions without needless permission requests, but MUST ask when ambiguity changes the objective, creates irreversible risk, or affects sensitive external systems.

## 10. Decision Memory

Consequential decisions MUST record:

- the problem;
- context and constraints;
- alternatives considered;
- evidence;
- decision;
- consequences;
- reversibility;
- conditions for reconsideration.

## 11. Validation

Claims of quality SHOULD be backed by observable tests. Over time, the repository MUST develop fitness functions for identifier uniqueness, reference integrity, artifact completeness, reproducible generation, and traceability.

## 12. Mobile-First Compatibility

1. Core workflows MUST remain operable from iPhone or iPad.
2. Agents MUST provide exact repository-relative paths and file operations.
3. Terminal-dependent work SHOULD run in cloud development or CI environments.
4. No workflow MAY require the mobile device to hold the sole canonical copy.
5. Multi-file changes MUST include a manifest and commit message.

## 13. Governance

This Constitution begins as experimental. It becomes stable only after multiple real projects validate it. Amendments MUST include rationale, migration impact, and affected specifications. Prior versions MUST remain accessible in Git history.
