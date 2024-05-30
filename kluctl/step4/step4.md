Now we need to create `redis` deployment folder.

`mkdir redis && cd redis`{{exec}}

Since we are using `kustomize` we need to create a `kustomization.yaml` file.

```yaml
cat <<EOF > kustomization.yaml
resources:
  - deployment.yaml
  - service.yaml
EOF
```{{exec}}

And now we can create the `service.yaml` and `deployment.yaml` files.

```yaml
cat <<EOF > deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: redis-cart
spec:
  selector:
    matchLabels:
      app: redis-cart
  template:
    metadata:
      labels:
        app: redis-cart
    spec:
      containers:
      - name: redis
        image: redis:alpine
        ports:
        - containerPort: 6379
        readinessProbe:
          periodSeconds: 5
          tcpSocket:
            port: 6379
        livenessProbe:
          periodSeconds: 5
          tcpSocket:
            port: 6379
        volumeMounts:
        - mountPath: /data
          name: redis-data
        resources:
          limits:
            memory: 256Mi
            cpu: 125m
          requests:
            cpu: 70m
            memory: 200Mi
      volumes:
      - name: redis-data
        emptyDir: {}
EOF
```{{exec}}

```yaml
cat <<EOF > service.yaml
apiVersion: v1
kind: Service
metadata:
  name: redis-cart
spec:
  type: ClusterIP
  selector:
    app: redis-cart
  ports:
  - name: redis
    port: 6379
    targetPort: 6379
EOF
```{{exec}}


> 💡 you can use the built-in editor (left top corner of the window) to view the files

## Next Step

Next we will deploy the redis application to the `dev` target.
