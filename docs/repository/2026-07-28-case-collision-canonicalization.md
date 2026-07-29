# Root Case-Collision Canonicalization

## Problem

Git tracked three case-only path pairs:

- `README.md` and `Readme.md`
- `CURRENT-STATE.md` and `current-state.md`
- `ROADMAP.md` and `roadmap.md`

On the repository’s case-insensitive macOS filesystem, each pair resolves to one working-tree path. An edit intended for the canonical file therefore appeared as a modification to both tracked entries. This undermined canonical state, cross-platform behavior, and evaluation reproducibility.

## Evidence

At commit `9b96b13`, each pair had identical SHA-256 content:

| Pair | SHA-256 |
|---|---|
| README variants | `7fcff95318b7fdfee7a51256d26b7d77e7dd349125562c5cc392c1d01dde9ebf` |
| current-state variants | `7f148d10c54123824d4942f1c72a0b72c4f76659c861b6b8c9e9c886216fa77c` |
| roadmap variants | `ec9f095b3043c4e7d2e6134a762865aa34e2e83e2e9e4f4b1f806cbde4f7cd6b` |

The bootstrap manifest, import audit, constitution, and agent instructions name the uppercase variants as canonical.

## Decision

Keep:

- `README.md`
- `CURRENT-STATE.md`
- `ROADMAP.md`

Remove the lowercase/camelcase variants from the Git index with `git rm --cached`. The working files remain, and all prior content and provenance remain recoverable from Git history.

## Validation

`python3 tools/evaluation/evalctl.py repo-audit` must report no case collisions.

## Reversal

If a case-sensitive environment reveals distinct content that was not captured by the identical-blob audit, recover it from commit `9b96b13` into a clearly named archive file rather than recreating case-only collisions.

