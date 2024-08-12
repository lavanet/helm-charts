# consumer

Lava helm chart for the consumer service

![Version: 0.3.8](https://img.shields.io/badge/Version-0.3.8-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v2.2.6](https://img.shields.io/badge/AppVersion-v2.2.6-informational?style=flat-square)

## Lavanet Consumer Helm Chart

## Installing the Chart

To install the chart with the release name `my-consumer`:

```shell
helm repo add lavanet https://lavanet.github.io/helm-charts
helm repo update
helm install my-consumer lavanet/consumer
```

## Requirements

Kubernetes: `>=1.25.0-0`

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Assign custom [affinity] rules to the deployment |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| cache.address | string | `"cache:20100"` | Cache address |
| cache.enabled | bool | `true` | Should add cache arg |
| chainId | string | `"lava-testnet-2"` | Lava chain id |
| disableConflictTransactions | bool | `true` | Should disable conflict transactions |
| fullnameOverride | string | `""` | String to fully override `"consumer.fullname"` |
| geolocation | int | `2` | Provider geo-location can be one of the [geolocations](https://docs.lavanet.xyz/provider-setup#geolocations) |
| image.pullPolicy | string | `"IfNotPresent"` | Image pull policy for the consumer |
| image.repository | string | `"ghcr.io/lavanet/lava/lavap"` | Repository to use for the consumer |
| image.tag | string | `""` (defaults to Chart.appVersion) | Tag to use for the consumer |
| imagePullSecrets | list | `[]` | Secrets with credentials to pull images from a private registry |
| ingress.annotations | object | `{}` | Additional ingress annotations |
| ingress.className | string | `""` | Defines which ingress controller will implement the resource |
| ingress.domain | string | `"my-consumer.local"` | Consumer host |
| ingress.enabled | bool | `true` | Enable an ingress resource for the consumers |
| ingress.tls | list | `[]` | Enable TLS configuration for the hostname |
| key.passwordSecretKey | string | `"password"` | The key in the kubernetes secret that contains the password for the private key |
| key.passwordSecretName | string | `"wallet"` | The kubernetes secret that contains the password for the private key |
| key.secretKey | string | `"key"` | The key in the kubernetes secret to use |
| key.secretName | string | `"wallet"` | The kubernetes secret name containing the private key |
| keyringBackend | string | `"test"` | Consumer keyring backend |
| log.format | string | `"json"` | Consumer pod log format, can be json or text |
| log.level | string | `"info"` | Consumer pod log level |
| metrics.enabled | bool | `true` | Should enable prometheus metrics |
| metrics.port | int | `9000` | Prometheus metrics address |
| metrics.serviceMonitor.additionalLabels | object | `{}` | Prometheus ServiceMonitor labels |
| metrics.serviceMonitor.annotations | object | `{}` | Prometheus ServiceMonitor annotations |
| metrics.serviceMonitor.enabled | bool | `false` | Enable a prometheus ServiceMonitor |
| metrics.serviceMonitor.interval | string | `"30s"` | Prometheus ServiceMonitor interval |
| metrics.serviceMonitor.metricRelabelings | list | `[]` | Prometheus [MetricRelabelConfigs] to apply to samples before ingestion |
| metrics.serviceMonitor.namespace | string | `""` | Prometheus ServiceMonitor namespace |
| metrics.serviceMonitor.relabelings | list | `[]` | Prometheus [RelabelConfigs] to apply to samples before scraping |
| metrics.serviceMonitor.scheme | string | `""` | Prometheus ServiceMonitor scheme |
| metrics.serviceMonitor.selector | object | `{}` | Prometheus ServiceMonitor selector |
| metrics.serviceMonitor.tlsConfig | object | `{}` | Prometheus ServiceMonitor tlsConfig |
| nameOverride | string | `""` | Consumer a name in place of release name |
| node | string | `"https://testnet2-rpc.lavapro.xyz:443"` | Lava node to connect to |
| nodeSelector | object | `{}` | [Node selector] |
| persistence.accessModes[0] | string | `"ReadWriteOnce"` |  |
| persistence.enabled | bool | `true` | Should create pvc for the consumer data |
| persistence.size | string | `"100Mi"` |  |
| podAnnotations | object | `{}` | Annotations for the all deployed pods |
| podSecurityContext | object | `{}` |  |
| relayServerAddress | string | `nil` | Address of the relay server |
| replicaCount | int | `1` | The number of consumer pods to run. |
| reportsBeAddress | string | `nil` | Address of the report server |
| resources | object | `{}` | Resource limits and requests for the consumers pods |
| securityContext | object | `{}` |  |
| service.type | string | `"ClusterIP"` | Consumer pods service type |
| serviceAccount.annotations | object | `{}` | annotations to add to the service account |
| serviceAccount.create | bool | `true` | specifies whether a service account should be created |
| serviceAccount.name | string | `""` | the name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| tolerations | list | `[]` | [Tolerations] for use with node taints |
| wallet | string | `"test"` | Wallet name |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
