# Feature: Service Discovery

    Services in Kubernetes are discovered via
    environmental variables or DNS service

## Scenario: New service created in cluster discovered via environmental variables

**Given** there is nginx deployment present in the cluster

`k get deploy -n default`{{execute}}

**And** deployment is exposed using "NodePort" Service

`k get svc -n default`{{execute}}

**When** new deployment and service are created

`k apply -f https://raw.githubusercontent.com/Piotr1215/dca-exercises/master/k8s/services/1-create-deployment-with-service.yaml`{{execute}}

`k get deploy -n default`{{execute}}

`k get svc -n default`{{execute}}

**Then** environmental variables for new service are created in pods of new deployment

`export POD_NEW=$(kubectl get pods -n default | grep "blue-test" | awk '{print $1}')`{{execute}}

`echo $POD_NEW`{{execute}}

`k exec -it $POD_NEW -- printenv | grep SERVICE`{{execute}}

**But** not in pods of old deployment

`export POD_OLD=$(kubectl get pods -n default | grep "nginx-test" | awk '{print $1}')`{{execute}}

`echo $POD_OLD`{{execute}}

`k exec -it $POD_OLD -- printenv | grep SERVICE`{{execute}}

> The reason why it is not possible to see environmental variables of the new service in old pods is that the new service was created *after* old pods were span up

## Scenario: New service created in cluster discovered via environmental DNS service

**Given** there are 2 nginx deployments present in the cluster

`k get deploy -n default`{{execute}}

**And** deployments are exposed using "NodePort" Services

`k get svc -n default`{{execute}}

**When** we want to reach services via curl

`k exec -it $POD_OLD -- curl http://nginxsvc2`{{execute}}

**Then** it is possible to curl new service by name from any of the old pods

See output of the last command

**And** it is possible to curl old service by name from any of the new pods

`k exec -it $POD_NEW -- curl http://nginxsvc`{{execute}}
