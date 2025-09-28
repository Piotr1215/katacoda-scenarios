# Step 5: Multi-Tenancy Setup

Create Dev Team vCluster with resource limits:

```bash
vcluster create dev-team \
  --namespace vcluster-dev-team \
  --values ~/vcluster-workshop/configs/dev-values.yaml \
  --connect=false
```{{exec}}

Create Production Team vCluster:

```bash
vcluster create prod-team \
  --namespace vcluster-prod-team \
  --values ~/vcluster-workshop/configs/prod-values.yaml \
  --connect=false
```{{exec}}

Wait for both to be ready:

```bash
kubectl wait --for=condition=ready pod -l app=vcluster --all-namespaces --timeout=300s
```{{exec}}

List all vClusters:

```bash
vcluster list
```{{exec}}

## Verification

```bash
[ $(vcluster list --output json | jq '. | length') -ge 3 ] && echo "SUCCESS: Multiple vClusters running" || echo "FAILED: Not all vClusters ready"
```{{exec}}

## Next Step

Test resource quotas and limits.