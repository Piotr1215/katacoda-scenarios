## Let's validate our composition

> [!NOTE]
> The validate command doesn't require a cluster, all required resources are
> encapsulated in the command

`crossplane beta validate assets/schemas.yaml assets/resources.yaml`{{exec}}

`crossplane beta validate missing-assets/schemas.yaml assets/resources.yaml`{{exec}}

`crossplane beta render assets/xr.yaml assets/composition.yaml assets/func.yaml | ./crossplane-cli beta validate assets/schemas.yaml -`{{exec}}

`crossplane beta render assets/xr.yaml assets/composition.yaml assets/func.yaml --include-full-xr | ./crossplane-cli beta validate assets/schemas.yaml -`{{exec}}

`crossplane beta render assets/xr.yaml assets/composition.yaml assets/func.yaml --include-full-xr > assets/rendered.yaml`{{exec}}

`crossplane beta validate Extensions assets/rendered.yaml`{{exec}}

`crossplane beta validate Extensions assets/rendered.yaml`{{exec}}

`crossplane beta validate Extensions assets/rendered.yaml --cache-dir mycache`{{exec}}

`crossplane beta validate Extensions assets/rendered.yaml --cache-dir mycache --clean-cache`{{exec}}
