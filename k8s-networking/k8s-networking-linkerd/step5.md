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
linkerd viz dashboard --address 0.0.0.0 &
```{{execute T1}}

visit [Linkerd Dashboard](https://[[HOST_SUBDOMAIN]]-50750-[[KATACODA_HOST]].environments.katacoda.com/)

---

Another

Install emoji app

```bash
curl --proto '=https' --tlsv1.2 -sSfL https://run.linkerd.io/emojivoto.yml \
  | kubectl apply -f -
```{{execute T1}}

```bash
kubectl -n emojivoto port-forward svc/web-svc 8085:80 &
```{{execute T1}}

```bash
https://[[HOST_SUBDOMAIN]]-8085-[[KATACODA_HOST]].environments.katacoda.com/ and paste port copied from previous command
```{{execute T1}}

Inject emoji app with linkerd sidecar

```bash
kubectl get -n emojivoto deploy -o yaml \
  | linkerd inject - \
  | kubectl apply -f -
```{{execute T1}}

