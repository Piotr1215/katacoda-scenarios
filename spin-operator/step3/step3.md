## Creating a Sample Spin Application

1. **Initialize a New Spin Application**:
   ```sh
   spin new http my-spin-app
   ```{{exec}}
   This command sets up a new Spin application template in the `my-spin-app` directory.

2. **Build the Application**:
   ```sh
   cd my-spin-app
   spin build
   ```{{exec}}

3. **Configure the Application**:
   Modify the `spin.toml` file to configure your application routes and settings.

4. **Add Your Code**:
   Implement your application logic in the designated source files (e.g., `src/lib.rs` for Rust).

---

## Running the Sample Spin Application

### Step-by-Step Guide

1. **Run the Application**:
   ```sh
   spin up
   ```{{exec}}
   This command starts your Spin application.

2. **Access Your Application**:
   Open your browser and navigate to the address provided in the terminal (e.g., `http://localhost:3000`).

3. **Testing**:
   Interact with your application through the browser or use tools like `curl` to send requests.

### Benefits
- **Quick Setup**: Get started with a sample application in minutes.
- **Easy Testing**: Run locally to test and iterate on your application.

For more details, visit the [Spin Quickstart Guide](https://developer.fermyon.com/spin/v2/quickstart).
