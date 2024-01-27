This environment comes with the following components pre-installed:

✔ helm

✔ crossplane v 1.14

✔ crossplane CLI

> Wait until "All Set" message is displayed on the screen and verify if cluster is setup correctly

Check the cluster setup `kubectl get pods -A`{{exec}}

Check Kuberentes cluster info and version `kubectl cluster-info && echo && kubectl version`{{exec}}

Proceed to step 2 where we will explore the setup ➡

## Next Step

Next we will learn how to use the **crossplane beta xpkg init** command.
