## Step 1: Setting Up Pepr 🛠️

### Prerequisites

- Node.js v18.0.0+ (even-numbered releases only)

- npm v10.1.0+

> Node.js v18+ and npm v10.1.0+ are already installed on this environment.

### Creating Pepr Module

Let's create a new Pepr module and start experimenting:

1. Create a new Pepr Module:

```bash
npx pepr init
```{{exec}}

2. Start Pepr in development mode:

```bash
npx pepr dev --host host.docker.internal
```{{exec}}

3. In a new terminal, apply the sample configuration:

```bash
kubectl apply -f capabilities/hello-pepr.samples.yaml
```{{exec}}

> 💡 The `--host host.docker.internal` flag is used because we're not using k3d in this environment.

Now you're ready to explore Pepr's capabilities! In the next steps, we'll dive deeper into how Pepr can simplify your Kubernetes workflows.

## Next Step

We'll explore basic commands and usage patterns in Pepr.
