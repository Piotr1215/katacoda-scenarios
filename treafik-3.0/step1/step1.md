# Step 1: Installing Traefik 3.0

In this first step, we'll install Traefik 3.0 and set up a basic configuration.

## Download Traefik 3.0

First, let's download the Traefik 3.0 binary:

```bash
wget https://github.com/traefik/traefik/releases/download/v3.0.0/traefik_v3.0.0_linux_amd64.tar.gz
```{{exec}}

Now, let's extract the binary:

```bash
tar -zxvf traefik_v3.0.0_linux_amd64.tar.gz
```{{exec}}

Move the Traefik binary to a directory in your PATH:

```bash
sudo mv traefik /usr/local/bin/
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

You should see output indicating that Traefik has started successfully.

## Access the Dashboard

You can now access the Traefik dashboard by clicking on the following link:

{{TRAFFIC_HOST1_8080}}

In the next step, we'll dive into configuring OpenTelemetry integration with Traefik 3.0!
