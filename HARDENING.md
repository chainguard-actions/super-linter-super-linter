<!-- markdownlint-disable -->

# Hardening Report: super-linter--super-linter/v8.6.0

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `1`

Action **super-linter--super-linter/v8.6.0** was hardened automatically. 1 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unpinned-uses (severity: high)

Both action.yml and slim/action.yml reference Docker images using mutable version tags instead of immutable SHA digests. `action.yml` uses `docker://ghcr.io/super-linter/super-linter:v8.6.0` and `slim/action.yml` uses `docker://ghcr.io/super-linter/super-linter:slim-v8.6.0`. A mutable tag can be silently updated to point to a different (potentially malicious) image, enabling supply-chain attacks. These should be pinned to a specific SHA digest, e.g. `docker://ghcr.io/super-linter/super-linter@sha256:<64-hex-char-digest>`.

Locations:

- `action.yml:7`
- `slim/action.yml:7`

## Iteration Notes

### Iteration 1

**Fixes applied:** unpinned-uses

**Notes:**

Pinned both Docker image references to immutable SHA digests:
- action.yml: ghcr.io/super-linter/super-linter:v8.6.0 → @sha256:35955a2af8395c8224c7072732b91350f7f02c2ae9ee751842776ef29092a6cc # v8.6.0
- slim/action.yml: ghcr.io/super-linter/super-linter:slim-v8.6.0 → @sha256:a56c57c3fbe361bf07173c35c1a8bb3839fc64e363021fdb67798625ea3f3565 # slim-v8.6.0
Original version tags are preserved as comments outside the YAML string for readability.

