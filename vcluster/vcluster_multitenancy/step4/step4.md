# Step 4: Connect and Explore vCluster

Connect to the vCluster:

```bash
vcluster connect my-first-vcluster --namespace vcluster-dev-team
```{{exec}}

Verify connection:

```bash
kubectl config current-context
```{{exec}}

Check namespaces in vCluster:

```bash
kubectl get namespaces
```{{exec}}

Check nodes (virtual):

```bash
kubectl get nodes
```{{exec}}

Deploy a test application:

```bash
kubectl create deployment nginx --image=nginx:alpine
```{{exec}}

```bash
kubectl get pods
```{{exec}}

## Verification

```bash
kubectl get deployment nginx -o jsonpath='{.status.readyReplicas}' | grep -q 1 && echo "SUCCESS: App deployed" || echo "FAILED: App not ready"
```{{exec}}

## Next Step

Next we'll see how vCluster translates resources to the host cluster.
