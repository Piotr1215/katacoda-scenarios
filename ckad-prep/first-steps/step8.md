Existing Resource definitions can be outputted as YAML or JSON, such as `kubectl get deployment examplehttpapp -o yaml`{{execute}}

This includes a number of additional properties that can make it difficult to edit. The `--export` flag  will remove these properties. `kubectl get deployment examplehttpapp -o yaml --export`{{execute}}

This can be saved to a file `kubectl get deployment examplehttpapp -o yaml --export > examplehttpapp.yaml`{{execute}} and edited using Vim with`vim examplehttpapp.yaml`{{execute}}

