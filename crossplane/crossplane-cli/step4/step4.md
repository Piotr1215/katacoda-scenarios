## Trace claim

Install provider nop

`crossplane xpkg install provider xpkg.upbound.io/crossplane-contrib/provider-nop:v0.2.0`{{exec}}

check if provider is ready

`kubectl get crossplane`{{exec}}

Apply resources `kubectl apply -f assets/composition.yaml,assets/xrd.yaml,assets/functions.yaml`{{exec}}

Once everything is applied, we can apply our xr: `kubectl apply -f assets/xr.yaml`{{exec}}

Trace
