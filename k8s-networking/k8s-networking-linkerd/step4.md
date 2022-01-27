# Inject Linkerd Sidecar 💉

```bash
kubectl get deploy kuard -o yaml \
  | linkerd inject - \
  | kubectl apply -f -
```{{execute T1}}

`linkerd -n default check --proxy`{{execute T1}}
