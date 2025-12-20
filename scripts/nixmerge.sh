#!/usr/bin/env bash
set -e

cd /etc/nixos

commit="$1"
strategy="$2"

if [ -z "$commit" ]; then
  echo "Usage: nixmerge <commit> [--override | --accept-override]"
  exit 1
fi

if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "Error: uncommitted changes present."
  echo "Clean or commit them first."
  exit 1
fi

echo "Applying changes from commit $commit (no commit yet)…"

if ! git cherry-pick -n "$commit"; then
  echo
  echo "Merge conflicts detected."

  case "$strategy" in
    --override)
      echo "Keeping LOCAL changes."
      git checkout --ours .
      git add .
      ;;

    --accept-override)
      echo "Accepting INCOMING changes."
      git checkout --theirs .
      git add .
      ;;

    *)
      echo
      echo "Resolve conflicts manually, then:"
      echo "  git add <files>"
      echo "  git commit"
      exit 1
      ;;
  esac
fi

echo
echo "Merge applied to working tree."
echo "Review changes, then commit when ready."

