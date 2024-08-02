## Pepr Capabilities

> We can also explore files in the editor

Our `HelloPepr` module has typescript file with capabilities

```bash
send_command 2 "bat ./capabilities/hello-pepr.ts"
```

and sample kubernetes yaml to test them

```bash
send_command 2 "bat ./capabilities/hello-pepr.samples.yaml"
```

Let's apply the yaml and observe pepr logs

```bash
send_command 2 "kubectl apply -f ./capabilities/hello-pepr.samples.yaml"
```












