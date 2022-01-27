🔭 Observability

First we need to install observability extensions

`linkerd viz install | kubectl apply -f -`{{execute T1}}
 



Check what image deployment currently has `k describe deploy nginx-test | grep image`{{execute T1}} and trigger rolling update by setting new version of the image (blue or green tag)
   - if image is *piotrzan/nginx-demo:blue* run `k set image deployment/nginx-test nginx-test=piotrzan/nginx-demo:green --record=true`{{execute T1}}
   - if image is *piotrzan/nginx-demo:green* run `k set image deployment/nginx-test nginx-test=piotrzan/nginx-demo:blue --record=true`{{execute T1}}
2. Observe how Kuberentes performs a rollout `k rollout status deployment nginx-test`{{execute T2}}
3. Trigger another rolling update by setting new version of the image, but this time make a mistake in image name `k set image deployment/nginx-test nginx-test=piotrzan/nginx-demo:blueA --record`{{execute T1}}
4. Observe how Kuberentes performs a rollout `k rollout status deployment nginx-test`{{execute interrupt T2}}
5. Check logs to see error messages on pods with *ImagePullBackOff* error `k get pods | grep ImagePullBackOff | awk '{print $1}' | xargs kubectl describe pod`{{execute T1}}
6. Check rollout history to determine how many revisions are recorded, there should be at least one.  `k rollout history deployment nginx-test`{{execute T1}}, choose number to which you want to roll back to
7. Perform rollback to previous version `k rollout undo deployment nginx-test --to-revision `{{execute no-newline}}, add revision number from the command output above and hit *Enter*
8. Observe how Kubernetes performs a new rollout `k rollout status deployment nginx-test`{{execute interrupt T2}}
9. Do a curl on service to make sure deployment was successful `curl localhost:$PORT`{{execute T1}}

**Conclusion**: We have successfully proven that Kubernetes allows fain grained control over software delivery process via rollouts and rollbacks.
