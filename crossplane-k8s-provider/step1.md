Following components are being installed:

✔ k3s cluster</BR>
✔ helm</BR>
✔ crossplane</BR>
✔ crossplane CLI</BR>
✔ kubernetes provider

> Wait until "All Set" message is displayed on the screen and verify if cluster is setup correctly

Check the cluster setup `kubectl get pods -A`{{execute T1}}

Check Kuberentes cluster info and version `kubectl cluster-info && echo && kubectl version --short`{{execute T1}}

Proceed to step 2 where we will explore the setup ➡

## Observability

> During this exercise, feel free to click on *Octant* tab and explore cluster status in a visual way. We will focus on *kubectl* commands.

Click on the Dashboard tab or run octant from this link: https://[[HOST_SUBDOMAIN]]-7777-[[KATACODA_HOST]].environments.katacoda.com/

