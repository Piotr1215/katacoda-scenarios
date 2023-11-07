## Better Log Output

Let's improve our log output by redefinihg the log struct with additional
context.

- `start_tmux.sh`{{exec}}
- `send_command 0 "go run . --insecure --debug"`{{exec}}
- `send_command 1 "crossplane beta render example/xr.yaml example/composition.yaml example/functions.yaml"`{{exec}}

We are using the `log.WithValues`{{}} function to add _xr_ context to our log.

- `kill_tmux.sh`{{exec interrupt}}

## Next Steps

Next we are going to run unit tests to make sure our function works as
expected and briefly outline next steps we could do with the function.

>  using a _TDD_ approach we would start from writing the tests, but for the
> sake of this example we are running tests at the end
