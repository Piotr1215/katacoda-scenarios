## vCluster State Management

> vCluster stores all state in a single SQLite database

```bash
# Snapshot to ephemeral docker image registry
vcluster snapshot admin "oci://ttl.sh/vcluster-admin:1h"
```{{exec}}

> Restore our virtual cluster onto it!

```bash
vcluster create admin --namespace admin-team --restore "oci://ttl.sh/vcluster-admin:1h"
```{{exec}}

## Verify restore

```bash
vcluster connect admin
kubectl get ns
```{{exec}}
