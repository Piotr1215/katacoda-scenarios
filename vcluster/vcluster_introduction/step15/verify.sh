#!/bin/bash

# Check if we're disconnected (not in vCluster context)
# and the deployment was created (would be synced to host)
kubectl config current-context 2>/dev/null | grep -v "vcluster_limited-team" >/dev/null 2>&1 && \
kubectl get deployment -n limited-ns 2>/dev/null | grep -E "quiz-app" >/dev/null 2>&1