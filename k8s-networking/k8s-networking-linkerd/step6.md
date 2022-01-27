👮 Mutual TLS

➡ remove kuard app

`kubectl delete deploy kuard`{{execute T1}}

➡ install emoji app

```bash
curl --proto '=https' --tlsv1.2 -sSfL https://run.linkerd.io/emojivoto.yml \
  | kubectl apply -f -
```{{execute T1}}

➡ wait for the pod to come up

`kubectl wait -n emojivoto deployment emoji --for=condition=Available --timeout=1m`{{execute T1}}

➡ forward traffic

```bash
kubectl -n emojivoto port-forward svc/web-svc 8080:80 &
```{{execute T1}}

➡ inject emoji app with linkerd sidecar

```bash
kubectl get -n emojivoto deploy -o yaml \
  | linkerd inject - \
  | kubectl apply -f -
```{{execute T1}}

➡ access the page and generate some traffic

https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com/
