🔭 Observability

First we need to install observability extension

`helm repo add linkerd https://helm.linkerd.io/stable`{{execute T1}}

```bash
helm install linkerd-viz \
  --set dashboard.enforcedHostRegexp=.* \
  linkerd/linkerd-viz
```{{execute T1}}

`linkerd check`{{execute T1}}

```bash
linkerd viz dashboard --address 0.0.0.0
```{{execute T1}}

```bash
https://[[HOST_SUBDOMAIN]]-50750-[[KATACODA_HOST]].environments.katacoda.com/ and paste port copied from previous command
```{{execute T1}}


