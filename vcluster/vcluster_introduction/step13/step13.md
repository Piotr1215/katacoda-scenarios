## Quiz 2: Create vCluster with Resource Quotas

Create a new vCluster with the following requirements:
- Name: `limited-team`
- Namespace: `limited-ns`
- Resource limits:
  - Maximum 4 CPUs
  - Maximum 8Gi memory
  - Maximum 15 pods
- Do NOT connect after creation

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