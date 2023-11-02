#!/usr/bin/env bash

set -euo pipefail

#Start Kubernetes
# curl -sfL https://get.k3s.io | sh -

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
curl -sL "https://raw.githubusercontent.com/crossplane/crossplane/master/install.sh" | sh &&
	sudo mv crossplane /usr/local/bin

echo "done" >>/opt/.crossplanecliinstalled

#Installing komoplane
helm repo add komodorio https://helm-charts.komodor.io &&
	helm repo update komodorio &&
	helm upgrade --install komoplane komodorio/komoplane

echo "done" >>/opt/.komoplaneinstalled

echo "done" >>/opt/.backgroundfinished
