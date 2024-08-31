# cache

Lava helm chart for the cache service

![Version: 0.5.5](https://img.shields.io/badge/Version-0.5.5-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v2.5.0](https://img.shields.io/badge/AppVersion-v2.5.0-informational?style=flat-square)

## Lavanet Cache Helm Chart

This Helm chart provides a simple way to deploy and manage Lava cache instances on Kubernetes clusters.
Lava cache is an in-memory caching system designed for high performance and scalability.

## Installing the Chart

To install the chart with the release name `my-cache`:

```shell
helm repo add lavanet https://lavanet.github.io/helm-charts
helm repo update
helm install my-cache lavanet/cache -n lava-system --create-namespace
```

## Requirements

Kubernetes: `>=1.25.0-0`

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| additionalArgs | list | `[]` | Lavap cache additional CLI arguments |
| affinity | object | `{}` | Assign custom [affinity] rules to the deployment |
| autoscaling.behavior | object | `{}` | Configures the scaling behavior of the target in both Up and Down directions. |
| autoscaling.enabled | bool | `false` | Enable Horizontal Pod Autoscaler ([HPA]) for the Cache |
| autoscaling.maxReplicas | int | `5` | Maximum number of replicas for the Cache [HPA] |
| autoscaling.minReplicas | int | `1` | Minimum number of replicas for the Cache [HPA] |
| autoscaling.targetCPUUtilizationPercentage | int | `50` | Average CPU utilization percentage for the Cache [HPA] |
| autoscaling.targetMemoryUtilizationPercentage | int | `50` | Average memory utilization percentage for the Cache [HPA] |
| certificate.additionalHosts | list | `[]` | Certificate Subject Alternate Names (SANs) |
| certificate.annotations | object | `{}` | Annotations to be applied to the Server Certificate |
| certificate.domain | string | `""` (defaults to global.domain) | Certificate primary domain (commonName) |
| certificate.duration | string | `""` (defaults to 2160h = 90d if not specified) | The requested 'duration' (i.e. lifetime) of the certificate. # Ref: <https://cert-manager.io/docs/usage/certificate/#renewal> |
| certificate.enabled | bool | `false` | Deploy a Certificate resource (requires cert-manager) |
| certificate.issuer.group | string | `""` | Certificate issuer group. Set if using an external issuer. Eg. `cert-manager.io` |
| certificate.issuer.kind | string | `""` | Certificate issuer kind. Either `Issuer` or `ClusterIssuer` |
| certificate.issuer.name | string | `""` | Certificate issuer name. Eg. `letsencrypt` |
| certificate.privateKey.algorithm | string | `"RSA"` | Algorithm used to generate certificate private key. One of: `RSA`, `Ed25519` or `ECDSA` |
| certificate.privateKey.encoding | string | `"PKCS1"` | The private key cryptography standards (PKCS) encoding for private key. Either: `PCKS1` or `PKCS8` |
| certificate.privateKey.rotationPolicy | string | `"Never"` | Rotation policy of private key when certificate is re-issued. Either: `Never` or `Always` |
| certificate.privateKey.size | int | `2048` | Key bit size of the private key. If algorithm is set to `Ed25519`, size is ignored. |
| certificate.renewBefore | string | `""` (defaults to 360h = 15d if not specified) | How long before the expiry a certificate should be renewed. # Ref: <https://cert-manager.io/docs/usage/certificate/#renewal> |
| certificate.secretTemplateAnnotations | object | `{}` | Annotations that allow the certificate to be composed from data residing in existing Kubernetes Resources |
| certificate.usages | list | `[]` | Usages for the certificate ## Ref: <https://cert-manager.io/docs/reference/api-docs/#cert-manager.io/v1.KeyUsage> |
| expiration_multiplier | string | `nil` | The expiration multiplier for items in the cache |
| expiration_non_finalized_multiplier | string | `nil` | The expiration non finalized multiplier for items in the cache |
| fullnameOverride | string | `""` | String to fully override `"cache.fullname"` |
| global.domain | string | `"my-cache.local"` | Default domain used by all components # Used for ingresses, certificates, etc. |
| image.pullPolicy | string | `"IfNotPresent"` | Image pull policy for the cache |
| image.repository | string | `"ghcr.io/lavanet/lava/lavap"` | Repository to use for the cache |
| image.tag | string | `""` (defaults to Chart.appVersion) | Tag to use for the cache |
| imagePullSecrets | list | `[]` | Secrets with credentials to pull images from a private registry |
| ingress.annotations | object | `{}` | Additional ingress annotations |
| ingress.className | string | `"nginx"` | Defines which ingress controller will implement the resource |
| ingress.enabled | bool | `false` | Enable an ingress resource for the provider |
| ingress.hostname | string | `""` (defaults to global.domain) | Cache hostname |
| ingress.path | string | `"/"` | The path to Provider |
| ingress.pathType | string | `"Prefix"` | Ingress path type. One of `Exact`, `Prefix` or `ImplementationSpecific` |
| ingress.tls | bool | `true` | Enable TLS configuration for the domain defined at `global.domain` # TLS certificate will be retrieved from a TLS secret with name: `cache-tls` |
| livenessProbe.failureThreshold | int | `3` | Minimum consecutive failures for the [probe] to be considered failed after having succeeded |
| livenessProbe.initialDelaySeconds | int | `10` | Number of seconds after the container has started before [probe] is initiated |
| livenessProbe.periodSeconds | int | `10` | How often (in seconds) to perform the [probe] |
| livenessProbe.successThreshold | int | `1` | Minimum consecutive successes for the [probe] to be considered successful after having failed |
| livenessProbe.timeoutSeconds | int | `1` | Number of seconds after which the [probe] times out |
| log.format | string | `"json"` | Cache log format, can be json or text |
| log.level | string | `"info"` | Cache log level |
| max_items | string | `nil` | Max items allowed in the cache |
| metrics.enabled | bool | `true` | Should enable prometheus metrics |
| metrics.port | int | `20200` | Metrics service port |
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
| nameOverride | string | `""` | Provide a name in place of release name |
| nodeSelector | object | `{}` | [Node selector] |
| podAnnotations | object | `{}` | Annotations for the all deployed pods |
| podSecurityContext | object | `{}` |  |
| readinessProbe.failureThreshold | int | `3` | Minimum consecutive failures for the [probe] to be considered failed after having succeeded |
| readinessProbe.initialDelaySeconds | int | `10` | Number of seconds after the container has started before [probe] is initiated |
| readinessProbe.periodSeconds | int | `10` | How often (in seconds) to perform the [probe] |
| readinessProbe.successThreshold | int | `1` | Minimum consecutive successes for the [probe] to be considered successful after having failed |
| readinessProbe.timeoutSeconds | int | `1` | Number of seconds after which the [probe] times out |
| replicaCount | int | `1` | The number of cache pods to run. |
| resources | object | `{}` | Resource limits and requests for the cache pods |
| securityContext | object | `{}` |  |
| service.port | int | `20100` | Cache service port |
| service.type | string | `"ClusterIP"` | Cache service type |
| serviceAccount.annotations | object | `{}` | annotations to add to the service account |
| serviceAccount.create | bool | `true` | specifies whether a service account should be created |
| serviceAccount.name | string | `""` | the name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| tolerations | list | `[]` | [Tolerations] for use with node taints |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
