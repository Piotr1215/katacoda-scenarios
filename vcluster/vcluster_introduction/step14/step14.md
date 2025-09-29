## Quiz 3: Take a vCluster Snapshot

Perform the following backup operation:
- Take a snapshot of the `quiz-k8s` vCluster created in Quiz 1
- Save it to ephemeral registry: `oci://ttl.sh/quiz-backup:2h`
- Verify the snapshot was successful

### Solution

<details>
<summary>click to see the answer</summary>

Take the snapshot:

```bash
# Generate random suffix to avoid naming conflicts
RAND=$(openssl rand -hex 3)
vcluster snapshot quiz-k8s "oci://ttl.sh/quiz-backup-${RAND}:2h"
```{{exec}}

The snapshot is now stored in the ttl.sh registry and will expire after 2 hours.

</details>