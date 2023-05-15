# AppDynamics Agent for Kubernetes using Kind

This repository provides a script to install and configure the AppDynamics agent for Kubernetes using Kind (Kubernetes in Docker). The agent enables monitoring and performance management of your Kubernetes applications with AppDynamics.

## Prerequisites

Before proceeding with the installation, make sure you have the following prerequisites:

- Docker installed on your machine
- Kind (Kubernetes in Docker) installed on your machine
- An active AppDynamics account and access to the controller

## Installation

To install the AppDynamics agent, follow the steps below:

1. Clone this repository to your local machine.

   ```shell
   git clone https://github.com/Abhimanyu9988/kind_kubernetes.git
Navigate to the repository directory.


```cd kind_kubernetes ```

Edit the values.yaml file to configure the agent settings. Set the following parameters in the controllerInfo section:

url: The URL of your AppDynamics controller.
account: Your AppDynamics account name.
Save the changes to the values.yaml file.

2. Run the install-kind.sh script.

  ```./install-kind.sh ```
This script will download all the necessary files and install the AppDynamics agent using Kind.

After the installation completes, you can verify the deployment by accessing the AppDynamics controller and checking for the registered Kubernetes application.

Configuration
Additional configuration options and advanced settings can be found in the values.yaml file. Modify these settings according to your requirements.

Contributing
Contributions are welcome! If you find any issues or have suggestions for improvements, please open an issue or submit a pull request.

