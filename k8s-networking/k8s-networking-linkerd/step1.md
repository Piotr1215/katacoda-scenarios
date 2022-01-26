# Prepare Kubernetes Cluster :coffee:

A background script will perform following tasks:

- start a 2-node Kubernetes cluster
- cleanup the environment
- setup required environmental variables
- install linkerd CLI
- display information about the cluster

Once all nodes are ready, we can see if all pods are in running status.

Once nodes are up and running let's check what pods are deployed in *kube-system* namespace: `kubectl get pods -n kube-system`{{execute T1 interrupt}}
