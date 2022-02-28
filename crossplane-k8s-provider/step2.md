First we need to let Crossplane know that we would like to define a composite resource (XR), by creating a composite resource definition (XRD) `kubectl apply -f definition.yaml`{{execute T1}}. Next let's create a sample composition to let Crossplane know what resources should be created `kubectl apply -f composition.yaml`{{execute T1}}.

> Definition describes API for creating a composite resource whereas composition defines what managed resources will be created when composite resource is created either directly or by a dedicated claim.

Here are the resources created in our cluster. `kubectl get xrd`{{execute}} shows our composite resource definition whereas `kubectl get compositions`{{execute}} returns all available compositions. Give it a try.

- create a namespace for the resources `kubectl create ns devops-team`{{execute T1}}
- claim the resources by running `kubectl apply -f app-claim.yaml`{{execute T1}}
- there are several resources created based on the composition
  ![resources-created](resources-created.png)
- port forward to the service `kubectl port-forward deployment/acmeplatform -n devops-team --address 0.0.0.0  8080:80`{{execute T1}}
- navigate to the app [here](https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com/)
- kubernetes demo app V1 up and running
  ![app-up](app-up.png)
- delete claim `kubectl delete -f app-claim.yaml`{{execute interrupt}}
- observe how all the resources created by the claim got deleted as well

