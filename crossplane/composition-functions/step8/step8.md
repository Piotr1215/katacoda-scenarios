## Function Anatomy

Notice that now the **fn.go** file has comments over important parts of the
code. We have also added a _log debug_ statement to show what we are getting as
the input to our function.

`f.log.Debug("Getting input", "input", in)`{{}}

Let's run the code again and see what we are getting

````bash
start_tmux.sh
send_command 0 "go run . --insecure --debug"
send_command 1 "crossplane beta render example/xr.yaml example/composition.yaml example/functions.yaml"
```{{exec}}

we should see `json`{{}} form of the function input.

`kill_tmux.sh`{{exec interrupt}}

````
