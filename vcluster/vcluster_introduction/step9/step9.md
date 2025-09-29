> Using virtual scheduler for true KAI isolation per team

```yaml
experimental:
  syncSettings:
    setOwner: false  # Required for KAI pod-grouper

controlPlane:
  advanced:
    virtualScheduler:
      enabled: true   # Runs scheduler inside a virtual cluster

sync:
  fromHost:
    nodes:
      enabled: true   # Syncs host nodes for labels detection
    runtimeClasses:
      enabled: true   # Syncs NVIDIA runtime
    # Auto-enabled with virtual scheduler:
    csiDrivers: auto
    csiNodes: auto
    csiStorageCapacities: auto
```

| **Virtual Scheduler Benefits** | **Impact**                                |
| ------------------------------ | ----------------------------------------- |
| Independent KAI versions       | Each team runs v0.7.11, v0.9.2, or v0.9.3 |
| Complete scheduler isolation   | KAI decisions stay within vCluster        |
| True scheduling autonomy       | No cross-team interference                |
| Verified working               | Pods scheduled by vCluster's KAI          |

```bash
vcluster create kai-isolated --values kai-vcluster.yaml
```{{exec}}

## Install KAI Inside vCluster

> Installing KAI scheduler that will make independent scheduling decisions

```bash
# Connect to vCluster first
vcluster connect kai-isolated

# Install KAI - it will be THE scheduler for this vCluster
KAI_VERSION=v0.7.11
helm upgrade -i kai-scheduler \
  oci://ghcr.io/nvidia/kai-scheduler/kai-scheduler \
  -n kai-scheduler --create-namespace \
  --version $KAI_VERSION \
  --set "global.gpuSharing=true"

kubectl wait --for=condition=ready pod -n kai-scheduler --all --timeout=120s
```{{exec}}

## Deploy and Test GPU Workload in vCluster

```bash
# Apply queues and deploy two pods with different GPU fractions
kubectl apply -f queues.yaml
kubectl apply -f gpu-demo-pod1.yaml
kubectl apply -f gpu-demo-pod2.yaml

kubectl wait --for=condition=ready pod -n default --all --timeout=120s

# Show both pods sharing the GPU
kubectl get pods -l app=gpu-demo -o custom-columns=NAME:.metadata.name,FRACTION:.metadata.annotations."kai\.scheduler/gpu-fraction",STATUS:.status.phase
```{{exec}}
