Let's start by creating the basic structure of our script with strict mode.

```bash
cat << 'EOF' > file_creator.sh
#!/usr/bin/env bash

# Set strict mode
set -euo pipefail
EOF

chmod +x file_creator.sh
```{{exec}}

The `set` command with these options enables strict mode:
- `-e`: Exit immediately if a command exits with a non-zero status.
- `-u`: Treat unset variables as an error when substituting.
- `-o pipefail`: The return value of a pipeline is the status of the last command to exit with a non-zero status, or zero if no command exited with a non-zero status.

This helps catch errors early and prevents many common shell scripting pitfalls.
