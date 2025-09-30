#!/bin/bash

# Check if the quiz-app pod was synced to the host cluster
# The synced pod name will be transformed to quiz-app-<hash>-x-default-x-quiz-mgmt
kubectl get pods -n quiz-mgmt-ns 2>/dev/null | grep -E "quiz-app.*x.*quiz-mgmt" >/dev/null 2>&1
