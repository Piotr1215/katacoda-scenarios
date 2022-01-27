Inject Linkerd Sidecar 💉

We are injecting a linkerd sidecar to kuard pod and enabling it.

```bash
kubectl get pod kuard -o yaml \
  | linkerd inject - \
  | kubectl apply -f -
```{{execute T1}}

`linkerd -n default check --proxy`{{execute T1}}
