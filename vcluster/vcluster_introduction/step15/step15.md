## Quiz 4: vCluster Management

Complete the following tasks:
1. List all running vClusters
2. Connect to the `limited-team` vCluster in the `limited-ns` namespace
3. Create a deployment named `quiz-app` with image `nginx:alpine`
4. Disconnect from the vCluster

### Solution

<details>
<summary>click to see the answer</summary>

Step 1: List all vClusters:

```bash
vcluster list
```{{exec}}

Step 2: Connect to the limited-team vCluster:

```bash
vcluster connect limited-team --namespace limited-ns
```{{exec}}

Step 3: Create a deployment:

```bash
kubectl create deployment quiz-app --image=nginx:alpine
```{{exec}}

Step 4: Disconnect:

```bash
vcluster disconnect
```{{exec}}

</details>