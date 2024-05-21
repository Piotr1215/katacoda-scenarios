In this section we will explore various _vcluster_ components and explain some
on the basic concepts.

> 💡 we can view the resources using octant. Open
> [Octant]({{TRAFFIC_HOST1_7777}})

Let's start by creating a simple deployment inside of the _vcluster_ and see
what resources are created.

```bash
send_command 0 "kubectl apply -f deployment.yaml"
```{{exec}}

This deployment will create a pod with a single container running a sample web
app. We will also expose this deployment using a service of type NodePort.

```bash
send_command 0 "kubectl all --all-namespaces"
```{{exec}}

Now we can check what was synchronized to the host cluster.
Notice that _vcluster didn't create _deployment_. This is because by default
_vcluster_ will only sync workloads and services, configmaps and secrets to the
host cluster.

```bash
send_command 1 "C-c" && send_command 0 "kubectl get svc,deploy,pod -n --all-namespaces"
```{{exec interrupt}}

We have disconnected from _vcluster_ and now can list resources in the host cluster.

> Notice how easy it is to connect and disconnect to and from a virtual cluster

Out pod and service are synchronized to host cluster with _vcluster_ applying naming convention to avoid name collisions.

Now, let's reconnect and keep exploring the virtual cluster in _octant_

```bash
send_command 0 "vcluster connect my-vcluster"
```{{exec interrupt}}
