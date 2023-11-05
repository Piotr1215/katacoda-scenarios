## Development Loop 🌀

<!-- TODO: 5. create simple function logic -->

We are going to clone a repository with an existing function and go through the
development process, but first let's see how the development loop looks like
with the composition functions.

`git clone https://github.com/Piotr1215/function-auto-ready.git && cd function-auto-ready && go mod download`{{exec}}

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

`cat example/functions.yaml`{{exec}}

Let's see if our function works, we are going to create a tmux session and
execute debug commands to see if our function works.

`start_tmux.sh`{{exec}}

> WARNING
> The below commands might take some time, so please be patient ⏳
> In the meantime you can explore the files in the `Editor` tab or read up on
> the composition functions documentation 💡

`send_command 0 "go run . --insecure --debug"`{{exec}}

With the above command we have ran the function code in a local _gRPC_ server.
Here we can output helpful debug information during the development process.

`send_command 1 "crossplane beta render example/xr.yaml example/composition.yaml example/functions.yaml"`{{exec}}

The above command generates the rendered XR and resource in a composition without requiring
Crossplane. This is very handy for testing and inner development loop.

### Coming next

In the next section we are going to start from an empty function code and
gradually build a fully fledged function.

> The function will will build already exists and it's called
> `function-auto-ready` and [was
> originally](https://github.com/crossplane-contrib/function-auto-ready) created
> by Nic Cope. 
