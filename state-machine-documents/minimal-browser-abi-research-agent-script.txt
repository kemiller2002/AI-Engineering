# Agent Research Script: Minimal Browser ABI for Strongly Typed WebAssembly Applications

## Mission

Act as a senior browser-runtime engineer, WebAssembly researcher, programming-language researcher, frontend-architecture researcher, security engineer, and AI-agent systems researcher.

Your task is to investigate, design, and critically evaluate a **minimal, application-agnostic browser ABI** that allows:

- HTML to own document structure and native browser semantics.
- CSS to own presentation and purely visual interaction.
- JavaScript to act only as a thin browser event/effect bridge.
- WebAssembly to own authoritative application semantics, state transitions, validation, capabilities, effects, evidence, obligations, and application decisions.

The goal is NOT to rewrite React in another language.

The goal is to determine whether modern web applications can be built with a much smaller semantic surface:

```text
HTML / CSS
    ↓
native browser behavior
    ↓
tiny generic JavaScript bridge
    ↕
strongly typed WebAssembly application
```

The central hypothesis is:

> A browser application can keep HTML/CSS as native browser concerns, reduce JavaScript to a small generic event/effect adapter, and move authoritative application semantics into strongly typed WebAssembly without recreating the complexity of a large JavaScript framework.

Do not assume this hypothesis is true.

Be skeptical.

Your job is to determine:
1. what can actually be removed,
2. what must remain,
3. where complexity merely moves,
4. where performance or ergonomics become worse,
5. which browser APIs force awkward interop,
6. whether the JavaScript bridge can remain generic and application-agnostic,
7. whether the resulting architecture is easier for AI agents to reason about and modify.

---

# Existing Architectural Context

If available, read and incorporate the project specification:

`/mnt/data/zero-authoritative-javascript-web-architecture-spec-v0.1.md`

Treat that specification as prior architectural context, not unquestionable truth.

Challenge it where necessary.

The key prior principle is:

> JavaScript may provide mechanism, but it may not own meaning.

The new investigation goes one level deeper:

> How small can the browser-side mechanism actually become?

---

# Core Architecture to Investigate

Evaluate this target model:

```text
                 BROWSER

        HTML                  CSS
         │                     │
         └──── native UI ──────┘
                  │
             browser events
                  │
                  ▼
        ┌──────────────────┐
        │ Generic JS bridge│
        │                  │
        │ events → Wasm    │
        │ effects ← Wasm   │
        │ results → Wasm   │
        │ DOM ops ← Wasm   │
        └────────┬─────────┘
                 │
                 ▼
              WebAssembly
                 │
        ┌────────▼─────────┐
        │ Typed Application│
        │                  │
        │ domain state     │
        │ transitions      │
        │ validation       │
        │ evidence         │
        │ capabilities     │
        │ obligations      │
        │ effects          │
        │ projections      │
        └──────────────────┘
```

The JavaScript layer should ideally:
- contain no domain knowledge,
- contain no application-specific rules,
- contain no authoritative state,
- contain no business validation,
- contain no workflow decisions,
- contain no authorization decisions,
- contain no policy interpretation.

---

# Key Design Principle

Use this rule:

> Cross the JavaScript/WebAssembly boundary at semantic frequency, not physical-event frequency.

Examples:

Do NOT send to Wasm merely for:
- CSS hover styling,
- animations,
- layout,
- scroll position unless semantically important,
- every pointer movement,
- every animation frame,
- purely visual focus effects,
- native browser validation that does not affect domain meaning.

Do send to Wasm for:
- submit intent,
- meaningful field completion,
- workflow commands,
- domain validation,
- capability checks,
- consequential state transitions,
- network-triggering actions,
- reconciliation,
- authorization-relevant decisions.

---

# Research Questions

Answer all of the following.

## 1. What should remain entirely native?

Determine which application behaviors should remain entirely in:

### HTML
Examples:
- semantic structure,
- forms,
- labels,
- input types,
- accessibility primitives,
- native dialogs where appropriate,
- details/summary,
- validation constraints,
- links,
- navigation semantics.

