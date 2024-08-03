## Run the backup module

```bash
start_tmux.sh 
```{{exec}}

```bash
send_command 0 "cd yaml-backup && pepr dev --confirm"
```{{exec}}

```bash
send_command 1 "kubectl create deployment nginx --image=nginx"
```{{exec}}

> We can also see logs output once the pod is created.

Let's check if the pod YAML was saved to the node in the `/tmp` directory:

```bash
send_command 1 "ls -l /tmp"
```{{exec}}

```bash
send_command 1 "bat /tmp/*.yaml"
```{{exec interrupt}}

## Next Steps

Next we will deploy pepr controller to the Kubernetes cluster.

