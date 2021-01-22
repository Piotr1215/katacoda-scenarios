# Cluster Setup

Run `launch.sh`{{execute T1}} to start cluster.

Now we need to make sure that additional Kubernetes node: *node01* has the same *kubeconfig* configuration so we can execute commands on this node as well.
To achieve this we will use `scp` to copy over content of the *.kube* directory including Kubernetes *config* file
`scp -pr .kube root@node01:/root/.kube`{{execute T1}}

Check if nodes are running and ready on the other terminal `kubectl get nodes -w`{{execute T2}}

> The *-w* parameter is shorthand for *-wait*, it establishes a wait handle on the command and periodically refreshes the output.

Once all nodes are ready, we can see if all pods are in ready status.

Once nodes are up and running let's check what pods are deployed in *kube-system* namespace: `kubectl get pods -n kube-system`{{execute T2 interrupt}}

Finally let's see what Kubernetes version are we running on:

```
kubectl cluster-info
kubectl version --short
```{{execute}}

All right, cluster seems to be ready for testing, let's head to *Step2*
