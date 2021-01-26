# Updates to config maps or secrets reflects in pods automatically

> - This functionality applies only to configuration or secrets **mounted to pods as volumes**
> - If you would like to reflect changes in environmental variables injected from configs or secrets, manual pod restart is required
> - You can vote here to push up https://github.com/kubernetes/kubernetes/issues/22368 to introduce auto restarts similar to configs and secrets mounted as volumes
> - Alternatively [admission controller](https://github.com/xing/kubernetes-deployment-restart-controller) setup is possible, but this is out of scope for this exercise

Create Resources:

``` bash
#Create config map:
k apply -f https://raw.githubusercontent.com/Piotr1215/dca-exercises/master/k8s/configuration/1-create-configmap.yaml

#Create deployment with config map mounted as volume:
k apply -f https://raw.githubusercontent.com/Piotr1215/dca-exercises/master/k8s/configuration/4-Create-deployment.yaml
```

1. Create config map
2. Create deployment with config map mounted as volume
3. Check how config map data is mounted into a folder specified in pod template
4. Edit config map and adjust one value
5. Check how config map data is is updated in a folder pod specified in pod template as mount point

[![Config Update](https://asciinema.org/a/384415.svg)](https://asciinema.org/a/384415)

Cleanup Resources:

``` bash
#Delete deployment:
k delete -f https://raw.githubusercontent.com/Piotr1215/dca-exercises/master/k8s/configuration/4-Create-deployment.yaml

#Delete config map:
k delete -f https://raw.githubusercontent.com/Piotr1215/dca-exercises/master/k8s/configuration/1-create-configmap.yaml
```

**Conclusion:** We have successfully proven configuration values mounted to pod as volume are auto updated after config map changes