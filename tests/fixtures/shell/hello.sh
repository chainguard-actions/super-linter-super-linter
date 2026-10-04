#!/usr/bin/env bash
set -euo pipefail

# A simple hello world script
main() {
  local name="${1:-World}"
  echo "Hello, ${name}!"
}

main "$@"
