
Since the focus of this workshop is on the implementaion fundamentals, our
function's logic will be simple and will add a label to every rendered resource.

`git clone https://github.com/Piotr1215/function-simple-label.git && cd
function-simple-label`{{exec}}

## Initial State

This repository was created using the
[function-template-go](https://github.com/crossplane/function-template-go)
GitHub template repo. The starting point:

- [x] Replace function-template-go with your function's name in go.mod, package/crossplane.yaml, and any Go imports
- [x] Update input/v1beta1/ to reflect your desired input (and run go generate)
- [x] Prepared files in the <kbd>example</kbd> directory. Here we are using
      [provider-nop](https://marketplace.upbound.io/providers/crossplane-contrib/provider-nop/v0.2.0)
      and [function-patch-and-transform](https://marketplace.upbound.io/functions/upbound/function-patch-and-transform/v0.2.1)

## Code

```bash
.
├── Dockerfile
├── example
│   ├── composition.yaml
│   ├── functions.yaml
│   ├── README.md
│   └── xr.yaml
├── fn.go
├── fn_test.go
├── go.mod
├── go.sum
├── label
│   ├── generate.go
│   └── v1beta1
│       ├── input.go
│       └── zz_generated.deepcopy.go
├── LICENSE
├── main.go
├── package
│   ├── crossplane.yaml
│   └── input
│       └── template.fn.crossplane.io_inputs.yaml
├── README.md
└── renovate.json

5 directories, 18 files
```

Here is explanation of main files and directories:

![functions-spec](http://www.plantuml.com/plantuml/proxy?cache=yes&src=https://raw.githubusercontent.com/Piotr1215/dca-prep-kit/master/diagrams/composition-funcion-mindmap.puml&fmt=png)

## Next Step

Next we will run the code and start developing the function.
