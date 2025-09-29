## Introduction

Before we start exploring _vcluster_, let's understand what it is and what benefits it provides.

> Definition: Virtual clusters are fully functional Kubernetes clusters nested inside a physical host cluster providing better isolation and flexibility to support multi-tenancy. Multiple teams can operate independently within the same physical infrastructure while minimizing conflicts, maximizing autonomy, and reducing costs.

source: https://www.vcluster.com/docs

What are the main benefits of using _vcluster_?

![vcluster_mindmap](http://www.plantuml.com/plantuml/proxy?cache=yes&src=https://raw.githubusercontent.com/Piotr1215/cloudrumble/master/diagrams/vcluster_mindmap.puml&fmt=png)

### vCluster Architecture

The architecture of _vcluster_ is very interesting. The central piece is the
_syncer_ component that is responsible for syncing resources between the virtual
and host clusters. 

<details>
<summary>vCluster components</summary>
<img src="http://www.plantuml.com/plantuml/proxy?cache=yes&src=https://raw.githubusercontent.com/Piotr1215/cloudrumble/master/diagrams/vcluster-components.puml&fmt=png" alt="vcluster">
<sub>source: author based on https://www.vcluster.com/docs/vcluster/architecture/</sub>
</details>

<details>
<summary>vCluster overview diagram</summary>

![vCluster Overview](./assets/vcluster-flowchart.png)

| **Feature**             | **Benefit**                               |
| ----------------------- | ----------------------------------------- |
| Full Kubernetes API     | Certified Kubernetes distribution         |
| Flexible isolation      | Separate control plane per team           |
| Resource efficiency     | Shared infrastructure, isolated workloads |
| Sub-minute provisioning | Instant test/dev/ci environments          |

> **vCluster** = Containerized Kubernetes inside a Pod!

</details>

## Next Step

Next we will install _vcluster_.
> 💡 Before proceeding with the installation steps, wait for the environment to be ready.

There are 3 ways to install _vcluster_:

- using the CLI
- via Helm chart
- with _kubectl_ applying the manifest directly

We will use the CIL as it provides a few handy features we will use.
Download the latest _vcluster_ CLI.

> 👇🖱️Clicking on grayed command like below will execute the command in the terminal.

```bash
curl -L -o vcluster "https://github.com/loft-sh/vcluster/releases/latest/download/vcluster-linux-amd64" \
    && sudo install -c -m 0755 vcluster /usr/local/bin \
    && rm -f vcluster
```{{exec}}

## Post Installation

Verify the installation by running the following command:

```bash
vcluster version
```{{exec}}

Check all available commands:

```bash
vcluster --help
```{{exec}}

Generate autocompletion scripts:

```bash
echo $SHELL
```{{exec}}

```bash
vcluster completion bash > /etc/bash_completion.d/vcluster
source ~/.bashrc
```{{exec}}

## Next Step

Next we will see how to achieve resources isolation using Kubernetes namespaces.
Let's imagine a scenario where we have multiple teams working on the same
Kubernetes cluster. Each team should be able to operate independently without
affecting other teams. One obvious way to achieve this is to use namespace.

Here is how this could look like in practice:

### Set up a namespace for team-a

```bash
kubectl create namespace team-a
```{{exec}}

### Create a user for the `team-a` namespace.

```yaml
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: ServiceAccount
metadata:
  name: test-user-a
  namespace: team-a
---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: team-a
  name: my-role
rules:
- apiGroups: [""]
  resources: ["pods", "services", "deployments"]
  verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: my-rolebinding
  namespace: team-a
subjects:
- kind: ServiceAccount
  name: test-user-a
  namespace: team-a
roleRef:
  kind: Role
  name: my-role
  apiGroup: rbac.authorization.k8s.io
EOF
```{{exec}}

### Attempt to perform a cluster-scoped operation within a namespace and observe the failure.

```bash
kubectl auth can-i get nodes --as test-user-a
```{{exec}}

> 🚨 This would mean that we have to create, manage and maintain a Role and
RoleBinding for each user in each namespace. This can be cumbersome and
error-prone. This is where `vcluster` can help.

## Next Step

Next, we will create a new _vcluster_
Creating a new vcluster is easy using the `vcluster create` command. The command
takes the name of the vcluster and an optional namespace.

> 💡 we can view the resources using octant or k9s. Open
> [Octant]({{TRAFFIC_HOST1_7777}}) or new tab with k9s.

We are going to use _tmux_ since _vcluster_ CLI will automatically switch to the
new cluster. In the other pane, we can interact with the new virtual cluster.

`start_tmux.sh`{{exec}}

```bash
send_command 0 "vcluster create my-vcluster --namespace test-namespace"
```{{exec}}

Now we can check all the resources in our new vcluster.

```bash
send_command 1 "vcluster list"
```{{exec}}

```bash
send_command 1 "kubectl get all --all-namespaces"
```{{exec}}

## Next Step

Next we will explore the _vcluster_ components and see how resources are
created, shared and synchronized

In this section we will explore various _vcluster_ components and explain some
on the basic concepts.

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
Notice that _vcluster_ didn't create _deployment_. This is because by default
_vcluster_ will only sync workloads and services, configmaps and secrets to the
host cluster.

```bash
send_command 0 "C-c" && send_command 1 "kubectl get all --all-namespaces"
```{{exec interrupt}}

```bash
vcluster disconnect
```{{exec}}

We have disconnected from _vcluster_ and now can list resources in the host cluster.

> Notice how easy it is to connect and disconnect to and from a virtual cluster

Our pod and service are synchronized to host cluster with _vcluster_ applying naming convention to avoid name collisions.


## Next Step

Next we will see how vcluster stores data.
## Data storage

Vcluster by default stores data in a _sqlite_ database. This database is stored
directly in the _vcluster_ pod. A key _vcluster_ component called _syncer_ is
responsible for syncing the resources between the virtual and host clusters.

First let's copy the database file from the _vcluster_ to the current folder.

```bash
kubectl cp test-namespace/my-vcluster-0:/data/state.db ./state.db -c syncer
```{{exec}}

All the interesting data is stored in the _state.db_ file. We can use _sqlite3_
to retrieve all data that _vcluster_ stores.

```bash
sqlite3 state.db "SELECT * FROM kine WHERE name LIKE '%nginx%';"
```{{exec}}

Here we can find our nginx pod and service and other data synchronized by _vcluster_.

## Next Step

Next we will see how well you have mastered the _vcluster_ CLI by running some
test scenarios.
The Frontend team needs a specific Kubernetes version. Let's create a new virtual cluster for them with the required version.

```bash
cat <<EOF > vcluster-frontend.yaml
sync:
  toHost:
    endpoints:
      enabled: false
controlPlane:
  distro:
    k8s:
      enabled: true
      version: "v1.28.0"
EOF
```{{exec}}

```bash
vcluster create frontend --namespace frontend-team -f vcluster-frontend.yaml --connect=false
```{{exec}}

Check our host cluster versin first:

```bash
kubectl version
```{{exec}}

Now let's connect to the `frontend` virtual cluster and check the version:

```bash
vcluster connect frontend
kubectl version
```{{exec}}

## Next Step

```bash
vcluster disconnect
vcluster delete frontend
```{{exec}}

Next we will see what the backend team needs and create a virtual cluster for them.
The Backend team needs newer Kubernetes version and resource quotas. 

```bash
cat <<EOF > vcluster-backend.yaml
controlPlane:
  distro:
    k8s:
      enabled: true
      version: "v1.29.0"
policies:
  resourceQuota:
    enabled: true
    quota:
      cpu: "10"
      memory: 2Gi
      pods: "10"
EOF
```{{exec}}

```bash
vcluster create backend --namespace backend-team -f vcluster-backend.yaml --connect=false
```{{exec}}

This creates a `ResourceQuota` resource on our host cluster. 

```bash
k describe resourcequota vc-backend -n backend-team
```{{exec}}

> Now we are sure that the backend team will not consume more resources than allowed.

## Next Step

```bash
vcluster disconnect
vcluster delete backend
```{{exec}}

Next we will see what the admin team needs and create a virtual cluster for them.
The admin team needs access to underlying Kubernetes nodes and they need more lightweight Kubernetes distribution. 

> By default, vcluster only syncs _pseudo-nodes_ to virtual cluster.

```bash
cat <<EOF > vcluster-admin.yaml
controlPlane:
  distro:
    k3s:
      enabled: true
sync:
  fromHost:
    nodes:
      enabled: true
EOF
```{{exec}}

```bash
vcluster create admin --namespace admin-team -f vcluster-admin.yaml --connect=false
```{{exec}}

Now we should see the actual nodes synced to the virtual cluster as well as `k3s` distribution.

```bash
vcluster connect admin
kubectl version
kubectl get nodes
```{{exec}}

## Next Step

```bash
vcluster disconnect
vcluster delete admin
```{{exec}}

Next we will see what the admin team needs and create a virtual cluster for them.
All Teams need to have virtual clusters with pre-populated resources. 

```bash
cat <<EOF > vcluster-base.yaml
controlPlane:
  distro:
    k8s:
      enabled: true
      version: "v1.30.0"
experimental:
  deploy:
    vcluster:
      manifests: |-
        apiVersion: v1
        kind: ConfigMap
        metadata:
          name: vcluster-test-config
        data:
          TEST_KEY: "test_value"
        ---
        apiVersion: v1
        kind: Secret
        metadata:
          name: vcluster-test-secret
        type: Opaque
        stringData:
          test-credential: "test123"
EOF
```{{exec}}

```bash
vcluster create base --namespace base-ns -f vcluster-base.yaml --connect=false
```{{exec}}

Now we should see the actula nodes synced to the virtual cluster.

```bash
vcluster connect base
k get secrets,cm -n default
```{{exec}}

## Next Step

```bash
vcluster disconnect
vcluster delete base
```{{exec}}


Next we will see how to sync generic resources to the virtual cluster.
We can sync resources from the host cluster and make them available in the virtual cluster. 

First let's install `cert manager` on the host cluster.

```bash
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.16.1/cert-manager.yaml
kubectl wait --for=condition=Ready pods --all --namespace cert-manager --timeout=300s
```{{exec}}

```bash
cat <<EOF > vcluster-cert-manager.yaml
controlPlane:
  distro:
    k8s:
      enabled: true
      version: "v1.30.0"
experimental:
  multiNamespaceMode:
    enabled: true

  genericSync:
    role:
      extraRules:
        - apiGroups: ["cert-manager.io"]
          resources: ["issuers", "certificates"]
          verbs: ["create", "delete", "patch", "update", "get", "list", "watch"]
    clusterRole:
      extraRules:
        - apiGroups: ["apiextensions.k8s.io"]
          resources: ["customresourcedefinitions"]
          verbs: ["get", "list", "watch"]
    export:
      - apiVersion: cert-manager.io/v1
        kind: Issuer
      - apiVersion: cert-manager.io/v1
        kind: Certificate
    import:
      - kind: Secret
        apiVersion: v1
EOF
```{{exec}}

```bash
vcluster create v-cert-manager -f vcluster-cert-manager.yaml --connect=true
```{{exec}}

Now let's create `Issuer` and `Certificate` resources on the virtual cluster.

```bash
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Namespace
metadata:
  name: cert-manager-test
---
apiVersion: cert-manager.io/v1
kind: Issuer
metadata:
  name: test-selfsigned
  namespace: cert-manager-test
spec:
  selfSigned: {}
---
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: selfsigned-cert
  namespace: cert-manager-test
spec:
  dnsNames:
    - example.com
  secretName: selfsigned-cert-tls
  issuerRef:
    name: test-selfsigned
EOF
```{{exec}}

> Notice we didn't need to install `cert manager` on the virtual cluster. We just synced the resources from the host cluster.

```bash
kubectl get Issuer,Certificate -n cert-manager-test
```{{exec}}


## Next Step

```bash
vcluster disconnect v-cert-manager
vcluster delete v-cert-manager
```{{exec}}


Check your knowkedgde by taking a short quiz.

Create a new vcluster named `new-vcluster` in the `new-namespace` namespace.
Make sure not to connect to the `vcluster` after creating it.

### Solution

<details>
<summary>click to see the answer</summary>

`vcluster create new-vcluster --namespace new-namespace --connect=false`{{exec}}

</details>
Try to implement the following on your own:

- [Isolated workloads](https://www.vcluster.com/docs/vcluster/deploy/topologies/isolated-workloads)
- [Multi-Namespace Mode](https://www.vcluster.com/docs/vcluster/deploy/topologies/multi-namespace-mode)

## Platform Overview

Helps manage virtual clusters across multiple teams and namespaces.

```bash
vcluster platform start --password=admin123
```{{exec}}

Let's add the virtual cluster to the platform and watch the resources in the `test-namespace`.

```bash
kubectl get pods -n test-namespace
```{{exec}}


Reconnect to the vcluster created first, `my-vcluster`, in the `test-namespace` namespace.

### Solution

<details>
<summary>click to see the answer</summary>

`vcluster connect my-vcluster`{{exec}}

</details>

## Next Step

This is the end of the workshop! Feel free to experiment with the
_vcluster_ and explore the different commands available in the CLI.
Now that you have learned and experimented with _vcluster_, head over to the official [vcluster website](https://www.vcluster.com/) where you can dive deeper into its features and capabilities. You can also try out _vcluster_ in your own environment by following the detailed documentation provided.

## Additional Resources

- Read the [vcluster Documentation](https://www.vcluster.com/docs) to learn more about installation, configuration, and use cases.
- Explore the [vcluster GitHub repository](https://github.com/loft-sh/vcluster) to see the source code, report issues, and contribute to the project.
- Watch the [vCluster Tips Playlist](https://www.youtube.com/playlist?list=PL8MSvTvMDqe5oj7aYx9A3W74ef2n1Xrgh) for some inspiration on what can be done with virtual clusters.
- Check out the [vcluster Helm Chart](https://artifacthub.io/packages/helm/loft/vcluster) on Artifact Hub for easy installation.

## Community

If you have any questions regarding _vcluster_, join the [vcluster Slack channel](https://loft-sh.slack.com) to interact with the community and get support from the developers.

Feel free to explore these resources and try out _vcluster_ in your Kubernetes environment! 
