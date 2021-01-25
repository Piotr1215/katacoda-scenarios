# Enable separations of application code and configuration

> During this exercise, feel free to click on *Octant* tab and explore cluster status in a visual way. We will focus on *kubectl* commands.

## Create config map

We are going to create a simple config map

`k apply -f https://raw.githubusercontent.com/Piotr1215/dca-exercises/master/k8s/configuration/1-create-configmap.yaml`{{execute}}

## Create deployment with config map mounted as volume

Once config map is created, let's create a deployment and mount the config map as volume, like so
`k apply -f https://raw.githubusercontent.com/Piotr1215/dca-exercises/master/k8s/configuration/4-Create-deployment.yaml`{{execute}}

## Examine pod and config map mounted to it

First lets capture pod name as into a variable `export POD=$(kubectl get pods -n default | grep "nginx-test" | awk '{print $1}')`{{execute}}

> Every pod in a deployment gets additional random string assigned by *Kubelet*, that's why we need the above command to extract pod name

We can view how config map *config-demo* is mounted to our pod: `kubectl describe po $POD | grep Volumes: -A 9`{{execute}}

Now, let's explore the nginx container running in our pod and see if data is mounted correctly to a volume.

This command will connect shell to our nginx contianer running in the pod

`kubectl exec -it $POD -- sh`{{execute}}

Once inside the container check */etc/foo* directory and content of the files. Remember, those files come from config map *data* section

`cd /etc/foo ; ls ; cat api.properties ; cat deployment_env ; echo""`{{execute}}

```
apiVersion: v1
kind: ConfigMap
metadata:
  name: config-demo
data:
  # property-like keys; each key maps to a simple value
  deployment_env: "DEV"

  # file-like keys
  api.properties: |
    api.debug=true
    api.code=555
```

Exit shell `exit`{{execute}}

**Conclusion**: We have successfully proven applications and configuration can be easily decoupled using confg maps