### CSS
Examples:
- hover,
- focus appearance,
- responsive layout,
- visual state,
- transitions,
- animation,
- media/container queries.

For each category, explain why moving it to Wasm would be unnecessary or harmful.

---

## 2. What events need to cross into Wasm?

Create a minimal event taxonomy.

Candidate event families:

```text
Activate
Submit
ValueChanged
ValueCommitted
SelectionChanged
FocusEntered
FocusLeft
KeyCommand
PointerCommand
NavigationRequested
FileSelected
VisibilityChanged
CustomSemanticEvent
```

Do not simply mirror DOM event names.

Design events around semantic usefulness.

Investigate whether a generic event envelope could work:

```text
UiEvent {
    event_id
    source_id
    event_type
    value
    metadata
    correlation_id
}
```

Then evaluate whether this becomes too dynamically typed.

If so, propose a better typed or schema-driven alternative.

---

## 3. What DOM operations must Wasm be able to request?

Find the smallest useful set.

Candidates:

```text
SetText
SetValue
SetAttribute
RemoveAttribute
AddClass
RemoveClass
SetVisible
SetEnabled
SetChecked
SetSelected
Focus
ScrollIntoView
InsertFragment
RemoveNode
ReplaceFragment
```

Challenge each operation.

Determine:
- whether it is actually necessary,
- whether it introduces too much arbitrary DOM authority,
- whether higher-level UI projection operations would be safer,
- whether direct HTML fragments should ever be allowed,
- whether DOM IDs are sufficient addressing,
- whether stable semantic element handles are preferable.

---

## 4. What browser capabilities must be exposed?

Investigate a minimal capability surface for:

```text
HTTP / fetch
navigation
history
clipboard
local storage
session storage
IndexedDB
cookies where allowed
file picker
file download
notifications
geolocation
media
camera/microphone
WebSocket
Server-Sent Events
WebRTC
workers
timers
clock
randomness / crypto
visibility
resize observation
intersection observation
URL/query state
```

Classify each as:

- essential core capability,
- optional capability module,
- should remain browser-native,
- should be avoided,
- too dangerous for unrestricted exposure.

---

# Capability Design

Do NOT expose generic escape hatches such as:

```text
eval
executeJavascript
callArbitraryFunction
getArbitraryProperty
setArbitraryProperty
invokeAnything
```

Instead design narrow explicit capabilities.

Example:

```text
BrowserCapabilities {
    Http
    Navigation
    Clipboard
    Storage
    Focus
    Files
}
```

Investigate whether capability handles can be granted selectively.

Example:

```text
CustomerSupportModule
    can:
        QueryReservation
        RequestCancellation

    cannot:
        ForceConfirmation
        RawFetch
        ArbitraryDomMutation
```

Determine how much of this can be enforced:
- at compile time,
- at link time,
- through module boundaries,
- through WebAssembly component interfaces,
- through runtime capability injection,
- through CI/static analysis.

---

# Fetch / Network Architecture

Design and test this flow:

```text
Wasm
 ↓
HttpRequest effect
 ↓
JS bridge
 ↓
fetch()
 ↓
response
 ↓
JS bridge
 ↓
HttpResult evidence
 ↓
Wasm
```

The JavaScript layer MUST NOT interpret business meaning.

It may return transport-level information such as:

```text
request_id
HTTP status
headers
body bytes/text
timing
network failure
abort
timeout
```

The Wasm layer must determine domain meaning.

Explicitly investigate ambiguous outcomes.

Example:

```text
POST /payment
↓
network timeout
```

The result must not automatically mean:

```text
PaymentFailed
```

because the remote side may have completed the operation.

Design:

```text
Success
Failure
OutcomeUnknown
```

where appropriate.

---

# UI Projection Model

Investigate whether domain/application state should directly emit DOM operations.

Assume initially that it SHOULD NOT.

Prefer:

