Following components are being installed:

- ✔ k3s cluster
- ✔ crossplane
- ✔ crossplane CLI
- ✔ helm

> Wait until "Cluster Ready" message is displayed on the screen

Check the cluster setup `kubectl get pods -A`{{execute T1}}

Check Kuberentes cluster info and version `kubectl cluster-info && echo && kubectl version --short`{{execute T1}}

Proceed to 👞 2 where we will setup Crossplane’s Kuberentes Provider.
