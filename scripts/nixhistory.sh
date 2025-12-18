#!/usr/bin/env bash
set -e

cd /etc/nixos

echo "== NixOS configuration history =="
echo

git log \
  --max-count=10 \
  --date=short \
  --pretty=format:"%C(yellow)%h%Creset  %C(cyan)%ad%Creset  %s"

