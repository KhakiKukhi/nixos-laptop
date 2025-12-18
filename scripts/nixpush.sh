#!/usr/bin/env bash
set -e

cd /etc/nixos

if git status --porcelain | grep -q .; then
  if [ "$1" != "-m" ] || [ -z "$2" ]; then
    echo "Error: uncommitted changes present."
    echo "Usage: nixpush -m \"commit message\""
    exit 1
  fi

  git add -A
  git commit -m "$2"
else
  echo "No new changes to commit; pushing preexisting changes..."
fi

if ! git push 2> >(tee /tmp/nixpush.err >&2); then
  if grep -q "Permission denied (publickey)" /tmp/nixpush.err; then
    echo
    echo "Hint: SSH authentication failed."
    echo "If you ran this via sudo, try:"
    echo "  sudo -E nixpush"
  fi
  exit 1
fi

