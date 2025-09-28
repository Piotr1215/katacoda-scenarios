# Step 3: Create Your First vCluster

Create a vCluster named 'my-first-vcluster' in the dev-team namespace:

```bash
vcluster create my-first-vcluster \
  --namespace vcluster-dev-team \
  --connect=false
```{{exec}}

Wait for the vCluster to be ready:

```bash
kubectl wait --for=condition=ready pod -l app=vcluster -n vcluster-dev-team --timeout=300s
```{{exec}}

Verify the vCluster was created:

```bash
vcluster list
```{{exec}}

Check the pods created for vCluster:

```bash
kubectl get pods -n vcluster-dev-team
```{{exec}}

## Verification

Run this verification to ensure vCluster is ready:

```bash
kubectl get statefulset -n vcluster-dev-team -o jsonpath='{.items[0].status.readyReplicas}' | grep -q 1 && echo "SUCCESS: vCluster is running" || echo "FAILED: vCluster not ready"
```{{exec}}

## Next Step

The vCluster is now running. Next, we'll connect to it and explore the isolated environment.