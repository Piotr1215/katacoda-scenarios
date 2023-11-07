## Main Function Logic

The goal of our function is to add or update a specific label to all the
resources created by the composition. Let's add the logic to do just that:

- `start_tmux.sh`{{exec}}
- `send_command 0 "go run . --insecure --debug"`{{exec}}
- `send_command 1 "crossplane beta render example/xr.yaml example/composition.yaml example/functions.yaml"`{{exec}}

Notice that now the resources from the `render`{{}} command now each have a
label of `crossplane.io/test-label: Hello work`

- `kill_tmux.sh`{{exec interrupt}}

### Recap

What we have done is iterated over all desired resources and if our label was
not present we have added it. In case when the label was present, we have
updated it's value based on the function's input.

At the end, by calling the `response.SetDesiredComposedResources`{{}} function,
we have re-added the modified resources to the pipeline so the functions running
after ours can operate on the whole resource.

## Next Step

Next we will add a more informative logging that will be later visible in the
function pod.
