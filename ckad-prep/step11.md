But how does Kubernetes know where to send traffic? That is managed by Labels. Each Object within Kubernetes can have a label attached, allowing Kubernetes to discover and use the configuration. With the previous example, the service knows which Pods to send traffic to based on the label called _app_. We can use this label to select all the pods for that deployment, within that namespace. 

`kubectl get services -l app=examplehttpapp -o go-template='{{(index .items 0).spec.clusterIP}}'`{{execute}}

`curl $(kubectl get services -l app=examplehttpapp -o go-template='{{(index .items 0).spec.clusterIP}}')`{{execute}}

