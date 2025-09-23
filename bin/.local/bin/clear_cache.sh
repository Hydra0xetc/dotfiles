#!/bin/bash
set -euo pipefail

CACHE_DIR="$HOME/.cache"

for item in "$CACHE_DIR"/*; do
  name=$(basename "$item")

  # skip folder tertentu
  if [[ "$name" == "nvim" ||
    "$name" == "gitstatus" ||
    "$name" == "tealdeer" ||
    "$name" == "pip" ||
    "$name" == "oh-my-zsh" ||
    "$name" == *"zsh"* ]]; then
    echo "Skipping: $name"
    continue
  fi

  echo "Deleting: $name"
  rm -rf -- "$item"
done

rm -rf ~/.npm/_cacache/*
rm -rf ~/.cargo/registry/cache/*
