First we need to let Crossplane know that we would like to define a composite resource (XR), by creating a composite resource definition (XRD) `kubectl apply -f definition.yaml`{{execute T1}}. Next let's create a sample composition to let Crossplane know what resources should be created `kubectl apply -f composition.yaml`{{execute T1}}.

> Definition describes API for creating a composite resource whereas composition defines what managed resources will be created when composite resource is created either directly or by a dedicated claim.

Here are the resources created in our cluster. `kubectl get xrd`{{execute}} shows our composite resource definition whereas `kubectl get compositions`{{execute}} returns all available compositions. Give it a try.

- create a namespace for the resources `kubectl create ns devops-team`{{execute T1}}

Our composition and definition describes what Kubernetes objects we want to create, but how should developers let us know what should be created? Do they need to open a Jira ticket? 😤... Nah, they just need to create a simple claim, like so

<pre>
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
</pre>

`kubectl apply -f app-claim.yaml`{{execute T1}}

There are several resources created based on the composition `kubectl get managed`. One of them is a deployment with a sample web app, let's port forward to it.
`kubectl port-forward deployment/acmeplatform -n devops-team --address 0.0.0.0  8080:80`{{execute T1}}
You can also navigate to the app [right here](https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com/)

In the next section, we will see how easy it is to modify the claim ➡

