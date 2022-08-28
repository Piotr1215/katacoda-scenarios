#!/usr/bin/env bash

set -euo pipefail

#Start Kubernetes
curl -sfL https://get.k3s.io | sh - 

echo "Waiting for nodes ready"
k3s kubectl wait node --all --for=condition=Ready --timeout=60s

echo "Setup KUBECONFIG"
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml 
echo "export KUBECONFIG=/etc/rancher/k3s/k3s.yaml" >> ~/.bashrc

echo "done" >> /opt/.clusterstarted

#Installing Helm
wget https://get.helm.sh/helm-v3.4.1-linux-amd64.tar.gz
tar xvf helm-v3.4.1-linux-amd64.tar.gz
mv linux-amd64/helm /usr/local/bin

echo "done" >> /opt/.helminstalled

#Installing Crossplane
kubectl create namespace crossplane-system
helm repo add crossplane-stable https://charts.crossplane.io/stable
helm repo upate
helm install crossplane --namespace crossplane-system crossplane-stable/crossplane
kubectl wait deployment.apps/crossplane --namespace crossplane-system --for condition=AVAILABLE=True --timeout 1m
kubectl wait deployment.apps/coredns --namespace kube-system --for condition=AVAILABLE=True --timeout 1m

echo "done" >> /opt/.crossplaneinstalled

#Installing Crossplane CLI
curl -sL https://raw.githubusercontent.com/crossplane/crossplane/release-1.5/install.sh | sh

echo "done" >> /opt/.crossplanecliinstalled

#Installing Crossplane’s Kubernetes Provider
kubectl apply -f kubernetes-provider.yaml
kubectl wait provider.pkg.crossplane.io/crossplane-provider-kubernetes --for condition=HEALTHY=True --timeout 1m

echo "done" >> /opt/.kubernetesproviderinstalled

#Installing Datree CLI
curl https://get.datree.io | /bin/bash

echo "done" >> /opt/.datreeinstalled

#Installing Octant
wget https://github.com/vmware-tanzu/octant/releases/download/v0.16.3/octant_0.16.3_Linux-64bit.tar.gz
tar -xzvf octant_0.16.3_Linux-64bit.tar.gz
cp ./octant_0.16.3_Linux-64bit/octant /usr/bin/

echo "done" >> /opt/.octantinstalled

#Installing K9s
wget https://github.com/derailed/k9s/releases/download/v0.26.3/k9s_Linux_x86_64.tar.gz
tar -xzvf k9s_Linux_x86_64.tar.gz
cp ./k9s_Linux_x86_64.tar.gz/k9s /usr/bin/

echo "done" >> /opt/.k9sinstalled

octant --listener-addr="0.0.0.0:7777" --disable-open-browser=true --kubeconfig="/etc/rancher/k3s/k3s.yaml" &

echo "done" >> /opt/.backgroundfinished
