## Check resources utilization

The top command acts similarity to the _kubectl top pods_ giving insight into
the resources utilization by the Crossplane pod.

By default the _top_ subcommand will search for crossplane pods in the
_crossplane-system_ namespace, however it's possible to change it with the _-n_
flag.

Let's see the command in action: `crossplane beta top`{{exec}}.

It's also possible to print a short summary by using the _-s_ or _--summary_, `crossplane beta top --summary`{{exec}}

### Next Step

Next we will learn how to use the _trace_ command
