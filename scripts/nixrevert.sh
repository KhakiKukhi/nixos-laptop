#!/usr/bin/env bash
set -e

cd /etc/nixos

if [ -z "$1" ]; then
  echo "Usage: nixrevert <commit>"
  exit 1
fi

if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "Error: uncommitted changes present."
  echo "Clean or commit them first."
  exit 1
fi

echo "Reverting commit $1"
git revert "$1"

echo
echo "Revert commit created."
echo "Run 'nixrebuild' to apply the reverted configuration."

