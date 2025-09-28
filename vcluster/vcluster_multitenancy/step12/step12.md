Try to implement the following on your own:

- [Isolated workloads](https://www.vcluster.com/docs/vcluster/deploy/topologies/isolated-workloads)
- [Multi-Namespace Mode](https://www.vcluster.com/docs/vcluster/deploy/topologies/multi-namespace-mode)

## Platform Overview

Helps manage virtual clusters across multiple teams and namespaces.

```bash
vcluster platform start --password=admin123
```{{exec}}

Let's add the virtual cluster to the platform and watch the resources in the `test-namespace`.

```bash
kubectl get pods -n test-namespace
```{{exec}}


