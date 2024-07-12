### Package and Distribute Your Application

   Use the Spin CLI to package and push your application to an OCI-compliant registry:
   ```sh
   APP_PREFIX=$(echo $RANDOM)
   spin registry push --build ttl.sh/"$APP_PREFIX"hello-rust:1h
   ```{{exec}}

> This command uses [Anonymous & ephemeral Docker image
> registry](http://ttl.sh/), a really cool service that allows you to push
> images anonymously and they will be deleted after some time.

## Deploying and Scaffolding Your Spin Application

Install `kube` plugin for the `spin` CLI to scaffold Kubernetes manifests for your Spin application:

   ```sh
   spin plugin install kube -y
   ```{{exec}}

### Scaffold Kubernetes Manifests

   Generate Kubernetes manifests for the Spin application:

   ```sh
   spin kube scaffold --from ttl.sh/"$APP_PREFIX"hello-rust:1h --out spinapp.yaml
   ccat spinapp.yaml
   ```{{exec}}

### Deploy Using kubectl

   Apply the generated manifest to deploy your application:
   ```sh
   kubectl apply -f spinapp.yaml
   ```{{exec}}

> 💡 we can view the deployed spin app using octant. Open
> [Octant]({{TRAFFIC_HOST1_7777}})

### View the Deployed Application

   Open the deployed application in your browser:
   ```sh
   kubectl port-forward deploy/"$APP_PREFIX"hello-rust 8085:80 --address 0.0.0.0 &
   ```{{exec}}

> 💡 Navigate to the page [Web Page]({{TRAFFIC_HOST1_8085}})

For more details, visit the [SpinKube Packaging Guide](https://www.spinkube.dev/docs/topics/packaging/).
