## Function Anatomy

Notice that now the **fn.go** file has comments over important parts of the
code. We have also added a _log debug_ statement to show what we are getting as
the input to our function.

`f.log.Debug("Getting input", "input", in)`{{}}

Let's run the code again and see what we are getting:

- `start_tmux.sh`{{exec}}
- `send_command 0 "go run . --insecure --debug"`{{exec}}
- `send_command 1 "crossplane beta render example/xr.yaml example/composition.yaml example/functions.yaml"`{{exec}}

we should see `json`{{}} form of the function input.

- `kill_tmux.sh`{{exec interrupt}}

### RunFunctionRequest and RunFunctionResponse

Each composition function accepts [RunFunctionRequest](https://pkg.go.dev/github.com/crossplane/function-sdk-go@v0.1.0/requesthttps://pkg.go.dev/github.com/crossplane/function-sdk-go@v0.1.0/request). See its [detailed schema](https://buf.build/crossplane/crossplane/docs/main:apiextensions.fn.proto.v1beta1#apiextensions.fn.proto.v1beta1.RunFunctionRequest) in the Buf Schema service.

And returns [RunFunctionResponse](https://pkg.go.dev/github.com/crossplane/function-sdk-go@v0.1.0/response). See its [detailed schema](https://buf.build/crossplane/crossplane/docs/main:apiextensions.fn.proto.v1beta1#apiextensions.fn.proto.v1beta1.RunFunctionResponse) in the Buf schema service.

### Function Input

Each function can have an arbitrary structure as input. In our case we have
defined a simple struct with one filed describing the label value:

```go
type Input struct {
	metav1.TypeMeta   `json:",inline"`
	metav1.ObjectMeta `json:"metadata,omitempty"`

	// Label is used to add a static label to each composed resource.
	Label string `json:"label"`
}
```

## Next Step

Next we will retrieve observed _xr_ from the request.

