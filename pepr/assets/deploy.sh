#!/usr/bin/env bash

# "Waiting for nodes ready"
curl -sLS https://get.arkade.dev | sudo sh
echo "export PATH=$PATH:$HOME/.arkade/bin/" >>~/.bashrc
arkade get kubectl
sudo mv /root/.arkade/bin/kubectl /usr/local/bin/
arkade get k3d
sudo mv /root/.arkade/bin/k3d /usr/local/bin/
k3d cluster create
kubectl wait node --all --for condition=ready --timeout=800s
echo "done" >>/opt/.clusterstarted

# "Installing tools and configuring git"
sudo apt-get update
sudo apt-get install -y tree bat jq
sudo mv /usr/bin/batcat /usr/bin/bat
git config --global user.email "you@example.com"
git config --global user.name "Pepr Demo"
# Source NVM scripts directly
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion" # This loads nvm bash_completion
nvm install 20 -y
echo "done" >>/opt/.toolsinstalled

# Installing octant for view
wget https://github.com/vmware-archive/octant/releases/download/v0.25.1/octant_0.25.1_Linux-64bit.tar.gz
tar -xzvf octant_0.25.1_Linux-64bit.tar.gz
cp ./octant_0.25.1_Linux-64bit/octant /usr/bin/
echo "done" >>/opt/.octantinstalled

echo "done" >>/opt/.backgroundfinished

# shellcheck disable=SC2034
# it is used in the background script
OCTANT_DISABLE_OPEN_BROWSER=true
OCTANT_LISTENER_ADDR=0.0.0.0:7777 octant
