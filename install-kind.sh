###Creating a new directory
echo "Creating a new directory"
mkdir $HOME/appdynamics-agent
cd $HOME/appdynamics-agent

#Check your macOS architecture
echo "Let's check your macOS architecture"
mac_arch=$(uname -m)
if [[ $mac_arch == "x86_64" ]]; then
  echo "macOS architecture: amd64"
elif [[ $mac_arch == "arm64" ]]; then
  echo "macOS architecture: arm64"
else
  echo "Unknown macOS architecture: $mac_arch"
  exit 1
fi

echo "Your macOS architecture is $mac_arch"
sleep 1


#Check if Docker is installed or not
echo "Let's check if Docker is installed"
if command -v docker &>/dev/null; then
  echo "Docker is already installed. Skipping Docker installation."
else
  # Install Docker
  if [[ $mac_arch == "arm64" ]]; then
    docker_pkg_url="https://desktop.docker.com/mac/main/arm64/Docker.dmg?utm_source=docker&utm_medium=webreferral&utm_campaign=docs-driven-download-mac-arm64"
  else
    docker_pkg_url="https://desktop.docker.com/mac/main/amd64/Docker.dmg?utm_source=docker&utm_medium=webreferral&utm_campaign=docs-driven-download-mac-amd64"
  fi

  curl -O "$docker_pkg_url"
  echo "Installing Docker"
  sleep 60
  echo "Docker Installed, Extracting the image"
  hdiutil attach Docker.dmg
  /Volumes/Docker/Docker.app/Contents/MacOS/install
  hdiutil detach /Volumes/Docker
fi
echo "Starting Docker"
open --background -a Docker
sleep 5
echo "Docker is running"


echo "###Now let's install kind###"
if command -v kind &>/dev/null; then
  echo "###Kind is already installed. Skipping Kind installation.###"
else
  # Install Kind
  brew install kind
fi
echo "### Congratulations Kind is installed####"


#Install dependancies
brew install wget


#Create a cluster using kind
echo "Let's create a cluster using kind"
kind create cluster --name appdynamics
echo "###Congratulations your cluster is created###"
sleep 5


echo "###Let's switch your Kubernetes context to kind-appdynamics###"
kubectl config use-context kind-appdynamics
echo "You can check all availaible kubernetes context using kubectl config get-contexts"
sleep 5


####Install Metric server
if [[ ! -f metric-server.yaml ]]; then
wget https://raw.githubusercontent.com/Abhimanyu9988/kind-kubernetes/main/metric-server.yaml
kubectl apply -f metric-server.yaml
fi


#Check if the user wants to install a Java application
read -p "Do you wish to install a Java application? (y/n): " install_java

if [[ $install_java == "y" ]]; then
  # Download the Java application file
  kubectl create namespace java-apps
  sleep 5
  echo "Downloading the Java application file"
  if [[ ! -f tomcatapp.yaml ]]; then
  echo "Downloading the Java application file"
  wget https://raw.githubusercontent.com/Abhimanyu9988/kind-kubernetes/main/tomcatapp.yaml
  echo "File is downloaded."
  fi
  # Apply the configuration using kubectl
  kubectl create -f tomcatapp.yaml
  echo "Java application is installed."
fi


# Check if the user wants to install a Node.js application
#Install Node.js application
read -p "Do you wish to install a Node.js application? (y/n): " install_nodejs
if [[ $install_nodejs == "y" ]]; then
  # Download the Node.js application file
  kubectl create namespace nodejs-apps
  sleep 5
  echo "Downloading the Node.js application file"
  if [[ ! -f mynodeapp.yaml ]]; then
  echo "Downloading the Node.js application file"
  wget https://raw.githubusercontent.com/Abhimanyu9988/kind-kubernetes/main/mynodeapp.yaml
  echo "File is downloaded."
  fi
  # Apply the configuration using kubectl
  kubectl create -f mynodeapp.yaml
  echo "Node.js application is installed."
fi


# Check if the user wants to install AppDynamics Kubernetes Agent
read -p "Do you want to install AppDynamics Kubernetes cluster agent? (y/n): " install_operator

if [[ $install_operator == "y" ]]; then
  #access_key_value=""
  #while [[ -z "$access_key_value" ]]; do
  kubectl create namespace appdynamics
  read -p "Enter the value for APPDYNAMICS_AGENT_ACCOUNT_ACCESS_KEY: " access_key_value
  kubectl -n appdynamics create secret generic cluster-agent-secret --from-literal=controller-key="$access_key_value"
  # Add the helm repo
  helm repo add appdynamics-charts https://ciscodevnet.github.io/appdynamics-charts
  
  if [[ ! -f values.yaml ]]; then
  wget https://raw.githubusercontent.com/Abhimanyu9988/kind-kubernetes/main/values.yaml
  fi

  read -p "Enter the cluster agent name: " appname
  helm install -f values.yaml "$appname" appdynamics-charts/cluster-agent --namespace=appdynamics
  echo "File is downloaded and installed."
  echo "Check your cluster on controllerces with the name "$appname""
  sleep 2
fi

echo "You can find all configuration files at $HOME/appdynamics-agent"