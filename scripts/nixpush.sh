#!/usr/bin/env bash
set -e

cd /etc/nixos

# Check if there are uncommitted changes
if ! sudo git diff --quiet || ! sudo git diff --cached --quiet; then
  # There ARE changes → require commit message
  if [ "$1" != "-m" ] || [ -z "$2" ]; then
    echo "Error: uncommitted changes present."
    echo "Usage: nixpush -m \"commit message\""
    exit 1
  fi

  sudo git add -A
  sudo git commit -m "$2"
else
  echo "No new changes to commit; pushing preexisting changes..."
fi

# Always attempt to push
sudo -E git push

