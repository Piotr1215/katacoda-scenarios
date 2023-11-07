## Retrieve XR data

Let's run the function again:

- `start_tmux.sh`{{exec}}
- `send_command 0 "go run . --insecure --debug"`{{exec}}
- `send_command 1 "crossplane beta render example/xr.yaml example/composition.yaml example/functions.yaml"`{{exec}}

With the added debug line we should see additional
output of the xr data we have submitted to to `render`{{}} command.


## Next Step

Next we are going to get desired resources.
