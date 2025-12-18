#!/usr/bin/env bash
set -e

cd /etc/nixos

echo "== NixOS configuration status =="
echo

sudo git status --branch --short

echo

if sudo git status --porcelain | grep -q .; then
  echo "⚠  Uncommitted changes present"
  exit 1
else
  echo "✔ Working tree clean"
fi

