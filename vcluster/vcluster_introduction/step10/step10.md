All Teams need to have virtual clusters with pre-populated resources. 

```bash
cat <<EOF > vcluster-base.yaml
controlPlane:
  distro:
    k8s:
      enabled: true
      version: "v1.30.0"
experimental:
  deploy:
    vcluster:
      manifests: |-
        apiVersion: v1
        kind: ConfigMap
        metadata:
          name: vcluster-test-config
        data:
          TEST_KEY: "test_value"
        ---
        apiVersion: v1
        kind: Secret
        metadata:
          name: vcluster-test-secret
        type: Opaque
        stringData:
          test-credential: "test123"
EOF
```{{exec}}

```bash
vcluster create base --namespace base-ns -f vcluster-base.yaml --connect=false
```{{exec}}

Now we should see the actula nodes synced to the virtual cluster.

```bash
vcluster connect base
k get secrets,cm -n default
```{{exec}}

## Next Step

```bash
vcluster disconnect
vcluster delete base
```{{exec}}


Next we will see how to sync generic resources to the virtual cluster.
