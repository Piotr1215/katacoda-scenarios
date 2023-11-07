## Get Desired Resources

Let's run the function again:

- `start_tmux.sh`{{exec}}
- `send_command 0 "go run . --insecure --debug"`{{exec}}
- `send_command 1 "crossplane beta render example/xr.yaml example/composition.yaml example/functions.yaml"`{{exec}}

With the added debug line we should see additional
output of the desired resources state.

- `kill_tmux.sh`{{exec interrupt}}

## Next Step

Next we are learn how to add main function logic add our label to the
composed resources.
