Now the application is receiving data, if something goes wrong we need to be able to investigate. Using `kubectl` it's possible to view the logs for Pods.

The command combines label selectors and querying the Go Template to get the first Pod name. 

`kubectl logs $(kubectl get pods -l app=examplehttpapp -o go-template='{{(index .items 0).metadata.name}}')`{{execute}}
