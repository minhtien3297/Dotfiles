#!/bin/bash

# Check for the existence of lockfiles
if [ -f "package-lock.json" ]; then
  echo "Using npm for development."
  npm i
  npm run $1
elif [ -f "pnpm-lock.yaml" ]; then
  echo "Using pnpm for development."
  pnpm i
  pnpm run $1
elif [ -f "yarn.lock" ]; then
  echo "Using yarn for development."
  yarn
  yarn $1
else
  echo "No lockfile found!"
fi

