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

Now we can check what was synchronized to the host cluster.
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
to write data to a file using a simple script.

```bash
send_command 1 "get_json"
```{{exec}}

> ⚠️ this command take take a moment to execute

Here we can find our nginx pod and service.

```bash
send_command 1 "jq '.' ./filtered_output.json"
```{{exec}}

### Reconnect to vcluster

Now, let's reconnect and keep exploring the virtual cluster in _octant_

```bash
send_command 0 "vcluster connect my-vcluster"
```{{exec interrupt}}


