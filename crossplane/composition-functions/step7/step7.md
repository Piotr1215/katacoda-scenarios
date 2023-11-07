## Initial Run

> For working with the code, please make sure to switch to the `Editor`{{}} tab
> on the top left corner of the terminal window. This will allow us to see the
> the files and explore code base better.

Click on the **function-simple-label** folder and the **fn.go**
file.

The initial state of the repository is just a function signature and some
_boilerplate_ code.

Let's make sure our function works by invoking `crossplane beta render`{{}} command
and running our function in the debug mode. First, lets start a tmux session to
split panes.

`start_tmux.sh`{{exec}}

Start the debug session in one pane.

`send_command 0 "go run . --insecure --debug"`{{exec}}

> ⚠️ The first run can take a while like in the previous example.
> In the meantime we can explore example files in the example directory

And render our resources in another pane.

`send_command 1 "crossplane beta render example/xr.yaml example/composition.yaml example/functions.yaml"`{{exec}}


### Example Files

If everything went well we should see some debug output as well as a rendered
manifest, which is just an XR at this point.

Now, let's look at the composition, xr and functions files in the editor.

> All the files are in the **example** folder.

### Composition

The **composition.yaml** is composing 2 resources that belong to
[provider-nop](https://github.com/crossplane-contrib/provider-nop)

> provider-nop does not crate any external resources, but is a handy way to
> test, experiment and learn.

Notice that the resources are composed with the familiar _P&T_ (Patch &
Transform) composition style. This is possible thanks to using another
composition function called
[function-patch-and-transform](https://marketplace.upbound.io/functions/upbound/function-patch-and-transform/v0.2.1),
which brings the _P&T_ style compositions to functions.

> This composition function does everything Crossplane's built-in patch & transform (P&T) composition does. Instead of specifying spec.resources in your Composition, you can use this function.

At the end of the file we can see a pipeline step where our function executes:

```yaml
- step: run-function-simple-label
  functionRef:
    name: function-simple-label
  input:
    apiVersion: label.fn.crossplane.io/v1beta1
    kind: Input
    # This will became the value of label "crossplane.io/test.label"
    # If the lable is missing it will be added with the value of label field
    # If the label is present its value will be updated
    label: "Hello world!"
```

### Functions

You might remember that _functions_ are like any other Crossplane packages and
can be installed in the same way.

> ℹ️Notice that the _Developmet_ annotation is already present on our Function so
> that we can run it locally

### XR

A sample _xr_ to render the resources in composition.

## Next Step

Next we will start implementing the function logic in the **fn.go** file.
