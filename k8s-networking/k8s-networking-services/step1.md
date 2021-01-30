# Feature: NodePort Service

    Expose service on each node on the
    same static port. Accessible on each node IP:PORT combination

## Scenario: Application running in pods accessed from outside of the cluster

**Given** there is nginx deployment present in the cluster

`k apply -f https://raw.githubusercontent.com/Piotr1215/dca-exercises/master/k8s/deployment/1-create-deployment.yaml`{{execute}}

**When** deployment is exposed using "NodePort" Service

`k expose deployment/nginx-test --port 80 --target-port 80 --type NodePort --name nginxsvc`{{execute}}

**Then** sample page correctly renders on the node port in "Katacoda"

`export PORT=$(k get service nginxsvc -o jsonpath='{.spec.ports[*].nodePort}')`{{execute}}

`echo $PORT`{{execute}}

Navigate to https://[[HOST_SUBDOMAIN]]-[[KATACODA_HOST]].environments.katacoda.com/ and paste port copied from previous command

**Conclusion:** We have successfully proven that workloads running in pods can be easily consumed from outside of the cluster
