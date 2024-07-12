## Creating a Sample Spin Application

1. **Install Spin Template for Rust**:
   ```sh
   spin templates install --git https://github.com/fermyon/spin --update
   ```{{exec}}

> We need to add `wasm32-wasi` compilation target

```bash
rustup target add wasm32-wasi
```{{exec}}

1. **Create a New Spin Application**:
   ```sh
   spin new -t http-rust hello-rust --accept-defaults
   ```{{exec}}
   This command creates a new Spin application using the template.

1. **Build the Application**
   ```sh
   cd hello-rust
   spin build
   ```{{exec}}

1. **Build the Application**
   ```sh
   spin build
   ```{{exec}}
   This command compiles the application code and generates the WebAssembly binary.

1. **Configure the Application**:
   We can modify the `spin.toml` file to configure your application routes and settings.

   ```sh
   cat spin.toml
   ```{{exec}}

---

## Running the Sample Spin Application

1. **Run the Application**:
   ```sh
   spin up
   ```{{exec}}
   This command starts your Spin application.

1. **Access Your Application**:
   Open your browser and navigate to the address provided in the terminal [Running Application]({{TRAFFIC_HOST1_3000}}) 

1. **Testing**:
   We can also curl the application to see the response.
   ```sh
   curl {{TRAFFIC_HOST1_3000}}
   ```{{exec}}

For more details, visit the [Spin Quickstart Guide](https://developer.fermyon.com/spin/v2/quickstart).
