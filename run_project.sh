#!/usr/bin/env bash

set -euo pipefail

task="${1:-dev}"

run_with_manager() {
  local manager="$1"
  local lockfile="$2"
  shift 2

  if [[ ! -d node_modules || "$lockfile" -nt node_modules ]]; then
    echo "Installing dependencies with ${manager}..."
    "$@"
  else
    echo "Dependencies already look up to date for ${manager}."
  fi
}

if [[ -f package-lock.json ]]; then
  echo "Using npm for development."
  run_with_manager npm package-lock.json npm install
  npm run "$task"
elif [[ -f pnpm-lock.yaml ]]; then
  echo "Using pnpm for development."
  run_with_manager pnpm pnpm-lock.yaml pnpm install
  pnpm run "$task"
elif [[ -f yarn.lock ]]; then
  echo "Using yarn for development."
  run_with_manager yarn yarn.lock yarn install
  yarn "$task"
else
  echo "No supported lockfile found in $(pwd)."
  exit 1
fi
