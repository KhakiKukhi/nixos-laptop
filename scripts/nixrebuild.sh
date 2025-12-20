#!/usr/bin/env bash

set -e
#nixos-rebuild switch --flake /etc/nixos#laptop
nixos-rebuild switch --flake /etc/nixos#"${1:-laptop}"

