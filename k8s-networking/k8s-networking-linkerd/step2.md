# Install linkerd

## Install CLI

`curl --proto '=https' --tlsv1.2 -sSfL https://run.linkerd.io/install | sh`{{execute T1}}

The CLI will allow you to interact with your Linkerd deployment.

## Validate your Kubernetes cluster

`linkerd check --pre`{{execute T1}}

## Install the control plane onto your cluster

`linkerd install | kubectl apply -f -`{{execute T1}}

`linkerd check`{{execute T1}}
