#!/usr/bin/env bash
set -e

cd /etc/nixos

echo "== NixOS configuration history =="
echo

if ! git log \
  --max-count=10 \
  --date=short \
  --pretty=format:"%C(yellow)%h%Creset  %C(cyan)%ad%Creset  %s" \
  2> >(tee /tmp/nixhistory.err >&2); then

  if grep -q "dubious ownership" /tmp/nixhistory.err; then
    echo
    echo "Hint: Git refused due to repository ownership."
    echo "Try running:"
    echo "  sudo nixhistory"
  fi

  exit 1
fi

