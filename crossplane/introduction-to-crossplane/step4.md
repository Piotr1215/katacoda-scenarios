We can easily update the image

`kubectl apply -f app-claim-blue.yaml`{{exec interrupt}}

> Notice how the page changed background color to blue with just one line change

Make sure the deployment is ready

`kubectl wait deployment.apps/acmeplatform --namespace devops-team --for condition=AVAILABLE=True --timeout 1m`{{exec}}

Open port one more time and see that the sample page changed color.

`kubectl port-forward deployment/acmeplatform -n devops-team --address 0.0.0.0 8080:80`{{exec}}

> You can
> [open the web page right here again]({{TRAFFIC_HOST1_8080}})

Deleting the application and underlying resources is as simple as
`kubectl delete -f app-claim.yaml`{{execute}} You observe how all the resources
created by the claim got deleted as well

The simplicity was possible thanks to Crossplane's composition mechanism, which
we will explore later.
