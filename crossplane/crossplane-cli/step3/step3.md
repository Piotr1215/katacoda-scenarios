## Let's validate our composition

The validate subcommand is used for offline schema validation using k8s API
server's validation library. The command requires two parameters; _extensions_
and _resources_. These parameters can be provided to the command via a file,
folder or standard input.

> The validate command doesn't require a cluster, all required resources are
> encapsulated in the command

First let's swap to the validate directory `cd /root/validate && tree`{{exec}} and start
validation process.

> Use the builtin editor, accessible on the left upper corner on the terminal,
> to view the files.

### Validate Kubernetes CEL rules

> ✨ Latest addition to the validate command

Crossplane Resource Definition XRD is an OpenAPIV3 spec compatible schema. As
such it benefits from the addition of [CEL Validation
Rules](https://kubernetes.io/docs/tasks/extend-kubernetes/custom-resources/custom-resource-definitions/#validation-rules).

Those rules enable expressing complex business validatation scenarios for claims
and XRs based on the XRD schema. Let's see it in action.

In this scenario our _xrd_ specifies that replicas should be between min and max
replicas values with the following rule:

```yaml
x-kubernetes-validations:
  - rule: "self.minReplicas <= self.replicas && self.replicas <= self.maxReplicas"
    message: "replicas should be in between minReplicas and maxReplicas."
```

First let's use an xr example with the incorrect values, here we are getting a
validation error.

`crossplane beta validate ./cel-rule-example/xrd.yaml ./cel-rule-example/wrong-xr.yaml`{{exec}}

Whereas with the correct xr, the validation passes.

`crossplane beta validate ./cel-rule-example/xrd.yaml ./cel-rule-example/xr.yaml`{{exec}}

### Validate resource against a schema

In the first scenario we can validate any resource (in this case XR and MR)
against any schema (in this case provider CRD and an XRD)

`crossplane beta validate schemas.yaml resources.yaml`{{exec}}

The command has two categories of output; _errors_ and _warnings_.
If there is a validation error or warning, the command will indicate it accordingly. Let's
try it out, here the command will output validation warning since were are
missing an XRD:

`crossplane beta validate missing-schemas.yaml resources.yaml`{{exec}}

### Validate render command output

This is a very useful feature when developing functions. Passing the output of
the _render_ command to the _validate_ command makes sure that our function does
not violate schema requirements.

`crossplane beta render xr.yaml composition.yaml func.yaml | crossplane beta validate schemas.yaml -`{{exec}}

You might have noticed that there is an error indicating the missing XR. This is
because functions do not have access to spec fields. The flag _--include-full-xr_ fixed
it by adding the XR to the _render_ command output and satisfying the validate
constrains.

`crossplane beta render xr.yaml composition.yaml func.yaml --include-full-xr | crossplane beta validate schemas.yaml -`{{exec}}

### Validate by folder

If you have multiple compositions and resources to validate, it is easy to use
the _validate_ command to travers all the Crossplane yaml files and validate in
batch mode across all the resources.

First let's render all our resources into a file (xr, compostion and function).
It will serve as a base for validation.

`crossplane beta render xr.yaml composition.yaml func.yaml --include-full-xr > rendered.yaml`{{exec}}

The _Extensions_ folder contains packages (provider and configuration) to validate against `tree Extensions`{{exec}}

`crossplane beta validate Extensions rendered.yaml`{{exec}}

After executing this command you will notice that the validate command downloads
missing CRDs into a _.crossplane_ folder. This enables the validation process
without the need to access external cluster!

Running the same command again will not trigger the download since we have
cached all the schemas.

`crossplane beta validate Extensions rendered.yaml`{{exec}}

Finally we can use a custom directory as a cache for downloading the schemas.
This enables having a centralized and shared cache directory between different
projects.

`crossplane beta validate Extensions rendered.yaml --cache-dir mycache`{{exec}}

Or clean the cache directory.

`crossplane beta validate Extensions rendered.yaml --cache-dir mycache --clean-cache`{{exec}}

## Next Step

Next we will learn new capabilities of the _top_ command.
