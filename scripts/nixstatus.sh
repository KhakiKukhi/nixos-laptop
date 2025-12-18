#!/usr/bin/env bash
set -e

cd /etc/nixos

echo "== NixOS configuration status =="
echo

git status --branch --short

echo

if git status --porcelain | grep -q .; then
  echo "⚠  Uncommitted changes present"
  exit 1
else
  echo "✔ Working tree clean"
fi

