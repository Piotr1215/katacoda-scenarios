## Conversions

Crossplane is evolving in a very fast pace, some features supercede others and
we need to migrate to newer APIs.

The _convert_ subcommand implements two conversions for now.

### Convert from ControllerConfig -> DeploymentRuntimeConfig

we can easily convert the deprecated _ControllerConfig_ into a new
_DeploymentConfig_ `crossplane beta convert deployment-runtime
/root/convert/controllerconfig.yaml`{{exec}}

### Convert from Classic Compositions -> Function Pipeline Compositions

The same with a sample composition `crossplane beta convert pipeline-composition
/root/convert/composition.yaml`{{exec}}

Let's save the last conversion and compare the old and new file `crossplane beta convert pipeline-composition
/root/convert/composition.yaml > new_composition.yaml`{{exec}}

`diff --side-by-side --color --suppress-common-lines --ignore-all-space /root/convert/composition.yaml new_composition.yaml`{{exec}}

## Next Step

This concludes the interactive workshop of crossplane CLI! I hope you have
learned something useful and will incorporate the commands into your daily
workflow.
