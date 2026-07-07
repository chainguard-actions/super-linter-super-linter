<!-- markdownlint-disable -->

# Hardening Report: super-linter--super-linter/v8.7.0

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `1`

Action **super-linter--super-linter/v8.7.0** was hardened automatically. 3 finding(s) were identified and resolved across 2 iteration(s).

## Findings Fixed

### unpinned-uses (severity: high)

action.yml uses a mutable docker image tag 'docker://ghcr.io/super-linter/super-linter:v8.7.0' instead of a SHA digest. slim/action.yml uses 'docker://ghcr.io/super-linter/super-linter:slim-v8.7.0'. Multiple workflow files use tag-based uses: references instead of pinned SHA commits: cd.yml uses actions/checkout@v6, docker/setup-buildx-action@v4, docker/login-action@v4.2.0, docker/build-push-action@v7, actions/github-script@v9, googleapis/release-please-action@v5.0.0, akhilerm/tag-push-action@v2.3.0; ci.yml uses actions/checkout@v6, docker/setup-buildx-action@v4, docker/build-push-action@v7, actions/upload-artifact@v7.0.1, actions/download-artifact@v8.0.1; dependabot-automation.yaml uses dependabot/fetch-metadata@v3; lint-commit.yaml uses actions/checkout@v6; stale.yml uses actions/stale@v10, actions/github-script@v9; thank_contributors.yaml uses github-community-projects/contributors@v2, peter-evans/create-issue-from-file@v6.

Locations:

- `action.yml:6`
- `slim/action.yml:6`
- `.github/workflows/cd.yml:37`
- `.github/workflows/ci.yml:29`
- `.github/workflows/dependabot-automation.yaml:18`
- `.github/workflows/lint-commit.yaml:16`
- `.github/workflows/stale.yml:26`
- `.github/workflows/thank_contributors.yaml:22`

### script-injection (severity: high)

Multiple run: blocks directly interpolate ${{ ... }} expressions into shell commands (rule a). In audit.yaml: 'run: make ${{ matrix.package-ecosystems.target }}'. In cd.yml: 'if [[ ${{ github.event_name }} == ...' and 'BUILD_REVISION=${{ github.sha }}' and 'BUILD_REVISION=${{ github.event.pull_request.head.sha }}'. In ci.yml: same github.event_name/sha patterns, plus 'echo "${{ secrets.GITHUB_TOKEN }}" > .github-personal-access-token'. In lint-commit.yaml: 'commit_count=${{ github.event.pull_request.commits }}'.

Locations:

- `.github/workflows/audit.yaml:47`
- `.github/workflows/cd.yml:107`
- `.github/workflows/ci.yml:35`
- `.github/workflows/ci.yml:432`
- `.github/workflows/lint-commit.yaml:21`

### github-env-injection (severity: high)

In cd.yml, a run: block writes 'echo "CONTAINER_IMAGE_ID=ghcr.io/super-linter/super-linter:${{ matrix.images.prefix }}latest"' directly to $GITHUB_ENV without sanitization — ${{ matrix.images.prefix }} is a matrix value that could contain newlines. Also in cd.yml, RELEASE_VERSION and SEMVER_MAJOR_VERSION (derived from steps.release.outputs.*) are written to $GITHUB_ENV via env vars without the required tr -d newline sanitization. In ci.yml, BUILD_REVISION (set from ${{ github.sha }} or ${{ github.event.pull_request.head.sha }}) is written to $GITHUB_ENV and $GITHUB_OUTPUT without sanitization.

Locations:

- `.github/workflows/cd.yml:148`
- `.github/workflows/cd.yml:298`
- `.github/workflows/ci.yml:66`

## Iteration Notes

### Iteration 1

**Fixes applied:** unpinned-uses, script-injection, github-env-injection

**Notes:**

Fixed all three finding types across 9 files:

1. unpinned-uses: Pinned all mutable container image tags and action references to full SHA digests. action.yml and slim/action.yml now use sha256 digests for ghcr.io/super-linter/super-linter. All workflow files (cd.yml, ci.yml, dependabot-automation.yaml, lint-commit.yaml, stale.yml, thank_contributors.yaml) have all uses: references pinned to full commit SHAs with tag comments.

2. script-injection: Moved all ${{ }} expressions out of run: blocks into step env: blocks. Fixed in audit.yaml (matrix.package-ecosystems.target), cd.yml (github.event_name, github.sha, github.event.pull_request.head.sha, matrix.images.prefix), ci.yml (same patterns plus secrets.GITHUB_TOKEN), and lint-commit.yaml (github.event.pull_request.commits).

3. github-env-injection: Added tr -d '\n\r' sanitization before writing context-derived values to GITHUB_ENV/GITHUB_OUTPUT. Fixed in cd.yml test job (IMAGE_PREFIX → CONTAINER_IMAGE_ID), cd.yml release job (RELEASE_VERSION and SEMVER_MAJOR_VERSION), and ci.yml set-build-metadata job (BUILD_REVISION).

### Iteration 2

**Fixes applied:** script-injection

**Notes:**

Fixed unquoted shell variable expansions in `.github/workflows/lint-commit.yaml`. In the 'Check if the pull request contains a single commit' step, `${commit_count}` was used unquoted in two shell conditionals. Both have been updated to use `"${commit_count}"` (double-quoted) to prevent shell metacharacter injection from the attacker-controllable `github.event.pull_request.commits` value.

