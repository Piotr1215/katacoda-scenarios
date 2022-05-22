☕ background script will perform following tasks:

> IMPORTANT. If any of the steps fails or you see CrashLoopBackOff in the
> kubectl command results, please restart the Killercoda environment.

- start a 2-node Kubernetes cluster
- setup required environmental variables
- install linkerd CLI
- display information about the cluster

> Once all nodes are ready, we can see cluster health information.

Check what pods are deployed in _kube-system_ namespace:

`kubectl get pods -n kube-system`{{execute}}

Let's also make sure that the linkerd CLI was succesfully installed.

`linkerd version`{{execute}}

And check if the cluster is ready for the control plane installation

`linkerd check --pre`{{execute}}

Once all the checks are green, proceed to the next step 👟
