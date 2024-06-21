Installing **arkade** is easy. 

> 💡 No need to remember all the installation commands, just memorize the
> one-liner below.

```bash
curl -sLS https://get.arkade.dev | sudo sh
arkade --help
```{{exec}}

## Usage overview

Arkade can be used to install Kubernetes apps or to download CLI tools.

    arkade install - install a Kubernetes app
    arkade info - see the post installation screen for a Kubernetes app
    arkade get - download a CLI tool
    arkade update - perform a self-update of arkade on MacOS and Linux

An arkade "app" could represent a helm chart such as openfaas/faas-netes, a custom CLI installer such as istioctl, or a set of static manifests (i.e. MetalLB).

An arkade "tool" is a CLI that can be downloaded for your operating system. Arkade downloads statically-linked binaries from their upstream locations on GitHub or the vendor's chosen URL such as with kubectl and terraform.
