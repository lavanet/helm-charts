# Kubernetes Cluster Setup Guide

This tutorial provides an overview of how to create a Kubernetes cluster, prioritizing local installation options and also outlining managed cloud services (paid). This guide assumes you're running commands from a local computer or standalone Ubuntu server.

## 1. Local Kubernetes Installation (Free)

You can install Kubernetes locally for testing and learning.

### Minikube

Minikube sets up a single-node Kubernetes cluster on your local machine.

**Prerequisites:**

- Docker installed or virtualization tool (KVM, VirtualBox, Hyper-V)

**Installation:**

```bash
# Download Minikube binary
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

# Start Minikube
minikube start
```

### Kubernetes CLI (kubectl)

`kubectl` is the command-line tool for Kubernetes clusters.

**Installation:**

```bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
```

### Verify Installation

```bash
kubectl get nodes
```

### Configure Access to Kubernetes (kubeconfig)

Minikube automatically updates your kubeconfig file, but if needed, you can manually set the context:

```bash
minikube kubectl -- get pods
minikube update-context
```

---

## 2. Managed Kubernetes Services (Paid)

Managed Kubernetes services simplify setup, scalability, and management.

### Amazon Elastic Kubernetes Service (EKS)

EKS is AWS's managed Kubernetes service.

**Prerequisites:**
- AWS Account
- AWS CLI configured (`aws configure`)

**Quick Start:**

```bash
# Install eksctl CLI
curl -sLO "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz"
tar -xzf eksctl_$(uname -s)_amd64.tar.gz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin

# Create EKS Cluster
eksctl create cluster --name my-cluster --region us-east-1

# Configure kubeconfig for EKS
aws eks update-kubeconfig --region us-east-1 --name my-cluster
```

[More information on EKS](https://aws.amazon.com/eks/)

### Google Kubernetes Engine (GKE)

GKE is Google's managed Kubernetes service.

**Prerequisites:**
- Google Cloud account
- `gcloud` CLI tool

**Quick Start:**

```bash
# Install and initialize gcloud CLI
curl https://sdk.cloud.google.com | bash
exec -l $SHELL
gcloud init

# Create GKE Cluster
gcloud container clusters create my-cluster --zone us-central1-a

# Configure kubeconfig for GKE
gcloud container clusters get-credentials my-cluster --zone us-central1-a
```

[More information on GKE](https://cloud.google.com/kubernetes-engine)

---

## Additional Resources

- [Kubernetes Official Documentation](https://kubernetes.io/docs/home/)
- [Minikube Documentation](https://minikube.sigs.k8s.io/docs/)
