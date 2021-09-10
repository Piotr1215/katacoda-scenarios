# Resources

Create deployment `kubectl apply -f https://raw.githubusercontent.com/Piotr1215/dca-exercises/master/k8s/deployment/1-create-deployment.yaml`{{execute}}

Expose Service: `k expose deployment.app/nginx-test --port 80 --target-port 80 --type NodePort --name nginxsvc`{{execute}}

Create ingress controller: `kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.43.0/deploy/static/provider/baremetal/deploy.yaml`{{execute}}

Make sure Ingress controller is running:

```
kubectl get pods -n ingress-nginx -l app.kubernetes.io/name=ingress-nginx --watch
```{{execute}}

Create Ingress:

```
cat << EOF | kubectl create -f -
apiVersion: networking.k8s.io/v1beta1
kind: Ingress
metadata:
  name: example-ingress
  annotations:
    kubernetes.io/ingress.class: "nginx"
spec:
  backend:
    serviceName: nginxsvc
    servicePort: 80
EOF
```{{execute}}