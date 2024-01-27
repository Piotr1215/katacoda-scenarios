## Trace claim

Apply resources `kubectl apply -f composition.yaml,xrd.yaml,functions.yaml`{{exec}}

Once everything is applied, we can apply our xr: `kubectl apply -f xr.yaml`{{exec}}

Now run trace command to see how the resources from our xr are applied

`crossplane beta trace ...`{{exec}}
