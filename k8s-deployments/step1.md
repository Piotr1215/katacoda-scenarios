# Cluster Setup

Run `prepare-cluster.sh`{{execute HOST1}} to start cluster.

Check if nodes are running and ready on the other terminal `kubectl get nodes -w`{{execute HOST2}}

Once nodes are up and running let's check what pods are deployed in *kube-system* namespace: `kubectl get pods -n kube-system`{{execute HOST1}}

Finally let's see what Kubernetes version are we running on:

```
kubectl cluster-info
kubectl version --short
```{{execute HOST1}}

All right, cluster seems to be ready for testing, let's head to *Step2*