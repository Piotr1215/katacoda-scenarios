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

``bash
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
tac << 'EOF' >> justfile
default:
    just --list

EOF
```{{exec}}

```bash
just
```{{exec}}

