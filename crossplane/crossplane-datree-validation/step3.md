## Prepare the resources

Since our focus here are on compositions validation, we are going to skip
detailed explanation of crosspolane's compositions and the use of
`kubernetes provider`.

Let's create the resources first

- `kubectl apply -f definition.yaml`{{exec}}
- `kubectl apply -f composition.yaml`{{exec}}
- `kubectl create ns devops-team`{{exec}}
- `kubectl apply -f app-claim.yaml`{{exec}}

And ensure they are created properly `kubectl get crossplane`{{exec}}

### What are we going to validate

Our goal is to validate whether the `owner` and `service` labels from the below
claim have been applied correctly to all the resources.

```yaml
apiVersion: acmeplatform.com/v1alpha1
kind: AppClaim
metadata:
  name: platform-demo
  labels:
    owner: piotrzan
    service: demo
spec:
  id: acmeplatform
  compositionSelector:
    matchLabels:
      type: frontend
  parameters:
    namespace: devops-team
    image: piotrzan/nginx-demo:green
```

Click next to see how we could do this in a composition and how to validate it. ➡
