## vCluster State Management

> vCluster stores all state in a single database (SQLite or etcd)

A vCluster snapshot includes:
- Backing store data (etcd or SQLite)
- vCluster Helm release information
- vCluster configuration (vcluster.yaml)

### Create Snapshot

```bash
# Snapshot the backend vCluster to ephemeral docker image registry (ttl.sh)
# Generate random suffix to avoid naming conflicts
RAND=$(openssl rand -hex 3)
vcluster snapshot backend "oci://ttl.sh/vcluster-backend-${RAND}:1h"
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
# Delete the backend vCluster to simulate disaster
vcluster delete backend --delete-namespace
```{{exec}}

### Restore from Snapshot

```bash
# Create new vCluster from snapshot (namespace is auto-created)
# Use the same image name from the snapshot step above
vcluster create backend-restored --restore "oci://ttl.sh/vcluster-backend-${RAND}:1h"
```{{exec}}

### Verify Restoration

```bash
# Connect and check restored state
vcluster connect backend-restored
kubectl get ns
kubectl get resourcequotas -A
```{{exec}}

> **Key Points:**
> - Snapshots do NOT include PVs/PVCs
> - Works with both embedded (SQLite/etcd) and external databases
> - Can be used to clone vClusters or migrate configurations