```text
Domain State
    ↓
View Projection
    ↓
View Model
    ↓
UI Diff / UI Commands
    ↓
JS bridge
    ↓
DOM
```

Determine whether a minimal UI runtime can track view dependencies without a React-style virtual DOM.

Explore at least three approaches:

## Approach A: Explicit DOM commands

Example:

```text
SetText("reservation-status", "Confirmed")
SetEnabled("cancel-button", false)
```

## Approach B: Typed view model projection + diff

Example:

```text
ReservationView {
    status_text
    can_cancel
    show_confirmation
}
```

Runtime compares old/new view models.

## Approach C: Fine-grained reactive dependencies

Example:

```text
Reservation.Status
    ├── StatusLabel
    ├── CancelButton.Enabled
    └── ConfirmationPanel.Visible
```

Compare the tradeoffs:
- implementation complexity,
- runtime cost,
- agent reasoning cost,
- debuggability,
- accessibility,
- determinism,
- testability,
- amount of JS required,
- amount of Wasm required.

---

# React Comparison

Use React as a control.

Do not treat React as the target architecture.

Compare the proposed model against React in terms of:

```text
component model
state management
effects
hooks
context
render scheduling
virtual DOM
reconciliation
event handling
DOM updates
fetch lifecycle
form lifecycle
server cache
local presentation state
```

For each React responsibility classify:

```text
Keep concept
Replace
Eliminate
Move to browser
Move to Wasm
Move to generic bridge
```

The goal is to identify which framework machinery becomes unnecessary when:
- state is explicit,
- transitions are explicit,
- effects are explicit,
- dependencies are explicit.

---

# Presentation State

Do not force all state into the authoritative domain model.

Define at least four state classes:

```text
A. Authoritative domain state
B. Application/workflow state
C. Presentation state
D. Browser-ephemeral state
```

Examples:

### A
- payment status,
- reservation status,
- eligibility,
- permissions,
- obligations.

### B
- active workflow,
- pending command,
- loading/reconciliation operation.

### C
- expanded row,
- selected tab,
- draft form text,
- local validation display.

### D
- hover,
- pointer coordinates,
- scroll,
- animation progress,
- browser focus internals.

Determine which layers:
- belong in Wasm,
- may remain in native browser behavior,
- may remain in generic JS,
- should never enter authoritative state.

---

# Form Architecture

Investigate forms specifically.

Prefer this flow:

```text
HTML form
 ↓
native browser validity
 ↓
semantic submit
 ↓
generic JS serialization
 ↓
Wasm decoding
 ↓
typed draft
 ↓
domain validation
 ↓
command
```

Evaluate whether generic serialization creates weak typing.

Explore alternatives:
- schema-generated form bindings,
- typed element IDs,
- generated serializers,
- declarative metadata,
- compile-time generated Wasm/HTML contracts.

Determine whether form libraries like React Hook Form become unnecessary or merely move elsewhere.

---

# JavaScript Bridge Size

Estimate the realistic size and complexity of a production-quality generic bridge.

Do not optimize for a toy demo.

Account for:
- initialization,
- module loading,
- event delegation,
- async effects,
- fetch,
- error propagation,
- DOM operations,
- capability dispatch,
- cleanup,
- subscriptions,
- browser differences,
- accessibility-related behavior,
- abort/cancellation,
- correlation IDs,
- concurrency.

Determine whether the bridge could plausibly remain:
- hundreds of lines,
- a few thousand lines,
- tens of thousands of lines.

Explain what causes growth.

The goal is NOT minimal line count at any cost.

The goal is minimal semantic authority and minimal application-specific logic.

---

# Security Analysis

Evaluate the security implications.

Investigate whether the architecture enables:

- strict Content Security Policy,
- no inline application JavaScript,
- no eval,
- reduced dependency attack surface,
- no application-specific JavaScript bundle,
- constrained browser capabilities,
- easier auditing,
- easier fuzzing,
- easier supply-chain review.

Do not claim WebAssembly is automatically secure.

