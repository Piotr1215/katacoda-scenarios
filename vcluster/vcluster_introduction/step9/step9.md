## What is Kueue?

> **Job queueing controller for Kubernetes batch workloads**

| **Feature**               | **Benefit**                        |
| ------------------------- | ---------------------------------- |
| Resource quotas & limits  | Fair sharing between teams         |
| Queue-based scheduling    | Priority and FIFO ordering         |
| Resource flavors          | Different node types & resources   |
| Preemption & priorities   | Critical jobs get resources first  |

> **CNCF Project:** Production-grade batch job management

## Deploy Kueue in vCluster with Virtual Scheduler

> Using virtual scheduler for complete Kueue isolation per team

### Create vCluster Configuration

```bash
cat <<EOF > kueue-vcluster.yaml
controlPlane:
  advanced:
    virtualScheduler:
      enabled: true  # Runs scheduler inside virtual cluster

sync:
  fromHost:
    nodes:
      enabled: true  # Required for virtual scheduler
EOF
```{{exec}}

### Deploy vCluster with Virtual Scheduler

```bash
vcluster create kueue-team --values kueue-vcluster.yaml --connect=false
kubectl wait --for=condition=ready pod -l app=vcluster -n vcluster-kueue-team --timeout=120s
```{{exec}}

## Install Kueue Inside vCluster

> Installing Kueue that will manage batch jobs independently

```bash
# Connect to vCluster first
vcluster connect kueue-team

# Install Kueue from official manifests
kubectl apply --server-side -f https://github.com/kubernetes-sigs/kueue/releases/download/v0.9.1/manifests.yaml

# Wait for Kueue controller to be ready
kubectl wait --for=condition=available deploy/kueue-controller-manager -n kueue-system --timeout=60s
```{{exec}}

## Configure Kueue Resources

> Set up ResourceFlavor, ClusterQueue, and LocalQueue

```bash
# Label node for Kueue flavor
kubectl label node node01 kueue.x-k8s.io/flavor=default --overwrite

# Create Kueue resources
kubectl apply -f - <<EOF
# ResourceFlavor defines the resources available
apiVersion: kueue.x-k8s.io/v1beta1
kind: ResourceFlavor
metadata:
  name: default-flavor
spec:
  nodeLabels:
    kueue.x-k8s.io/flavor: default
---
# ClusterQueue manages resources at cluster level
apiVersion: kueue.x-k8s.io/v1beta1
kind: ClusterQueue
metadata:
  name: team-a-cq
spec:
  namespaceSelector: {}
  queueingStrategy: StrictFIFO
  resourceGroups:
  - coveredResources: ["cpu", "memory"]
    flavors:
    - name: default-flavor
      resources:
      - name: cpu
        nominalQuota: 10
      - name: memory
        nominalQuota: 20Gi
---
# LocalQueue for team namespace
apiVersion: kueue.x-k8s.io/v1beta1
kind: LocalQueue
metadata:
  namespace: default
  name: team-a-queue
spec:
  clusterQueue: team-a-cq
EOF
```{{exec}}

## Deploy Sample Batch Jobs

> Submit multiple jobs to see Kueue's queue management

```bash
# Create three batch jobs with different resource requirements
kubectl apply -f - <<EOF
apiVersion: batch/v1
kind: Job
metadata:
  name: sample-job-1
  namespace: default
  labels:
    kueue.x-k8s.io/queue-name: team-a-queue
spec:
  parallelism: 1
  completions: 1
  suspend: true  # Kueue will unsuspend when admitted
  template:
    spec:
      containers:
      - name: worker
        image: busybox
        command: ["sh", "-c", "echo 'Processing batch job 1' && sleep 30"]
        resources:
          requests:
            cpu: "1"
            memory: "512Mi"
      restartPolicy: Never
---
apiVersion: batch/v1
kind: Job
metadata:
  name: sample-job-2
  namespace: default
  labels:
    kueue.x-k8s.io/queue-name: team-a-queue
spec:
  parallelism: 1
  completions: 1
  suspend: true
  template:
    spec:
      containers:
      - name: worker
        image: busybox
        command: ["sh", "-c", "echo 'Processing batch job 2' && sleep 30"]
        resources:
          requests:
            cpu: "2"
            memory: "1Gi"
      restartPolicy: Never
---
apiVersion: batch/v1
kind: Job
metadata:
  name: sample-job-3
  namespace: default
  labels:
    kueue.x-k8s.io/queue-name: team-a-queue
spec:
  parallelism: 1
  completions: 1
  suspend: true
  template:
    spec:
      containers:
      - name: worker
        image: busybox
        command: ["sh", "-c", "echo 'Processing batch job 3' && sleep 30"]
        resources:
          requests:
            cpu: "1"
            memory: "256Mi"
      restartPolicy: Never
EOF
```{{exec}}

## Check Queue Status

> View how Kueue manages the job queue

```bash
# Check Kueue workloads
kubectl get workloads

# Check job status - some may be pending due to resource limits
kubectl get jobs

# View ClusterQueue resource usage
kubectl describe clusterqueue team-a-cq | grep -A 10 "Status:"
```{{exec}}

## Virtual Scheduler Benefits

| **Benefit**              | **Impact**                                |
| ------------------------ | ----------------------------------------- |
| Independent Kueue versions | Each team runs their preferred version  |
| Complete queue isolation | No cross-team job interference           |
| Custom resource limits   | Per-team quotas and priorities          |
| Safe testing            | Test new Kueue features without risk     |

> **Key Point:** Each vCluster runs its own Kueue instance with virtual scheduler!