# Mutual TLS with Linkerd

> Visit Linkerd documentation if you need a refresher about [service mesh](https://linkerd.io/what-is-a-service-mesh/)
>
> Basic definitions are provided on diagrams below
> This scenario is part of a [blog about mTLS with linkerd](https://itnext.io/how-to-secure-kubernetes-in-cluster-communication-5a9927be415b)

## How does it work?

Once installed on the cluster, linkerd control plane will inject sidecars to Kubernetes system pods. From there we can inject sidecars to the pods and create a service mesh.

![Linkerd mTLS](http://www.plantuml.com/plantuml/proxy?cache=yes&src=https://raw.githubusercontent.com/Piotr1215/dca-prep-kit/master/diagrams/linkerd-mtls-sequence.puml&fmt=png)

## What Problem does it solve?

Service meshes add observability, security, and reliability features to “cloud native” applications by transparently inserting this functionality at the platform layer rather than the application layer.

- **Platform Level Metrics**: without changing configuration or source code, track low level metrics
- **Mutual TLS - mLTS**: add encryption and certificates based identity to cluster workloads
- **Improved Resiliency**: latency aware load balancing, retires, timeouts and advanced deployment patterns
- **Authorization Policy**: enforce traffic rules on services level

In next steps of this tutorial we will focus on setting up and utilizing mutualTLS with Linkerd

