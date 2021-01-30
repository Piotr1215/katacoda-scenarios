# Feature: Service Discovery

    Services in Kubernetes are discovered via
    environmental variables or DNS service

## Scenario: New service created in cluster

**Given** there is nginx deployment present in the cluster

`k get deploy -n default`{{execute}}

**And** deployment is exposed using "NodePort" Service

`k get svc -n default`{{execute}}

**When** new deployment and service are created

`k apply -f https://raw.githubusercontent.com/Piotr1215/dca-exercises/master/k8s/services/1-create-deployment-with-service.yaml`{{execute}}

**Then** environmental variables for new service are created in pods of new deployment

`export POD=$(kubectl get pods -n default | grep "nginx-test" | awk '{print $1}')`{{execute}}

`echo $POD`

`k exec -it $POD -- printevn | grep SERVICE`{{execute}}

**And** it is possible to curl new service by name from any of the new pods

`k run -it --rm debug --image=radial/busyboxplus:curl --restart=Never -- curl http://nginxsvc2`{{execute}}