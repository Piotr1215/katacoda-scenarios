
## Building and Pushing Your Spin Application

4. **Package and Distribute Your Application**:
   Use the Spin CLI to package and push your application to an OCI-compliant registry:
   ```sh
   APP_NAME=$(echo RANDOM)
   spin registry push --build ttl.sh/"$APP_NAME":1h
   ```

> This command uses [Anonymous & ephemeral Docker image
> registry](http://ttl.sh/), a really cool service that allows you to push
> images anonymously and they will be deleted after some time.

---

## Deploying and Scaffolding Your Spin Application

2. **Scaffold Kubernetes Manifests**:
   Generate Kubernetes manifests for your Spin application:
   ```sh
   spin kube scaffold --from ttl.sh/"$APP_NAME":1h --out spinapp.yaml
   ccat spinapp.yaml
   ```

3. **Deploy Using kubectl**:
   Apply the generated manifest to deploy your application:
   ```sh
   kubectl apply -f spinapp.yaml
   ```

For more details, visit the [SpinKube Packaging Guide](https://www.spinkube.dev/docs/topics/packaging/).
