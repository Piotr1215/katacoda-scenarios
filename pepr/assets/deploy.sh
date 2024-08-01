#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

# "Waiting for nodes ready"
kubectl wait node --all --for condition=ready --timeout=800s
echo "done" >>/opt/.clusterstarted

# "Installing tools and configuring git"
sudo apt-get update
sudo apt-get install -y tree
git config --global user.email "you@example.com"
git config --global user.name "Pepr Demo"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
# Install NVM and Node.js
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# Source NVM scripts directly
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion" # This loads nvm bash_completion
nvm install 20 -y
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
