The admin team needs access to underlying Kubernetes nodes. By default, vcluster only syncs _pseudo-nodes_ to virtual cluster.

```bash
cat <<EOF > vcluster-admin.yaml
controlPlane:
  distro:
    k8s:
      enabled: true
      version: "v1.30.0"
sync:
  fromHost:
    nodes:
      enabled: true
EOF
```{{exec}}

```bash
vcluster create admin --namespace admin-team -f vcluster-admin.yaml --connect=false
```{{exec}}

Now we should see the actula nodes synced to the virtual cluster.

```bash
vcluster connect admin
k get nodes
```{{exec}}

## Next Step

Next we will see what the admin team needs and create a virtual cluster for them.
