# OpenTelemetry Integration with Traefik 3.0 📊

Let's adjust our setup to resolve the port conflicts and address the localhost issue:

1. Stop and remove the existing whoami container:

```bash
docker stop whoami && docker rm whoami
```{{exec interrupt}}

2. Update the Traefik configuration:

```bash
cat << EOF > traefik.yml
entryPoints:
  web:
    address: ":8000"

providers:
  file:
    directory: /etc/traefik/dynamic
    watch: true

api:
  insecure: true
  dashboard: true

metrics:
  prometheus: {}

tracing:
  otlp:
    http:
      endpoint: "http://0.0.0.0:4318"
EOF
```{{exec}}

3. Start the whoami container on a different port:

```bash
docker run -d --name whoami -p 8080:80 traefik/whoami
```{{exec}}

4. Update the dynamic configuration:

```bash
cat << EOF > /etc/traefik/dynamic/whoami.yml
http:
  routers:
    whoami:
      rule: "PathPrefix(\`/whoami\`)"
      service: whoami
  services:
    whoami:
      loadBalancer:
        servers:
          - url: "http://0.0.0.0:8080"
EOF
```{{exec}}

5. Now, start Traefik:

```bash
traefik --configfile=traefik.yml
```{{exec}}

6. In a new terminal, generate some traffic:

```bash
for i in {1..10}; do curl -s http://0.0.0.0:8000/whoami > /dev/null; done
```{{exec}}

You can access the Traefik dashboard at: {{TRAFFIC_HOST1_8080}}

And the whoami service at: {{TRAFFIC_HOST1_8000}}/whoami

For Prometheus metrics, you can query them at: {{TRAFFIC_HOST1_8000}}/metrics

In the next step, we'll explore Traefik's new support for the Gateway API!
