<!-- markdownlint-disable -->

# Hardening Report: super-linter--super-linter--slim/v8.3.2

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **super-linter--super-linter--slim/v8.3.2** was hardened automatically. 1 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unpinned-uses (severity: high)

The Docker image reference in `runs.image:` uses a mutable version tag (`slim-v8.3.2`) instead of an immutable SHA digest. This means the image pulled at runtime could change without notice, enabling a supply-chain attack. It should be pinned to a specific SHA digest, e.g. `image: ghcr.io/super-linter/super-linter@sha256:<64-hex-char-digest> # slim-v8.3.2`.

Offending line: `image: "docker://ghcr.io/super-linter/super-linter:slim-v8.3.2"`

Locations:

- `action.yml:6`

## Iteration Notes

### Iteration 1

**Fixes applied:** unpinned-uses

**Notes:**

Pinned the Docker image reference in action.yml from `docker://ghcr.io/super-linter/super-linter:slim-v8.3.2` to `docker://ghcr.io/super-linter/super-linter:slim-v8.3.2@sha256:0591b4d7d11be09b00a358340bee9637fcb8d3df474881898b399182471fcee2`. The docker:// scheme and tag are preserved inline alongside the immutable digest, preventing supply-chain attacks via mutable tags.

