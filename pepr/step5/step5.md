## Let's develop a custom capability

`Pepr's` claim to fame is to be `Configuration as Code for IT Ops`. One of the
most common tasks for IT or DevOps engineers is to create backup. Let's design a
custom capability for a simple YAML backup when a pod is created in a `default`
namespace.

First we need to generate a new module:

```bash
cd /root && pepr init
```{{exec interrupt}}

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
import { Capability, Log, a } from "pepr";
import * as fs from "fs";
import * as path from "path";
import * as yaml from "js-yaml";

export const SavePodYAML = new Capability({
  name: "save-pod-yaml",
  description: "Save YAML of created Pods in default namespace.",
  namespaces: ["default"],
});

const { When } = SavePodYAML;

When(a.Pod).IsCreated().Mutate((request) => {
  const pod = request.Raw;
  const podName = pod.metadata?.name || pod.metadata?.generateName;
  if (!podName) return;

  const filePath = path.join("/tmp", `${podName}.yaml`);
  try {
    fs.writeFileSync(filePath, yaml.dump(pod), "utf8");
    Log.info(`Pod YAML saved to ${filePath}`);
  } catch (error) {
    Log.error(`Failed to save Pod YAML: ${error}`);
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

## Next Steps

Next we will deploy our backup module and capabilities.
