This environment comes with the following components pre-installed:

✔ helm

<!-- TODO:(piotr1215) swap to 1.15 when ready -->

✔ crossplane v 1.14

✔ crossplane CLI

> Wait until "All Set" message is displayed on the screen and verify if cluster is setup correctly

Check the cluster setup `kubectl get pods -A`{{exec}}

Check Kuberentes cluster info and version `kubectl cluster-info && echo && kubectl version`{{exec}}

> 🚨 if it takes longer than 5 minutes to load the environment, please
> restart scenario (or refresh browser)

## Next Step

Next we will learn how to use the **crossplane beta xpkg init** command.
