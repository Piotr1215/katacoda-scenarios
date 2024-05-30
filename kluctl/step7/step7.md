At the beginning of the workshop, we have two different environments; `prod` and
`dev`. This setup works out of the box for multiple targets (clusters), however
in our case, we want to have a single target (cluster) and we want to deploy
different targets to different namespaces.

Let's start by deleting the existing resources and modifying some of the files.

> 💡 It is possible to `migrate` the resources to a different namespace using
> the `kluctl prune` command. However, in this case, we will delete the old
> resources and recreate them in new namespaces.

`kluctl delete --yes -t dev`{{exec}}

In order to differentiate between the two environments, we will need to adjust
the `discriminator` field in the `.kluctl.yaml` file. 

`yq e '.discriminator = "kluctl-demo-{{ target.name }}-{{ args.environment }}"' -i .kluctl.yaml`{{exec}}

We also need to create a namespace folder and yaml and add it to our
`kustomization.yaml` file.

First create the namespace folder.

`mkdir namespace`{{exec}}

Now we can add the namespace folder to the `kustomization.yaml` file.

> 💡 Notice the use of `barrier: true` in the `kustomization.yaml` file. This
> tells `kluctl` to apply the resources in the order they are defined in the
> file and wait for the resource before the barrier to be ready before applying
> the next ones

```yaml
cat <<EOF > deployment.yaml
deployments:
  - path: namespace
  - barrier: true
  - path: redis

commonLabels:
  examples.kluctl.io/deployment-project: "redis"

overrideNamespace: kluctl-demo-{{ args.environment }}
EOF
```{{exec}}

Now let's create the namespace yaml file.

```yaml
cat <<EOF > ./namespace/namespace.yaml
apiVersion: v1
kind: Namespace
metadata:
  name: kluctl-demo-{{ args.environment }}
EOF
```{{exec}}

## Next Step

We will test if our setup works by deploying the redis application to the `dev`
and `prod` namespaces.
