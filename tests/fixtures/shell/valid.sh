#!/usr/bin/env bash
set -euo pipefail

# A simple valid shell script
greet() {
  local name="$1"
  echo "Hello, ${name}!"
}

greet "World"
