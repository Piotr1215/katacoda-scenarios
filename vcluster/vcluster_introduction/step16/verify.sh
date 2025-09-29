#!/bin/bash

# Check if quiz-prepop vCluster exists and contains the expected ConfigMap
vcluster list 2>/dev/null | grep -E "quiz-prepop.*quiz-final.*Running" >/dev/null 2>&1 && \
vcluster connect quiz-prepop --namespace quiz-final -- kubectl get configmap quiz-config -o jsonpath='{.data.environment}' 2>/dev/null | grep -q "production"