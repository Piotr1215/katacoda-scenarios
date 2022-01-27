🔭 Observability

First we need to install observability extension

```bash
helm install linkerd-viz \
  --set dashboard.enforcedHostRegexp=.* \
  linkerd/linkerd-viz
```{{execute T1}}

`linkerd check`{{execute T1}}

```bash
linkerd viz dashboard --address 0.0.0.0
```{{execute T1}}

