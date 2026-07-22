# AI Engineering Handbook

# Part 4 --- Research Engineering

Version: Draft 0.1

------------------------------------------------------------------------

# Introduction

Engineering research is different from software development. The
objective is not to produce code as quickly as possible but to reduce
uncertainty with the smallest amount of effort while creating reusable
knowledge.

A productive research system generates artifacts that become
organizational assets instead of disappearing into chat history.

------------------------------------------------------------------------

# 1. Research Operating Principles

1.  Evidence before conclusions.
2.  Treat every architectural decision as a hypothesis until validated.
3.  Record negative results.
4.  Separate observations from interpretations.
5.  Preserve reproducibility.

------------------------------------------------------------------------

# 2. The Research Loop

``` text
Question
   ↓
Hypothesis
   ↓
Predictions
   ↓
Evidence Collection
   ↓
Critical Evaluation
   ↓
Revision
   ↓
Knowledge Artifact
   ↓
Next Question
```

The loop should continue until additional research produces diminishing
returns.

------------------------------------------------------------------------

# 3. Research Artifacts

Maintain durable records for:

-   Research questions
-   Hypothesis registry
-   Evidence registry
-   Open questions
-   Experiment log
-   Literature summaries
-   Contradictory evidence
-   Final recommendations

These artifacts reduce duplicate work across multiple agents.

------------------------------------------------------------------------

# 4. Agent Roles

## Research Coordinator

Prioritizes uncertainty and allocates work.

## Literature Researcher

Finds papers, standards, documentation, and primary sources.

## Critical Reviewer

Attempts to falsify conclusions and identify weak assumptions.

## Synthesizer

Combines evidence into practical engineering guidance.

------------------------------------------------------------------------

# 5. Evidence Hierarchy

Highest confidence:

1.  Standards
2.  Academic research
3.  Vendor documentation
4.  Production case studies
5.  Benchmarks
6.  Expert interviews
7.  Blogs and opinion pieces

Evidence quality should be recorded alongside every claim.

------------------------------------------------------------------------

# 6. Managing Uncertainty

Categorize findings:

-   Established
-   Strong evidence
-   Moderate evidence
-   Weak evidence
-   Speculative
-   Unknown

This prevents speculation from becoming accepted practice.

------------------------------------------------------------------------

# 7. Common Failure Modes

Avoid:

-   Confirmation bias
-   Premature conclusions
-   Repeating previous research
-   Ignoring contradictory evidence
-   Searching only for supporting sources
-   Failing to document rejected ideas

------------------------------------------------------------------------

# 8. Measuring Research

Useful metrics include:

-   Questions answered
-   Hypotheses validated
-   Hypotheses rejected
-   Duplicate research avoided
-   Reusable artifacts produced
-   Time to actionable recommendation

------------------------------------------------------------------------

# 9. Research Checklist

-   [ ] Define the question.
-   [ ] State assumptions.
-   [ ] Make predictions.
-   [ ] Gather diverse evidence.
-   [ ] Attempt falsification.
-   [ ] Record uncertainty.
-   [ ] Publish reusable artifacts.
-   [ ] Identify the next highest-value question.

------------------------------------------------------------------------

# Next Part

Part 5 explores token economics, context optimization, prompt
compilation, retrieval, caching, and maximizing engineering value per
token.
