## Quiz 2: Create vCluster with Resource Quotas

First, clean up the previous quiz vCluster:

```bash
vcluster delete quiz-k8s --delete-namespace
```{{exec}}

Create a new vCluster with the following requirements:
- Name: `limited-team`
- Namespace: `limited-ns`
- Resource limits:
  - Maximum 4 CPUs
  - Maximum 8Gi memory
  - Maximum 15 pods
- Do NOT connect after creation

> **📚 Documentation**: For more details on resource quota configuration, see [vCluster Resource Quota Policies](https://www.vcluster.com/docs/vcluster/configure/vcluster-yaml/policies/resource-quota)

### Solution

<details>
<summary>click to see the answer</summary>

First, create the configuration file with resource quotas:

```bash
cat <<EOF > quiz-limits.yaml
policies:
  resourceQuota:
    enabled: true
    quota:
      cpu: "4"
      memory: 8Gi
      pods: "15"
EOF
```{{exec}}

Then create the vCluster:

```bash
vcluster create limited-team --namespace limited-ns -f quiz-limits.yaml --connect=false
```{{exec}}

</details>