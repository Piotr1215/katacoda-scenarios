# Compose Kubernetes Applications

By utilizing Kubernetes provider, it's possible to control what Kubernetes resources are being created. It also enables complexity hiding for developers not familiar with Kubernetes Resource Model. In this scenario we will deploy a Kubernetes application consisting of:

- deployment
- service
- ingress
- horizontal pod autoscaler

Instead of exposing the resources directly to developers who might be inexperience with Kubernetes, we will create a simple composition containing only important fields, such as:

- namespace to deploy to
- image with tag
- name of the host for ingress
