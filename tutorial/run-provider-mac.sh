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

# Enable minikube ingress
minikube addons enable ingress

# Install Helm
brew install helm

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
helm install lava-provider-cache lavanet/cache --values values/provider-cache.values.yml
helm install lava-provider lavanet/provider --values values/provider.values.yml

# Get the ingress IP
ingress_ip=$(minikube ip)

## Add to /etc/hosts
hosts=$(kubectl get ingress consumer -o jsonpath='{.spec.rules[*].host}' | tr ' ' '\n')
echo "$hosts" | while read host; do
    echo "127.0.0.1 $host"
done | sudo tee -a /etc/hosts
