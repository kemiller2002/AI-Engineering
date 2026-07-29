# AI-ROS Agent Evaluation Research

## What We Are Trying to Learn

AI agents can produce convincing work without completing the real task. This program asks a stricter question:

> Did the complete agent system produce the intended result, preserve valid existing state, stay within its authority, leave traceable evidence, and do so at an acceptable total cost?

The system under study includes the model, harness, instructions, context, tools, permissions, environment, and recovery policy.

## The Seven Questions

Use these questions in order:

1. **Is the task valid?** A broken prompt or grader cannot support a capability claim.
2. **Is the run contained?** Evaluation must not endanger real systems.
3. **Is the result observable?** Persuasive prose is not completion evidence.
4. **Is the grader calibrated?** Correct alternatives must pass and incomplete work must fail.
5. **Is the result repeatable?** One stochastic run is an anecdote.
6. **Does it transfer?** A documentation task does not prove production coding ability.
7. **Is it worth the full cost?** Include retries, latency, review, and recovery.

## Current Evidence

- Two pilot task contracts exist.
- The deterministic grader matches all seven declared probe classifications.
- Blind fixtures can be exported without calibration outcomes or grader code.
- No agent capability baseline or independent human review exists yet.

## Start Here by Role

- **New research agent:** `NEXT-AGENT-START-HERE.md`
- **Architect:** `11-system-architecture.md`
- **Evaluation designer:** `02-evaluation-specification.md`
- **Decision maker:** `08-decision-framework.md`
- **Security reviewer:** `10-threat-model.md`
- **Independent task reviewer:** `13-independent-review-protocol.md`
- **Program lead:** `12-research-and-engineering-roadmap.md`
- **Reproducer:** `tools/evaluation/README.md`

## Current Boundary

The next useful information must come from independent task review and isolated agent runs. Additional untested architecture would now have lower value than empirical work.
