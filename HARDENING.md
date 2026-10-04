<!-- markdownlint-disable -->

# Hardening Report: super-linter--super-linter/v8.3.2

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **super-linter--super-linter/v8.3.2** was hardened automatically. 1 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unpinned-uses (severity: high)

Both action.yml and slim/action.yml reference Docker images using mutable version tags instead of immutable SHA digests. This means the action could silently pull a different (potentially malicious) image if the tag is moved. `action.yml` uses `docker://ghcr.io/super-linter/super-linter:v8.3.2` and `slim/action.yml` uses `docker://ghcr.io/super-linter/super-linter:slim-v8.3.2`. These should be replaced with `@sha256:<64-hex-char-digest>` references.

Locations:

- `action.yml:7`
- `slim/action.yml:7`

## Iteration Notes

### Iteration 1

**Fixes applied:** unpinned-uses

**Notes:**

Pinned both Docker image references to immutable SHA digests:
- action.yml: ghcr.io/super-linter/super-linter:v8.3.2 → :v8.3.2@sha256:e9d1895a1bdc1f9d9df41f688b27aa891743f23f9fae0f22a3e25eeda8f102db
- slim/action.yml: ghcr.io/super-linter/super-linter:slim-v8.3.2 → :slim-v8.3.2@sha256:0591b4d7d11be09b00a358340bee9637fcb8d3df474881898b399182471fcee2
The docker:// scheme and version tags are preserved inline for readability.

