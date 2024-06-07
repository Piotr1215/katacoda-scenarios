#!/usr/bin/env bash

set -euo pipefail

# "Waiting for nodes ready"
kubectl wait node --all --for condition=ready --timeout=800s
echo "done" >>/opt/.clusterstarted

# "Installing tools and configuring git"
sudo apt-get update
sudo apt-get install -y tree
git config --global user.email "you@example.com"
git config --global user.name "Just Demo"
echo "done" >>/opt/.toolsinstalled

echo "done" >>/opt/.backgroundfinished
