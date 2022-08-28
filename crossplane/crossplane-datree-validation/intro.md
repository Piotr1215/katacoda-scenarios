## Setting up the Environment

Following components are being installed:

✔ k3s cluster

✔ helm

✔ crossplane

✔ datree CLI

✔ kubernetes provider

✔ octant & k9s observability

> Wait until "**All Set**" message is displayed on the screen and verify if
> cluster is set up correctly

Check the cluster setup `kubectl get pods -A`{{exec}}

Check Kuberentes cluster info and version
`kubectl cluster-info && echo && kubectl version --short`{{exec}}

## Observability 🔎

> During this exercise, feel free to click on _Octant_ tab and explore cluster
> status in a visual way or use _k9s_ to stay in the terminal.

Click on the Dashboard tab or run octant from this link:
[Octant]({{TRAFFIC_HOST1_7777}})

Type `k9s` to use CLI cluster visualization.

## What you will learn

This workshop will help you understand how to use `datree` to validate
Crossplane's compositions.

- Get a quick refresher about Crossplane
- Learn what Datree is and how it works
- Go through real world scenario of creating, and validating Crossplane's
  compostion with Datree

<mark>
    Remember, this is a live environment, feel free to experiment and use all the available tools to dive deeper in your own pace.
</mark>

> In case of errors try to restart the environment.

If all is ok, proceed to next steps. ➡
