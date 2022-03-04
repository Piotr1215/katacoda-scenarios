## Composition

The magic of crossplane really happens in the [composition](https://crossplane.io/docs/v1.6/reference/composition.html). There are 3 main tasks that composition performs

- compose together set of managed resources based on a claim or composed reource
- reference credentials needed for accessing the provider API
- patch/map from values provided in a claim to values in managed resource

Below you can see how composition enables creating AWS instance based on its definition.

```yaml
apiVersion: apiextensions.crossplane.io/v1
kind: Composition
metadata:
  name: xvminstances.aws.vm.platform.org
  labels:
    provider: aws
    vpc: new
spec:
  writeConnectionSecretsToNamespace: crossplane-system
  compositeTypeRef:
    apiVersion: vm.platform.org/v1alpha1
    kind: XVirtualMachineInstance
  resources:
    - name: vminstance
      base:
        apiVersion: ec2.aws.crossplane.io/v1alpha1
        kind: Instance
        spec:
          forProvider:
            subnetIdSelector:
              matchControllerRef: true
            region: eu-central-1
            imageId: ami-0a49b025fffbbdac6
            accociatePublicIpAddress: true
            keyName: ec2-sandbox
            securityGroupSelector:
              matchControllerRef: true
            publiclyAccessible: true
          writeConnectionSecretToRef:
            namespace: crossplane-system
      patches:
        - fromFieldPath: "metadata.uid"
          toFieldPath: "spec.writeConnectionSecretToRef.name"
        - fromFieldPath: "spec.parameters.instanceSize"
          toFieldPath: "spec.forProvider.instanceType"
          transforms:
            - type: map
              map:
                small: "t2.micro"
                medium: "m1.medium"
                large: "m1.large"
```
