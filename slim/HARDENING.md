<!-- markdownlint-disable -->

# Hardening Report: super-linter--super-linter--slim/v8.7.0

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **super-linter--super-linter--slim/v8.7.0** was hardened automatically. 1 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unpinned-uses (severity: high)

The action uses a Docker image referenced by a mutable version tag rather than an immutable SHA digest. The image `docker://ghcr.io/super-linter/super-linter:slim-v8.7.0` uses the tag `slim-v8.7.0`, which can be silently overwritten on the registry, enabling a supply-chain attack. It should be pinned to a full SHA256 digest, e.g. `image: ghcr.io/super-linter/super-linter@sha256:<64-hex-char-digest> # slim-v8.7.0`.

Locations:

- `action.yml:6`

## Iteration Notes

### Iteration 1

**Fixes applied:** unpinned-uses

**Notes:**

Pinned the Docker image reference in hardened/action/action.yml from `docker://ghcr.io/super-linter/super-linter:slim-v8.7.0` to `docker://ghcr.io/super-linter/super-linter:slim-v8.7.0@sha256:c95c714f746edc70e54926a69e229c834ffcdec2450bd3475f7865164d749a56`. The docker:// scheme and tag are preserved inline; the SHA256 digest was resolved via the Docker Registry API.

