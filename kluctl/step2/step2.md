To start using `kluctl` define a .kluctl.yaml file in the root of your project
with the targets where you want to deploy.

let's create a folder for our project and create a .kluctl.yaml file in it.

`mkdir kluctl-project && cd kluctl-project`{{exec}}

```yaml
cat <<EOF > .kluctl.yaml
discriminator: "kluctl-demo-{{ target.name }}"

targets:
  - name: dev
    context: kubernetes-admin@kubernetes
    args:
      environment: dev
  - name: prod
    context: kubernetes-admin@kubernetes
    args:
      environment: prod

args:
  - name: environment
EOF
```{{exec}}

This file defines two targets, `dev` and `prod`, that will deploy to the same
Kubernetes cluster. 

We can use the `args` section to define the arguments that we will use in our
yaml files to template them. For example `{{ args.environment }}` would output
`dev` or `prod` depending on the target we are deploying to.

## Next Step

Next we will create a `kustomize` deployment for redis application.
