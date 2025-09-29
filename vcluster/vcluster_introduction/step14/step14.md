## Quiz 3: Take a vCluster Snapshot

First, ensure we're not connected to any vCluster and list existing vClusters:

```bash
vcluster disconnect
vcluster list
```{{exec}}

Perform the following backup operation:
- Take a snapshot of the `limited-team` vCluster created in Quiz 2
- Namespace: `limited-ns`
- Save it to local container storage: `container:///data/backup.tar.gz`
- Verify the snapshot was created successfully

> **📚 Documentation**: For more details on backup and restore operations, see [vCluster Backup & Restore](https://www.vcluster.com/docs/vcluster/manage/backup-restore/backup)

### Solution

<details>
<summary>click to see the answer</summary>

Create the snapshot:

```bash
# Create snapshot inside vCluster's /data directory
vcluster snapshot limited-team --namespace limited-ns "container:///data/backup.tar.gz"
```{{exec}}

The snapshot is now saved persistently in the vCluster's data directory.

</details>