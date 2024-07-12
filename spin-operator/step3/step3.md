## Creating a Sample Spin App

### Install Spin Template for Rust

> ✅We have already installed Rust toolchain and Cargo.

   ```sh
   spin templates install --git https://github.com/fermyon/spin --update
   ```{{exec}}

> We need to add `wasm32-wasi` compilation target

   ```sh
   source ~/.bashrc && rustup target add wasm32-wasi
   ```{{exec}}

### Create a New Spin App

   ```sh
   spin new -t http-rust hello-rust --accept-defaults && tree hello-rust
   ```{{exec}}
   This command creates a new Spin application using the template.

### Build the App

   ```sh
   cd hello-rust
   spin build
   ```{{exec}}
   This command compiles the application code and generates the WebAssembly binary.

> 💤 Cargo build can take some time

### Configure the App

   We can modify the `spin.toml` file to configure your application routes and settings.

   ```sh
   ccat spin.toml
   ```{{exec}}

## Running the Sample Spin App

Let's start tmux first so we can run the application in the background.

### Start tmux

   ```sh
   start_tmux
   ```{{exec}}

### Run the App

   ```sh
   send_command 1 "spin up"
   ```{{exec}}
   This command starts your Spin application.

### Testing

   We can now curl the application to see the response.
   ```sh
   send_command 0 "curl http://127.0.0.1:3000"
   ```{{exec}}

For more details, visit the [Spin Quickstart Guide](https://developer.fermyon.com/spin/v2/quickstart).
