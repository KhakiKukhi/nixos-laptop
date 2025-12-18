#!/usr/bin/env bash
set -e

cd /etc/nixos

case "$1" in
  "")
    if ! sudo git diff --quiet || ! sudo git diff --cached --quiet; then
      echo "Error: /etc/nixos has uncommitted changes."
      echo "Refusing to revert."
      echo
      echo "Use:"
      echo "  nixrevert --hard"
      echo "to discard ALL local changes and return to the last commit."
      exit 1
    fi

    echo "Working tree is clean."
    echo "Already at last committed state."
    ;;

  --hard)
    echo "WARNING: This will permanently discard ALL uncommitted changes"
    echo "and delete ALL untracked files in /etc/nixos."
    echo
    read -r -p "Type 'yes' to continue: " confirm

    if [ "$confirm" != "yes" ]; then
      echo "Aborted."
      exit 1
    fi

    echo "Hard reverting /etc/nixos…"

    sudo git reset --hard HEAD
    sudo git clean -fd

    echo "Hard revert complete."
    echo "Run 'nixrebuild' to apply the reverted configuration."
    ;;

  *)
    echo "Usage:"
    echo "  nixrevert"
    echo "  nixrevert --hard"
    exit 1
    ;;
esac

