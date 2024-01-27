## Let's validate our composition

> [!NOTE]
> The validate command doesn't require a cluster, all required resources are
> encapsulated in the command

`crossplane beta validate ./validte_assets/schemas.yaml ./validte_assets/resources.yaml`{{exec}}

`crossplane beta validate missing-./validte_assets/schemas.yaml ./validte_assets/resources.yaml`{{exec}}

`crossplane beta render ./validte_assets/xr.yaml ./validte_assets/composition.yaml ./validte_assets/func.yaml | ./crossplane-cli beta validate ./validte_assets/schemas.yaml -`{{exec}}

`crossplane beta render ./validte_assets/xr.yaml ./validte_assets/composition.yaml ./validte_assets/func.yaml --include-full-xr | ./crossplane-cli beta validate ./validte_assets/schemas.yaml -`{{exec}}

`crossplane beta render ./validte_assets/xr.yaml ./validte_assets/composition.yaml ./validte_assets/func.yaml --include-full-xr > ./validte_assets/rendered.yaml`{{exec}}

`crossplane beta validate Extensions ./validte_assets/rendered.yaml`{{exec}}

`crossplane beta validate Extensions ./validte_assets/rendered.yaml`{{exec}}

`crossplane beta validate Extensions ./validte_assets/rendered.yaml --cache-dir mycache`{{exec}}

`crossplane beta validate Extensions ./validte_assets/rendered.yaml --cache-dir mycache --clean-cache`{{exec}}
