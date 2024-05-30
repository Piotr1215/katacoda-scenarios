> 👇🖱️Clicking on grayed command like below will execute it in the terminal.

`curl -s https://kluctl.io/install.sh | bash`{{exec}}

Once the installation is complete, we can start a `kluctl` webui 

`nohup kluctl webui run --host=0.0.0.0 > /dev/null 2>&1 &`{{exec}}

This will start the [kluctl webui]({{TRAFFIC_HOST1_8080}}) which we will use
later in the workshop. 

## Next Step

Next we will setup a basic `kluctl` project.
