echo "Waiting for Kubernetes to start. This can take a few minutes"
while [ ! -f /opt/.backgroundfinished ]; do sleep 2; done
echo "Kubernetes Started"
