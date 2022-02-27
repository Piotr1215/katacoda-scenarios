#!/usr/bin/env bash

set -euo pipefail
#Start Kubernetes
echo "Installing k3s Kubernetes Cluster"
curl -sfL https://get.k3s.io | sh - 

echo "Waiting for nodes ready"
k3s kubectl wait node --all --for=condition=Ready --timeout=60s

echo "Setup KUBECONFIG"
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml 
echo "export KUBECONFIG=/etc/rancher/k3s/k3s.yaml" >> ~/.bashrc

echo "done" >> /opt/.clusterstarted

echo "Installing Helm"
wget https://get.helm.sh/helm-v3.4.1-linux-amd64.tar.gz
tar xvf helm-v3.4.1-linux-amd64.tar.gz
mv linux-amd64/helm /usr/local/bin

echo "done" >> /opt/.helminstalled

echo "Installing Crossplane"
kubectl create namespace crossplane-system
helm repo add crossplane-stable https://charts.crossplane.io/stable
helm repo upate
helm install crossplane --namespace crossplane-system crossplane-stable/crossplane
kubectl wait deployment.apps/crossplane --namespace crossplane-system --for condition=AVAILABLE=True --timeout 1m

echo "Waiting for DNS service to start"
kubectl wait deployment.apps/coredns --namespace kube-system --for condition=AVAILABLE=True --timeout 1m

echo "Installing Crossplane CLI"
curl -sL https://raw.githubusercontent.com/crossplane/crossplane/release-1.5/install.sh | sh

echo "done" >> /opt/.crossplaneinstalled

echo "done" >> /opt/.backgroundfinished
