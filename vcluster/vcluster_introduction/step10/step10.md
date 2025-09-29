# vCluster Snapshots

vCluster stores all state in a single SQLite database, making backup and restore operations straightforward.

## Understanding vCluster State Storage

All vCluster state is contained in `/data/state.db` - a single SQLite database file:

```bash
vcluster connect admin
kubectl exec -n admin-team admin-0 -c syncer -- ls -lh /data/state.db
```{{exec}}

This simplicity enables multiple backup strategies for disaster recovery and migration.

## Create a Test Deployment

First, let's create some resources to backup:

```bash
kubectl create namespace backup-test
kubectl create deployment nginx --image=nginx:alpine -n backup-test --replicas=2
kubectl create configmap test-config --from-literal=env=production -n backup-test
```{{exec}}

Verify the resources:

```bash
kubectl get all,cm -n backup-test
```{{exec}}

## Snapshot to OCI Registry

vCluster can snapshot directly to OCI-compliant registries. We'll use ttl.sh (ephemeral registry) for this demo:

```bash
vcluster disconnect
vcluster snapshot admin "oci://ttl.sh/vcluster-admin-backup:1h"
```{{exec}}

> **ttl.sh**: Free ephemeral Docker registry where images expire after specified time (1h = 1 hour)

The snapshot is now stored as an OCI artifact and can be pulled from any location.

## Delete and Recreate vCluster

Let's simulate a disaster recovery scenario:

```bash
vcluster delete admin --delete-namespace
```{{exec}}

Create a new namespace for restoration:

```bash
kubectl create namespace admin-restored
```{{exec}}

## Restore from Snapshot

Restore the vCluster from the OCI snapshot:

```bash
vcluster create admin-restored --namespace admin-restored \
  --restore "oci://ttl.sh/vcluster-admin-backup:1h" \
  --connect=false
```{{exec}}

Wait for restoration to complete:

```bash
kubectl wait --for=condition=ready pod -l app=vcluster -n admin-restored --timeout=60s
```{{exec}}

## Verify Restored State

Connect to the restored vCluster and check if our resources are present:

```bash
vcluster connect admin-restored
kubectl get all,cm -n backup-test
```{{exec}}

All resources should be restored exactly as they were before the backup!

## Alternative Backup Methods

### Direct SQLite Backup

Copy the database file directly:

```bash
kubectl cp admin-restored/admin-restored-0:/data/state.db ./backup-state.db -c syncer
ls -lh backup-state.db
```{{exec}}

### Snapshot to S3

For production use, snapshot to S3:

```bash
# Example (requires AWS credentials)
# vcluster snapshot admin "s3://my-bucket/vcluster-backups/admin-$(date +%Y%m%d-%H%M%S).db"
```

### Platform API Backups (Pro)

vCluster Pro provides automated scheduled backups through the platform API.

### Volume Snapshots

Use your cloud provider's volume snapshot capabilities for the PVC containing `/data`.

## Backup Best Practices

1. **Regular Snapshots**: Schedule automated backups based on your RPO requirements
2. **Test Restores**: Regularly verify backup integrity by performing test restores
3. **Multiple Locations**: Store backups in different locations (OCI, S3, local)
4. **Retention Policy**: Define how long to keep backups based on compliance needs

## Next Step

```bash
vcluster disconnect
```{{exec}}

Next we'll configure pre-populated resources for all teams.