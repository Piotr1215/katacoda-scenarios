#!/usr/bin/env bash

set -euo pipefail

# "Waiting for nodes ready"
kubectl wait node --all --for condition=ready --timeout=800s
echo "done" >>/opt/.clusterstarted

# "Installing tools and configuring git"
sudo apt-get update
sudo apt-get install -y tree
git config --global user.email "you@example.com"
git config --global user.name "Spinkube Demo"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
wget https://github.com/owenthereal/ccat/releases/download/v1.1.0/linux-amd64-1.1.0.tar.gz
tar -xzf linux-amd64-1.1.0.tar.gz
mv linux-amd64-1.1.0/ccat /usr/local/bin
echo "done" >>/opt/.toolsinstalled

# Installing octant for view
wget https://github.com/vmware-tanzu/octant/releases/download/v0.16.3/octant_0.16.3_Linux-64bit.tar.gz
tar -xzvf octant_0.16.3_Linux-64bit.tar.gz
cp ./octant_0.16.3_Linux-64bit/octant /usr/bin/
echo "done" >>/opt/.octantinstalled

echo "done" >>/opt/.backgroundfinished

# shellcheck disable=SC2034
# it is used in the background script
OCTANT_DISABLE_OPEN_BROWSER=true
OCTANT_LISTENER_ADDR=0.0.0.0:7777 octant
