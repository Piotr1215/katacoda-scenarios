## It's like a Makefile _just_ better

Every project needs to orchestrate commands; whether for testing, building,
creating components, infrastructure and many many more. This is typically done via a `Makefile` or `bash scripts`. The problem with `make` is that it is designed as a tool to _build\_C source code, it \_can_ run commands but that's not its purpose. This means that when using `Makefile` we take on the whole unnecessary baggage of the build part.

`Bash scripts` are a bit better but after a while when more scripts are created,
managing them and their dependencies becomes a nightmare.

There is a tool that combines best of both worlds; [just](https://github.com/casey/just) is similar to `make`, but focused on commands orchestration.

![justfile-pic](./_media/justfile-pic.png)

## Next Step

Next we will install `just` and setup a simple `justfile` to see how it works.
> 👇🖱️Clicking on grayed command like below will execute it in the terminal.

### Installation

We can install `just` using an installation script

```bash
curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh \
    | bash -s -- --to /usr/local/bin
```{{exec}}

We can confirm that the installation was succesfull by running

```bash
just --version
```{{exec}}

### Setting up sample project

Create a directory for the sample project

```bash
mkdir -p ./just-example && cd ./just-example
```{{exec}}

Create a `justfile` in the project directory

```bash
cat << 'EOF' > justfile
# This is a comment
hello:
    echo "Hello, World!"
EOF
```{{exec}}

### Running the first command

Now we can run the `hello` command

> 💡 by default `just` will run first recipe in the `justfile` if we don't
> specify one

```bash
just
```{{exec}}

## Next Step

Next we will learn basic commands and syntax of `just`.

> Commands in `justfile` are called recipes. 

We can use `@` to supress printing the command to the terminal. This is useful when we want to
show only command output and not the command itself.

### Suppressing command

```bash
cat << 'EOF' >> justfile

supress_command:
    @echo "Only this is printed"

full_command:
    echo "Both command and output are printed"
EOF
```{{exec}}

Now we can run the `supress_command` and `full_command` commands

```bash
just supress_command
just full_command
```{{exec}}

### Running faulty recipes will fail early

Recipes will fail if any of the commands return non-zero exit code.

```bash
cat << 'EOF' >> justfile

fail_recipe:
    @ls /non-existing-dir
    @echo "This is never printed"
EOF
```{{exec}}

```bash
just fail_recipe
```{{exec}}

### Recipes can have dependencies.

```bash
cat << 'EOF' >> justfile

dependency:
    @echo "This is the dependency"

dependent: dependency
    @echo "This is the dependent"
EOF
```{{exec}}

```bash
just dependent
```{{exec}}

### Running multiple recipes

```bash
cat << 'EOF' >> justfile

recipe1:
    @echo "This is recipe1"

recipe2:
    @echo "This is recipe2"
EOF
```{{exec}}

```bash
just recipe1 recipe2
```{{exec}}

### Default recipe

If we don't specify a recipe, `just` will run the first recipe in the
`justfile`. We can specify a default recipe by using `default` as the recipe name.

```bash
{
    echo "default:"
    echo "    just --list"
    echo ""
    cat justfile
} | sponge justfile
```{{exec}}

```bash
just
```{{exec}}

Notice that running `just` this time simply printed the list of recipes.

> 💡 comments on top of recipes are used as descriptions when running `just
> --list`

## Next Step

There are many more features in `just` that we can explore. Next we will look an
at example production ready `justfile`

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
Just offers a lot of flexibility and power to define and execute recipes. It is
continuously being improved and has a very active community. Here are some
advanced features that helped me to write complex recipes:

### Using Shell Recipes

`just` allows you to define recipes in any shell language. This is very useful
when you need to write complex shell scripts. For example:

```justfile
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
cd cd ../just-example/
cat <<EOF >> justfile 
date_suffix                      := `echo test_$(date +%F)`
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


# Finish
