#!/bin/bash

# Start Kubernetes
echo "Starting Kubernetes Cluster"
launch.sh

echo "Waiting for nodes ready"
kubectl wait node --all --for=condition=Ready --timeout=60s
echo "done" >> /opt/.backgroundfinished

