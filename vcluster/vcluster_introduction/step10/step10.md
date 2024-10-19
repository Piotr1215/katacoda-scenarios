We can sync resources from the host cluster and make them available in the virtual cluster. 

First let's install `cert manager` on the host cluster.

```bash
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.16.1/cert-manager.yaml
kubectl wait --for=condition=Ready pods --all --namespace cert-manager --timeout=300s
```{{exec}}

```bash
cat <<EOF > vcluster-cert-manager.yaml
controlPlane:
  distro:
    k8s:
      enabled: true
      version: "v1.30.0"
experimental:
  multiNamespaceMode:
    enabled: true

  genericSync:
    role:
      extraRules:
        - apiGroups: ["cert-manager.io"]
          resources: ["issuers", "certificates"]
          verbs: ["create", "delete", "patch", "update", "get", "list", "watch"]
    clusterRole:
      extraRules:
        - apiGroups: ["apiextensions.k8s.io"]
          resources: ["customresourcedefinitions"]
          verbs: ["get", "list", "watch"]
    export:
      - apiVersion: cert-manager.io/v1
        kind: Issuer
      - apiVersion: cert-manager.io/v1
        kind: Certificate
    import:
      - kind: Secret
        apiVersion: v1
EOF
```{{exec}}

```bash
vcluster create v-cert-manager -f vcluster-cert-manager.yaml --connect=true
```{{exec}}

Now let's create `Issuer` and `Certificate` resources on the virtual cluster.

```bash
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Namespace
metadata:
  name: cert-manager-test
---
apiVersion: cert-manager.io/v1
kind: Issuer
metadata:
  name: test-selfsigned
  namespace: cert-manager-test
spec:
  selfSigned: {}
---
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: selfsigned-cert
  namespace: cert-manager-test
spec:
  dnsNames:
    - example.com
  secretName: selfsigned-cert-tls
  issuerRef:
    name: test-selfsigned
EOF
```{{exec}}

> Notice we didn't need to install `cert manager` on the virtual cluster. We just synced the resources from the host cluster.

## Next Step

Check your knowkedgde by taking a short quiz.

