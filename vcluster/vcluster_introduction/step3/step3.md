Creating a new vcluster is easy using the `vcluster create` command. The command
takes the name of the vcluster and an optional namespace.

We are going to use _tmux_ since _vcluster_ CLI will port forward to our new
kubeconfig. In the other pane, we can interact with the new vcluster.

`start_tmux.sh`{{exec}}

```bash
send_command 0 "vcluster create my-vcluster --namespace test-namespace"
```{{exec}}

Now we can check all the resources in our new vcluster.

```bash
send_command 1 "kubectl get all"
```{{exec}}

## Next Step

Next we will explore the _vcluster_ components and see how resources are
created, shared and synchronized

