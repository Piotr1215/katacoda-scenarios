#!/usr/bin/env bash

set -euo pipefail

# "Waiting for nodes ready"
kubectl wait node --all --for condition=ready --timeout=800s
echo "done" >>/opt/.clusterstarted

# "Installing tools"
sudo apt-get update
sudo apt-get install -y sqlite3
sudo apt-get install -y tree
echo "done" >>/opt/.toolsinstalled

#Installing K9s
wget https://github.com/derailed/k9s/releases/download/v0.32.5/k9s_Linux_amd64.tar.gz
tar -xzvf k9s_Linux_amd64.tar.gz
chmod +x k9s
sudo cp ./k9s /usr/local/bin/
echo "done" >>/opt/.k9sinstalled

# Installing kube-ps1
cat <<'EOF' >>~/.bashrc

source /root/kube-ps1.sh

kube_ps1_custom() {
    local kube_ps1_output
    kube_ps1_output="$(kube_ps1)"
    echo "${kube_ps1_output#[⎈ }"
}

KUBE_PS1_SYMBOL_DEFAULT="⎈"
KUBE_PS1_SEPARATOR="/"
KUBE_PS1_PREFIX="["
KUBE_PS1_SUFFIX="]"

PS1='$(kube_ps1_custom)\$ '
EOF

# Marking installation as complete
echo "done" >>/opt/.kubeps1installed

# Installing octant for view
wget https://github.com/vmware-tanzu/octant/releases/download/v0.16.3/octant_0.16.3_Linux-64bit.tar.gz
tar -xzvf octant_0.16.3_Linux-64bit.tar.gz
cp ./octant_0.16.3_Linux-64bit/octant /usr/bin/
echo "done" >>/opt/.octantinstalled

echo "done" >>/opt/.backgroundfinished

OCTANT_DISABLE_OPEN_BROWSER=true
OCTANT_LISTENER_ADDR=0.0.0.0:7777 octant
