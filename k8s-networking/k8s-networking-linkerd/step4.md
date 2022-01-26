# Inject Linkerd Sidecar 💉

```bash
kubectl get -n emojivoto deploy -o yaml \
  | linkerd inject - \
  | kubectl apply -f -
```{{execute T1}}

`linkerd -n default check --proxy`{{execute T1}}
