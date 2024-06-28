# Step 1: Installing Traefik 3.0

In this first step, we'll install Traefik 3.0 and set up a basic configuration.

## Download and Install Traefik 3.0

Let's download, extract, and install Traefik 3.0 in one command:

```bash
wget https://github.com/traefik/traefik/releases/download/v3.0.0/traefik_v3.0.0_linux_amd64.tar.gz && \
tar -zxvf traefik_v3.0.0_linux_amd64.tar.gz && \
sudo mv traefik /usr/local/bin/ && \
rm traefik_v3.0.0_linux_amd64.tar.gz
```{{exec}}

## Verify Installation

Let's verify that Traefik 3.0 is correctly installed:

```bash
traefik version
```{{exec}}

You should see output indicating Traefik version 3.0.0.

## Create a Basic Configuration

Now, let's create a basic Traefik configuration file:

```bash
cat << EOF > traefik.yaml
entryPoints:
  web:
    address: ":80"

providers:
  file:
    directory: /etc/traefik/dynamic
    watch: true

api:
  insecure: true
  dashboard: true
EOF
```{{exec}}

This configuration:
- Sets up an entrypoint on port 80
- Configures Traefik to watch for dynamic configuration files
- Enables the API and dashboard in insecure mode (for demonstration purposes)

## Create Dynamic Configuration Directory

Let's create the directory that Traefik will watch for dynamic configuration:

```bash
sudo mkdir -p /etc/traefik/dynamic
```{{exec}}

## Start Traefik

Now we can start Traefik with our new configuration:

```bash
traefik --configfile=traefik.yaml
```{{exec}}

## Important Note on Service Configuration

When configuring services to work with Traefik in this Killercoda environment, ensure they are set to listen on all interfaces (0.0.0.0) and not just localhost. This allows the services to be accessible from outside the container or VM.

For example, if you're running a web service, make sure it's configured to listen on 0.0.0.0:port instead of localhost:port or 127.0.0.1:port.

## Access the Dashboard

You can now access the Traefik dashboard by clicking on the following link:

{{TRAFFIC_HOST1_8080}}

In the next step, we'll dive into configuring OpenTelemetry integration with Traefik 3.0!
