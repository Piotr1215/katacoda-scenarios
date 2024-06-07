> 👇🖱️Clicking on grayed command like below will execute it in the terminal.

### Installation

We can install `just` using an installation script

```bash
curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh \
    | bash -s -- --to /usr/local/bin
```{{exec}}

We can confirm that the installation was succesfull by running

```bash
just --version
```{{exec}}

### Setting up sample project

Create a directory for the sample project

```bash
mkdir -p ./just-example && cd ./just-example
```{{exec}}

Create a `justfile` in the project directory

```bash
cat << 'EOF' > justfile
# This is a comment
hello:
    echo "Hello, World!"
EOF
```{{exec}}

### Running the first command

Now we can run the `hello` command

> 💡 by default `just` will run first recipe in the `justfile` if we don't
> specify one

```bash
just
```{{exec}}

