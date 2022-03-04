## Kubernetes Provider

We will start by practical demonstration of Crossplane composition by utilizing Kubernetes Provider and later explain relevant concepts based on actual cloud providers!

> Crossplane can compose infrastructure from various providers and most common usecase is cloud infrastructure. However, composing cloud infrastructure requires access to cloud and storing credentials in a secret. This is obviously not safe and that's why we will use Kubernetes Provider. All the Crossplane concepts and techniques equally apply to cloud provider infrastructure.

By utilizing [Kubernetes provider](https://github.com/crossplane-contrib/provider-kubernetes), it's possible to control what Kubernetes resources are being created. It also enables complexity hiding for developers not familiar with [Kubernetes Resource Model](https://github.com/Kubernetes/design-proposals-archive/blob/main/architecture/resource-management.md). In this scenario we will deploy a Kubernetes application consisting of:

- deployment
- service
- horizontal pod autoscaler

Instead of exposing the resources directly to developers who might be inexperience with Kubernetes, we will create a simple composition containing only important fields, such as:

- namespace to deploy to
- image with tag
