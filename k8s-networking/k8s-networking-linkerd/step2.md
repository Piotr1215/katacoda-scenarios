# Install linkerd

## Install CLI

`curl --proto '=https' --tlsv1.2 -sSfL https://run.linkerd.io/install | sh`{{execute T1}}

The CLI will allow you to interact with your Linkerd deployment.

## Scale deployment up and watch pods being created

First, we are going to set up a watch to observe how pods are being created and terminated: `k get pods -w`{{execute T2}}

Let's make sure our deployment is setup correctly `k get deploy`{{execute T1}}

Now, let's scale it up to **5 replicas** `k scale deployment nginx-test --replicas 5`{{execute T1}}. Pay attention what is happening on the other terminal. Additional pods are being created.

## Scale deployment down and watch pods being terminated

Again, we are going to set up a watch to observe how pods are being created and terminated: `k get pods -w`{{execute interrupt T2}}

Now, let's scale it down back to **1 replica** `k scale deployment nginx-test --replicas 1`{{execute T1}}. Pay attention what is happening on the other terminal. Pods are being terminated.

There should only be one pod left: `k get pods`{{execute interrupt T2}}

**Conclusion**: We have successfully proven pods can be easily scaled up and down.
