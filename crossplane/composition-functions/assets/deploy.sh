#!/usr/bin/env bash

set -euo pipefail

#Start Kubernetes
# curl -sfL https://get.k3s.io | sh -

# echo "Waiting for nodes ready"
# k3s kubectl wait node --all --for=condition=Ready --timeout=60s

# echo "Setup KUBECONFIG"
# export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
# echo "export KUBECONFIG=/etc/rancher/k3s/k3s.yaml" >>~/.bashrc

echo "done" >>/opt/.clusterstarted

#Installing Helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
# wget https://get.helm.sh/helm-v3.4.1-linux-amd64.tar.gz
# tar xvf helm-v3.4.1-linux-amd64.tar.gz
# mv linux-amd64/helm /usr/local/bin

echo "done" >>/opt/.helminstalled

#Installing Crossplane
echo "Installing Crossplane"
helm repo add crossplane-stable https://charts.crossplane.io/stable
helm repo update
helm install crossplane \
	--namespace crossplane-system \
	--create-namespace crossplane-stable/crossplane

echo "done" >>/opt/.crossplaneinstalled

#Installing Crossplane CLI
curl -sL "https://raw.githubusercontent.com/crossplane/crossplane/master/install.sh" | sh

echo "done" >>/opt/.crossplanecliinstalled

#Installing Octant
wget https://github.com/vmware-tanzu/octant/releases/download/v0.16.3/octant_0.16.3_Linux-64bit.tar.gz
tar -xzvf octant_0.16.3_Linux-64bit.tar.gz
cp ./octant_0.16.3_Linux-64bit/octant /usr/bin/
echo "done" >>/opt/.octantinstalled

octant --listener-addr="0.0.0.0:7777" --disable-open-browser=true --kubeconfig="/etc/rancher/k3s/k3s.yaml" &

echo "done" >>/opt/.backgroundfinished
