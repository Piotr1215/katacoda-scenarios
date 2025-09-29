#!/bin/bash

# Verify that the container snapshot was created successfully
# Check if /data/backup.tar.gz exists in the vCluster pod
kubectl exec -n limited-ns limited-team-0 -c syncer -- test -f /data/backup.tar.gz 2>/dev/null
