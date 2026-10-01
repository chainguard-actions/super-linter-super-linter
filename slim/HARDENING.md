<!-- markdownlint-disable -->

# Hardening Report: super-linter--super-linter--slim/v9.0.0

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **super-linter--super-linter--slim/v9.0.0** was hardened automatically. 1 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unpinned-uses (severity: high)

The action's Docker image reference uses a mutable version tag instead of an immutable SHA digest. `image: "docker://ghcr.io/super-linter/super-linter:slim-v9.0.0"` should be pinned to a full SHA256 digest (e.g. `image: "ghcr.io/super-linter/super-linter@sha256:<64-hex-char-digest>"`). A mutable tag can be silently updated to point to a different (potentially malicious) image, enabling a supply-chain attack.

Locations:

- `action.yml:7`

## Iteration Notes

### Iteration 1

**Fixes applied:** unpinned-uses

**Notes:**

Pinned the Docker image reference in action.yml from the mutable tag `docker://ghcr.io/super-linter/super-linter:slim-v9.0.0` to the immutable digest `docker://ghcr.io/super-linter/super-linter:slim-v9.0.0@sha256:7d0b4d3387deaac975e86e0787c7a05a25d530469b27d74c2b4599ab5800d9e4`, preserving the docker:// scheme and tag for readability.

