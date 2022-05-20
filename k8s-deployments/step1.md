# Prepare Kubernetes Cluster

Run `launch.sh`{{execute}} to start cluster.

Now we need to make sure that additional Kubernetes node: *node01* has the same *kubeconfig* configuration so we can execute commands on this node as well.
To achieve this we will use `scp` to copy over content of the *.kube* directory including Kubernetes *config* file
`scp -pr .kube root@node01:/root/.kube`{{execute}}

Check if nodes are running and ready on the other terminal `kubectl wait node --all --for=condition=Ready --timeout=3m`{{execute}}

> *wait*, it establishes a wait handle on the command and periodically refreshes the output.

Expected command output. Run command one more time if you cannot see the output below.

```
node/controlplane condition met
node/node01 condition met
```

Once all nodes are ready, we can see if all pods are in running status.

Once nodes are up and running let's check what pods are deployed in *kube-system* namespace: `kubectl get pods -n kube-system`{{execute interrupt}}

Last thing, let's create a useful alias for `kubectl` also on the cluster node `alias k=kubectl`{{execute}}

Finally let's see what Kubernetes version are we running on:

```
kubectl cluster-info
kubectl version --short
```{{execute}}

All right, cluster seems to be ready for testing, let's head to *Step2*
