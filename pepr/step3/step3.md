Start Pepr in development mode:

```bash
pepr dev --confirm
```{{exec}}

>NOTE: This command, by necessity, installs resources into the cluster you run it against. Generally, these resources are removed once the pepr dev session ends but there are two notable exceptions:
    the pepr-system namespace, and
    the PeprStore CRD.