Separate:
- sandboxing benefits,
- architectural benefits,
- CSP benefits,
- type-system benefits,
- capability-control benefits.

---

# Performance Analysis

Investigate likely performance costs.

Pay special attention to:

- JS/Wasm boundary crossing,
- serialization,
- DOM mutation cost,
- event frequency,
- large forms,
- large tables,
- high-frequency pointer input,
- animation,
- network-heavy applications,
- memory copying,
- string conversion,
- garbage collection,
- browser engine optimization differences.

Test or estimate:

```text
physical event frequency
vs
semantic event frequency
```

Develop batching rules.

Example:

```text
mousemove
    → remain browser-side

email input
    → debounce
    → semantic ValueCommitted

form submit
    → immediate Wasm event
```

---

# Strongly Typed Language Compatibility

Evaluate the ABI from the perspective of:

- F#
- C#
- Rust
- Kotlin

Optionally:
- Swift
- Haskell
- Go

The ABI should ideally be language-neutral.

Determine what representation works best across languages:

- JSON,
- MessagePack,
- CBOR,
- FlatBuffers,
- Protocol Buffers,
- WIT/component-model values,
- shared memory,
- generated binary protocol.

Do not assume JSON is optimal.

Compare:
- implementation complexity,
- runtime cost,
- type preservation,
- schema evolution,
- debugging,
- browser tooling,
- agent comprehensibility.

---

# WebAssembly Component Model

Investigate whether the WebAssembly Component Model and WIT can help define the browser ABI.

Explore whether concepts such as:

```text
record
variant
enum
option
result
resource
```

can describe:

- browser events,
- effect requests,
- effect results,
- capabilities,
- element handles.

Determine:
- what works today,
- what is theoretical,
- what browser support is missing,
- whether a custom ABI is still required.

Do not overstate maturity.

---

# Prototype Requirement

Build or specify a minimal prototype application that proves the architecture.

The prototype should contain:

1. A native HTML form.
2. CSS hover/focus behavior with no Wasm call.
3. An email field.
4. Browser-native email syntax validation.
5. A semantic event when the email is committed or debounced.
6. Wasm domain validation.
7. Wasm requesting a fetch through the JS bridge.
8. JS executing fetch.
9. JS returning transport-level evidence.
10. Wasm deciding:
    - available,
    - unavailable,
    - invalid,
    - request failed,
    - outcome unknown if applicable.
11. Wasm projecting view state.
12. The bridge applying minimal DOM updates.
13. A submit command.
14. A second external effect.
15. At least one capability the application is deliberately NOT granted.

Use one strongly typed language for the first prototype.

Prefer F# or Rust unless evidence strongly favors another option.

Do not choose based on familiarity alone.

---

# Failure / Falsification Tests

Actively try to break the architecture.

Test cases must include:

## High-frequency events
Can the boundary become a bottleneck?

## Large DOM updates
Does avoiding a virtual DOM become cumbersome?

## Complex dynamic lists
How are insertion, deletion, sorting, and keyed identity handled?

## Rich text editing
Does the model fall apart?

## Drag-and-drop
Does too much physical event data need to cross the boundary?

## Canvas/WebGL applications
Is this architecture inappropriate there?

## Complex animations
Should these remain browser-side?

## Third-party widgets
Payments, maps, analytics, support chat, CAPTCHA, editors.

## Accessibility
Can generic DOM commands accidentally break semantics?

## SSR / hydration
How does the model behave with server-rendered HTML?

## Offline apps
How do service workers fit?

## Real-time applications
How do WebSocket/SSE events enter Wasm?

## Browser extensions
Can injected JS interfere with assumptions?

For each failure case classify:

```text
Architecture still works
Requires extension
Requires specialized bridge
Poor fit
Fundamental problem
```

---

# AI-Agent Evaluation

The broader research question is whether this architecture is easier for AI coding agents.

Evaluate whether an agent must reason about fewer implicit concepts than in React.

Compare:

React-style reasoning:

```text
state
props
context
hooks
closures
effect dependencies
memoization
render lifecycle
component ownership
query cache
async state
reconciliation
```

