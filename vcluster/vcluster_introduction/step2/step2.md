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

Next we will see how to achieve resources isolation using Kubernetes namespaces.
