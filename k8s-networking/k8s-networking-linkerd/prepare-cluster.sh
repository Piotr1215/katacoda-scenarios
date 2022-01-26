#!/usr/bin/env bash

/usr/bin/launch.sh

until kubectl cluster-info 2&>/dev/null; do
  echo "Waiting for Kubernetes cluster startup..."
  sleep 5
done

kubectl wait node --all --for=condition=Ready --timeout=3m

source <(kubectl completion bash)

echo "source <(kubectl completion bash)" >> ~/.bashrc

complete -F __start_kubectl k

source ~/.bashrc

clear

echo "Cluster is ready! Cluster information:"

kubectl cluster-info
kubectl version --short
kubectl wait node --all --for=condition=Ready --timeout=3m

# Install linkerd
curl --proto '=https' --tlsv1.2 -sSfL https://run.linkerd.io/install | sh

export PATH=$PATH:/root/.linkerd2/bin
