## Creating a Sample Spin Application

1. **Install Spin Template for Python**:
   ```sh
   spin templates install --git https://github.com/fermyon/spin-python-sdk --update
   ```{{exec}}

1. **Create a New Spin Application**:
   ```sh
   spin new -t http-py hello-python --accept-defaults
   ```{{exec}}
   This command creates a new Spin application using the template.

1. **Prepare Python Virtual Environment**:
   ```sh
   cd hello-python
   python3 -m venv venv-dir
   source venv-dir/bin/activate
   pip3 install -r requirements.txt
   ```{{exec}}

1. **Configure the Application**:
   We can modify the `spin.toml` file to configure your application routes and settings.
   ```sh
   cat spin.toml
   ```{{exec}}

1. **Build the Application**
   ```sh
   spin build
   ```{{exec}}
   This command compiles the application code and generates the WebAssembly binary.

---

## Running the Sample Spin Application

### Step-by-Step Guide

1. **Run the Application**:
   ```sh
   spin up
   ```{{exec}}
   This command starts your Spin application.

2. **Access Your Application**:
   Open your browser and navigate to the address provided in the terminal [Running Application]({{TRAFFIC_HOST1_3000}}) 

3. **Testing**:
   Interact with your application through the browser or use tools like `curl` to send requests.

For more details, visit the [Spin Quickstart Guide](https://developer.fermyon.com/spin/v2/quickstart).
