## Quiz 1: Create vCluster with Custom Kubernetes Version

First, list existing vClusters:

```bash
vcluster list
```{{exec}}

Create a new vCluster with the following requirements:
- Name: `quiz-k8s`
- Namespace: `quiz-ns`
- Kubernetes version: `v1.29.0`
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
      version: "v1.29.0"
EOF
```{{exec}}

Then create the vCluster:

```bash
vcluster create quiz-k8s --namespace quiz-ns -f quiz-version.yaml --connect=false
```{{exec}}

</details>