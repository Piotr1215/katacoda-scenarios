## Deploy The Pepr Controller

Now that we have our Pepr module ready, we can build and deploy it to our
Kubernetes cluster.

```bash
pepr format && pepr build
```{{exec}}

`pepr build` generated various build artifacts, we are interested in the
Kubernetes yaml files. Let's deploy the Pepr controller to our Kubernetes.

```bash
kubectl apply -f ./dist/pepr*.yaml
```{{exec}}

> 💡 Open [Octant]({{TRAFFIC_HOST1_7777}}) to see the Pepr controller
> deployment in the `pepr-system` namespace.

## Next Steps

Next we will look at how to monitor the Pepr webhooks.

