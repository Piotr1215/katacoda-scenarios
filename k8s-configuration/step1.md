# Enable separations of application code and configuration

Run Octant: https://[[HOST_SUBDOMAIN]]-7777-[[KATACODA_HOST]].environments.katacoda.com, this command will display *octant* cluster viewer. Octant is already installed on this setup

## Create config map

Click on IDE tab, this will load VS Code, once it finishes loading, open configuration file that we are about to create.

`cd /dca-exercises/k8s/configuration/`{{execute}}

`/dca-exercises/k8s/configuration/1-create-configmap.yaml`{{open}}


2. Create deployment with config map mounted as volume
3. Check how config map data is mounted into a folder specified in pod template

Resources to create:

``` bash
#Create config map:
k apply -f https://raw.githubusercontent.com/Piotr1215/dca-exercises/master/k8s/configuration/1-create-configmap.yaml

#Create deployment with config map mounted as volume:
k apply -f https://raw.githubusercontent.com/Piotr1215/dca-exercises/master/k8s/configuration/4-Create-deployment.yaml
```

## Open file

