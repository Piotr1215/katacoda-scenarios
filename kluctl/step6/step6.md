Let's see what we have deployed so far by executing `tree`{{exec}} command.

> 💡 Notice this resembles a typical `kustomize` directory structure.

One of the superpowers of `kluctl` is how transparently it handles changes.
Let's modify the redis deployment and see how `kluctl` handles it.

`yq -i eval '.spec.replicas = 2' redis/deployment.yaml`{{exec}}

Now let's deploy the changes to the `dev` target.

`kluctl deploy --yes -t dev`{{exec}}

Remember at the beginning, we have added custom labels to each deployment. Let's
see if the labels were correctly applied.

`kubectl get deployments -A --show-labels`{{exec}}

## Next Step

Next we will use templating capabilities of `kluctl` to deploy the same
application to a different namespace
