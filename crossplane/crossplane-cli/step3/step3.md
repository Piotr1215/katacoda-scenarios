## Let's validate our composition

> The validate command doesn't require a cluster, all required resources are
> encapsulated in the command

First let's swap to the validate directory `cd validate`{{exec}} and start
validation process.

> Use the builtin editor, accessible on the left upper corner on the terminal,
> to view the files.

`crossplane beta validate schemas.yaml resources.yaml`{{exec}}

`crossplane beta validate missing-schemas.yaml resources.yaml`{{exec}}

`crossplane beta render xr.yaml composition.yaml func.yaml | ./crossplane-cli beta validate schemas.yaml -`{{exec}}

`crossplane beta render xr.yaml composition.yaml func.yaml --include-full-xr | ./crossplane-cli beta validate schemas.yaml -`{{exec}}

`crossplane beta render xr.yaml composition.yaml func.yaml --include-full-xr > rendered.yaml`{{exec}}

`crossplane beta validate Extensions rendered.yaml`{{exec}}

`crossplane beta validate Extensions rendered.yaml`{{exec}}

`crossplane beta validate Extensions rendered.yaml --cache-dir mycache`{{exec}}

`crossplane beta validate Extensions rendered.yaml --cache-dir mycache --clean-cache`{{exec}}
