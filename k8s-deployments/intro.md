# Kubernetes Deployments: scaling, rollouts, rollbacks

> Visit Kubernetes documentation if you need a refresher about [Deployments](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)
>
> Basic definitions are provided on diagrams below

## How does it work?

Typical deployment resource consists of following objects

![Deployment Spec](http://www.plantuml.com/plantuml/proxy?cache=yes&src=https://raw.githubusercontent.com/Piotr1215/dca-prep-kit/master/diagrams/k8s-deployment-spec.puml&fmt=png)

As usual *apiVersion, kind, metadata and spec* are mandatory fields in every Kubernetes resource. Deployment adds following important fields under *spec*:

- replicas: number of pods replicated via the deployment
- selector: tells Kubernetes how deployment should find pods to act on
- template: fields under this section refer to pod specification that deployment acts on