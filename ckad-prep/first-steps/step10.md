We've learned how to successfully deploy and manage applications, but we need to make them accessible. This is managed via Services.

The `expose` command will create a new service for a deployment. The _port_ specifies the port of the application we want to available `kubectl expose deployment examplehttpapp --port 80`{{execute}}

Like with Pods, we can get and describe Services `kubectl get svc`{{execute}} `kubectl describe svc examplehttpapp`{{execute}}
