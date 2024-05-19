In this section we will explore various _vcluster_ components and explain some
on the basic concepts.

> 💡 we can view the resources using octant. Open
> [Octant]({{TRAFFIC_HOST1_7777}})

Let's start by creating a simple deployment inside of the _vcluster_ and see
what resources are created.

```bash
send_command 1 "kubectl apply -f deployment.yaml"
```{{exec}}

This deployment will create a pod with a single container running a sample web
app. We will also expose this deployment using a service of type NodePort.

```bash
send_command 1 "kubectl get svc,deploy,pod"
```{{exec}}

Now we can check what was synchronized to the host cluster.
Notice that _vcluster didn't create _deployment_. This is because by default
_vcluster_ will only sync workloads and services, configmaps and secrets to the
host cluster.

```bash
send_command 1 "vcluster disconnect my-vcluster && kubectl get svc,deploy,pod -n test-namespace"
```{{exec interrupt}}

Here we can see the resources created by the _vcluster_ in the host cluster.

> ℹ️ feel free to explore the resources using octant.
