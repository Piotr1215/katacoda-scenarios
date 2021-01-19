_Pro tip:_Working with a namespace for a period of time? Change the context to make a different namespace the default.

`kubectl config set-context $(kubectl config current-context) --namespace=testns; kubectl config get-contexts`{{execute}}

`kubectl get pods`{{execute}}