against proposed reasoning:

```text
state
command
transition
effect
capability
projection
view
```

Do not assume fewer named concepts automatically means lower token cost.

Identify:
- hidden complexity,
- generated-code complexity,
- debugging burden,
- ABI complexity,
- tooling burden.

Propose controlled experiments measuring:

```text
tokens
tool calls
files inspected
repair loops
compile errors
runtime defects
architecture violations
context required
regressions
time to modify
total execution cost
```

---

# Deliverables

Produce all of the following.

## 1. Research Summary

A concise answer to:

> Is a native HTML/CSS + tiny generic JavaScript bridge + strongly typed Wasm application architecture technically viable today?

Give:
- Yes,
- Partially,
- No,

with precise qualifications.

---

## 2. Minimal Browser ABI Specification

Define:

```text
events
DOM commands
browser capabilities
effect requests
effect results
correlation
errors
cancellation
lifecycle
```

Use language-neutral types.

---

## 3. JavaScript Bridge Specification

Define exactly what JS MAY and MUST NOT do.

Include security invariants.

---

## 4. Wasm Application Contract

Define what the Wasm side owns.

Include:
- authoritative state,
- transitions,
- validation,
- effects,
- capabilities,
- evidence,
- obligations,
- view projection.

---

## 5. HTML/CSS Responsibility Specification

Explicitly define what should not cross into Wasm.

---

## 6. React Responsibility Decomposition

Provide a table showing which React responsibilities:
- disappear,
- move to Wasm,
- remain native,
- remain in bridge.

---

## 7. Prototype Design

Provide enough detail for another agent to implement the prototype without further architectural decisions.

---

## 8. Conformance Tests

Create machine-checkable or mechanically reviewable rules.

Examples:

```text
No application-specific JavaScript.
No eval.
No raw JS execution capability.
No browser types in the domain module.
No direct fetch from domain/application modules.
No authoritative state in DOM attributes.
No business rule inside event handlers.
No network response directly mutates domain state.
```

---

## 9. Falsification Report

List findings that weaken the hypothesis.

Do not hide failures.

---

## 10. Recommendation

Conclude whether to:

```text
Proceed
Proceed with constraints
Prototype only
Abandon
```

Explain why.

---

# Research Standards

Use primary sources where possible:

- W3C
- WHATWG
- WebAssembly specifications
- official browser documentation
- MDN when appropriate
- official Rust wasm-bindgen/web-sys documentation
- Microsoft .NET/Blazor documentation
- JetBrains Kotlin/Wasm documentation
- official framework/runtime documentation
- peer-reviewed or original technical papers where useful

Avoid relying on SEO articles or unsourced summaries for architectural conclusions.

For anything current or unstable, verify against up-to-date sources.

Separate:

```text
Observed fact
Source evidence
Inference
Hypothesis
Recommendation
```

Do not blur these categories.

---

# Critical Constraints

Do not:

- recreate React and call that success,
- assume a virtual DOM is required,
- assume a virtual DOM is unnecessary,
- assume JSON is the ABI,
- assume Wasm boundary cost is negligible,
- assume HTML/CSS can handle every interaction,
- assume all local state belongs in Wasm,
- assume WebAssembly Component Model browser support is complete,
- assume static typing alone solves architectural problems,
- hide complexity inside generated code and then claim it disappeared,
- confuse fewer JavaScript lines with lower total system complexity.

The main question is:

> Does this architecture actually reduce semantic complexity, implicit reasoning, and failure modes?

Not:

> Can we technically make it work?

---

# Final Decision Test

At the end, answer this exact question:

> If we were designing a serious web application platform from scratch in 2026 for both human developers and AI coding agents, would we deliberately choose native HTML/CSS + a narrow browser capability bridge + strongly typed WebAssembly over a React-style JavaScript application architecture?

Answer with:
- the strongest case FOR,
- the strongest case AGAINST,
- the conditions under which the recommendation changes,
- the experiments still required before making a production commitment.
