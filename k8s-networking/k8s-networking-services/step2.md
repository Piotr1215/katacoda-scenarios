# Feature: Cluster Networking

    Kubernetes networking is flat meaning that resources can communicate with each other directly via their IPs

## Scenario: Pods communicate with each other

**Given** there is nginx deployment present in the cluster

`k get deploy -n default`{{execute}}

**And** deployment is exposed using "NodePort" Service

`k get svc -n default`{{execute}}

**When** pods of the deployment are curled using "http://nginxsvc" name from a busybox pod

`kubectl run -it --rm debug --image=radial/busyboxplus:curl --restart=Never -- curl http://nginxsvc`{{execute}}

**Then** index.html content is returned to the terminal

**Conclusion:** We have successfully proven that pods can communicate with each other via services using DNS service