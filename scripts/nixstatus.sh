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

# Fetch remote state quietly (read-only)
if git rev-parse --abbrev-ref --symbolic-full-name @{upstream} >/dev/null 2>&1; then
  git fetch --quiet

  ahead_behind=$(git rev-list --left-right --count HEAD...@{upstream})
  ahead=$(echo "$ahead_behind" | awk '{print $1}')
  behind=$(echo "$ahead_behind" | awk '{print $2}')

  echo

  if [ "$ahead" -eq 0 ] && [ "$behind" -eq 0 ]; then
    echo "✔ Branch is up to date with remote"
  elif [ "$ahead" -gt 0 ] && [ "$behind" -eq 0 ]; then
    echo "↑ Local branch is ahead of remote by $ahead commit(s)"
  elif [ "$ahead" -eq 0 ] && [ "$behind" -gt 0 ]; then
    echo "↓ Local branch is behind remote by $behind commit(s)"
    echo "  Run: nixupdate"
  else
    echo "⚠ Branch has diverged from remote"
    echo "  Manual intervention required"
  fi
fi

