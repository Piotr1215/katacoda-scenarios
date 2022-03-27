# Crossplane Rancher Provider

This workshop will show how to use another Crossplane Provider: [Provider Jet Rancher](https://github.com/crossplane-contrib/provider-jet-rancher)

- Use helm provider to install rancher
- Configure Rancher installation using its Crossplane provider

> At the end of this tutorial you will able to create a free account in [Upbound Cloud](https://www.upbound.io/) and try provisioning cloud infrastructure youself!

What makes Crossplane so special? First, it builds on Kubernetes and capitalizes on the fact that the real power of Kubernetes is its powerful API model and control plane logic (control loops). It also moves away from Infrastructure as Code to Infrastructure as Data. The difference is that IaC means writing code to describe how the provisioning should happen, whereas IaD means writing pure data files (in the case of Kubernetes YAML) and submitting them to the control component (in the case of Kubernetes an operator) to encapsulate and execute the provisioning logic.

The best part about Crossplane is that it seamlessly enables collaboration between Application Teams and Platform Teams, by leveraging [Kubernetes Control](https://containerjournal.com/kubeconcnc/kubernetes-true-superpower-is-its-control-plane/) Plane as the convergence point where everyone meets.

## High Level Architecture

> For a more overview of Crossplane, check out this [short presentation](https://slides.com/decoder/crossplane) and very comprehensive [Crossplane Docs](https://crossplane.io/docs/v1.6/).

Below diagram explains Crossplane's components and their relations.

<details>
    <summary>Click here to see Crossplane architecture diagram</summary>

![crossplane-components](http://www.plantuml.com/plantuml/proxy?cache=yes&src=https://raw.githubusercontent.com/Piotr1215/crossplane-demo/master/diagrams/crossplane-components.puml&fmt=png)

</details>

