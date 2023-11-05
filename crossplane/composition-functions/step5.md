## Create simple function

<!-- TODO: 5. create simple function logic -->

The repository with `function-auto-ready` is already cloned into our
environment.

The initial state of the repository is just a function scaffolding, with each
step we will add more code and explain the development.

Check if the function is correctly deployed:

`cd function-auto-ready && go test -v -cover .`{{exec}}

Let's see if our function works:

`start_tmux.sh`{{exec}}

`send_command 0 "go run . --insecure --debug"`{{exec}}

`send_command 1 "crossplane beta render example/xr.yaml example/composition.yaml example/functions.yaml"`{{exec}}
