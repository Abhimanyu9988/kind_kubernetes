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

shell
Copy code
cd kind_kubernetes
Edit the values.yaml file to configure the agent settings. Set the following parameters in the controllerInfo section:

url: The URL of your AppDynamics controller.
account: Your AppDynamics account name.
Save the changes to the values.yaml file.

Run the install-kind.sh script.

  ```shell
  ./install-kind.sh 


