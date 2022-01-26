# Perform zero-downtime update of pods to new versions

This scenario is a little bit more involving, so there are a few more steps. We are going to use octant to see pods being updated in real time as well as a very simple static page served by nginx.

Run Octant: https://[[HOST_SUBDOMAIN]]-7777-[[KATACODA_HOST]].environments.katacoda.com, this command will display *octant* cluster viewer. Octant is already installed on this setup

> HINT: In order to observe real time updates of the pods consider installing a [browser auto-refresh plugin](https://www.supersimpleautorefresh.tk/)

## Follow steps below

1. Install browser auto-refresh plugin to see the effects of updates [optional]
2. Setup watch on pods `k get pods -w`{{execute T2}}
3. Make sure deployment is scaled to 5 replicas `k scale deployment nginx-test --replicas 5`{{execute T1}}
4. Expose deployment by creating a service of type NodePort `k expose deployment/nginx-test --port 80 --target-port 80 --type NodePort --name nginxsvc`{{execute T1}}
5. Retrieve port of the newly service `export PORT=$(k get service nginxsvc -o jsonpath='{.spec.ports[*].nodePort}')`{{execute T1}}, `echo $PORT`{{execute T1}} copy the port, this is a node port where *nginxsvc* is running on.
6. Navigate to https://[[HOST_SUBDOMAIN]]-[[KATACODA_HOST]].environments.katacoda.com/ and paste port copied from previous command
7. Activate auto-refresh plugin if you installed in in step 1
8. Update image of the containers running in pods controlled by our deployment `k set image deployment/nginx-test nginx-test=piotrzan/nginx-demo:blue --record`{{execute T1}}
9. Observe how page changes to new version.
10. Reset watch: `k get pods`{{execute interrupt T2}}

**Conclusion**: We have successfully proven that pods in a deployment can be easily updated with new version of an image without causing downtime in availability.
