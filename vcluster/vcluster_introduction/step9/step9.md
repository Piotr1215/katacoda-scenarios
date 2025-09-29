The admin team needs access to underlying Kubernetes nodes and they need more lightweight Kubernetes distribution. 

> By default, vcluster only syncs _pseudo-nodes_ to virtual cluster.

```bash
cat <<EOF > vcluster-admin.yaml
controlPlane:
  distro:
    k3s:
      enabled: true
sync:
  fromHost:
    nodes:
      enabled: true
EOF
```{{exec}}

```bash
vcluster create admin --namespace admin-team -f vcluster-admin.yaml --connect=false
```{{exec}}

Now we should see the actual nodes synced to the virtual cluster as well as `k3s` distribution.

```bash
vcluster connect admin
kubectl version
kubectl get nodes
```{{exec}}

## Next Step

```bash
vcluster disconnect
vcluster delete admin
```{{exec}}

Next we will see what the admin team needs and create a virtual cluster for them.
