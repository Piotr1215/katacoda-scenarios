The admin team needs secure external access to the vCluster for CI/CD pipelines and automation tools.

## Export Kubeconfig for External Access

vCluster can automatically export kubeconfig to a secret, which tools like ArgoCD, Flux, or Terraform can use to deploy applications.

### Configure Export with Custom Domain

Create a vCluster that exports kubeconfig with a custom server endpoint using nip.io for DNS resolution:

```bash
cat <<EOF > vcluster-admin.yaml
exportKubeConfig:
  context: admin-ci-cd
  server: https://vcluster-admin.127-0-0-1.nip.io:443
EOF
```{{exec}}

> **nip.io**: A wildcard DNS service that resolves `127-0-0-1.nip.io` to `127.0.0.1`, perfect for local testing and demos.

### Create vCluster with Export Configuration

```bash
vcluster create admin --namespace admin-team -f vcluster-admin.yaml --connect=false
```{{exec}}

Wait for the vCluster to be ready:

```bash
kubectl wait --for=condition=ready pod -l app=vcluster -n admin-team --timeout=60s
```{{exec}}

### Verify Exported Kubeconfig

Check the exported kubeconfig secret:

```bash
kubectl get secrets -n admin-team | grep -E "^vc-"
```{{exec}}

The secret `vc-admin` contains the kubeconfig with our custom configuration.

### Examine the Exported Kubeconfig

View the kubeconfig contents to verify custom context and server:

```bash
kubectl get secret vc-admin -n admin-team -o jsonpath='{.data.config}' | base64 -d | grep -E "server:|current-context:" | head -2
```{{exec}}

You should see:
- `server: https://vcluster-admin.127-0-0-1.nip.io:443`
- `current-context: admin-ci-cd`

### Using the Exported Kubeconfig

Save the kubeconfig to a file for external tools:

```bash
kubectl get secret vc-admin -n admin-team -o jsonpath='{.data.config}' | base64 -d > admin-kubeconfig.yaml
```{{exec}}

Test access using the exported kubeconfig:

```bash
KUBECONFIG=admin-kubeconfig.yaml kubectl get ns
```{{exec}}

### CI/CD Integration Examples

**ArgoCD Application:**
```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: admin-apps
spec:
  destination:
    server: https://vcluster-admin.127-0-0-1.nip.io:443
```

**Flux Kustomization:**
```yaml
apiVersion: kustomize.toolkit.fluxcd.io/v1beta2
kind: Kustomization
metadata:
  name: admin-cluster
spec:
  kubeConfig:
    secretRef:
      name: vc-admin
```

**Terraform Provider:**
```hcl
provider "kubernetes" {
  config_path = "admin-kubeconfig.yaml"
  config_context = "admin-ci-cd"
}
```

## Next Step

```bash
vcluster disconnect
```{{exec}}

Next we'll explore vCluster snapshots for backup and disaster recovery.