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
send_command 1 "kubectl get all --all-namespaces"
```{{exec}}

We can access the web page as we normally would in a regular Kubernetes cluster.

```bash
send_command 1 "kubectl -n team-b port-forward --address 0.0.0.0 svc/test-service 31234:80 > /dev/null &"
```{{exec}}

> Now we can access the web page by clicking on the link below.
> [nginx sample app]({{TRAFFIC_HOST1_31234}})

Let's check what was synchronized to the host cluster.
Notice that _vcluster didn't create _deployment_. This is because by default
_vcluster_ will only sync workloads and services, configmaps and secrets to the
host cluster.

```bash
send_command 0 "C-c" && send_command 1 "kubectl get all --all-namespaces"
```{{exec interrupt}}

We have disconnected from _vcluster_ and now can list resources in the host cluster.

> Notice how easy it is to connect and disconnect to and from a virtual cluster

Our pod and service are synchronized to host cluster with _vcluster_ applying naming convention to avoid name collisions.

### Data storage

Vcluster by default stores data in a _sqlite_ database. This database is stored
directly in the _vcluster_ pod. A key _vcluster_ component called _syncer_ is
responsible for syncing the resources between the virtual and host clusters.

First let's copy the database file from the _vcluster_ to the current folder.

```bash
send_command 1 "kubectl cp test-namespace/my-vcluster-0:/data/server/db/state.db ./state.db -c syncer "
```{{exec}}

All the interesting data is stored in the _state.db_ file. We can use _sqlite3_
to retrieve all data that _vcluster_ stores.

```bash
send_command 1 "sqlite3 state.db \"SELECT * FROM kine WHERE name LIKE '%nginx%';\""
```{{exec}}

Here we can find our nginx pod and service and other data synchronized by _vcluster_.

## Next Step

Next we will see how well you have mastered the _vcluster_ CLI by running some
test scenarios.
