#!/usr/bin/env bash
set -e

if [ "$1" != "-m" ] || [ -z "$2" ]; then
  echo "Usage: nixpush -m \"commit message\""
  exit 1
fi

cd /etc/nixos

sudo git add -A
sudo git commit -m "$2"
sudo -E git push

