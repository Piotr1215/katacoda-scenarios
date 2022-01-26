# Prepare Kubernetes Cluster ☕

A background script will perform following tasks:

- start a 2-node Kubernetes cluster
- cleanup the environment
- setup required environmental variables
- install linkerd CLI
- display information about the cluster

Once all nodes are ready, we can see cluster health information.

Check what pods are deployed in *kube-system* namespace:

`kubectl get pods -n kube-system`{{execute T1 interrupt}}

Let's also make sure that the linkerd CLI was succesfully installed.

`linkerd version`{{execute T1}}

And check if the cluster is ready for the control plane installation

`linkerd check --pre`{{execute T1}}

Once all the checks are green, proceed to the next step.
