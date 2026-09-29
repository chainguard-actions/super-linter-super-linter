<!-- markdownlint-disable -->

# Hardening Report: super-linter--super-linter/v8.7.0

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **super-linter--super-linter/v8.7.0** was hardened automatically. 1 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unpinned-uses (severity: high)

Both action.yml and slim/action.yml reference Docker images using mutable version tags instead of immutable SHA digests. This means the action could silently pull a different (potentially malicious) image if the tag is moved. `action.yml` uses `docker://ghcr.io/super-linter/super-linter:v8.7.0` and `slim/action.yml` uses `docker://ghcr.io/super-linter/super-linter:slim-v8.7.0`. These should be replaced with `@sha256:<64-hex-char-digest>` references.

Locations:

- `action.yml:6`
- `slim/action.yml:6`

## Iteration Notes

### Iteration 1

**Fixes applied:** unpinned-uses

**Notes:**

Pinned both Docker image references to immutable SHA digests:
- action.yml: ghcr.io/super-linter/super-linter:v8.7.0 → :v8.7.0@sha256:c05768164eed53bac7c82aade7a14a76955206d4962cd41be97118db96fa5996
- slim/action.yml: ghcr.io/super-linter/super-linter:slim-v8.7.0 → :slim-v8.7.0@sha256:c95c714f746edc70e54926a69e229c834ffcdec2450bd3475f7865164d749a56
The docker:// scheme and version tags are preserved inline; only the @sha256 digest was appended to make the references immutable.

