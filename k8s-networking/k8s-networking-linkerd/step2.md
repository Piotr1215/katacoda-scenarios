📎 Setup Linkerd Control Plane

➡ add helm repo

`helm repo add linkerd https://helm.linkerd.io/stable`{{execute T1}}

➡ install linkerd

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
  --set dashboard.enforcedHostRegexp=" " \
  linkerd/linkerd2
```{{execute T1}}

➡ check linkerd installation

`linkerd check`{{execute T1}}
