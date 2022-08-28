## Validation

Since we want to ensure that all the resources have the same patch, we are going
to use Crossplane's `patchSet` feature.

```yaml
patchSets:
  - name: commonLabels
    patches:
      - type: FromCompositeFieldPath
        fromFieldPath: metadata.labels[owner]
        toFieldPath: spec.forProvider.manifest.metadata.labels[owner]
      - type: FromCompositeFieldPath
        fromFieldPath: metadata.labels[service]
        toFieldPath: spec.forProvider.manifest.metadata.labels[service]
```

### Apply patchset

Within the composition, patchset is applied to all resources, here example of
the deployment snippet.

```yaml
---
resources:
  - name: deployment
    base:
      apiVersion: kubernetes.crossplane.io/v1alpha1
      kind: Object
      spec:
        forProvider:
          manifest:
            apiVersion: apps/v1
            kind: Deployment
    patches:
      - type: PatchSet
        patchSetName: commonLabels
```

### Why to valiadte

We want to validate the composition against a policy that enforces presence of
this `patchSet`, because this is a common practice all team members agree to
follow. By codyfying it in an inner development loop via a CLI or a linter as
well as in CI/CD pipeline we ensure that all the compositions adhere the the
same standards and lower numer of errors.

Let's make sure that the labels are correctly applied to the kubernetes
resources:

```bash
kubectl describe service acmeplatform -n devops-team | grep ^Labels -A2
kubectl describe deployment acmeplatform -n devops-team | grep ^Labels -A2
kubectl describe hpa acmeplatform -n devops-team | grep ^Labels -A2
```{{exec}}

Click next to see how to apply `datree` validation to each composition. ➡
