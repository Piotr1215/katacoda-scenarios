💉 inject linkerd sidecar

> Before injecting the linkerd sidecar, let's see how many containers run inside
> kuard pod. There should be only kuard container running.

`kubectl get pods -l app=kuard -o jsonpath='{.items[*].spec.containers[*].name}{"\n"}'`{{execute}}

➡ inject linkerd sidecar into kuard pod

````bash
kubectl get deploy kuard -o yaml \
  | linkerd inject - \
  | kubectl apply -f -
```{{execute}}

➡ make sure linkerd sidecar applied correctly

`linkerd -n default check --proxy`{{execute}}

➡ we should see the linkerd sidecar running in the pod

`kubectl get pods -l app=kuard -o jsonpath='{.items[*].spec.containers[*].name}{"\n"}'`{{execute}}
````
