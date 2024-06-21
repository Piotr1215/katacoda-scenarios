#!/usr/bin/env bash

set -euo pipefail

# "Installing tools and configuring git"
git config --global user.email "you@example.com"
git config --global user.name "Arkade Demo"
echo "done" >>/opt/.toolsinstalled

echo "done" >>/opt/.octantinstalled

echo "done" >>/opt/.backgroundfinished

# shellcheck disable=SC2034
# it is used in the background script
OCTANT_DISABLE_OPEN_BROWSER=true
OCTANT_LISTENER_ADDR=0.0.0.0:7777 octant
