#!/usr/bin/env bash

until kubectl cluster-info 2&>/dev/null; do
  echo "Waiting for Kubernetes cluster startup..."
  sleep 5
done

kubectl wait node --all --for=condition=Ready --timeout=3m

source <(kubectl completion bash)

echo "source <(kubectl completion bash)" >> ~/.bashrc

complete -F __start_kubectl k

source ~/.bashrc

clear

echo "Cluster is ready! Cluster information:"

kubectl cluster-info
kubectl version --short
kubectl wait node --all --for=condition=Ready --timeout=3m

# Install linkerd
curl --proto '=https' --tlsv1.2 -sSfL https://run.linkerd.io/install | sh

export PATH=$PATH:/root/.linkerd2/bin

# Setup tmux sessions
tmux -2 new-session -d -s kuard
tmux -2 new-session -d -s linkerd

#tmux new-window -t $SESSION2:1 -n 'Linkerd'

# Install step
# wget https://dl.step.sm/gh-release/cli/docs-cli-install/v0.18.0/step-cli_0.18.0_amd64.deb
# sudo dpkg -i step-cli_0.18.0_amd64.deb

# Setup certifications
# step certificate create root.linkerd.cluster.local ca.crt ca.key \
# --profile root-ca --no-password --insecure
 
# step certificate create identity.linkerd.cluster.local issuer.crt issuer.key \
# --profile intermediate-ca --not-after 8760h --no-password --insecure \
# --ca ca.crt --ca-key ca.key

