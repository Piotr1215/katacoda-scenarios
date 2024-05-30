Deploying the resources to the `dev` namespace:

```bash
kluctl deploy --yes -t dev
```{{exec}}

And to the `prod` namespace:

```bash
kluctl deploy --yes -t prod
```{{exec}}

Let's check if everything deployed as expected:

```bash
kubectl get pods,svc -n kluctl-demo-dev
kubectl get pods,svc -n kluctl-demo-prod
```{{exec}}

## Next Step

That's it! We have seen basic capabilities of `kluctl`.



