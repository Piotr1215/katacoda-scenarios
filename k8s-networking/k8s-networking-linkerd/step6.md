👮 Mutual TLS

➡ install emoji app

```bash
curl --proto '=https' --tlsv1.2 -sSfL https://run.linkerd.io/emojivoto.yml \
  | kubectl apply -f -
```{{execute T1}}

➡ forward traffic

```bash
kubectl -n emojivoto port-forward svc/web-svc 8085:80 &
```{{execute T1}}

➡ inject emoji app with linkerd sidecar

```bash
kubectl get -n emojivoto deploy -o yaml \
  | linkerd inject - \
  | kubectl apply -f -
```{{execute T1}}

➡ access the page and generate some traffic

https://[[HOST_SUBDOMAIN]]-8085-[[KATACODA_HOST]].environments.katacoda.com/
