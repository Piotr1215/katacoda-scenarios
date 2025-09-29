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

| **Component** | **Purpose** | **Location** |
|--------------|------------|--------------|
| **kine** | Lightweight etcd replacement using SQLite | Runs as process in syncer |
| **kube-apiserver** | Full Kubernetes API server | Runs as process in syncer |
| **kube-controller-manager** | Manages Kubernetes controllers | Runs as process in syncer |
| **syncer** | Bi-directional resource sync with host | Main container process |
| **SQLite Database** | Complete state isolation | `/data/state.db` |

### Exploring Running Processes

View the control plane components running inside the vCluster pod:

```bash
kubectl exec -n test-namespace my-vcluster-0 -c syncer -- sh -c "echo '📊 vCluster Control Plane Processes' && echo '═══════════════════════════════════' && echo && echo 'Component                     PID   Time' && echo '─────────────────────────────────────────' && ps aux | grep 'vcluster start' | grep -v grep | head -1 | awk '{printf \"%-28s %5s  %s\\n\", \"vCluster Manager\", \$1, \$3}' && ps aux | grep 'kine.*state.db' | grep -v grep | head -1 | awk '{printf \"%-28s %5s  %s\\n\", \"Kine (etcd replacement)\", \$1, \$3}' && ps aux | grep 'kube-apiserver' | grep -v grep | head -1 | awk '{printf \"%-28s %5s  %s\\n\", \"Kubernetes API Server\", \$1, \$3}' && ps aux | grep 'kube-controller-manager' | grep -v grep | head -1 | awk '{printf \"%-28s %5s  %s\\n\", \"Controller Manager\", \$1, \$3}'"
```{{exec}}

This shows the four key processes that make up a complete Kubernetes control plane, all running inside a single pod!

### vCluster Data Directory

Examine the data directory structure:

```bash
kubectl exec -n test-namespace my-vcluster-0 -c syncer -- ls -la /data/
```{{exec}}

Key files and directories:
- **state.db**: SQLite database containing all cluster state
- **kine.sock**: Unix socket for kine (etcd replacement)
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

### Understanding vCluster Isolation

vCluster achieves workload isolation by running a full Kubernetes control plane inside a pod:

```bash
kubectl exec -n test-namespace my-vcluster-0 -c syncer -- \
  ps aux | grep -E '(kube-apiserver|kube-controller|kine)' | \
  grep -v grep | \
  awk '{print $11}' | \
  cut -d'/' -f3 | \
  sort -u
```{{exec}}

This architecture provides:
- **API isolation**: Each vCluster has its own API server
- **Independent state**: Separate SQLite database per vCluster
- **Resource efficiency**: All components run in a single pod (10-50MB typical)
- **Fast provisioning**: Sub-minute deployment time

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
