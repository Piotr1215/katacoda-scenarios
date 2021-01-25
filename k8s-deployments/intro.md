# Kubernetes Deployments: scaling, rollouts, rollbacks

> Visit Kubernetes documentation if you need a refresher about [Deployments](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)
>
> Basic definitions are provided on diagrams below
> This scenario is part of a [blog about Kubernetes deployments](https://itnext.io/kubernetes-explained-deep-enough-deployments-371755fbe2a3)

## How does it work?

Typical deployment resource consists of following objects

![Deployment Spec](http://www.plantuml.com/plantuml/proxy?cache=yes&src=https://raw.githubusercontent.com/Piotr1215/dca-prep-kit/master/diagrams/k8s-deployment-spec.puml&fmt=png)

As usual *apiVersion, kind, metadata and spec* are mandatory fields in every Kubernetes resource. Deployment adds following important fields under *spec*:

- replicas: number of pods replicated via the deployment
- selector: tells Kubernetes how deployment should find pods to act on
- template: fields under this section refer to pod specification that deployment acts on

## What Problem does it solve?

Deployments are very flexible and can be used in many ways. Below I have selected most important problems that deployments help solve.

- **Scalability**: enable up and down-scaling of pods
- **Configuration**: enables changing of pods state and configuration on the flight
- **Deployment**: enables zero-downtime updates of pods to new versions
- **Delivery Control**: enables high degree of control over delivery process by using rollouts and rollbacks

In next steps of this tutorial we will perform experiments to make sure prove the above statements.

Let's get to the exercises!