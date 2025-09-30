## Quiz 1: Create vCluster with Custom Kubernetes Version

> **💡 Tip**: Both `kubectl` and `vcluster` commands support tab completion. You can also use `k9s` for interactive cluster management.

First, ensure we're not connected to any vCluster and list existing vClusters:

```bash
vcluster disconnect
vcluster list
```{{exec}}

Create a new vCluster with the following requirements:
- Name: `quiz-k8s`
- Namespace: `quiz-ns`
- Kubernetes version: `v1.31.0`
- Do NOT connect to it after creation

### Solution

<details>
<summary>click to see the answer</summary>

First, create the configuration file:

```bash
cat <<EOF > quiz-version.yaml
controlPlane:
  distro:
    k8s:
      enabled: true
      version: "v1.31.0"
EOF
```{{exec}}

Then create the vCluster:

```bash
vcluster create quiz-k8s --namespace quiz-ns -f quiz-version.yaml --connect=false
```{{exec}}

Wait for the vCluster to be ready:

```bash
kubectl wait --for=condition=Ready pod -l app=vcluster -n quiz-ns --timeout=120s
```{{exec}}

</details>