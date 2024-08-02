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
cd pepr-demo && tree -I 'node_modules' 
```{{exec}}

## Next Step

Start pepr in dev mode
