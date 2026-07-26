---
identifier: RP-2026-07-23-EVAL-CHARTER
title: AI-ROS Long-Horizon Agent Evaluation Charter
version: 0.1.0
status: experimental
---

# Evaluation Research Charter

## Mission

Determine which observable evaluation methods distinguish correct, safe, economical AI-ROS repository work from incomplete, regressive, unsafe, or merely persuasive output.

## Unit of Evaluation

The unit is the complete agent system:

`model + harness + instructions + tools + permissions + context policy + environment + recovery policy`

Model-only conclusions are out of scope unless other system variables are controlled.

## Decision Authority

Research agents may create reversible repository artifacts, inspect history, run read-only validation, and design local fixtures. They must not spend money, expose credentials, modify external systems, or run destructive/adversarial actions outside disposable fixtures without explicit authorization.

## Evidence Standard

Conclusions require:

- versioned task contracts;
- reproducible initial state;
- observable outcome checks;
- preserved run metadata and failures;
- separation of task defects from agent failures;
- repeated stochastic runs where feasible;
- explicit contradictory evidence and reversal conditions.

Final prose quality alone is never sufficient evidence.

## Non-Goals

- producing a universal model leaderboard;
- training or fine-tuning models;
- maximizing one composite score;
- proving repository-native tasks are inherently superior;
- building a multi-agent platform before measuring coordination value.

## Current Cycle Boundary

Cycle 001 establishes constructs, candidate tasks, audit rules, hypotheses, evidence, and the minimum viable evaluation specification. It does not claim empirical agent-performance results.

## Stop Conditions

Stop or redesign when task ambiguity exceeds agent error, graders cannot distinguish partial from complete work, evaluator disagreement remains unexplained, or an additional experiment is unlikely to change a decision.

