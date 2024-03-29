#!/usr/bin/env bash

set -euo pipefail

echo "Waiting for nodes ready"
kubectl wait node --all --for condition=ready --timeout=800s

echo "done" >>/opt/.clusterstarted

#Installing Helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

echo "done" >>/opt/.helminstalled

#Installing Crossplane
echo "Installing Crossplane and setting up cluster"
helm repo add crossplane-stable https://charts.crossplane.io/stable
helm repo update
helm install crossplane \
	--namespace crossplane-system \
	--create-namespace crossplane-stable/crossplane
kubectl wait -n crossplane-system deploy/crossplane --for='condition=AVAILABLE=True'
kubectl apply -f /root/top/install.yaml
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
kubectl patch deployment metrics-server -n kube-system \
	--type='json' \
	-p='[{"op": "add", "path": "/spec/template/spec/containers/0/args/-", "value": "--kubelet-insecure-tls=true"}]'

echo "done" >>/opt/.crossplaneinstalled

#Installing Crossplane CLI
# TODO:(piotr1215) crossplane CLI binary is in the assets as the build takes forever, change this when release is Available
# curl -sL "https://raw.githubusercontent.com/crossplane/crossplane/master/install.sh" | sh && sudo mv crossplane /usr/local/bin

# echo "done" >>/opt/.crossplanecliinstalled

# Install tree command
sudo apt-get install tree

echo "done" >>/opt/.backgroundfinished
