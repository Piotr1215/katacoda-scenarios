# Perform zero-downtime update of pods to new versions

This scenario is a little bit more involving, so there are a few more steps. We are going to use octant to see pods being updated in real time as well as a very simple static page served by nginx.

Run Octant: https://[[HOST_SUBDOMAIN]]-7777-[[KATACODA_HOST]].environments.katacoda.com, this command will display *octant* cluster viewer. Octant is already installed on this setup

> HINT: In order to observe real time updates of the pods consider installing a [browser auto-refresh plugin](https://www.supersimpleautorefresh.tk/)

## We will follow steps below

1. Install browser auto-refresh plugin to see the effects of updates [optional]
2. Make sure deployment is scaled the deployment to 5 replicas `k scale deployment nginx-test --replicas 5`{{execute T1}}
3. Expose deployment by creating a service of type NodePort `k expose deployment/nginx-test --port 80 --target-port 80 --type NodePort --name nginxsvc`{{execute T1}}
4. Check port of the newly service `kubectl describe service frontend | grep NodePort`{{execute T1}}
Access the pods in a browser localhost:PORT
Update image of the containers running in pods controlled by our deployment
Observe how page changes to new version