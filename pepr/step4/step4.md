## Pepr Capabilities

> We can also explore files in the editor

Our `HelloPepr` module has typescript file with capabilities

```bash
bat /root/pepr-demo/capabilities/hello-pepr.ts
```{{exec}}

and sample kubernetes yaml to test them

```bash
bat /root/pepr-demo/capabilities/hello-pepr.samples.yaml
```{{exec}}

Let's apply the yaml and observe pepr logs

```bash
kubectl apply -f /root/pepr-demo/capabilities/hello-pepr.samples.yaml
```{{exec}}

## Next Steps 

Next we will build a custom capability
