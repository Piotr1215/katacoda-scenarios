# OpenTelemetry Integration with Traefik 3.0 📊

Let's set up our environment with the correct port configurations:

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
  dashboard:
    address: ":8085"
providers:
  file:
    directory: /etc/traefik/dynamic
    watch: true
api:
  insecure: true
  dashboard: true
  entrypoint: dashboard
metrics:
  prometheus: {}
tracing:
  otlp:
    http:
      endpoint: "http://0.0.0.0:4318"
EOF
```{{exec}}

3. Start the whoami container:

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

5. Start Traefik:

```bash
traefik --configfile=traefik.yml
```{{exec}}

6. In a new terminal, generate some traffic:

```bash
for i in {1..10}; do curl -s http://0.0.0.0:8000/whoami > /dev/null; done
```{{exec}}

You can access:
- The Traefik dashboard at: {{TRAFFIC_HOST1_8085}}
- The whoami service at: {{TRAFFIC_HOST1_8000}}/whoami
- Prometheus metrics at: {{TRAFFIC_HOST1_8000}}/metrics

In the next step, we'll explore Traefik's new support for the Gateway API!
