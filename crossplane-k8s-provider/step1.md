Following components are being installed:

✔ k3s cluster\
✔ helm\
✔ crossplane\
✔ crossplane CLI\
✔ kubernetes provider

> Wait until "All Set" message is displayed on the screen and verify if cluster is setup correctly

Check the cluster setup `kubectl get pods -A`{{execute T1}}

Check Kuberentes cluster info and version `kubectl cluster-info && echo && kubectl version --short`{{execute T1}}

Proceed to step 2 where we will explore the setup ➡

