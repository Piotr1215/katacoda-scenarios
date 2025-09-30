## Quiz 5: Create vCluster with Pre-populated Resources

> **💡 Tip**: Both `kubectl` and `vcluster` commands support tab completion. You can also use `k9s` for interactive cluster management.

First, ensure we're not connected to any vCluster and list existing vClusters:

```bash
vcluster disconnect
vcluster list
```{{exec}}

Create a vCluster with the following requirements:
- Name: `quiz-prepop`
- Namespace: `quiz-final`
- Pre-populate with:
  - A ConfigMap named `quiz-config` with key `environment` = `production`
  - A Secret named `quiz-secret` with key `api-key` = `secret123`
- Do NOT connect after creation

### Solution

<details>
<summary>click to see the answer</summary>

Create the configuration file with pre-populated resources:

```bash
cat <<EOF > quiz-prepop.yaml
experimental:
  deploy:
    vcluster:
      manifests: |-
        apiVersion: v1
        kind: ConfigMap
        metadata:
          name: quiz-config
        data:
          environment: "production"
        ---
        apiVersion: v1
        kind: Secret
        metadata:
          name: quiz-secret
        type: Opaque
        stringData:
          api-key: "secret123"
EOF
```{{exec}}

Create the vCluster:

```bash
vcluster create quiz-prepop --namespace quiz-final -f quiz-prepop.yaml --connect=false
```{{exec}}

Wait for the vCluster to be ready:

```bash
kubectl wait --for=condition=Ready pod -l app=vcluster -n quiz-final --timeout=120s
```{{exec}}

</details>

## Congratulations! 🎉

You've completed all the vCluster workshop quizzes! You now know how to:
- Create vClusters with custom configurations
- Set resource limits and quotas
- Take snapshots for backup
- Manage multiple vClusters
- Pre-populate resources for teams

Feel free to explore more advanced vCluster features at [vcluster.com](https://www.vcluster.com/docs)
