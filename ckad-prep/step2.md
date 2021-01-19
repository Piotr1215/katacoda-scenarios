Kubernetes is managed by creating, editing, or deleting objects and resources. Each object has a structure and properties that instructs Kubernetes about the desired state, allowing Kubernetes to make the changes required. To deploy an applicaton, a Deployment needs to be created using `kubectl create deployment examplehttpapp --image=katacoda/docker-http-server`{{execute}} 

View all deployments with `kubectl get deployments`{{execute}}

