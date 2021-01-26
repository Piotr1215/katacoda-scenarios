# Updates to config maps or secrets reflects in pods automatically

> - This functionality applies only to configuration or secrets **mounted to pods as volumes**
> - If you would like to reflect changes in environmental variables injected from configs or secrets, manual pod restart is required
> - You can vote here to push up https://github.com/kubernetes/kubernetes/issues/22368 to introduce auto restarts similar to configs and secrets mounted as volumes
> - Alternatively [admission controller](https://github.com/xing/kubernetes-deployment-restart-controller) setup is possible, but this is out of scope for this exercise

Create Resources:
We are going to create a simple config map, same as in step 1

`k apply -f https://raw.githubusercontent.com/Piotr1215/dca-exercises/master/k8s/configuration/1-create-configmap.yaml`{{execute}}

## Create deployment with config map mounted as volume

Once config map is created, let's create a deployment and mount the config map as volume, like so
`k apply -f https://raw.githubusercontent.com/Piotr1215/dca-exercises/master/k8s/configuration/4-Create-deployment.yaml`{{execute}}

## Examine pod and config map mounted to it

As previously we will capture pod name in a variable, let's reuse the same name `export POD=$(kubectl get pods -n default | grep "nginx-test" | awk '{print $1}')`{{execute}}

We are going to enter pod shell `k exec -it $POD -- sh`{{execute}}

```bash
cd /etc/foo/
cat api.properties
cat deployment_env
echo ""
```{{execute}}

Now, we are going to edit config map and change its data values `k edit cm config-demo`{{execute}}. Output should be similar to below:

![Config map edit](https://www.screencast.com/t/3m9xcRxj)

Enter edit mode in vim `i`{{execute no-newline}}

Adjust values of *api.debug*, *api.code* and *deployment_env*. Now let's check if values are correctly updated in the pod.

`k exec -it $POD -- sh`{{execute}}

```bash
cd /etc/foo/
cat api.properties
cat deployment_env
echo ""
```{{execute}}

We should see updated values

> It might take a moment for Kubelet to reflect the new values in the pod.

**Conclusion:** We have successfully proven configuration values mounted to pod as volume are auto updated after config map changes.
