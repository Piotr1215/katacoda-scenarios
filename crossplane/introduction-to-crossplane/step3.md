First we need to let Crossplane know that we would like to define a composite
resource (XR), by creating a composite resource definition (XRD)
`kubectl apply -f definition.yaml`{{exec}}. Next let's create a sample
composition to let Crossplane know what resources should be created
`kubectl apply -f composition.yaml`{{exec}}.

> Definition describes API for creating a composite resource whereas composition
> defines what managed resources will be created when composite resource is
> created either directly or by a dedicated claim.

Here are the resources created in our cluster. `kubectl get xrd`{{execute}}
shows our composite resource definition whereas
`kubectl get compositions`{{execute}} returns all available compositions. Give
it a try.

We need to create a namespace for the resources
`kubectl create ns devops-team`{{exec}} first.

Our composition and definition describes what Kubernetes objects we want to
create, but how should developers let us know what should be created? Do they
need to open a Jira ticket? 😤... Nah, they just need to create a simple claim,
like so

```yaml
apiVersion: acmeplatform.com/v1alpha1
kind: AppClaim
metadata:
  name: platform-demo
  labels:
    app-owner: piotrzan
spec:
  id: acmeplatform
  compositionSelector:
    matchLabels:
      type: frontend
  parameters:
    namespace: devops-team
    image: piotrzan/nginx-demo:green
```

By applying the claim, we are creating multiple Kubernetes resources "under the
hood" without needing to know what they are and how they are created. This
concern can be moved onto a Platform Team.

`kubectl apply -f app-claim.yaml`{{exec}}

`kubectl wait deployment.apps/acmeplatform --namespace devops-team --for condition=AVAILABLE=True --timeout 1m`{{exec}}

There are several resources created based on the composition
`kubectl get managed`{{execute}}. One of them is a deployment with a sample web
app, let's port forward to it.

`kubectl port-forward deployment/acmeplatform -n devops-team --address 0.0.0.0 8080:80`{{exec}}

You can also
[open the web page right here]({{TRAFFIC_HOST1_8080}})

In the next section, we will see how easy it is to modify the claim ➡
