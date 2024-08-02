Let's create a new Pepr module and start experimenting:

```bash
pepr init
```{{exec}}

- module name: `pepr-demo`{{exec}}
- description: `A simple Pepr module`{{exec}}
- configure failure behavior: `^M`{{exec}}
- create module: `Y`{{exec}}

Start Pepr in development mode:

```bash
cd pepr-demo && pepr dev
```{{exec}}

Confirm module redeploy `Y`{{exec}} 

### Kubernetes Resources Overview

> 💡 Open [Octant]({{TRAFFIC_HOST1_7777}}) to see Kubernetes dahsboard.

## Next Step

Add simple capability
