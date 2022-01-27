# Setup Frontent 💻

> Kuard is a demo K8s application from the book “Kubernetes Up and Running”

`kubectl create deployment --image=gcr.io/kuar-demo/kuard-amd64:blue kuard`{{execute T1}}

`kubectl wait deployment kuard --for=condition=Available --timeout=1m`{{execute T1}}

Port forward traffic to the pod

`kubectl port-forward kuard 8080:8080 --address 0.0.0.0`{{execute T1}}

Naviagate to [the kuard page](https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com/)
