#!/bin/bash

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