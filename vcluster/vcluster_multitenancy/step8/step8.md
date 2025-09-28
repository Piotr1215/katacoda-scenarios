# Step 8: Challenge and Cleanup

## Challenge

Create a Partner Team vCluster with pre-populated resources:

```bash
vcluster create partner-team \
  --namespace vcluster-partner-team \
  --values ~/vcluster-workshop/configs/partner-values.yaml \
  --connect=false
```{{exec}}

Connect and verify pre-populated resources:

```bash
vcluster connect partner-team --namespace vcluster-partner-team
```{{exec}}

```bash
kubectl get configmap,secret -n default
```{{exec}}

## Resource Summary

Disconnect and check all vClusters:

```bash
vcluster disconnect
```{{exec}}

```bash
vcluster list
```{{exec}}

Check resource usage across all vClusters:

```bash
kubectl top pods -A | grep vcluster
```{{exec}}

## Cleanup (Optional)

To delete all vClusters:

```bash
vcluster delete dev-team --namespace vcluster-dev-team
vcluster delete prod-team --namespace vcluster-prod-team
vcluster delete partner-team --namespace vcluster-partner-team
vcluster delete my-first-vcluster --namespace vcluster-dev-team
```{{exec}}

## Summary

You've successfully:
- Created multiple vClusters with different configurations
- Tested resource quotas and limits
- Explored resource translation
- Created backups
- Implemented multi-tenancy patterns