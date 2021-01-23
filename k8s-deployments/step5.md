# Control the delivery process by using rollouts and rollbacks

First we need to understand how Kubernetes performs updates:
Kubernetes supports two types of deployment strategies

- RollingUpdate
- Recreate

We are only looking at RollingUpdate below:

![Deployment Spec](http://www.plantuml.com/plantuml/proxy?cache=yes&src=https://raw.githubusercontent.com/Piotr1215/dca-prep-kit/master/diagrams/k8s-deployment-seq.puml&fmt=png)
*Source*: https://kubernetes.io/docs/tutorials/kubernetes-basics/update/update-intro/

Rollback is simply the reverse of rolling update. Kubernetes stores state of previous updates, so it’s very easy to revert to previous revision.

**Let’s dive in!**

## Follow steps below

Let's clear both terminals from previous output

`clear`{{execute T1 T2}}

1. Scale deployment to 10 replicas `k scale deployment nginx-test --replicas 5`{{execute T1}}
Check what image deployment currently has `k describe deploy nginx-test | grep image`{{execute T1}} and trigger rolling update by setting new version of the image (blue or green tag)
   - if image is *piotrzan/nginx-demo:blue* run `kubernetes.io/change-cause: kubectl set image deployment/nginx-test nginx-test=piotrzan/nginx-demo:green --record=true`{{execute T1}}
   - if image is *piotrzan/nginx-demo:green* run `kubernetes.io/change-cause: kubectl set image deployment/nginx-test nginx-test=piotrzan/nginx-demo:blue --record=true`{{execute T1}}
2. Observe how Kuberentes performs a rollout `k rollout status deployment nginx-test`{{execute T2}}
3. Trigger another rolling update by setting new version of the image, but this time make a mistake in image name `k set image deployment/nginx-test nginx-test=piotrzan/nginx-demo:blueA --record`{{execute T1}}
4. Observe how Kuberentes performs a rollout `k rollout status deployment nginx-test`{{execute interrupt T2}}
5. Check logs to see error messages
6. Check rollout history to determine how many revisions are recorded, there should be at least one.  `k rollout history deployment nginx-test`{{execute T1}}, choose number to which you want to roll back to
7. Perform rollback to previous version `k rollout undo deployment nginx-test --to-revision `{{copy}} add revision number and hit *Enter*
8. Observe how Kuberentes performs a new rollout `k rollout status deployment nginx-test`{{execute interrupt T2}}
9. Do a curl on service to make sure deployment was successful `PORT=$(k get service nginxsvc -o jsonpath='{.spec.ports[*].nodePort})`{{copy}}. `curl localhost:$PORT`{{execute T1}}