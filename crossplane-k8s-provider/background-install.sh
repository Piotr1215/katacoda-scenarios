#!/bin/bash

# Start Kubernetes
echo "Installing k3s Kubernetes Cluster"
curl -sfL https://get.k3s.io | sh -

echo "Waiting for nodes ready"
k3s kubectl wait node --all --for=condition=Ready --timeout=60s
echo "done" >> /opt/.backgroundfinished

