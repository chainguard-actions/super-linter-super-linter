<!-- markdownlint-disable -->

# Hardening Report: super-linter--super-linter/v8.7.0

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **super-linter--super-linter/v8.7.0** was hardened automatically. 1 finding(s) were identified and resolved across 5 iteration(s).

## Findings Fixed

### unpinned-uses (severity: high)

Both action.yml and slim/action.yml reference Docker images using mutable version tags instead of immutable SHA digests. This means the action could silently pull a different (potentially malicious) image if the tag is overwritten. `action.yml` uses `docker://ghcr.io/super-linter/super-linter:v8.7.0` and `slim/action.yml` uses `docker://ghcr.io/super-linter/super-linter:slim-v8.7.0`. Both should be pinned to a full SHA256 digest, e.g. `image: ghcr.io/super-linter/super-linter@sha256:<64-hex-char-digest> # v8.7.0`.

Locations:

- `action.yml:6`
- `slim/action.yml:6`

## Iteration Notes

### Iteration 1

**Fixes applied:** unpinned-uses

**Notes:**

Pinned both Docker image references to immutable SHA256 digests:
- hardened/action/action.yml: docker://ghcr.io/super-linter/super-linter:v8.7.0 → :v8.7.0@sha256:c05768164eed53bac7c82aade7a14a76955206d4962cd41be97118db96fa5996
- hardened/action/slim/action.yml: docker://ghcr.io/super-linter/super-linter:slim-v8.7.0 → :slim-v8.7.0@sha256:c95c714f746edc70e54926a69e229c834ffcdec2450bd3475f7865164d749a56
The docker:// scheme and version tags are preserved inline; digests were resolved via the Docker Registry HTTP API.

### Iteration 2

**Fixes applied:** unpinned-uses, script-injection, github-env-injection

**Notes:**

Fixed all three finding types across 6 workflow files:

1. **unpinned-uses**: Pinned all 13 unique action references to full 40-char SHAs across cd.yml, ci.yml, dependabot-automation.yaml, lint-commit.yaml, stale.yml, and thank_contributors.yaml.

2. **script-injection**: Moved all ${{ }} expressions out of run: blocks into env: blocks in:
   - ci.yml: github.event_name/sha/pr.head.sha → ENV_NAME/GIT_SHA/PR_HEAD_SHA; secrets.GITHUB_TOKEN → GITHUB_TOKEN_VALUE
   - cd.yml: github.event_name/sha/pr.head.sha/matrix.images.prefix → env vars
   - lint-commit.yaml: github.event.pull_request.commits → COMMIT_COUNT
   - audit.yaml: matrix.package-ecosystems.target → AUDIT_TARGET

3. **github-env-injection**: In cd.yml Set build metadata step, matrix.images.prefix is now sanitized with `printf '%s' "${IMAGE_PREFIX}" | tr -d '\n\r'` before being written to GITHUB_ENV as part of CONTAINER_IMAGE_ID.

### Iteration 3

**Fixes applied:** github-env-injection

**Notes:**

Fixed the 'Configure release metedata' step in the 'release' job of .github/workflows/cd.yml:
1. Changed `grep -E -o` to `grep -E -x` so the semver pattern must match the entire line, not just a substring — this prevents values with embedded newlines from passing validation.
2. Added `safe_release_version=$(printf '%s' "${RELEASE_VERSION}" | tr -d '\n\r')` to sanitize RELEASE_VERSION before writing to $GITHUB_ENV.
3. Added `safe_semver_major_version=$(printf '%s' "${SEMVER_MAJOR_VERSION}" | tr -d '\n\r')` to sanitize SEMVER_MAJOR_VERSION before writing to $GITHUB_ENV.
Both sanitized variables are now written to $GITHUB_ENV instead of the raw unsanitized values.

### Iteration 4

**Fixes applied:** script-injection

**Notes:**

Fixed unquoted variable expansion in `.github/workflows/lint-commit.yaml` line 30. Changed `if [ -z ${commit_count} ]` to `if [ -z "${commit_count}" ]` to prevent shell metacharacter injection from the untrusted `github.event.pull_request.commits` value. The variable was already correctly moved into the env block (COMMIT_COUNT), but the unquoted expansion in the single-bracket test was the remaining vulnerability.

### Iteration 5

**Fixes applied:** github-env-injection

**Notes:**

Fixed github-env-injection in two workflow files:

1. .github/workflows/ci.yml: In the 'Set build metadata' step of the 'set-build-metadata' job, added sanitization of BUILD_DATE, BUILD_REVISION, and BUILD_VERSION using `printf '%s' ... | tr -d '\n\r'` before writing to $GITHUB_ENV and $GITHUB_OUTPUT. The safe_build_date, safe_build_revision, and safe_build_version variables are now used in both heredoc blocks.

2. .github/workflows/cd.yml: In the 'Set build metadata' step of the 'test' job, added sanitization of BUILD_DATE, BUILD_REVISION, and BUILD_VERSION using `printf '%s' ... | tr -d '\n\r'` before writing to $GITHUB_ENV. The safe_ prefixed variables are now used alongside the already-sanitized safe_prefix variable.

Both fixes prevent an attacker who can influence commit SHAs or PR head SHAs from injecting newlines to set arbitrary environment variables or outputs.

