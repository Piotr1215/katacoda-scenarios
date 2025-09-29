## vCluster State Management

> vCluster stores all state in a single database (SQLite or etcd)

A vCluster snapshot includes:
- Backing store data (etcd or SQLite)
- vCluster Helm release information
- vCluster configuration (vcluster.yaml)

### Create Snapshot

```bash
# Snapshot to ephemeral docker image registry (ttl.sh)
vcluster snapshot admin "oci://ttl.sh/vcluster-admin:1h"
```{{exec}}

> **Note**: ttl.sh is a free ephemeral registry where images expire after the specified time (1h = 1 hour)

### Supported Snapshot Protocols

| Protocol | Storage Type | Example |
|----------|-------------|---------|
| `oci` | Container registries | `oci://ghcr.io/user/repo:tag` |
| `s3` | S3-compatible buckets | `s3://bucket/key` |
| `container` | Local PVC | `container:///data/backup.tar.gz` |

### Simulate Disaster Recovery

```bash
# Delete the vCluster to simulate disaster
vcluster delete admin --delete-namespace
```{{exec}}

### Restore from Snapshot

```bash
# Create new vCluster from snapshot (namespace is auto-created)
vcluster create admin --namespace admin-team --restore "oci://ttl.sh/vcluster-admin:1h"
```{{exec}}

### Verify Restoration

```bash
# Connect and check restored state
vcluster connect admin
kubectl get ns
```{{exec}}

> **Key Points:**
> - Snapshots do NOT include PVs/PVCs
> - Works with both embedded (SQLite/etcd) and external databases
> - Can be used to clone vClusters or migrate configurations