#!/bin/bash

MESSAGE_FILE='/opt/.messagefile'

# Start Kubernetes
echo "Installing k3s Kubernetes Cluster" > $MESSAGE_FILE
curl -sfL https://get.k3s.io | sh -

echo "Waiting for nodes ready" > $MESSAGE_FILE
k3s kubectl wait node --all --for=condition=Ready --timeout=60s

#echo "Setup KUBECONFIG" > $MESSAGE_FILE
#echo "export KUBECONFIG=/etc/rancher/k3s/k3s.yaml" 
#echo "export KUBECONFIG=/etc/rancher/k3s/k3s.yaml" >> ~/.bashrc

echo "Installing Helm" > $MESSAGE_FILE
wget https://get.helm.sh/helm-v3.4.1-linux-amd64.tar.gz
tar xvf helm-v3.4.1-linux-amd64.tar.gz
mv linux-amd64/helm /usr/local/bin

#echo "Installing Crossplane" > $MESSAGE_FILE
#kubectl create namespace crossplane-system
#helm repo add crossplane-stable https://charts.crossplane.io/stable
#helm repo upate
#helm install crossplane --namespace crossplane-system crossplane-stable/crossplane
#kubectl wait deployment.apps/crossplane --namespace crossplane-system --for condition=AVAILABLE=True --timeout 1m

echo "done" >> /opt/.backgroundfinished
