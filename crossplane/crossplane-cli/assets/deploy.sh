#!/usr/bin/env bash

set -euo pipefail

echo "Waiting for nodes ready"
kubectl wait node --all --for condition=ready --timeout=800s

echo "done" >>/opt/.clusterstarted

#Installing Helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

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
curl -sL "https://raw.githubusercontent.com/crossplane/crossplane/master/install.sh" | sh && sudo mv crossplane /usr/local/bin

echo "done" >>/opt/.crossplanecliinstalled

## Upgrade Go to latest
wget https://go.dev/dl/go1.21.3.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.21.3.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
echo "export PATH=$PATH:/usr/local/go/bin" >>/etc/profile

echo "done" >>/opt/.goupgraded

# Install tree command
sudo apt-get install tree

## Installing Provider Nop
crossplane xpkg install provider xpkg.upbound.io/crossplane-contrib/provider-nop:v0.2.0
echo "done" >>/opt/.nopinstalled

#Installing komoplane
helm repo add komodorio https://helm-charts.komodor.io &&
	helm repo update komodorio &&
	helm upgrade --install komoplane komodorio/komoplane
kubectl wait --for condition=Available=True --timeout=300s deployment/komoplane
kubectl port-forward --address 0.0.0.0 services/komoplane 8090:8090 &

echo "done" >>/opt/.komoplaneinstalled

echo "done" >>/opt/.backgroundfinished
