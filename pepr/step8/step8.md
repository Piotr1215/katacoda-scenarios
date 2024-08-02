## Check Webhook Triggers

```bash
MODULE_UUID=$(npx pepr uuid | tail -n 1 | awk '{print $1}')
```{{exec}}

```bash
pepr monitor $MODULE_UUID
```{{exec}}

> 💡 The `pepr monitor` command provides a detailed log of Mutations and
> Validations.
- The `pepr monitor` command provides a detailed log of Mutations and Validations.
- The `npx pepr uuid` command helps in identifying the currently deployed modules and their details.

