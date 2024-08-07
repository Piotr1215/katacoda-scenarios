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

1. Scale deployment to **10 replicas** `k scale deployment nginx-test --replicas 10`{{execute}}
Check what image deployment currently has `k describe deploy nginx-test | grep image`{{execute}} and trigger rolling update by setting new version of the image (blue or green tag)
   - if image is *piotrzan/nginx-demo:blue* run `k set image deployment/nginx-test nginx-test=piotrzan/nginx-demo:green --record=true`{{execute}}
   - if image is *piotrzan/nginx-demo:green* run `k set image deployment/nginx-test nginx-test=piotrzan/nginx-demo:blue --record=true`{{execute}}
2. Observe how Kuberentes performs a rollout `k rollout status deployment nginx-test`{{execute}}
3. Trigger another rolling update by setting new version of the image, but this time make a mistake in image name `k set image deployment/nginx-test nginx-test=piotrzan/nginx-demo:blueA --record`{{execute}}
4. Observe how Kuberentes performs a rollout `k rollout status deployment nginx-test`{{execute}}
5. Check logs to see error messages on pods with *ImagePullBackOff* error `k get pods | grep ImagePullBackOff | awk '{print $1}' | xargs kubectl describe pod`{{execute}}
6. Check rollout history to determine how many revisions are recorded, there should be at least one.  `k rollout history deployment nginx-test`{{execute}}, choose number to which you want to roll back to
7. Perform rollback to previous version `k rollout undo deployment nginx-test --to-revision `{{execute no-newline}}, add revision number from the command output above and hit *Enter*
8. Observe how Kubernetes performs a new rollout `k rollout status deployment nginx-test`{{execute}}
9. Do a curl on service to make sure deployment was successful `curl localhost:$PORT`{{execute}}

**Conclusion**: We have successfully proven that Kubernetes allows fain grained control over software delivery process via rollouts and rollbacks.
