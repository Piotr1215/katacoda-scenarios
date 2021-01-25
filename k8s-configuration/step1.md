# Enable separations of application code and configuration

1. Create config map
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

`/dca-exercises/k8s/configuration/1-create-configmap.yaml`{{open}}