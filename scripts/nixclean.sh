#!/usr/bin/env bash
set -e

cd /etc/nixos

if git diff --quiet && git diff --cached --quiet && [ -z "$(git ls-files --others --exclude-standard)" ]; then
  echo "Working tree is already clean."
  exit 0
fi

echo "WARNING: This will discard ALL local changes in /etc/nixos"
echo "Including untracked files."
echo
read -r -p "Type 'yes' to continue: " confirm

if [ "$confirm" != "yes" ]; then
  echo "Aborted."
  exit 1
fi

git reset --hard HEAD
git clean -fd

echo "Workspace cleaned."
echo "Run 'nixrebuild' to apply the clean configuration."

