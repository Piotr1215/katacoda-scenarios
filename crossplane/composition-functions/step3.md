## Tools of the trade

To write a function in Go you need:

- [Go](https://go.dev/dl/) 1.21 or newer. The guide uses Go 1.21.
- [Docker Engine](https://docs.docker.com/engine/). This guide uses Engine v24.
- The [Crossplane CLI](https://docs.crossplane.io/latest/cli) v1.14 or newer. This guide uses Crossplane CLI v1.14.

Let's make sure everything is installed in our environment:

```bash
go version
docker version --format 'Docker Server version: {{println .Server.Version}}Docker Client version: {{.Client.Version}}'
echo "Crossplane version: $(crossplane --version)"
```{{exec}}

If we got all the right prerequisites version, let's move to the next step
