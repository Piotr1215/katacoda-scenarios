# Install-linkerd :link:

## Add CLI to PATH

`export PATH=$PATH:/root/.linkerd2/bin`{{execute T1}}

The linkerd CLI will allow you to interact with your Linkerd deployment.

## Install the control plane onto your cluster

`linkerd install | kubectl apply -f -`{{execute T1}}

`linkerd check`{{execute T1}}
