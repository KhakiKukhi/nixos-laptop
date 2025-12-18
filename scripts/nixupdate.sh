#!/usr/bin/env bash
set -e

if [ "$EUID" -ne 0 ]; then
  echo "This command must be run with sudo."
  echo "Try:"
  echo "  sudo nixupdate"
  exit 1
fi

cd /etc/nixos

# Refuse if working tree is dirty
if git status --porcelain | grep -q .; then
  echo "Error: /etc/nixos has uncommitted changes."
  echo "Refusing to update."
  echo
  echo "Run 'sudo nixstatus' to inspect."
  exit 1
fi

echo "Fetching updates from origin…"
git fetch origin

# Check if we are behind
LOCAL=$(git rev-parse HEAD)
REMOTE=$(git rev-parse origin/main)

if [ "$LOCAL" = "$REMOTE" ]; then
  echo "Already up to date."
  exit 0
fi

# Ensure fast-forward is possible
if ! git merge-base --is-ancestor "$LOCAL" "$REMOTE"; then
  echo "Error: Non-fast-forward update required."
  echo "Manual intervention needed."
  exit 1
fi

echo "Pulling updates…"
git pull --ff-only

echo "Update complete."
echo "Run 'sudo nixrebuild' to apply changes."

