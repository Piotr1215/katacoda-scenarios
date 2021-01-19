Kubectl can help scale the number of Pods running for a deployment, referred to as replicas. 

`kubectl scale deployment examplehttpapp --replicas=5`{{execute}}

View the state of the scale with `kubectl get deployments`{{execute}} as you scale up/down, the number of Pods will update to reflect the **desired configuration** `kubectl get pods`{{execute}}
