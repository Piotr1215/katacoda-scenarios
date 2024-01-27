## Let's validate our composition

> [!NOTE]
> The validate command doesn't require a cluster, all required resources are
> encapsulated in the command

`crossplane beta validate ./_assets/schemas.yaml ./_assets/resources.yaml`{{exec}}

`crossplane beta validate missing-./_assets/schemas.yaml ./_assets/resources.yaml`{{exec}}

`crossplane beta render ./_assets/xr.yaml ./_assets/composition.yaml ./_assets/func.yaml | ./crossplane-cli beta validate ./_assets/schemas.yaml -`{{exec}}

`crossplane beta render ./_assets/xr.yaml ./_assets/composition.yaml ./_assets/func.yaml --include-full-xr | ./crossplane-cli beta validate ./_assets/schemas.yaml -`{{exec}}

`crossplane beta render ./_assets/xr.yaml ./_assets/composition.yaml ./_assets/func.yaml --include-full-xr > ./_assets/rendered.yaml`{{exec}}

`crossplane beta validate Extensions ./_assets/rendered.yaml`{{exec}}

`crossplane beta validate Extensions ./_assets/rendered.yaml`{{exec}}

`crossplane beta validate Extensions ./_assets/rendered.yaml --cache-dir mycache`{{exec}}

`crossplane beta validate Extensions ./_assets/rendered.yaml --cache-dir mycache --clean-cache`{{exec}}
