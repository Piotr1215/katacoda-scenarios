# Cluster Setup

Run `launch.sh`{{execute}} to start cluster.

Once the script finished, check if nodes are running and ready on the other terminal `kubectl get nodes -w`{{execute}}

> Check new Terminal Tab that just opened

Once nodes are up and running let's check what pods are deployed in *kube-system* namespace: `kubectl get pods -n kube-system`{{execute}}

```
kubectl cluster-info
kubectl version --short
```{{execute}}

Finally let's see what Kubernetes version are we running on:

All right, cluster seems to be ready for testing, let's head to *Step2*