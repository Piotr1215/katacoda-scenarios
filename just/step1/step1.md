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

