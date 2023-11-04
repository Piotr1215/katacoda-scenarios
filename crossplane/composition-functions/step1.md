This environment comes with the following components pre-installed:

✔ helm

✔ crossplane v 1.14

✔ crossplane CLI

✔ komoplane for observability

> Wait until "All Set" message is displayed on the screen and verify if cluster is setup correctly

Check the cluster setup `kubectl get pods -A`{{exec}}

Check Kuberentes cluster info and version `kubectl cluster-info && echo && kubectl version`{{exec}}

Proceed to step 2 where we will explore the setup ➡

## Observability 🔎

> During this exercise, feel free to use _Komoplane_ and explore
> crossplane resources in a visual way.

Start [Komoplane]({{TRAFFIC_HOST1_8090}}) in a new tab
