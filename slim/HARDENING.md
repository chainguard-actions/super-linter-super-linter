<!-- markdownlint-disable -->

# Hardening Report: super-linter--super-linter--slim/v8.6.0

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **super-linter--super-linter--slim/v8.6.0** was hardened automatically. 1 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unpinned-uses (severity: high)

The Docker action's `runs.image:` references a mutable version tag instead of an immutable SHA digest. The image `docker://ghcr.io/super-linter/super-linter:slim-v8.6.0` could be silently replaced with a different (potentially malicious) image at any time. It should be pinned to a full SHA256 digest, e.g. `image: ghcr.io/super-linter/super-linter@sha256:<64-hex-char-digest> # slim-v8.6.0`.

Locations:

- `action.yml:6`

## Iteration Notes

### Iteration 1

**Fixes applied:** unpinned-uses

**Notes:**

Pinned the Docker container image in action.yml from the mutable tag `slim-v8.6.0` to the immutable digest `sha256:a56c57c3fbe361bf07173c35c1a8bb3839fc64e363021fdb67798625ea3f3565`. The `docker://` scheme and the original tag are preserved inline for readability: `docker://ghcr.io/super-linter/super-linter:slim-v8.6.0@sha256:a56c57c3fbe361bf07173c35c1a8bb3839fc64e363021fdb67798625ea3f3565`.

