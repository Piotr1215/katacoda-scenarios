As with Deployments, namespaces can be created with`kubectl create ns testns`{{execute}} 

Namespaces can be specified with `-n <namespace>` such as `kubectl create deployment namespacedeg -n testns --image=katacoda/docker-http-server`{{execute}} 

`kubectl get pods -n testns`{{execute}}
