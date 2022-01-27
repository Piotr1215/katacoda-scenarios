🔭 Observability

First we need to install observability extensions

`linkerd viz install | kubectl apply -f -`{{execute T1}}

`linkerd check`{{execute T1}}

```bash
linkerd viz dashboard --address 0.0.0.0
```{{execute T1}}

