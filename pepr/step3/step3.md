## Start Pepr in development mode

```bash
start_tmux.sh
```{{exec}}

Now let's run pepr in first pane

```bash
cd pepr-demo && send_command 1 "pepr dev --confirm"
```{{exec}}

>NOTE: This command, by necessity, installs resources into the cluster you run it against. Generally, these resources are removed once the pepr dev session ends but there are two notable exceptions:
- the pepr-system namespace, and
- the PeprStore CRD.

## Kubernetes Resources Overview

Running `pepr dev` deploys 2 webhooks (mutating and validating) as well as
PeprStore CRD. 

### Overview of MutatingWebhookConfiguration and ValidatingWebhookConfiguration

Admission webhooks in Kubernetes allow you to intercept and modify or validate requests to the API server before they are persisted. Mutating webhooks can alter the incoming requests by adding or changing fields, while validating webhooks ensure requests meet certain criteria and can reject those that do not.

**MutatingWebhookConfiguration** defines a set of mutating webhooks that modify requests, and **ValidatingWebhookConfiguration** defines a set of validating webhooks that validate requests without changing them. These configurations specify rules for which requests are intercepted and endpoints to which they are sent for processing .

Source: https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/

### Custom Resource Definition (CRD)

The CustomResourceDefinition API resource allows you to define custom resources. Defining a CRD object creates a new custom resource with a name and schema that you specify.

Source: https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/#customresourcedefinitions

> 💡 Open [Octant]({{TRAFFIC_HOST1_7777}}) to see Kubernetes dahsboard.

## Next Steps

Next we will review pepr capabilities and apply sample yaml
