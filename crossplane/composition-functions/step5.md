## Begin the development

<!-- TODO: 5. create simple function logic -->

We are going to clone a repository with an existing function and go through the
development process.

`git clone https://github.com/Piotr1215/function-auto-ready.git`{{exec}}

The initial state of the repository is just a function scaffolding, with each
step we will add more code and explain the development.

Before we start developing our function we need to tell the system to use local
version instead of pulling the image from a registry:

`yq eval -i '(select(.kind == "Function" and .metadata.name == "function-auto-ready").metadata.annotations."render.crossplane.io/runtime") = "Development"' example/functions.yaml`{{exec}}

> The above command will add the required development annotation to our
> function:
```yaml
  annotations:
    render.crossplane.io/runtime: Development
```


Let's see if our function works, we are going to create a tmux session and
execute debug commands to see if our function works.

`start_tmux.sh`{{exec}}

`send_command 0 "go run . --insecure --debug"`{{exec}}

> WARNING
> This might take some time, so please be patient ⏳

`send_command 1 "crossplane beta render example/xr.yaml example/composition.yaml example/functions.yaml"`{{exec}}
