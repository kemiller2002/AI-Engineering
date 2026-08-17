# Time Entry

This directory contains the current application-specific implementation inputs
for the Time Entry test case. These documents do not define the reusable generic
semantic-control research program.

## Current inputs

- Business and AI implementation requirements:
  `requirements/time-entry-system-ai-requirements.txt`
- Application semantic lifecycle and invariants:
  `domain/time-entry-state-model-v0.1.txt`
- Current implementation structure and WASM/TypeScript/service/persistence
  boundaries: `architecture/time-entry-large-view-architecture-v0.1.txt`

The requirements document contains explicitly separated business, domain,
architecture, acceptance, and experimental sections. It remains intact to
preserve its original substance; those sections should not be treated as one
undifferentiated authority.

## Generic dependencies

Generic browser-kernel and semantic-control constraints live under
`docs/architecture/semantic-control/`. The duplicated browser-kernel policy that
previously appeared inside the Time Entry folder was byte-identical and has been
consolidated into that canonical generic location.

## Absent specification set

No separate numbered Time Entry specification set (index, domain contract,
transition contract, WASM/TypeScript interface, service contract, GitHub
persistence contract, capabilities, diagnostics, test oracle, security policy,
semantic change policy, ADR log, and experiment plan) existed at the time of
this organization. This index does not imply that those artifacts have been
implemented or approved.
