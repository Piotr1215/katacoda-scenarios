## Installation

As the last step we are going to install our function and compositon into the
local cluster:

First notice that we have added the `xrd.yaml`{{}} file to the example folder as
well as adjusted the compositon and xr to fulfill Crossplane's requirements.

### Let's apply some YAML

`kubectl apply -f example/composition.yaml,example/xrd.yaml,example/functions.yaml`{{exec}}

Once everything is applied, we can apply our xr: `kubectl apply -f example/xr.yaml`{{exec}}

> Now you can open `Komoplane`{{}} on the port `8090`{{}} and check what we have
> deployed.

### Checking managed resources

`watch kubectl get managed`{{exec}}

should give us an idea if the resources are correctly applied.

Let's check if the labels are added as per our specification!

`kubectl get testresources --show-labels`{{exec interrupt}}

