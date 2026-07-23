# Lesson 1 --- Why AI Sometimes Feels Like Magic... and Sometimes Feels Completely Useless

## Learning Goal

Develop your first mental model for AI engineering: **AI is stateless.
Your project should not be.**

## The Problem

Two engineers use the same AI model. One consistently gets outstanding
results while the other struggles.

The difference usually isn't intelligence or prompt-writing skill. It is
workflow design.

A language model behaves more like an exceptionally capable contractor
than a permanent team member. It only knows what is available during the
current interaction. If important knowledge exists only in chat history,
that knowledge is fragile.

Professional software teams solved this problem decades ago by creating
durable artifacts: source code, design documents, architecture decision
records (ADRs), tests, and operational documentation. AI engineering
extends this idea by making those artifacts the primary source of
context for both humans and AI.

## A Better Mental Model

Think of every conversation as a temporary workshop.

Think of your repository as the organization's memory.

When a conversation ends, the valuable outcome should not be the
conversation itself---it should be the artifacts created during it.

Those artifacts become the starting point for future work.

## First Principle

> AI is stateless. Your project should not be.

This principle explains why long chats eventually become difficult to
manage and why artifact-first workflows scale much better than
conversation-first workflows.

## Reflection

Ask yourself:

-   What important knowledge currently exists only in my conversations?
-   Which of those ideas should become durable project artifacts?
-   How would I resume my project six months from now?

## Key Takeaway

Successful AI engineering is less about remembering everything and more
about designing systems that preserve the right knowledge in reusable
forms.
