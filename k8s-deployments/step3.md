# Change pods state and configuration on the flight

## Scale deployment back to 5 replicas

First, we are going to set up a watch to observe how pods are being created and terminated: `k get pods -w`{{execute T2}}

Let's make sure our deployment is setup correctly `k get deploy`{{execute T1}}

Now, let's scale it up to **5 replicas** `k scale deployment nginx-test --replicas 5`{{execute T1}}. Pay attention what is happening on the other terminal. Additional pods are being created.

## Make sure there are no environmental variables on the pods

Again, we are going to set up a fresh watch to observe how pods are being created and terminated: `k get pods -w`{{execute T2 interrupt}}

List all environmental variables in container running in our pod `k set env pods --all --list`{{execute T1}}. Pay attention what is happening on the other terminal. Pods are being terminated.

Now, let's add a new environmental variable on the deployment `k set env deployment/nginx-test APP=TEST`{{execute T1}} and list variables again `k set env pods --all --list`{{execute T1}}, we should see the new variable added.

Reset watch: `k get pods`{{execute interrupt T2}}

**Conclusion**: We have successfully proven that pods in a deployment can be easily changed via deployment manipulation.
