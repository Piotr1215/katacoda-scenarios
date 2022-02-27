#!/usr/bin/env bash

#set -euo pipefail

MESSAGE_FILE='/opt/.messagefile'

# Start Kubernetes
echo "Installing k3s Kubernetes Cluster" > $MESSAGE_FILE
curl -sfL https://get.k3s.io | sh - &> /dev/null

echo "Waiting for nodes ready" > $MESSAGE_FILE
k3s kubectl wait node --all --for=condition=Ready --timeout=60s &> /dev/null

echo "Setup KUBECONFIG" > $MESSAGE_FILE
{
     export KUBECONFIG=/etc/rancher/k3s/k3s.yaml 
     echo "export KUBECONFIG=/etc/rancher/k3s/k3s.yaml" >> ~/.bashrc
} &> /dev/null

echo "Installing Helm" > $MESSAGE_FILE
{
     wget https://get.helm.sh/helm-v3.4.1-linux-amd64.tar.gz
     tar xvf helm-v3.4.1-linux-amd64.tar.gz
     mv linux-amd64/helm /usr/local/bin
} &> /dev/null

echo "Installing Crossplane" > $MESSAGE_FILE
{
     kubectl create namespace crossplane-system
     helm repo add crossplane-stable https://charts.crossplane.io/stable
     helm repo upate
     helm install crossplane --namespace crossplane-system crossplane-stable/crossplane
     kubectl wait deployment.apps/crossplane --namespace crossplane-system --for condition=AVAILABLE=True --timeout 1m
} &> /dev/null

echo "Waiting for DNS service to start" > $MESSAGE_FILE
kubectl wait deployment.apps/coredns --namespace kube-system --for condition=AVAILABLE=True --timeout 1m &> /dev/null

echo "Installing Crossplane CLI" > $MESSAGE_FILE
curl -sL https://raw.githubusercontent.com/crossplane/crossplane/release-1.5/install.sh | sh &> /dev/null

-echo "done" >> /opt/.backgroundfinished

echo "Cluster Ready" &> /dev/null
