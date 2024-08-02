## Backup YAML to node

`Pepr's` claim to fame is to be `Configuration as Code for IT Ops`. One of the
most common tasks for IT or DevOps engineers is to create backup. Let's design a
custom capability for a simple YAML backup when a pod is created in a `default`
namespace.

First we need to generate a new module:

```bash
cd /root && pepr init
```{{exec}}

- module name: `yaml-backup`{{exec}}
- description: `Backup pod YAML to node`{{exec}}
- configure failure behavior: `^M`{{exec}}
- create module: `Y`{{exec}}

```bash
cd ./yaml-backup
```{{exec}}

And let's create a backup.ts capability

```typescript
cat << 'EOF' > capabilities/backup.ts
import {
  Capability,
  Log,
  a,
} from "pepr";
import * as fs from "fs";
import * as path from "path";
import * as yaml from "js-yaml";

/**
 *  The SavePodYAML Capability saves the YAML of created Pods in the default namespace.
 */
export const SavePodYAML = new Capability({
  name: "save-pod-yaml",
  description: "Saves the YAML of created Pods in the default namespace to a file.",
  namespaces: ["default"],
});

// Use the 'When' function to create a new action
const { When } = SavePodYAML;

// Define the action to save Pod YAML when a Pod is created in the default namespace
When(a.Pod)
  .IsCreated()
  .Mutate(async (request) => {
    const pod = request.Raw;
    const podName = pod.metadata?.name;
    const podYaml = yaml.dump(pod);
    const filePath = path.join("/tmp", `${podName}.yaml`);

    try {
      fs.writeFileSync(filePath, podYaml, "utf8");
      Log.info(`Pod YAML saved to ${filePath}`);
    } catch (error) {
      Log.error(error, `Failed to save Pod YAML to ${filePath}`);
    }
  });
EOF
```{{exec}}

Ok, we need to modify the `pepr.ts` file to remove the `HelloPepr` module and
add our own:

```typescript
cat << 'EOF' > pepr.ts
import { PeprModule } from "pepr";
// cfg loads your pepr configuration from package.json
import cfg from "./package.json";

// Import the new SavePodYAML capability
import { SavePodYAML } from "./capabilities/backup";

/**
 * This is the main entrypoint for this Pepr module. It is run when the module is started.
 * This is where you register your Pepr configurations and capabilities.
 */
new PeprModule(cfg, [
  // Your additional capabilities go here
  SavePodYAML,
]);
EOF
```{{exec}}

Run `pepr format`{{exec}} to make sure the files are formatted correctly.

```bash
start_tmux.sh 
```{{exec}}

```bash
send_command 1 "cd yaml-backup && pepr dev --confirm"
```

```bash
send_command 0 "kubectl create deployment nginx --image=nginx"
```



