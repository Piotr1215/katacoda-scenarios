## Development Loop 🌀

We are going to clone a repository with an existing function and see how the
inner development loop looks like. The function we will work with is called
`function-auto-ready`{{}} and it solves a specific problem of [deriving
readiness](https://github.com/crossplane/crossplane/issues/4616) status in the
functions pipeline.

> The function `function-auto-ready` [was developed](https://github.com/crossplane-contrib/function-auto-ready) by Nic Cope.

Let's clone the repository `git clone
https://github.com/crossplane-contrib/function-auto-ready.git`{{exec}}
download the dependencies `cd function-auto-ready && go mod download`{{exec}}
and run tests to make sure everything works `go test -v .`{{exec}}.

> WARNING
> The above command might take some time, so please be patient ⏳
> In the meantime you can explore the files in the `Editor`{{}} tab or read up on
> the composition functions documentation 💡

Before we start development loop we need to tell the system to use local
version of the code instead of pulling the image from a registry:

`yq eval -i '(select(.kind == "Function" and .metadata.name ==
"function-auto-ready").metadata.annotations."render.crossplane.io/runtime") =
"Development"' example/functions.yaml`{{exec}} will add a required annotation to
the functions.yaml file.

```yaml
annotations:
  render.crossplane.io/runtime: Development
```

Let's see if it worked `cat example/functions.yaml`{{exec}}. With this
annotation we can run the go code and use local function for development.

To simulate a development environment we are going to create a `tmux`{{}}
session and run the 2 commands below.

> This process would look very similar in your local development environment.
> Running the commands with `watch`{{}} helps with iterating over the code.

`start_tmux.sh`{{exec}}

`send_command 0 "go run . --insecure --debug"`{{exec}}

With the above command we have ran the function code in a local _gRPC_ server.
Here we can output helpful debug information during the development process.

`send_command 1 "crossplane beta render example/xr.yaml example/composition.yaml example/functions.yaml"`{{exec}}

The above command generates the rendered XR and resource in a composition without requiring
Crossplane. This is very handy for testing and inner development loop.

### Coming next

In the next section we are going to start from an empty function code and
gradually build a simple function.
