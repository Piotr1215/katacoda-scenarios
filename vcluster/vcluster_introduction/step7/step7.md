The Frontend team needs a specific Kubernetes version. Let's create a new virtual cluster for them with the required version.

```bash
cat <<EOF > vcluster-frontend.yaml
sync:
  toHost:
    endpoints:
      enabled: false
controlPlane:
  distro:
    k8s:
      enabled: true
      version: "v1.32.0"
EOF
```{{exec}}

```bash
vcluster create frontend --namespace frontend-team -f vcluster-frontend.yaml --connect=false
```{{exec}}

Check our host cluster versin first:

```bash
kubectl version
```{{exec}}

Now let's connect to the `frontend` virtual cluster and check the version:

```bash
vcluster connect frontend
kubectl version
```{{exec}}

## Next Step

```bash
vcluster disconnect
vcluster delete frontend
```{{exec}}

Next we will see what the backend team needs and create a virtual cluster for them.
