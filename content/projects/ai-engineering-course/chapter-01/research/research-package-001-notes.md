# Research Package 001

# Lesson 1 Research Notes (Draft)

## Research Question

**Why is working with an AI model fundamentally different from working
with traditional software?**

------------------------------------------------------------------------

## Initial Assumptions

Before beginning, we intentionally list assumptions so they can be
challenged.

1.  Prompt quality is the primary determinant of success.
2.  Better models solve most workflow problems.
3.  Long conversations preserve useful context.
4.  AI behaves similarly to search engines or IDE autocomplete.

These assumptions will be evaluated rather than accepted.

------------------------------------------------------------------------

# Observations

Modern LLMs generate responses by predicting likely continuations from
the current context. They do not maintain persistent project memory
across independent conversations.

This means project knowledge must exist somewhere other than the
conversation if work is expected to continue over weeks or months.

------------------------------------------------------------------------

# Evidence Categories

## Well Established

-   Transformer-based LLMs operate over a supplied context window.
-   Retrieved information often improves factual grounding.
-   External documentation remains important for software engineering.

## Emerging Practice

-   Context engineering as a named discipline.
-   Artifact-first AI workflows.
-   Multi-agent orchestration for software development.

## Open Questions

-   Which workflow patterns consistently outperform traditional
    prompting?
-   When do multi-agent systems outperform a single capable model?
-   How should engineering teams measure AI productivity?

------------------------------------------------------------------------

# Competing Explanations

## Hypothesis A

Prompt engineering is the dominant differentiator.

Evidence supporting: - Better prompts improve immediate outputs.

Evidence against: - Experienced teams increasingly emphasize reusable
context, tooling, retrieval, and review processes.

Status: Partially supported.

------------------------------------------------------------------------

## Hypothesis B

Workflow engineering is the dominant differentiator.

Evidence supporting: - Reusable artifacts reduce repeated explanation. -
Structured development processes reduce ambiguity.

Evidence against: - Small one-off tasks may not justify additional
workflow overhead.

Status: Promising but requires additional evidence.

------------------------------------------------------------------------

# Preliminary Conclusion

The available evidence suggests that prompt quality matters, but prompt
quality alone is insufficient for sustained engineering work.

Workflow, durable project knowledge, verification, and retrieval appear
to become increasingly important as project complexity grows.

Confidence: Moderate

------------------------------------------------------------------------

# Questions for Further Research

-   How does cognitive load affect LLM performance?
-   How should context be measured?
-   Can engineering value per token be quantified?
