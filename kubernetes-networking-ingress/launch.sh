#!/bin/bash
while [ ! -f /root/.kube/config ]; do
  sleep 1
done
if [ -f /root/.kube/start ]; then
  /root/.kube/start
fi

echo "done" >>/opt/.backgroundfinished
