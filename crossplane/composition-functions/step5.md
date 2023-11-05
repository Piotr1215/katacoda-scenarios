## Create simple function

<!-- TODO: 5. create simple function logic -->

We are going to clone a repository with an existing function and go through the
development process.

`git clone https://github.com/Piotr1215/function-auto-ready.git`{{exec}}

The initial state of the repository is just a function scaffolding, with each
step we will add more code and explain the development.

Check if the function is correctly deployed:

`cd function-auto-ready && go test -v -cover .`{{exec}}

> [!WARNING]
> This might take some time, so please be patient ⏳

Let's see if our function works:

`start_tmux.sh`{{exec}}

`send_command 0 "go run . --insecure --debug"`{{exec}}

`send_command 1 "crossplane beta render example/xr.yaml example/composition.yaml example/functions.yaml"`{{exec}}
