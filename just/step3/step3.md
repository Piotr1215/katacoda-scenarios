Let's start by cloning a repository with the `justfile` and checking all the recipes in it.

```bash
cd ../
git clone https://github.com/Piotr1215/crossplane-box.git
cd crossplane-box
```{{exec}}

```bash
just
```{{exec}}

> 📓 This `justfile` contains a set of recipes that help you to manage your
> Crossplane installation. You can find more information about the recipes in
> the [Crossplane Box
> Blog](https://resources.upbound.io/blogs/crossplane-in-a-box-your-toolkit-for-fast-prototyping-and-testing)

### Settings

Just supports a set of settings that you can use to customize the behavior of
the runner. For example:

```bash
set export
set shell := ["bash", "-uc"]
```

This tells `just` to export all variables and to use `bash -uc` for every shell
execution where the `-c` flag tells `bash` to run commands specified as text and
`-u` to treat unset variables as an error.

### Builtin Functions

Just provides a set of builtin functions. For example:

```bash
yaml          := justfile_directory() + "/yaml"
apps          := justfile_directory() + "/apps"
```

This tells `just` to define two variables `yaml` and `apps` that point to the
specific directories regardless where the `justfile` directory is located.

It is also easy to detect operatin system and conditionally execute different commands:

```bash
browse        := if os() == "linux" { "xdg-open "} else { "open" }
copy          := if os() == "linux" { "xsel -ib"} else { "pbcopy" }
replace       := if os() == "linux" { "sed -i"} else { "sed -i '' -e" }
```

Here we can see that `browse`, `copy`, and `replace` functions are defined based
on the operating system. Those can be used later in the recipes like this:

`kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d | {{copy}}`

### Recipe Parameters

Just allows you to define parameters for the recipes. For example:

```bash
# setup kind cluster
setup_kind cluster_name='control-plane':
  #!/usr/bin/env bash
  set -euo pipefail

  echo "Creating kind cluster - {{cluster_name}}"
  envsubst < kind-config.yaml | kind create cluster --config - --wait 3m
  kind get kubeconfig --name {{cluster_name}}
  kubectl config use-context kind-{{cluster_name}}
```

Here we can see that the `setup_kind` recipe takes a parameter `cluster_name`
which has a default value of `control-plane`.

### Control Flow Recipes

It's very easy to string together various recipes in a sequence. For example:

```bash
# * setup kind cluster with crossplane, ArgoCD and launch argocd in browser
setup: _replace_repo_user setup_kind setup_crossplane setup_argo launch_argo
```

Here we can see that the `setup` recipe is a sequence of other recipes. This is
useful when all commands are well tested and we want to quickly execute them in
a sequence.

## Next Steps

Next we will look at some advanced features of `just`.
