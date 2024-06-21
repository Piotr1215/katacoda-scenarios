Now our cluster is ready and apps are being installed as we speak. We didn't
need to navigate to different repositories, search for helm charts or write any
YAML files. 

Let's see what command line tools are available in arkade.

```bash
arkade get
```{{exec}}

And let's install a few.

```bash
arkade get vcluster \
    viddy \
    yq \ 
    k9s
```{{exec}}

Easy as pie 🥧!

Let's check our cluster with k9s!

```bash
k9s
```{{exec}}

We can also install any chart by using the `chart` subcommand. Let's try with
`crossplane`.

```bash
arkade install chart --repo-name stable/crossplane --chart crossplane
```{{exec interrupt}}

This was too easy 🤯!
