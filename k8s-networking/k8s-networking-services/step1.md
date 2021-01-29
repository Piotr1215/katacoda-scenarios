# Create Service

Create deployment: `k apply -f https://raw.githubusercontent.com/Piotr1215/dca-exercises/master/k8s/deployment/1-create-deployment.yaml`

Expose service: `k expose deployment/nginx-test --port 80 --target-port 80 --type NodePort --name nginxsvc`

Check service: `kubectl run curl --image=radial/busyboxplus:curl -i --tty`

My busybox: `kubectl run -it --rm debug --image=radial/busyboxplus:curl --restart=Never -- sh`

curl for service: `kubectl run -it --rm debug --image=radial/busyboxplus:curl --restart=Never -- curl http://nginxsvc`

Export port: `export PORT=$(k get service nginxsvc -o jsonpath='{.spec.ports[*].nodePort}')`

Attach back to curl: `kubectl attach curl -c curl -i -t`