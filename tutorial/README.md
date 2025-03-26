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

- A running **Kubernetes** cluster. Check steps [here](https://github.com/lavanet/helm-charts/blob/main/tutorial/How-to-run-Kubernetes.md)

### 📦 Automated Deployment

Install and configure all the services automatically. Check the chains to run in the values folder and simply add or remove chains in the `chains` block.

MacOS:

```bash
bash run-mac.sh
```

Linux (Ubuntu):

```bash
bash run-linux.sh
```

### 📦 Manual Deployment

Test that your Kubernetes cluster is ready with the following command:

```bash
kubectl get nodes
```

You should get an output like this:

```bash
NAME                    STATUS   ROLES    AGE     VERSION
mynode1-1c1487a1-bfgp   Ready    <none>   3h42m   v1.30.8.1051000
mynode2-4c2eea16-4wtj   Ready    <none>   11h     v1.30.8.1051000
```

This means that you have connectivity to your Kubernetes cluster through kubectl.

If you are on MacOS, you can install Helm (which will install and deploy the Lava code) with this command:

```bash
brew install helm
```

If you are not in MacOS, check the Helm docs to install: https://helm.sh/docs/intro/install/#through-package-managers

Create a Lava wallet (Refer to [this](https://docs.lavanet.xyz/wallet/#cli) for more information):

```bash
lavap keys add tutorial-lava-wallet --keyring-backend test
```

You can export the private key from your wallet with this command:
```bash
lavap keys export tutorial-lava-wallet
```

It will ask you to create a password for the key that will be exported, save the password and the key, you'll use it in the upcoming command.

You can create the [Kubernetes secret](https://kubernetes.io/docs/concepts/configuration/secret/) with the following command:

```bash
kubectl create secret generic tutorial-lava-wallet --from-file=secretKey=/home/user/private.key --from-literal=passwordSecretKey="superstrong"
```
- secretKey: Wallet private key
- passwordSecretKey: Password for the private key

Add the Lava Network Helm repository and deploy your first component in just a few commands:

```bash
helm repo add lavanet https://lavanet.github.io/helm-charts
helm repo update
helm install lava-consumer-cache lavanet/cache --values values/consumer-cache.values.yml
helm install lava-consumer lavanet/consumer --values values/consumer.values.yml
helm install lava-provider-cache lavanet/cache --values values/provider-cache.values.yml
helm install lava-provider lavanet/provider --values values/provider.values.yml
```

When the chart has been successfully installed, you'll get a message like this:

<img width="1240" alt="Installed Helm Chart" src="https://github.com/user-attachments/assets/d2d5b441-1dcd-4066-84fe-b451d096ab30" />


That's it! Your Lava Network consumer is now up and running. 🎉

### Test

To test your fully deployed infrastructure, simply forward the service to your computer through the Kubernetes internal networking:

```bash
kubectl port-forward service/near-lava-consumer 2032:27017
curl -k -X POST -d  '{"jsonrpc":"2.0","method":"block","params":{"finality":"final"},"id":1}' http://localhost:27017
```

Optionally, you can expose your consumer with an Ingress or a Gateway like NGINX or Envoy.

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
helm uninstall lava-consumer
helm uninstall lava-consumer-cache
helm uninstall lava-provider
helm uninstall lava-provider-cache
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
