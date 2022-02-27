
- apply composition and definition `kubectl apply -f composition-definition.yaml`
  ![k8s-resource-xrd](k8s-resource-xrd.png)
  ![k8s-resource-app](k8s-resource-app.png)

- create a namespace for the resources `kubectl create ns devops-team`
- claim the resources by running `kubectl apply -f app-claim.yaml`
- navigate to `https://platform.127.0.0.1.nip.io/` and you should see a simple demo page
  ![demo-webapp-browser](demo-webapp-browser.png)
- delete claim `kubectl delete -f app-claim.yaml`
- observe how all the resources created by the claim got deleted as well

