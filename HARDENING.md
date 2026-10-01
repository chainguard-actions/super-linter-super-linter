<!-- markdownlint-disable -->

# Hardening Report: super-linter--super-linter/v9.0.0

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **super-linter--super-linter/v9.0.0** was hardened automatically. 1 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unpinned-uses (severity: high)

Both action.yml and slim/action.yml reference Docker images using mutable version tags instead of immutable SHA digests. This means the action could silently pull a different (potentially malicious) image if the tag is moved. action.yml uses `docker://ghcr.io/super-linter/super-linter:v9.0.0` and slim/action.yml uses `docker://ghcr.io/super-linter/super-linter:slim-v9.0.0`. These should be pinned to a full SHA256 digest, e.g. `docker://ghcr.io/super-linter/super-linter@sha256:<64-hex-char-digest> # v9.0.0`.

Locations:

- `action.yml:6`
- `slim/action.yml:6`

## Iteration Notes

### Iteration 1

**Fixes applied:** unpinned-uses

**Notes:**

Pinned both Docker image references to their immutable SHA256 digests:
- action.yml: docker://ghcr.io/super-linter/super-linter:v9.0.0@sha256:7620fb6f07a1908b0642d9ddc4f49da7d9f2b9497bcafee4d3d151d1e5567c0b
- slim/action.yml: docker://ghcr.io/super-linter/super-linter:slim-v9.0.0@sha256:7d0b4d3387deaac975e86e0787c7a05a25d530469b27d74c2b4599ab5800d9e4

Both retain the docker:// scheme (required for Docker container actions) and keep the version tags inline for readability.

