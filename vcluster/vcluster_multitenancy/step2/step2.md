# Step 2: Installation and Environment Setup

## Check Environment

Verify the Kubernetes environment is ready:

```bash
kubectl version --short
```{{exec}}

```bash
kubectl get nodes -o wide
```{{exec}}

```bash
kubectl top nodes
```{{exec}}

## Install vCluster CLI

Download and install the latest vCluster CLI:

```bash
curl -L -o vcluster "https://github.com/loft-sh/vcluster/releases/latest/download/vcluster-linux-amd64" && \
sudo install -c -m 0755 vcluster /usr/local/bin && \
rm -f vcluster
```{{exec}}

Verify installation:

```bash
vcluster version
```{{exec}}

## Enable Auto-completion

```bash
vcluster completion bash > /etc/bash_completion.d/vcluster
source /etc/bash_completion.d/vcluster
```{{exec}}

## Explore vCluster Commands

```bash
vcluster --help | head -30
```{{exec}}

### Essential Commands

| Command | Description |
|---------|-------------|
| `vcluster create` | Create a new virtual cluster |
| `vcluster connect` | Connect to a vCluster's API server |
| `vcluster list` | List all vClusters |
| `vcluster delete` | Delete a vCluster |
| `vcluster pause` | Scale down vCluster to save resources |
| `vcluster resume` | Scale vCluster back up |
| `vcluster snapshot` | Create/restore vCluster backups |

## Install Helper Tools

```bash
apt-get update > /dev/null 2>&1 && apt-get install -y jq tree > /dev/null 2>&1
```{{exec}}

## Create Workshop Directory

```bash
mkdir -p ~/vcluster-workshop/{configs,manifests,backups}
```{{exec}}

Copy configuration files:

```bash
cp ~/dev-values.yaml ~/vcluster-workshop/configs/
cp ~/prod-values.yaml ~/vcluster-workshop/configs/
cp ~/partner-values.yaml ~/vcluster-workshop/configs/
cp ~/web-app.yaml ~/vcluster-workshop/manifests/
```{{exec}}

View structure:

```bash
tree ~/vcluster-workshop/
```{{exec}}

## Configuration Methods

vCluster can be configured in multiple ways:

| Method | Example |
|--------|---------|
| CLI Flags | `vcluster create --set key=value` |
| Values File | `vcluster create -f values.yaml` |
| Helm Values | Direct Helm chart customization |
| vCluster.yaml | New unified configuration format |

## Preview Configuration Files

Development team configuration (resource-limited):

```bash
grep -E "enabled|cpu|memory" ~/vcluster-workshop/configs/dev-values.yaml | head -10
```{{exec}}

Production team configuration (full access):

```bash
grep -E "enabled|ingress" ~/vcluster-workshop/configs/prod-values.yaml | head -10
```{{exec}}

Partner team configuration (pre-populated):

```bash
grep -E "enabled|manifests" ~/vcluster-workshop/configs/partner-values.yaml | head -5
```{{exec}}

## Prepare Namespaces

Create namespaces for different teams:

```bash
kubectl create namespace vcluster-dev-team --dry-run=client -o yaml | kubectl apply -f -
kubectl create namespace vcluster-prod-team --dry-run=client -o yaml | kubectl apply -f -
kubectl create namespace vcluster-partner-team --dry-run=client -o yaml | kubectl apply -f -
```{{exec}}

Label namespaces:

```bash
kubectl label namespace vcluster-dev-team purpose=development team=dev --overwrite
kubectl label namespace vcluster-prod-team purpose=production team=prod --overwrite
kubectl label namespace vcluster-partner-team purpose=partner team=partner --overwrite
```{{exec}}

List team namespaces:

```bash
kubectl get namespaces -l team
```{{exec}}

## Baseline Metrics

Record initial cluster state:

```bash
kubectl get ns --no-headers | wc -l
```{{exec}}

```bash
kubectl get pods -A --no-headers | wc -l
```{{exec}}

```bash
kubectl top nodes --no-headers | awk '{print "CPU: " $2 ", Memory: " $4}'
```{{exec}}

## Configure Aliases

```bash
cat >> ~/.bashrc << 'EOF'
alias vls='vcluster list'
alias vconn='vcluster connect'
alias vdel='vcluster delete'
alias kc='kubectl'
alias kcg='kubectl get'
alias kcd='kubectl describe'
alias kctx='kubectl config current-context'
EOF

source ~/.bashrc
```{{exec}}

## Environment Verification

```bash
# Check vCluster CLI
vcluster version 2>&1 | grep -q Version && echo "vCluster CLI: Ready" || echo "vCluster CLI: Not found"

# Check kubectl
kubectl version --short > /dev/null 2>&1 && echo "kubectl: Ready" || echo "kubectl: Not found"

# Check namespaces
[ $(kubectl get ns -l team --no-headers | wc -l) -eq 3 ] && echo "Namespaces: Ready" || echo "Namespaces: Not ready"

# Check config files
[ -f ~/vcluster-workshop/configs/dev-values.yaml ] && echo "Config files: Ready" || echo "Config files: Not found"
```{{exec}}

## Next Step

Environment is ready. Next, we'll create our first vCluster and explore its isolated environment.