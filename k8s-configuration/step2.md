# Mount secrets and other security sensitive information

> Secrets are by default **base64 encoded**, but it's possible to create secret with plain text by using **stringData:** instead of **data** section of secret YAML

## Create secret

We will create a encoded sample secret resource `k apply -f https://raw.githubusercontent.com/Piotr1215/dca-exercises/master/k8s/configuration/3-create-secret-encoded.yaml`{{execute}}

```bash
apiVersion: v1
kind: Secret
metadata:
  name: mysecret-encoded
type: Opaque
data:
  username: YWRtaW4=
  password: dW5icmVha2FibGU=
```

> Notice that secret data fields are base64 encoded, we will learn how to decode them later on.

## Create deployment with secret mounted as volume

Similar as with config maps, let's mount secret as volume to a pod so our container can use it in run time. `k apply -f https://raw.githubusercontent.com/Piotr1215/dca-exercises/master/k8s/configuration/5-create-deployment-secret.yaml`{{execute}}

Let's see if our secret has been created `k get secret`{{execute}}. To see secret details as with all Kubernetes resources use *describe* command. `k describe secrets mysecret-encoded`{{execute}}. You will notice that secret data is obfuscated in the output.

As previously we will capture pod name in a variable, let's reuse the same name `export POD=$(kubectl get pods -n default | grep "nginx-test" | awk '{print $1}')`{{execute}}

## Examine pod and secret mounted to it

Run `kubectl describe po $POD | grep Volumes: -A 9`{{execute}} to see our secret mounted as a volume.

We are going to enter pod shell `k exec -it $POD -- sh`{{execute}}

```bash
cd /etc/foo/
cat password
echo ""
```{{execute}}

Notice that inside the container secrets are available in clear text, this is so that containers can consume the values during runtime.

Exit shell, click `exit`{{execute no-newline}} and confirm with <kbd>Enter</kbd>

Decode password to see it in clear text `kubectl get secrets mysecret-encoded -n default -o jsonpath='{@.data.password}'| base64 --decode && echo ""`{{execute}}. Here we have used [*jsonpath*](https://kubernetes.io/docs/reference/kubectl/jsonpath/) to extract single value from command output

> Kubernetes currently does not encrypt secrets in its data store *etcd*. Mounted secrets are only encoded, nevertheless, there are discussions to provide secrets encryption at rest and in transit, so it's considered best practice to use secrets whenever dealing with sensitive information.

**Conclusion:** We have successfully proven that base64 encoded secrets can be ingested and consumed by pod and in turn containers
