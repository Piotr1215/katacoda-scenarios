## Quiz 4: vCluster Management

> **💡 Tip**: Both `kubectl` and `vcluster` commands support tab completion. You can also use `k9s` for interactive cluster management.

First, ensure we're not connected to any vCluster and list existing vClusters:

```bash
vcluster disconnect
vcluster list
```{{exec}}

Clean up the previous quiz vCluster:

```bash
vcluster delete quiz-version --delete-namespace
```{{exec}}

Complete the following tasks:
1. Create a vCluster named `quiz-mgmt` in namespace `quiz-mgmt-ns`
2. Connect to the vCluster
3. Create a deployment named `quiz-app` with image `nginx:alpine`
4. Verify the deployment was created
5. Disconnect from the vCluster
6. Clean up the vCluster

### Solution

<details>
<summary>click to see the answer</summary>

Step 1: Create the vCluster:

```bash
vcluster create quiz-mgmt --namespace quiz-mgmt-ns --connect=false
```{{exec}}

Wait for the vCluster to be ready:

```bash
kubectl wait --for=condition=Ready pod -l app=vcluster -n quiz-mgmt-ns --timeout=120s
```{{exec}}

Step 2: Connect to the vCluster:

```bash
vcluster connect quiz-mgmt --namespace quiz-mgmt-ns
```{{exec}}

Step 3: Create a deployment:

```bash
kubectl create deployment quiz-app --image=nginx:alpine
```{{exec}}

Step 4: Verify the deployment was created:

```bash
kubectl get deployments
```{{exec}}

Step 5: Disconnect:

```bash
vcluster disconnect
```{{exec}}

Step 6: Clean up the vCluster:

```bash
vcluster delete quiz-mgmt --delete-namespace
```{{exec}}

</details>
