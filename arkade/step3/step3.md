Let's see what apps are available in arkade.

```bash
arkade install --help
```{{exec}}

> ⭐Kubernetes apps can be installed using `helm` or plain `kubectl` manifests 

We will install observability tools and a database.

```bash
arkade install prometheus --set grafana.enabled=true
arkade install postgresql 
```{{exec}}

Let's check if prometheus works.

```bash
kubectl port-forward service/prometheus-server 8080:80 --address 0.0.0.0 &
```{{exec}}

[open prometheus]({{TRAFFIC_HOST1_8080}})



