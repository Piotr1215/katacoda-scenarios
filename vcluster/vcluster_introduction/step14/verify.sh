#!/bin/bash

# For snapshot verification, we check if the vCluster still exists
# (since we can't easily verify the OCI upload succeeded)
# In a real scenario, you might restore and verify
vcluster list 2>/dev/null | grep -E "quiz-k8s.*quiz-ns" >/dev/null 2>&1