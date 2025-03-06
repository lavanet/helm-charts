# 1-click-deployment

This repository contains Helm charts for deploying components to Kubernetes clusters. These charts allow you to quickly deploy and manage components.

## Managed (TODO)

Create an account and quickly deploy your consumer/provider in [managed.lavanet.xyz](https://managed.lavanet.xyz)

## Self-hosted

### Prerequisites

- **Kubernetes:** v1.32 or later
- **Helm:** v3.17 or later

### Deploying a chart

Add the 1-click-deployment Helm charts repository to your Kubernetes cluster:

```bash
    helm repo add lavanet https://lavanet.github.io/helm-charts
    helm repo update
    helm install lava-consumer lavanet/lavanet-consumer --values example.values.yaml
```

### Available Charts

| Name | Description |
| --- | --- |
| [cache](../charts/cache/) | A high-performance, in-memory caching system |
| [provider](../charts/provider/) | Service provider component for the Lava Network |
| [consumer](../charts/consumer/) | Client component for consuming services on the Lava Network |


### Uninstalling a Chart

Remove a deployed release with:

```bash
helm uninstall lava-consumer --namespace lava
helm uninstall lava-provider --namespace lava
```
