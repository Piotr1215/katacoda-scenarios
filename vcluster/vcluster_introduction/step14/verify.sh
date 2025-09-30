#!/bin/bash

# Verify that the vCluster has been upgraded to Kubernetes v1.33.0
# Check the kubernetes init container image version
kubectl get pod quiz-version-0 -n quiz-upgrade -o jsonpath='{.spec.initContainers[?(@.name=="kubernetes")].image}' 2>/dev/null | grep -q "v1.33.0"
