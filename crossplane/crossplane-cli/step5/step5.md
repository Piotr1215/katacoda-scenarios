## Trace packages

The _trace_ subcommand was introduced with the [Crossplane v1.14
release](https://blog.crossplane.io/crossplane-v1-14/), however in this release
it was expanded by adding the capability to trace _packages_ installation.
This is very helpful as Crossplane configurations can bring a lot of additional
resources such as providers and functions.

Let's apply a very useful confgiuration which creates a base observabilty stack
[configuration-observability-oss](https://marketplace.upbound.io/configurations/upbound/configuration-observability-oss/v0.2.0)
`kubectl apply -f /root/trace/observabilty.yaml`{{exec}}

Now we can trace the installation progress of all the package components
`crossplane beta trace configuration/configuration-observability-oss`{{exec}}

Notice how the packages status update in real time giving a deep insight into
the installation process.

## Next Step

Next we will learn how to use _convert_ command
