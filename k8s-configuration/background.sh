#!/bin/bash

# Start Kubernetes
echo "Waiting for cluster ready"
kubectl wait node --all --for=condition=Ready --timeout=60s
echo "done" >> /opt/.nodesready

echo "Installing and Octant"
wget https://github.com/vmware-tanzu/octant/releases/download/v0.16.3/octant_0.16.3_Linux-64bit.tar.gz
tar -xzvf octant_0.16.3_Linux-64bit.tar.gz
cp ./octant_0.16.3_Linux-64bit/octant /usr/bin/
echo "done" >> /opt/.octantinstalled

echo "Cloning repo with examples"
mkdir examples
cd examples
git clone https://github.com/Piotr1215/dca-exercises.git dca-exercises
echo "done" >> /opt/.examplescloned

echo "Starting Octant in the background"

echo "done" >> /opt/.backgroundfinished

OCTANT_DISABLE_OPEN_BROWSER=true
OCTANT_LISTENER_ADDR=0.0.0.0:7777 octant
