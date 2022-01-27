📎 Setup Linkerd Control Plane

`helm repo add linkerd https://helm.linkerd.io/stable`{{execute T1}}

```bash
step certificate create root.linkerd.cluster.local ca.crt ca.key \
--profile root-ca --no-password --insecure
```{{execute T1}}

```bash
step certificate create identity.linkerd.cluster.local issuer.crt issuer.key \
--profile intermediate-ca --not-after 8760h --no-password --insecure \
--ca ca.crt --ca-key ca.key
```{{execute T1}}


```bash
# set expiry date one year from now, in Mac:
exp=$(date -v+8760H +"%Y-%m-%dT%H:%M:%SZ")

# in Linux:
exp=$(date -d '+8760 hour' +"%Y-%m-%dT%H:%M:%SZ")

helm install linkerd2 \
  --set-file identityTrustAnchorsPEM=ca.crt \
  --set-file identity.issuer.tls.crtPEM=issuer.crt \
  --set-file identity.issuer.tls.keyPEM=issuer.key \
  --set identity.issuer.crtExpiry=$exp \
  --set enforcedHostRegexp=.* \
  linkerd/linkerd2
```{{execute T1}}

`linkerd check`{{execute T1}}
