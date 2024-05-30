Under the hood `kluctl` uses `kustomize` to manage the Kubernetes manifests. `kustomize` is a tool that lets you customize raw, template-free YAML files for multiple purposes, leaving the original YAML untouched and usable as is.

> 💡 we are following a tutorial from the `kluctl` documentation [Basic Project Setup
Introduction](https://kluctl.io/docs/tutorials/microservices-demo/1-basic-project-setup/)

Let's create a `deployment.yaml` where we will define elements that `kluclt` will use to deploy the application.

```yaml
cat <<EOF > deployment.yaml
deployments:
  - path: redis

commonLabels:
  examples.kluctl.io/deployment-project: "redis"
EOF
```{{exec}}

## Next Step

Next we will create deployment and service for redis kustomization.


