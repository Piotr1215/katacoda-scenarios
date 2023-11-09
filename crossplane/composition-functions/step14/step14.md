## Are labels really applied?

As the last step we are going to install our function and compositon into the
local cluster:

First notice that we have added the `xrd.yaml`{{}} file to the example folder as
well as adjusted the compositon and xr to fulfill Crossplane's requirements. Our
`function-simple-label`{{}} has been published to a repository and added to the
`functions.yaml`{{}} as another installation target.

> 📖 to learn how to build and publish composition functions, visit [Crossplane docs](https://docs.crossplane.io/v1.14/concepts/composition-functions/#write-a-composition-function).

### Let's apply some YAML

`kubectl apply -f example/composition.yaml,example/xrd.yaml,example/functions.yaml`{{exec}}

Once everything is applied, we can apply our xr: `kubectl apply -f example/xr.yaml`{{exec}}

### Checking managed resources


- `start_tmux.sh`{{exec}}
- `send_command 0 "watch kubectl get nopresources --show-labels"`{{exec}}
- `send_command 1 "watch kubectl get crossplane"`{{exec}}

The labels should be added as per our specification!

> Now you can open [Komoplane]({{TRAFFIC_HOST1_8090}}) and check what we have
> deployed.

![komoplane-resources](https://i.ibb.co/DQV2cTT/image.png)

## Explore on your own

Use `komoplane`{{}} and `Crossplane`{{}} to modify the function and experiment
with installing, building and other commands from the `crossplane` CLI.

You can for example add a `label`{{}} field to the `xrd`{{}} and pass it to the
composition function input or change the label value.

## Next Step

If you have made it this far, thank you and congratulation 🎉.
This is the end of the tutorial. You have learned about developing and
testing Crossplane Composition Functions.

Next step is to create your own function solving a real business need or just
for fun. Since now the compositions can be rendered using Touring-complete
languages, the possibilities are quiet literally endless!
