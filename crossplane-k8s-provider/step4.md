We can easily update the image

`kubectl apply -f app-claim-blue.yaml`{{execute interrupt}}

> Notice how the page changed background color to blue with just one line change

`kubectl port-forward deployment/acmeplatform -n devops-team --address 0.0.0.0  8080:80`{{execute T1}}

Deleting the application and underlying resources is as simple as `kubectl delete -f app-claim.yaml`{{execute interrupt}}
You observe how all the resources created by the claim got deleted as well

The similicity was possible thanks to Crossplane's composition mechanism which we will explore later.
