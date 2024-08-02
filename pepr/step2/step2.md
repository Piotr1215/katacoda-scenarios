Let's create a new Pepr module and start experimenting:

```bash
pepr init
```{{exec}}

- module name: `pepr-demo`{{exec}}
- description: `A simple Pepr module`{{exec}}
- configure failure behavior: `^M`{{exec}}
- create module: `Y`{{exec}}

Let's see what the `pepr init` command created:

```bash
cd pepr-demo && tree 
```{{exec}}


### Kubernetes Resources Overview

> 💡 Open [Octant]({{TRAFFIC_HOST1_7777}}) to see Kubernetes dahsboard.

## Next Step

Start pepr in dev mode
