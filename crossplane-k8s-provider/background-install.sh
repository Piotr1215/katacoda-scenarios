#!/bin/bash

# Start Kubernetes
echo "Installing k3s Kubernetes Cluster"
curl -sfL https://get.k3s.io | sh -

echo "Waiting for nodes ready"
k3s kubectl wait node --all --for=condition=Ready --timeout=60s

echo "Setup KUBECONFIG"
echo "export KUBECONFIG=/etc/rancher/k3s/k3s.yaml" >> ~/.bashrc

echo "Installing Helm"
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

echo "Installing Crossplane"
kubectl create namespace crossplane-system
helm repo add crossplane-stable https://charts.crossplane.io/stable
helm repo upate
helm install crossplane --namespace crossplane-system crossplane-stable/crossplane
kubectl wait deployment.apps/crossplane --namespace crossplane-system --for condition=AVAILABLE=True --timeout 1m

echo "done" >> /opt/.backgroundfinished
