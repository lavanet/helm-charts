#!/bin/bash

# Check if lavap is installed
if ! command -v lavap &> /dev/null; then
    echo "lavap could not be found"
    exit 1
else
    echo "lavap is installed"
fi

# Check if if kubectl is installed
if ! command -v kubectl &> /dev/null; then
    echo "kubectl could not be found"
    exit 1
else
    echo "kubectl is installed"
fi

# Check if Kubernetes cluster is running
if ! kubectl get nodes &> /dev/null; then
    echo "Kubernetes cluster is not found"
    exit 1
else
    echo "Kubernetes cluster is running and connected"
fi

# Install Helm
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
sudo apt-get install apt-transport-https --yes
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update -y
sudo apt-get install helm -y


# Create a wallet
lavap keys add tutorial-lava-wallet --keyring-backend test

# Export wallet
echo "superstrongpassword" | lavap keys export tutorial-lava-wallet > private.key

# Create a secret
kubectl create secret generic tutorial-lava-wallet --from-file=secretKey=private.key --from-literal=passwordSecretKey="superstrongpassword"

# Remove private key
rm -f private.key

# Install Lava Chart
helm repo add lavanet https://lavanet.github.io/helm-charts
helm repo update
helm install lava-consumer-cache lavanet/cache --values values/consumer-cache.values.yml
helm install lava-consumer lavanet/consumer --values values/consumer.values.yml
helm install lava-provider-cache lavanet/cache --values values/provider-cache.values.yml
helm install lava-provider lavanet/provider --values values/provider.values.yml
