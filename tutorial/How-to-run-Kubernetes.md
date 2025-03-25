# 🚀 Kubernetes Cluster Setup Guide 🐳

Welcome to the ultimate guide on creating your Kubernetes cluster! This guide prioritizes local installation but also includes options for managed cloud services. Follow along if you're running commands from your local computer 💻 or a standalone Ubuntu server 🖥️.

---

## 📍 Local Kubernetes Installation (Free)

Perfect for learning, testing, or small projects! 🌟

### 🐋 Minikube

Minikube quickly spins up a single-node Kubernetes cluster on your machine.

**Prerequisites:**

- ✅ Docker installed

**Installation:**

🍎 **MacOS:**
```bash
brew install minikube
```

🐧 **Linux:**

```bash
# Download Minikube binary
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
```

▶️ **Start Minikube:**

```bash
minikube start
```

🔗 Check additional architectures [here](https://minikube.sigs.k8s.io/docs/start).

### 📟 Kubernetes CLI (kubectl)

`kubectl` lets you interact seamlessly with your Kubernetes cluster.

**Installation:**

🍎 **MacOS:**

```bash
brew install kubectl
```

🐧 **Linux:**

```bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
```

✅ **Verify Installation:**

```bash
kubectl get nodes
```

🔗 [Check installation steps for other architectures](https://kubernetes.io/docs/tasks/tools/)

### 🔑 Configure kubeconfig

Minikube usually updates kubeconfig automatically, but you can manually update:

```bash
minikube kubectl -- get pods
minikube update-context
```

---

## 🌩️ Managed Kubernetes Services (Paid)

Simplify Kubernetes at scale! 📈

### ☁️ Amazon Elastic Kubernetes Service (EKS)

Fully managed Kubernetes by AWS.

**Prerequisites:**
- 🔑 AWS Account
- 🔧 AWS CLI (`aws configure`)

**Quick Start:**

```bash
# Install eksctl CLI
curl -sLO "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz"
tar -xzf eksctl_$(uname -s)_amd64.tar.gz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin

# Create EKS Cluster 🚀
eksctl create cluster --name my-cluster --region us-east-1

# Configure kubeconfig
aws eks update-kubeconfig --region us-east-1 --name my-cluster
```

🔗 [More information on EKS](https://aws.amazon.com/eks/)

### 🌐 Google Kubernetes Engine (GKE)

Google's hassle-free managed Kubernetes.

**Prerequisites:**
- 🔑 Google Cloud account
- 🔧 `gcloud` CLI

**Quick Start:**

```bash
# Install and initialize gcloud CLI
curl https://sdk.cloud.google.com | bash
exec -l $SHELL
gcloud init

# Create GKE Cluster 🚀
gcloud container clusters create my-cluster --zone us-central1-a

# Configure kubeconfig
gcloud container clusters get-credentials my-cluster --zone us-central1-a
```

🔗 [More information on GKE](https://cloud.google.com/kubernetes-engine)

---

## 📚 Additional Resources

- 📖 [Kubernetes Official Docs](https://kubernetes.io/docs/home/)
- 📖 [Minikube Docs](https://minikube.sigs.k8s.io/docs/)

Happy Kubernetes-ing! 🎉🐙
