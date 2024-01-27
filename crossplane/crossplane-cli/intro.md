## Introduction

<!-- TODO:(piotr1215) add back link to blog when ready --> 
This workshop will help you understand how to use various `crossplane CLI`
commands and how they can help you with your day-to-day crossplane tasks

> At the end of this tutorial you will:

- 🦉 Understand how to use all the crossplane CLI commands with practical
  examples at every stage:

  - 🚀 initiate a new project with `crossplane beta init` including running an
    `init.sh` script
  - 🔄 convert classic P&T composition to a new function P&T using `crossplane beta convert pipeline-composition`
  - 🔀 convert a ControllerConfig to a DeploymentRuntimeConfig using `crossplane beta convert deployment-runtime`
  - ✅ validate composition against a schema using `crossplane beta validate`
  - 🔍 improvements to `crossplane beta trace` command allow tracing packages
  - 📊 quickly check resources utilization of crossplane pods using `crossplane beta top`

## Crossplane Recap

What makes Crossplane so special? First, it builds on Kubernetes and capitalizes
on the fact that the real power of Kubernetes is its powerful API model and
control plane logic (control loops). It also moves away from Infrastructure as
Code to Infrastructure as Data. The difference is that IaC means writing code to
describe how the provisioning should happen, whereas IaD means writing pure data
files (about Kubernetes YAML) and submitting them to the control
component (about Kubernetes an operator) to encapsulate and execute the
provisioning logic.

The best part about Crossplane is that it seamlessly enables collaboration
between Application Teams and Platform Teams, by leveraging
[Kubernetes Control](https://containerjournal.com/kubeconcnc/kubernetes-true-superpower-is-its-control-plane/)
Plane as the convergence point where everyone meets.

## High Level Architecture

> For a more overview of Crossplane, check out this
> [short presentation](https://slides.com/decoder/crossplane) and very
> comprehensive [Crossplane Docs](https://crossplane.io/docs/).
