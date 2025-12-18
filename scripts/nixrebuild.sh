#!/usr/bin/env bash

set -e
sudo nixos-rebuild switch --flake /etc/nixos#laptop
