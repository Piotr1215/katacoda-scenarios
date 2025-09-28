# Flexible Multi-Tenancy with vCluster

## Workshop Overview

This workshop demonstrates how to implement flexible Kubernetes multi-tenancy using vCluster, allowing teams to operate with complete isolation while sharing infrastructure efficiently.

### Learning Objectives

- Understand vCluster architecture and its benefits over namespace isolation
- Create and manage multiple virtual clusters with different configurations
- Implement resource quotas and limits for different team scenarios
- Configure advanced features like ingress synchronization and cross-cluster DNS
- Backup and restore vCluster state using snapshots

### The Multi-Tenancy Challenge

Traditional Kubernetes multi-tenancy using namespaces has significant limitations:

**Namespace-based isolation:**
- Shared control plane and API server
- No CRD isolation between teams
- Version lock-in across all tenants
- Risk of noisy neighbor problems
- Limited RBAC flexibility

### vCluster Solution

vCluster provides each team with their own Kubernetes control plane running inside a pod:

```
Host Kubernetes Cluster
├── vCluster Team A (own control plane, API server, scheduler)
├── vCluster Team B (own control plane, API server, scheduler)
└── vCluster Team C (own control plane, API server, scheduler)

Shared: Infrastructure, Nodes, Network, Storage
Isolated: Control Plane, CRDs, RBAC, Kubernetes Version
```

### Key Benefits

| Feature | Namespace Isolation | vCluster |
|---------|-------------------|----------|
| Control Plane | Shared | Dedicated per team |
| CRD Conflicts | Yes | No |
| K8s Version | Shared | Independent |
| Provisioning | Instant | < 60 seconds |
| Resource Overhead | None | ~100MB RAM |
| Full Admin Access | Risky | Safe |

### Workshop Structure

**Part 1: Fundamentals**
- Understanding vCluster architecture
- Installation and environment setup
- Creating your first vCluster

**Part 2: Multi-Tenancy Scenarios**
- Development team with resource limits
- Production team with full features
- Partner team with pre-populated resources

**Part 3: Advanced Features**
- Resource quotas and limits
- Data persistence and backups
- Ingress and service synchronization

### Prerequisites

Before starting, the environment will provide:
- Kubernetes cluster (single node)
- kubectl configured and ready
- 4GB RAM available
- Internet connectivity for downloads

### Ready to Begin?

Click **Start** to begin exploring vCluster's approach to multi-tenancy.