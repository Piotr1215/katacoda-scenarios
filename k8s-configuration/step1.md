# Enable separations of application code and configuration

Run Octant: https://[[HOST_SUBDOMAIN]]-7777-[[KATACODA_HOST]].environments.katacoda.com, this command will display *octant* cluster viewer. Octant is already installed on this setup

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

`kubectl exec -it $POD -- sh`{{execute}}

Inside the container run this code snippet to see config data mounted as files `cd /etc/foo ; ls ; cat api.properties ; cat deployment_env ; echo""`{{execute}}

Exit pod shell `exit`{{execute}}

**Conclusion**: We have successfully proven applications and configuration can be easily decoupled using confg maps
