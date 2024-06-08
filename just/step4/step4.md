Just offers a lot of flexibility and power to define and execute recipes. It is
continuously being improved and has a very active community. Here are some
advanced features that helped me to write complex recipes:

### Using Shell Recipes

`just` allows you to define recipes in any shell language. This is very useful
when you need to write complex shell scripts. For example:

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

Notice the `#!/usr/bin/env bash` shebang at the beginning of the recipe. This
means that the recipe is executed by single bash subshell and can share
variables context.

### Commands Evaluation

Variables' values are evaluated at runtime. This means that you can use

```bash
date_suffix                      := `echo test_$(date +%F)`
```

This will allow to use the `date_suffix` variable in the recipes and it will
add suffix with test_(current date). Let's try it out:

```bash
cat <<EOF >> justfile 
date_suffix                      := \`echo test_\$(date +%F)\`
add_suffix:
  echo "Adding date suffix: {{date_suffix}}"
EOF
```{{exec}}

### Just Scripts

Adding `#!/usr/bin/env -S just --justfile` shebang to the script allows to call
just recipes directly as if they were scripts. This is very useful when working
with system wide scripts. For example, I use this alias to call `just` recipe
that sets up my kind cluster with crossplane.

```bash
alias uxp="just ~/dev/dotfiles/scripts/uxp-setup/setup_infra"
```

This allows me to call `uxp` from anywhere in the system and it will execute the
`setup_infra` recipe.

### Interactive Mode

Just has an interactive mode that allows you to select recipes from the list
using the `--choose` flag. Another alias I like to use is:

```bash
.j: aliased to just --justfile ~/dev/dotfiles/scripts/uxp-setup/justfile --working-directory ~/dev/dotfiles/scripts/uxp-setup --choose
```

## Next Steps

We have _just_ scratched the surface of what `just` can do. Read more about
features in just [documentation](https://just.systems/man/en/chapter_22.html).


