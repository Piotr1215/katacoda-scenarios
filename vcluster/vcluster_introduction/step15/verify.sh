#!/bin/bash

# Check if the quiz-app pod was synced to the host cluster
# The synced pod name will be transformed to quiz-app-<hash>-x-default-x-limited-team
kubectl get pods -n limited-ns 2>/dev/null | grep -E "quiz-app.*x.*limited-team" >/dev/null 2>&1
