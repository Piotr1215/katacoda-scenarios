
- apply composition and definition `kubectl apply -f composition-definition.yaml`{{execute T1}}
  ![appclaim-crd](appclaim-crd.png)
  ![kubernetes-provider-pods](kubernetes-provider-pods.png)
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

