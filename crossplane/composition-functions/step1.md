Following components are being installed:

✔ helm

✔ crossplane

✔ crossplane CLI

✔ kubernetes provider

✔ komoplane observability

> Wait until "All Set" message is displayed on the screen and verify if cluster is setup correctly

Check the cluster setup `kubectl get pods -A`{{exec}}

Check Kuberentes cluster info and version `kubectl cluster-info && echo && kubectl version`{{exec}}

Proceed to step 2 where we will explore the setup ➡

## Observability 🔎

> During this exercise, feel free to click on _Komoplane_ tab and explore
> compositions status in a visual way. We will focus on _kubectl_ commands.

Click on the Dashboard tab or run Komoplane from this link:
[Komoplane]({{TRAFFIC_HOST1_8090}})
