The syncer is the heart of vCluster, acting as a bidirectional state reconciliation engine between virtual and host clusters.

### Syncer Architecture

![vCluster Syncer](./assets/vcluster-syncer.png)

The syncer continuously watches both the vCluster API and host cluster API, transforming and synchronizing resources between them.

### How the Syncer Works

Let's explore the syncer's operations in real-time:

```bash
kubectl logs -n test-namespace my-vcluster-0 -c syncer --tail=20
```{{exec}}

### Syncer Operations

The syncer performs several key transformations:

| **Operation** | **Description** | **Example** |
|--------------|-----------------|-------------|
| **Name Rewriting** | Transforms resource names | `nginx` → `nginx-x-default-x-my-vcluster` |
| **Namespace Translation** | Maps virtual to host namespaces | `default` → `test-namespace` |
| **Reference Tracking** | Updates cross-resource references | ConfigMap refs are rewritten |
| **Status Syncing** | Propagates status back to vCluster | Pod conditions from host |

### Resource Transformation in Action

Let's see how resources are transformed. First, create a deployment in the vCluster:

```bash
vcluster connect my-vcluster --namespace test-namespace
kubectl create deployment testapp --image=nginx --replicas=2
```{{exec}}

Now check how it appears in the host cluster:

```bash
vcluster disconnect
kubectl get pods -n test-namespace | grep testapp
```{{exec}}

Notice the naming pattern: `<name>-x-<namespace>-x-<vcluster-name>`

### What Gets Synced?

#### Resources Synced TO Host Cluster:

```bash
kubectl get pods,services,configmaps,secrets -n test-namespace \
  --show-labels | \
  grep "vcluster.loft.sh/managed-by=my-vcluster"
```{{exec}}

#### Resources Synced FROM Host Cluster:

Check node information synced from host:

```bash
vcluster connect my-vcluster --namespace test-namespace
kubectl get nodes -o wide
vcluster disconnect
```{{exec}}

### Syncer Configuration

View current syncer configuration:

```bash
kubectl get cm -n test-namespace my-vcluster-config -o yaml | \
  grep -A 20 "sync:"
```{{exec}}

### Bidirectional Sync Example

Let's demonstrate bidirectional syncing by adding a label to a pod in the host cluster:

```bash
POD=$(kubectl get pods -n test-namespace \
  -l vcluster.loft.sh/managed-by=my-vcluster \
  -o name | head -1)
kubectl label -n test-namespace $POD test-label=from-host
```{{exec}}

Check if the label appears in the vCluster:

```bash
vcluster connect my-vcluster --namespace test-namespace
kubectl get pods --show-labels | grep test-label
vcluster disconnect
```{{exec}}

### Syncer Resource Mappings

Examine the syncer's internal mappings:

```bash
kubectl exec -n test-namespace my-vcluster-0 -c syncer -- \
  sqlite3 /data/state.db \
  "SELECT name FROM kine WHERE name LIKE '/vcluster/mappings/%' LIMIT 10;"
```{{exec}}

### Reconciliation Loop

The syncer follows this continuous loop:

```
Watch(vCluster API) → Transform(resource) → Apply(host API) → Update Status(vCluster API)
                                              ↑                           ↓
                                              └───────────────────────────┘
```

Monitor the reconciliation in real-time:

```bash
kubectl logs -n test-namespace my-vcluster-0 -c syncer -f | \
  grep -E "(create|update|delete|sync)" | \
  head -20
```{{exec}}

### Syncer Performance Metrics

Check syncer resource usage:

```bash
kubectl exec -n test-namespace my-vcluster-0 -c syncer -- sh -c "ps aux | grep syncer | head -1"
```{{exec}}

### Key Syncer Features

| **Feature** | **Benefit** |
|------------|------------|
| **Selective Sync** | Only sync required resources, reducing overhead |
| **Name Translation** | Prevents conflicts between multiple vClusters |
| **Status Reflection** | Real-time status updates from host to vCluster |
| **Reference Rewriting** | Maintains resource relationships across clusters |
| **Bidirectional Updates** | Labels/annotations flow both directions |

> **Note:** The syncer is highly optimized and typically syncs resources within milliseconds, making vCluster feel like a native Kubernetes cluster.

## Next Step

Next we will practice using the _vcluster_ CLI with different scenarios.
