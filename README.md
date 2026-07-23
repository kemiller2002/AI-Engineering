# AI Research Operating System

**Status:** Active repository  
**Canonical source:** This Git repository

AI-ROS is a mobile-capable, Git-backed operating system for durable autonomous research and engineering. Markdown is the canonical source of truth. Websites, indexes, dashboards, and graphs are generated views.

## Start Here

1. Read `CURRENT-STATE.md`.
2. Read `docs/governance/000-engineering-constitution.md`.
3. Read `ai-prompts/bootstrap/AI-ROS-Bootstrap-Agent.md`.
4. Follow `docs/mobile/ios/setup/working-copy-setup.md` on iPhone or iPad.
5. Review the canonical handbook and course content under `content/`.
6. Commit every accepted change to Git.

## Core Rule

> ChatGPT proposes and produces changes. GitHub remembers them. Working Copy moves them. Cloud automation validates them.

## Repository Principles

- Conversation history is not permanent project memory.
- Every accepted artifact has a repository path and stable identity.
- Agents receive the minimum sufficient context, not the entire repository by default.
- Every major decision records alternatives, evidence, reversibility, and consequences.
- Generated outputs are disposable; canonical Markdown is not.

## Current Scope

This repository currently includes:

- an engineering constitution and current-state handoff model;
- the canonical REP v2 specification in `ai-prompts/Research-Execution-Package-Specification-v2.md`;
- reusable bootstrap and research prompts;
- mobile-first iOS workflows;
- artifact templates;
- imported handbook, research-program, research-relay, and course materials;
- knowledge-platform architecture deliverables and migration guidance.

Imported bootstrap placeholder documents for CI, tests, tooling, and website generation were preserved under `docs/repository/` as historical scope markers rather than active implementations.
