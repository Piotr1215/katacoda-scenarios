## vCluster State Management

> vCluster stores all state in a single database (SQLite or etcd)

A vCluster snapshot includes:
- Backing store data (etcd or SQLite)
- vCluster Helm release information
- vCluster configuration (vcluster.yaml)

### Create Snapshot

```bash
# Snapshot my-vcluster to ephemeral docker image registry (ttl.sh)
# Generate random suffix to avoid naming conflicts
RAND=$(openssl rand -hex 3)
vcluster snapshot my-vcluster --namespace test-namespace "oci://ttl.sh/vcluster-snapshot-${RAND}:1h"
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
# Delete my-vcluster to simulate disaster
vcluster delete my-vcluster --namespace test-namespace
```{{exec}}

### Restore from Snapshot

```bash
# Create new vCluster from snapshot (namespace is auto-created)
# Use the same image name from the snapshot step above
vcluster create my-vcluster --namespace test-namespace --restore "oci://ttl.sh/vcluster-snapshot-${RAND}:1h"
```{{exec}}

> **Note**: After restore, vCluster automatically connects you to the restored cluster. You can verify the restoration by checking if the `nginx-test` deployment in the `team-b` namespace was restored.

```bash
# Disconnect from restored vcluster
vcluster disconnect
```{{exec}}

## Cleanup

```bash
# Delete my-vcluster to free up resources for next steps
vcluster delete my-vcluster --namespace test-namespace
```{{exec}}

> **Key Points:**
> - Snapshots do NOT include PVs/PVCs
> - Works with both embedded (SQLite/etcd) and external databases
> - Can be used to clone vClusters or migrate configurations