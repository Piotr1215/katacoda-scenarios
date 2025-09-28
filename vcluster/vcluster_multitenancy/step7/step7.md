# Step 7: Data Persistence

Disconnect from vCluster:

```bash
vcluster disconnect
```{{exec}}

Check vCluster data storage:

```bash
kubectl exec -n vcluster-dev-team dev-team-0 -c syncer -- ls -lh /data/state.db
```{{exec}}

Create a snapshot:

```bash
vcluster snapshot create dev-team-backup --namespace vcluster-dev-team
```{{exec}}

List snapshots:

```bash
vcluster snapshot list --namespace vcluster-dev-team
```{{exec}}

Export snapshot for backup:

```bash
kubectl get configmap -n vcluster-dev-team dev-team-backup -o yaml > ~/vcluster-workshop/backups/dev-team-backup.yaml
```{{exec}}

## Verification

```bash
[ -f ~/vcluster-workshop/backups/dev-team-backup.yaml ] && echo "SUCCESS: Backup created" || echo "FAILED: Backup not found"
```{{exec}}

## Next Step

Final challenge and cleanup.