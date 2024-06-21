Let's install `KIND` and `kubectl`

```bash
arkade get kind kubectl
```{{exec}}

Now let's create a Kubernetes cluster with `KIND`:

```bash
kind create cluster
```{{exec}}

And finally, let's check if `kubectl` is working:

```bash
kubectl get nodes
```{{exec}}
