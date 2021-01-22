#!/bin/bash

wget https://github.com/vmware-tanzu/octant/releases/download/v0.16.3/octant_0.16.3_Linux-64bit.tar.gz
tar -xzvf octant_0.16.3_Linux-64bit.tar.gz
cp ./octant_0.16.3_Linux-64bit/octant /usr/bin/

OCTANT_DISABLE_OPEN_BROWSER=true
OCTANT_LISTENER_ADDR=0.0.0.0:7777 octant