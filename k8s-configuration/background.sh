#!/bin/bash

# Start Kubernetes
echo "Starting cluster"
launch.sh
echo "done" >> /opt/.clusterstarted

echo "Installing Octant"
wget https://github.com/vmware-tanzu/octant/releases/download/v0.16.3/octant_0.16.3_Linux-64bit.tar.gz
tar -xzvf octant_0.16.3_Linux-64bit.tar.gz
cp ./octant_0.16.3_Linux-64bit/octant /usr/bin/

OCTANT_DISABLE_OPEN_BROWSER=true
OCTANT_LISTENER_ADDR=0.0.0.0:7777 octant &
echo "done" >> /opt/.octantinstalled

echo "Waiting for nodes ready"
kubectl wait node --all --for=condition=Ready --timeout=60s
echo "done" >> /opt/.nodesready

echo "Cloning Repo with Examples"
mkdir examples
cd examples
git clone https://github.com/Piotr1215/dca-exercises.git dca-exercises
echo "done" >> /opt/.examplescloned

echo "done" >> /opt/.backgroundfinished