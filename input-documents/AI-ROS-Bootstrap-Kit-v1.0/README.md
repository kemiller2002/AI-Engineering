# AI Research Operating System

**Release:** Bootstrap Kit v1.0  
**Status:** Experimental  
**Canonical source:** This Git repository

AI-ROS is a mobile-capable, Git-backed operating system for durable autonomous research and engineering. Markdown is the canonical source of truth. Websites, indexes, dashboards, and graphs are generated views.

## Start Here

1. Read `CURRENT-STATE.md`.
2. Read `constitution/000-engineering-constitution.md`.
3. Read `prompts/bootstrap/AI-ROS-Bootstrap-Agent.md`.
4. Follow `mobile/ios/setup/Working-Copy-Setup.md` on iPhone or iPad.
5. Build the first two shortcuts from `mobile/ios/shortcuts/`.
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

This bootstrap release establishes:

- an initial engineering constitution;
- the canonical REP v2 specification;
- a bootstrap and orchestration prompt;
- mobile-first iOS workflows;
- artifact templates;
- an implementation roadmap;
- a current-state handoff mechanism.

It does **not** yet include production validators, a generated website, or importable Apple Shortcut files. Apple Shortcut packages are signed by Apple; this repository therefore begins with reviewable shortcut specifications and manual build instructions.
