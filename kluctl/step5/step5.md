First we need to change to the root of the `kluctl-project` repository and initialize a git repository there.

```bash
cd /root/kluctl-project && \
   git init && \
   git add . && \
   git commit -m "Initial commit"
```{{exec}}

Now we can deploy the application to dev environment.

```bash
kluctl deploy --yes -t dev
```{{exec}}

> 💡 Notice that we are using the `--yes` flag to avoid the confirmation prompt.
> This is useful for the scenario, but in real life you should always review the changes before applying them.

## Next Step

Next we will introduce changes to our setup and see how `kluclt` handles them.
