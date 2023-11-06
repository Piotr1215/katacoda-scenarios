To write a function in Go you need the following tools. Click on the commands to
make sure everything is installed and versions are correct.

- [Go](https://go.dev/dl/) 1.21 or newer. The guide uses Go 1.21.
  `go version`{{exec}}
- [Docker Engine](https://docs.docker.com/engine/). This guide uses Engine v24.
  `docker version --format 'Docker Server version: {{println .Server.Version}}Docker Client version: {{.Client.Version}}'
`{{exec}}
- The [Crossplane CLI](https://docs.crossplane.io/latest/cli) v1.14 or newer. This guide uses Crossplane CLI v1.14.
  `crossplane --version`{{exec}}

## Next Step

Next we are going to lean how to use `crossplane beta xpkg init` command to
initiate a new function repository.
