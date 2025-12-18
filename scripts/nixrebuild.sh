#!/usr/bin/env bash

set -e
nixos-rebuild switch --flake /etc/nixos#laptop
