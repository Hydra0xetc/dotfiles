#!/bin/bash

CACHE_DIR="$HOME/.cache"

for item in "$CACHE_DIR"/*; do
  name=$(basename "$item")

  # skip gitstatus, oh-my-zsh, dan apapun yang mengandung zsh
  if [[ "$name" == "nvim" || "$name" == "gitstatus" || "$name" == "oh-my-zsh" || "$name" == *zsh* ]]; then
    echo "Skipping: $name"
    continue
  fi

  echo "Deleting: $name"
  rm -rf "$item"
done
# rm -rf ~/.gemini/tmp/*
rm -rf ~/.npm/_cacache/*
