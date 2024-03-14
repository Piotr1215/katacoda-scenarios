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
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
kubectl patch deployment metrics-server -n kube-system \
	--type='json' \
	-p='[{"op": "add", "path": "/spec/template/spec/containers/0/args/-", "value": "--kubelet-insecure-tls=true"}]'

echo "done" >>/opt/.crossplaneinstalled

#Installing Crossplane CLI
curl -sL https://raw.githubusercontent.com/crossplane/crossplane/release-1.15/install.sh | sh

echo "done" >>/opt/.crossplanecliinstalled

#Installing Crossplane’s Kubernetes Provider
kubectl apply -f kubernetes-provider.yaml
echo "alias k=kubectl" >>~/.bashrc

echo "done" >>/opt/.kubernetesproviderinstalled

#Installing Octant
wget https://github.com/vmware-tanzu/octant/releases/download/v0.16.3/octant_0.16.3_Linux-64bit.tar.gz
tar -xzvf octant_0.16.3_Linux-64bit.tar.gz
cp ./octant_0.16.3_Linux-64bit/octant /usr/bin/
echo "done" >>/opt/.octantinstalled

octant --listener-addr="0.0.0.0:7777" --disable-open-browser=true --kubeconfig="/root/.kube/config" &

echo "done" >>/opt/.backgroundfinished
