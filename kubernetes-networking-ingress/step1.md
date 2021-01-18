# Resources

Create deployment `kubectl apply -f https://raw.githubusercontent.com/Piotr1215/dca-exercises/master/k8s/deployment/1-create-deployment.yaml`{{execute}}

Expose Service: `k expose deployment.app/nginx-test --port 80 --target-port 80 --type NodePort --name nginxsvc`{{execute}}

Create Ingress:

``` bash
cat << EOF | kubectl create -f -
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: example-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /$1
spec:
  rules:
    - host: hello-world.info
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: nginxsvc
                port:
                  number: 80
EOF
```