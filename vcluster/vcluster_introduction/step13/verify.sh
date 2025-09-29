#!/bin/bash

# Check if limited-team vCluster exists and has resource quota
kubectl get resourcequota vc-limited-team -n limited-ns >/dev/null 2>&1 && \
vcluster list 2>/dev/null | grep -E "limited-team.*limited-ns" >/dev/null 2>&1