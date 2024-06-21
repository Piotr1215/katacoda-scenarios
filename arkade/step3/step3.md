Let's see what apps are available in arkade.

```bash
arkade install --help
```{{exec}}

>  Kubernetes apps can be installed using `helm` or plain `kubectl` manifests 

We will need observability tools, a database and a service mesh:

```bash
arkade install prometheus grafana postgresql linkerd
```{{exec}}

