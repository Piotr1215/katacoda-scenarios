> 💡 Before proceeding with the installation steps, wait for the environment to be ready.

There are 3 ways to install _vcluster_:

- using the CLI
- via Helm chart
- with _kubectl_ applying the manifest directly

We will use the CIL as it provides a few handy features we will use.
Download the latest _vcluster_ CLI.

> 👇🖱️Clicking on grayed command like below will execute the command in the terminal.

```bash
curl -L -o vcluster "https://github.com/loft-sh/vcluster/releases/latest/download/vcluster-linux-amd64" \
    && sudo install -c -m 0755 vcluster /usr/local/bin \
    && rm -f vcluster
```{{exec}}

## Next Step

Next we will see how to achieve resources isolation using Kubernetes namespaces.
