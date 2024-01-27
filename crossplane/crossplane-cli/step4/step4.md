## Trace claim

The _trace_ subcommand was introduced with the [Crossplane v1.14
release](https://blog.crossplane.io/crossplane-v1-14/), however in this release
it was expanded by adding the capability to trace \_packages installation.
This is very helpful as Crossplane configurations can bring a lot of additional
resources such as providers and functions.

Let's apply a very powerful [Crossplane CaaS](https://marketplace.upbound.io/configurations/upbound/configuration-caas/v0.2.0) (Cluster As a Service) composition `kubectl apply -f /root/trace/caas.yaml`{{exec}}

Now we can trace the installation progress of all the package components
`crossplane beta trace configuration/configuration-caas`{{exec}}

Notice how the packages status update in real time giving a deep insight into
the installation process.

## Next Step

This concluded the overview of new features in the Crossplane CLI
