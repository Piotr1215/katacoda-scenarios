## Creating a Sample Spin Application

1. **Prerequisites**:
   - ✅Ensure Rust and Cargo installed.

1. **Install Spin Template for Rust**:
   ```sh
   spin templates install --git https://github.com/fermyon/spin --update
   ```{{exec}}

> We need to add `wasm32-wasi` compilation target

   ```bash
   source ~/.bashrc && rustup target add wasm32-wasi
   ```{{exec}}

1. **Create a New Spin Application**:
   ```sh
   spin new -t http-rust hello-rust --accept-defaults && tree hello-rust
   ```{{exec}}
   This command creates a new Spin application using the template.

1. **Build the Application**
   ```sh
   cd hello-rust
   spin build
   ```{{exec}}
   This command compiles the application code and generates the WebAssembly binary.

> 💤 Cargo build can take some time

1. **Configure the Application**:
   We can modify the `spin.toml` file to configure your application routes and settings.

   ```sh
   ccat spin.toml
   ```{{exec}}

---

## Running the Sample Spin Application

Let's start tmux first so we can run the application in the background.

1. **Start tmux**:
   ```sh
   start_tmux
   ```{{exec}}

1. **Run the Application**:
   ```sh
   send_command 1 "spin up"
   ```{{exec}}
   This command starts your Spin application.

1. **Testing**:
   We can now curl the application to see the response.
   ```sh
   send_command 0 "curl http://127.0.0.1:3000"
   ```{{exec}}

For more details, visit the [Spin Quickstart Guide](https://developer.fermyon.com/spin/v2/quickstart).
