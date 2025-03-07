# 🚀 Lava Network Kubernetes Tutorial 🚀

Welcome to the **Lava Network helm chart Deployment** repository! Effortlessly deploy and manage Lava Network components on your Kubernetes clusters with our streamlined Helm charts.

---

## 🌟 Why the Lava Helm Chart?

- **Fast & Easy:** Deploy Lava Network components in seconds.
- **Reliable:** Tested and optimized Helm charts for seamless integration.
- **Flexible:** Supports both managed and self-hosted Kubernetes environments.

---

## 🌐 Managed Deployment (Coming Soon!)

Want a hassle-free experience? Soon you'll be able to deploy your Lava Network consumer/provider directly through our managed platform:

👉 [managed.lavanet.xyz](https://managed.lavanet.xyz)

Stay tuned for updates!

---

## 🛠️ Self-Hosted Deployment

Prefer managing your own infrastructure? No problem! Follow these simple steps to deploy Lava Network components on your Kubernetes cluster.

### ✅ Prerequisites

Ensure you have the following installed:

- **Kubernetes:** v1.32 or later
- **Helm:** v3.17 or later

### 📦 Quick Installation

Add the Lava Network Helm repository and deploy your first component in just a few commands:

```bash
helm repo add lavanet https://lavanet.github.io/helm-charts
helm repo update
helm install lava-consumer lavanet/lavanet-consumer --values example.values.yaml
```

That's it! Your Lava Network consumer is now up and running. 🎉

---

## 📚 Available Helm Charts

Explore our available charts to enhance your Lava Network deployment:

| Chart Name | Description | Quick Install |
|------------|-------------|---------------|
| [🚀 Consumer](../charts/consumer/) | Client component for consuming services on the Lava Network | `helm install lava-consumer lavanet/lavanet-consumer` |
| [⚙️ Provider](../charts/provider/) | Service provider component for the Lava Network | `helm install lava-provider lavanet/lavanet-provider` |
| [⚡ Cache](../charts/cache/) | High-performance, in-memory caching system | `helm install lava-cache lavanet/cache` |

---

## 🗑️ Uninstalling Components

Need to remove a deployment? Simply run:

```bash
helm uninstall lava-consumer --namespace lava
helm uninstall lava-provider --namespace lava
```

---

## 🤝 Contributing

We welcome contributions! Check out our [CONTRIBUTING.md](../CONTRIBUTING.md) to get started.

---

## 📖 Documentation & Support

- 📚 [Full Documentation](../docs/)
- 🐞 [Report Issues](https://github.com/lavanet/helm-charts/issues)
- 💬 [Community Discussions](https://github.com/lavanet/helm-charts/discussions)

---

Happy deploying! 🚀✨
