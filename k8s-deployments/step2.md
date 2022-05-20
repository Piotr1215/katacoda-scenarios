# Scale pods up and down on demand

## Create deployment

`k apply -f https://raw.githubusercontent.com/Piotr1215/dca-exercises/master/k8s/deployment/1-create-deployment.yaml`{{execute}}

This will create a simple nginx deployment.

## Scale deployment up and watch pods being created

First, we are going to set up a watch to observe how pods are being created and terminated: `k get pods -w`{{execute}}

Let's make sure our deployment is setup correctly `k get deploy`{{execute}}

Now, let's scale it up to **5 replicas** `k scale deployment nginx-test --replicas 5`{{execute}}. Pay attention what is happening on the other terminal. Additional pods are being created.

## Scale deployment down and watch pods being terminated

Again, we are going to set up a watch to observe how pods are being created and terminated: `k get pods -w`{{execute}}

Now, let's scale it down back to **1 replica** `k scale deployment nginx-test --replicas 1`{{execute}}. Pay attention what is happening on the other terminal. Pods are being terminated.

There should only be one pod left: `k get pods`{{execute}}

**Conclusion**: We have successfully proven pods can be easily scaled up and down.
