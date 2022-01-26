# Prepare Kubernetes Cluster ☕

A background script will perform following tasks:

- start a 2-node Kubernetes cluster
- cleanup the environment
- setup required environmental variables
- install linkerd CLI
- display information about the cluster

Once all nodes are ready, we can see cluster health information.

Once nodes are up and running we can check what pods are deployed in *kube-system* namespace:

`kubectl get pods -n kube-system`{{execute T1 interrupt}}

Let's also make sure that the linkerd CLI was succesfully installed:

`linkerd check`{{execute T1}}
