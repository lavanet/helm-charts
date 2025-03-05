# 1-click-deployment

This repository contains Helm charts for deploying components to Kubernetes clusters. These charts allow you to quickly deploy and manage components.

## Managed

Create an account and deploy your consumer/provider with a few clicks in [managed.lavanet.xyz](https://managed.lavanet.xyz)

## Self-hosted

### Prerequisites

- **Kubernetes:** v1.18 or later
- **Helm:** v3.2 or later

### Adding the Repository

Add the 1-click-deployment Helm charts repository to your Helm client:

```bash
helm repo add 1-click-deployment https://lavanet.github.io/helm-charts
helm repo update
```

### Available Charts

The repository currently includes the following charts (subject to updates):

- **lavanet-consumer:** Deploy a lava consumer.
- **lavanet-provider:** Deploy a lava provider.

### Installing a Chart

For example, to install the `lavanet-consumer` chart:

```bash
helm install my-lavanet-consumer lavanet/lavanet-consumer --namespace lava --create-namespace
```

This command deploys a lava consumer with default settings. To customize the deployment, override the default values using your own `values.yaml` file or the `--set` flag.

### Customizing the Deployment

You can override configuration parameters by either:
- Using a custom `values.yaml` file:

  ```bash
  helm install my-lavanet-consumer lavanet/lavanet-consumer --namespace lava --create-namespace --values custom-values.yaml
  ```

- Or setting parameters directly on the command line:

  ```bash
  helm install my-lavanet-consumer lavanet/lavanet-consumer --namespace lava --create-namespace --set replicaCount=3,image.tag=v1.2.3
  ```

### Common Parameters

- **replicaCount:** Number of pod replicas.
- **image.repository:** The container image repository.
- **image.tag:** The image tag to deploy.
- **service.type:** Kubernetes service type (e.g., `ClusterIP`, `NodePort`, `LoadBalancer`).
- **resources:** CPU and memory requests/limits.

Refer to the chart's documentation within the `/charts` directory for a full list of configurable parameters.

### Upgrading a Release

To upgrade your deployed release with new configuration or chart updates:

```bash
helm upgrade my-lavanet-node lavanet/lavanet-node --namespace lavanet --values custom-values.yaml
```

### Uninstalling a Chart

Remove a deployed release with:

```bash
helm uninstall my-lavanet-node --namespace lavanet
```

### Troubleshooting

- **Cluster Access:** Ensure your Kubernetes cluster is running and reachable.
- **Helm Version:** Verify your Helm version with `helm version`.
- **Pod Logs:** Check pod logs using `kubectl logs <pod-name>`.
- **Issues:** For further assistance, please open an issue on the [GitHub repository](https://github.com/lavanet/helm-charts/issues).
