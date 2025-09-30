## Quiz 3: Upgrade Kubernetes Version

> **💡 Tip**: Both `kubectl` and `vcluster` commands support tab completion. You can also use `k9s` for interactive cluster management.

First, ensure we're not connected to any vCluster and list existing vClusters:

```bash
vcluster disconnect
vcluster list
```{{exec}}

Perform the following tasks:
1. Create a vCluster named `quiz-version` in namespace `quiz-upgrade`
2. Configure it with Kubernetes version `v1.32.0`
3. Wait for the vCluster to be ready
4. Upgrade the Kubernetes version to `v1.33.0`
5. Verify the upgrade succeeded

> **📚 Documentation**: For more details on Kubernetes distribution configuration, see [vCluster K8s Distribution](https://www.vcluster.com/docs/vcluster/configure/vcluster-yaml/control-plane/distro/k8s)

### Solution

<details>
<summary>click to see the answer</summary>

Create the configuration file with Kubernetes v1.32.0:

```bash
cat <<EOF > quiz-k8s-132.yaml
controlPlane:
  distro:
    k8s:
      enabled: true
      version: v1.32.0
EOF
```{{exec}}

Create the vCluster:

```bash
vcluster create quiz-version --namespace quiz-upgrade -f quiz-k8s-132.yaml --connect=false
```{{exec}}

Wait for the vCluster to be ready:

```bash
kubectl wait --for=condition=Ready pod -l app=vcluster -n quiz-upgrade --timeout=120s
```{{exec}}

Create the upgrade configuration file with Kubernetes v1.33.0:

```bash
cat <<EOF > quiz-k8s-133.yaml
controlPlane:
  distro:
    k8s:
      enabled: true
      version: v1.33.0
EOF
```{{exec}}

Upgrade the vCluster:

```bash
vcluster create quiz-version --namespace quiz-upgrade -f quiz-k8s-133.yaml --connect=false --upgrade
```{{exec}}

Wait for the upgrade to complete:

```bash
sleep 10 && kubectl wait --for=condition=Ready pod -l app=vcluster -n quiz-upgrade --timeout=120s
```{{exec}}

</details>