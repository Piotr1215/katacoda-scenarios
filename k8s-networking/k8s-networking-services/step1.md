# Create Service

## Feature: NodePort service

    Expose service on each node on the
    same static port. Accessible on each node IP:PORT combination

## Scenario: Expose deployment on the network

**Given** there is nginx deployment present in the cluster

    `k apply -f https://raw.githubusercontent.com/Piotr1215/dca-exercises/master/k8s/deployment/1-create-deployment.yaml`{{execute}}

**And** it is in default namespace

`k get deploy -owide`{{execute}}

**When** deployment is exposed using "NodePort" Service

**Then** pods of the deployment can be curled using "http://nginxsvc" name

**And** sample page correctly renders on the node port in "Katacoda"

Scenario:



Expose service: `k expose deployment/nginx-test --port 80 --target-port 80 --type NodePort --name nginxsvc`

Check service: `kubectl run curl --image=radial/busyboxplus:curl -i --tty`

My busybox: `kubectl run -it --rm debug --image=radial/busyboxplus:curl --restart=Never -- sh`

curl for service: `kubectl run -it --rm debug --image=radial/busyboxplus:curl --restart=Never -- curl http://nginxsvc`

Export port: `export PORT=$(k get service nginxsvc -o jsonpath='{.spec.ports[*].nodePort}')`

Attach back to curl: `kubectl attach curl -c curl -i -t`