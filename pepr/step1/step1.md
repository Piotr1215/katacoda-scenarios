### Prerequisites

- Node.js v18.0.0+ (even-numbered releases only)

- npm v10.1.0+

> Node.js v18+ and npm v10.1.0+ are already installed on this environment.

```bash
source ~/.bashrc
```{{exec}}

### Installing Pepr

```bash
npm -i -g pepr@33.0
```

### Creating Pepr Module

Let's create a new Pepr module and start experimenting:

```bash
pepr init
```{{exec}}

- module name: `pepr-demo`{{exec}}
- description: `A simple Pepr module`{{exec}}
- create module: `Y`{{exec}}

Start Pepr in development mode:

```bash
cd pepr-demo && pepr dev --host host.docker.internal
```{{exec}}

> 💡 The `--host host.docker.internal` flag is used because we're not using k3d in this environment.

Explore the files in the editor

## Next Step

Create and run a simple Pepr module.
