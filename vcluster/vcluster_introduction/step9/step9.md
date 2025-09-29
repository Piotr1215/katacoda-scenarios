The admin team needs external access to manage the vCluster from their local machines.

## Export Kubeconfig for External Access

### Create vCluster with Export Configuration

```bash
cat <<EOF > vcluster-admin.yaml
exportKubeConfig:
  context: admin-external
  server: $(sed 's/PORT/30443/g' /etc/killercoda/host)
EOF
```{{exec}}

```bash
vcluster create admin --namespace admin-team -f vcluster-admin.yaml --connect=false
```{{exec}}

```bash
kubectl wait --for=condition=ready pod/admin-0 -n admin-team --timeout=90s
```{{exec}}

### Expose vCluster via NodePort

```bash
kubectl expose -n admin-team service admin --type=NodePort --name=admin-external --port=443 --target-port=8443 --node-port=30443
```{{exec}}

### Save Kubeconfig to File

```bash
kubectl get secret vc-admin -n admin-team -o jsonpath='{.data.config}' | base64 -d > admin.kubeconfig
```{{exec}}

### View Kubeconfig

```bash
cat admin.kubeconfig
```{{exec}}

Copy the content above to your local machine, save as `admin.kubeconfig`, then:

```bash
export KUBECONFIG=admin.kubeconfig
kubectl get ns --insecure-skip-tls-verify
```

### Test Access

Browser access: {{TRAFFIC_HOST1_30443}}

## Next Step

```bash
vcluster disconnect
```{{exec}}

Next we'll explore vCluster snapshots for backup and disaster recovery.