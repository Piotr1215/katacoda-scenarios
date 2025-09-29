Let's explore what's inside a vCluster pod and how it manages data.

### vCluster Architecture: What's Inside?

First, let's examine the containers running in our vCluster pod:

```bash
kubectl get pod -n test-namespace -l app=vcluster -o json | \
  jq -r '.items[0] |
    "INIT CONTAINERS:\n" +
    (.spec.initContainers[] | "  \(.name): \(.image)") +
    "\n\nMAIN CONTAINERS:\n" +
    (.spec.containers[] | "  \(.name): \(.image)")'
```{{exec}}

### vCluster Components

The init container copies Kubernetes binaries, then the main container runs all processes:

| **Component** | **Purpose** | **Details** |
|--------------|------------|-------------|
| **Init Container** | Provides Kubernetes binaries | Copies from `ghcr.io/loft-sh/kubernetes` to `/binaries/` |
| **kine** | Lightweight etcd replacement using SQLite | Process in syncer container (PID ~21) |
| **kube-apiserver** | Full Kubernetes API server | Process in syncer container (PID ~30) |
| **kube-controller-manager** | Manages Kubernetes controllers | Process in syncer container (PID ~71) |
| **syncer process** | Bi-directional resource sync with host | Main orchestrator (PID 1) |
| **SQLite Database** | Complete state isolation | `/data/state.db` with WAL |

### Exploring Running Processes

View the control plane components running inside the vCluster pod:

```bash
kubectl exec -n test-namespace my-vcluster-0 -c syncer -- ps aux | grep -E "vcluster|kine|kube-" | grep -v grep | awk '{print NR". "$0}'
```{{exec}}

This shows the four key processes that make up a complete Kubernetes control plane, all running inside a single container!

### vCluster Data Directory

Examine the data directory structure:

```bash
kubectl exec -n test-namespace my-vcluster-0 -c syncer -- ls -la /data/
```{{exec}}

Key files and directories:
- **state.db**: SQLite database containing all cluster state
- **state.db-wal**: Write-ahead log for database durability
- **state.db-shm**: Shared memory file for concurrent access
- **kine.sock**: Unix socket for etcd-compatible API
- **pki/**: Certificates and keys for secure communication
- **pids/**: Process ID files for running components

### vCluster Resource Footprint

Check resource usage of the vCluster pod:

```bash
kubectl get pod -n test-namespace -l app=vcluster -o custom-columns=NAME:.metadata.name,CPU_REQ:.spec.containers[0].resources.requests.cpu,MEM_REQ:.spec.containers[0].resources.requests.memory,CPU_LIM:.spec.containers[0].resources.limits.cpu,MEM_LIM:.spec.containers[0].resources.limits.memory
```{{exec}}

Get actual resource consumption:

```bash
kubectl top pod -n test-namespace -l app=vcluster
```{{exec}}


### Database Storage Analysis

Now let's explore the actual data storage. First, copy the database file from the _vcluster_ to the current folder.

```bash
kubectl cp test-namespace/my-vcluster-0:/data/state.db ./state.db -c syncer
```{{exec}}

Check the database size (typically 10-50MB):

```bash
ls -lh state.db
```{{exec}}

All the interesting data is stored in the _state.db_ file using the _kine_ table structure.
Let's explore what's stored:

### View Database Schema

```bash
sqlite3 state.db ".schema kine"
```{{exec}}

### List All Resource Types

```bash
sqlite3 state.db "SELECT DISTINCT name FROM kine WHERE name LIKE '/registry/%' ORDER BY name;" | awk -F'/' '{print $3}' | sort -u | head -10
```{{exec}}


### vCluster Mappings

vCluster maintains mappings between virtual and host cluster resources. The syncer keeps track of how resources in the virtual cluster map to their counterparts in the host cluster. For example, a pod named `nginx` in the `default` namespace of the virtual cluster gets mapped to `nginx-x-default-x-my-vcluster` in the host cluster's `test-namespace`.

```bash
sqlite3 state.db "SELECT name FROM kine WHERE name LIKE '/vcluster/mappings/%' LIMIT 10;"
```{{exec}}

> **Note:** The syncer component updates the database approximately every 10 seconds, so recently created resources may take a moment to appear.

## Next Step

Next we will explore how the syncer component works to synchronize resources between virtual and host clusters.
