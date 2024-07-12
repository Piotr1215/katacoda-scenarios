## Objective

Learn how to install and configure the Spin Operator on a Kubernetes cluster using Helm.

## Demo

### Steps

1. Install cert-manager:
   ```bash
   kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.14.0/cert-manager.yaml
   ```{{exec}}

2. Install KWasm Operator:
   ```bash
   helm repo add kwasm http://kwasm.sh/kwasm-operator/
   helm install kwasm-operator kwasm/kwasm-operator \
     --namespace kwasm --create-namespace \
     --set kwasmOperator.installerImage=ghcr.io/spinkube/containerd-shim-spin/node-installer:v0.13.1
   kubectl annotate node --all kwasm.sh/kwasm-node=true
   ```{{exec}}

3. Install Spin Operator CRDs and configurations:
   ```bash
   kubectl apply -f https://github.com/spinkube/spin-operator/releases/download/v0.2.0/spin-operator.crds.yaml
   kubectl apply -f https://github.com/spinkube/spin-operator/releases/download/v0.2.0/spin-runtimeclass.yaml
   kubectl apply -f https://github.com/spinkube/spin-operator/releases/download/v0.2.0/spin-app-executor.yaml
   ```{{exec}}

4. Install Spin Operator using Helm:
   ```bash
   helm install spin-operator \
     --namespace spin-operator --create-namespace \
     --version 0.2.0 --wait \
     oci://ghcr.io/spinkube/charts/spin-operator
   ```{{exec}}

> Check [Octant]({{TRAFFIC_SELECTOR_HOST1_7777}}) to see the installed
> resources.

