## Composition

The magic of crossplane really happens in the [composition](https://crossplane.io/docs/v1.6/reference/composition.html). There are 3 main tasks that composition performs

- compose together set of managed resources based on a claim or composed resource
- reference credentials needed for accessing the provider API
- patch/map from values provided in a claim to values in managed resource

Below you can see how composition creates deployment, service and horizontal pod autoscaler in response to creating the AppClaim. The "binding glue" between the composition and actual Kubernetes resource is a composite resource definition (XRD) which you can think of as a kind of API between the developer consuming resources via claim and platform engineer or SRE desgning the composition for underlying resources or infrastructure.

Here are 2 key fields that make the composition so powerful.

### forProvider

Specifies kubernetes resources and settings to be created. In this case we can see how the composition adds livenessProbe and readinessProbe as well as resource limits which might be defined by the Platform Team and thus not exposed to Application Development Teams.

### Patches

Enables mapping between fields provided in the definition (XRD) and fields in the Managed Resource (MR).

> The blow YAMl is abbreviated and the complexity of those files can be substantial. This is by design, there is no magic "remove complexity" button. Instead Crossplane provides facilities for moving the complexity onto the Platfrom Teams and designing simple, custom APIs for other teams.

```yaml
apiVersion: apiextensions.crossplane.io/v1
kind: Composition
...
spec:
  compositeTypeRef:
    apiVersion: acmeplatform.com/v1alpha1
    kind: App
...
  - name: deployment
    base:
      apiVersion: kubernetes.crossplane.io/v1alpha1
      kind: Object
      spec:
        forProvider:
          manifest:
            apiVersion: apps/v1
            kind: Deployment
            spec:
              template:
                spec:
                  containers:
                  - name: frontend
                    ports:
                    - containerPort: 80
                    livenessProbe:
                      httpGet:
                        path: /
                        port: 80
                    readinessProbe:
                      httpGet:
                        path: /
                        port: 80
                    resources:
                      limits:
                        cpu: 250m
                        memory: 256Mi
                      requests:
                        cpu: 125m
                        memory: 128Mi
    patches:
    - fromFieldPath: spec.id
      toFieldPath: metadata.name
      transforms:
        - type: string
          string:
            fmt: "%s-deployment"
...
  - name: service
    base:
      apiVersion: kubernetes.crossplane.io/v1alpha1
      kind: Object
      spec:
        forProvider:
          manifest:
            apiVersion: v1
            kind: Service
            spec:
              type: ClusterIP
              ports:
              - port: 80
                targetPort: 80
                protocol: TCP
                name: http
    patches:
    - fromFieldPath: spec.id
      toFieldPath: metadata.name
      transforms:
        - type: string
          string:
            fmt: "%s-service"
...
  - name: hpa
    base:
      apiVersion: kubernetes.crossplane.io/v1alpha1
      kind: Object
      spec:
        forProvider:
          manifest:
            apiVersion: autoscaling/v1
            kind: HorizontalPodAutoscaler
            spec:
              minReplicas: 2
              maxReplicas: 6
              scaleTargetRef:
                apiVersion: apps/v1
                kind: Deployment
              targetCPUUtilizationPercentage: 80
    patches:
    - fromFieldPath: spec.id
      toFieldPath: metadata.name
      transforms:
        - type: string
          string:
            fmt: "%s-ingress"
    readinessChecks:
      - type: None
```

