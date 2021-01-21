# Cluster Setup

Run `prepare-cluster.sh`{{execute T1}} to start cluster.

Once the script finished, check if nodes are running and ready on the other terminal `kubectl get nodes -w`{{execute T2}}

> Check new Terminal Tab that just opened

Once nodes are up and running let's check what pods are deployed in *kube-system* namespace: `kubectl get pods -n kube-system`{{execute T1}}

Finally let's see what Kubernetes version are we running on:

All right, cluster seems to be ready for testing, let's head to *Step2*