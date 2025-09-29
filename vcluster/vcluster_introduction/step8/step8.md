The Backend team needs newer Kubernetes version and resource quotas. 

```bash
cat <<EOF > vcluster-backend.yaml
controlPlane:
  distro:
    k8s:
      enabled: true
      version: "v1.32.0"
policies:
  resourceQuota:
    enabled: true
    quota:
      cpu: "10"
      memory: 2Gi
      pods: "10"
EOF
```{{exec}}

```bash
vcluster create backend --namespace backend-team -f vcluster-backend.yaml --connect=false
```{{exec}}

This creates a `ResourceQuota` resource on our host cluster. 

```bash
k describe resourcequota vc-backend -n backend-team
```{{exec}}

> Now we are sure that the backend team will not consume more resources than allowed.

## Next Step

```bash
vcluster disconnect
vcluster delete backend
```{{exec}}

Next we will see what the admin team needs and create a virtual cluster for them.
