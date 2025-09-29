We can reuse the metrics server from the host cluster within the vCluster.

> 📚 **Documentation**: For more details, see the [vCluster Metrics Server Integration docs](https://www.vcluster.com/docs/vcluster/configure/vcluster-yaml/integrations/metricsServer)

The metrics server is already installed on the host cluster. Let's create a vCluster that uses it.

```bash
cat <<EOF > vcluster-metrics.yaml
integrations:
  metricsServer:
    enabled: true
    nodes: true
    pods: true
EOF
```{{exec}}

```bash
vcluster create host-metrics-vcluster -f vcluster-metrics.yaml --connect=true
```{{exec}}

Now the metrics API should be available within the vCluster. Let's test it:

```bash
kubectl top nodes
```{{exec}}

```bash
kubectl top pods -A
```{{exec}}

> Notice we didn't need to install metrics server on the virtual cluster. We just reused it from the host cluster.

## Next Step

```bash
vcluster disconnect host-metrics-vcluster
vcluster delete host-metrics-vcluster
```{{exec}}

Check your knowledge by taking a short quiz.

