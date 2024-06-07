We can use `@` to supress printing the command to the terminal. This is useful when we want to
show only command output and not the command itself.

```bash
cat << 'EOF' >> justfile

supress_command:
    @echo "This will not be printed only once"

full_command:
    echo "This will be printed twice"
EOF
```{{exec}}

Now we can run the `supress_command` and `full_command` commands

```bash
just supress_command
just full_command
```{{exec}}
