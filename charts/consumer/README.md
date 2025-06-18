# consumer

Lava helm chart for the consumer service

![Version: 1.1.2](https://img.shields.io/badge/Version-1.1.2-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v2.5.0](https://img.shields.io/badge/AppVersion-v2.5.0-informational?style=flat-square)

## Lavanet Consumer Helm Chart

## Prerequisites

Before deploying the consumer chart you'll need to do few imporatnt things:

* Create wallet and export it, or export an existing one

### Create wallet

In order to create a new wallet, make sure you have [lavap](https://github.com/lavanet/lava/releases/latest) CLI installed and run:

```shell
lavap keys add my-key
```

After that export the key by running:

```shell
lavap keys export my-key
```

Enter a password for the exported key, it's important that you note it for the next steps.

### Apply wallet secrets to kubernetes

Encode both exported key and your password on base64:

```shell
base64 -w 0 <<EOF
-----BEGIN TENDERMINT PRIVATE KEY-----
kdf: bcrypt
salt: 5A21556CF5842BDEF9B9949418B0E0B8
type: secp256k1

******ngpVQsF7xr3jBFtNXUhQN4Q0pwDvRk8jQ1ubTyE/j8vg9q811iqb7gD
P7ZmrGWPZLrTvh******/InhEHq1vlLIEc9fk8=
=aGWZ
-----END TENDERMINT PRIVATE KEY-----
EOF
```

```shell
echo "12345678" | base64
```

Add two new secrets to your namespace containing the encoded exported key and the passphrase:

```shell
cat > exported-key.yaml << EOF
apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: wallet
data:
  key: >-
    LS0tLS1CRUdJTiBURU5ERVJNSU5UIFBSSVZBVEUgS0VZLS0tLS0Ka2RmOiBiY3J5cHQKc2FsdDogNUEyMTU1NkNGNTg0MkJERUY5Qjk5NDk0MThCMEUwQjgKdHlwZTogc2VjcDI1NmsxCgoqKioqKipuZ3BWUXNGN3hyM2pCRnROWFVoUU40UTBwd0R2Ums4alExdWJUeUUvajh2ZzlxODExaXFiN2dEClA3Wm1yR1dQWkxyVHZoKioqKioqL0luaEVIcTF2bExJRWM5Zms4PQo9YUdXWgotLS0tLUVORCBURU5ERVJNSU5UIFBSSVZBVEUgS0VZLS0tLS0K
  password: MTIzNDU2NzgK
EOF

kubectl apply -f exported-key.yaml -n lava-system
```

### Modify values file

The final step is to refrence the newly created secrets in the chart's values file:

```yaml
# values.yaml

key:
  secretName: "wallet"
  secretKey: "key"
  passwordSecretName: "wallet"
  passwordSecretKey: "password"
```

## Installing the Chart

To install the chart with the release name `my-consumer`:

```shell
helm repo add lavanet https://lavanet.github.io/helm-charts
helm repo update
helm install my-consumer lavanet/consumer -n lava-system --create-namespace
```

## Requirements

Kubernetes: `>=1.25.0-0`

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| additionalArgs | list | `[]` | Lavap consumer additional CLI arguments |
| affinity | object | `{}` | Assign custom [affinity] rules to the deployment |
| autoscaling.behavior | object | `{}` | Configures the scaling behavior of the target in both Up and Down directions. |
| autoscaling.enabled | bool | `false` | Enable Horizontal Pod Autoscaler ([HPA]) for the Consumer |
| autoscaling.maxReplicas | int | `5` | Maximum number of replicas for the Consumer [HPA] |
| autoscaling.minReplicas | int | `1` | Minimum number of replicas for the Consumer [HPA] |
| autoscaling.targetCPUUtilizationPercentage | int | `50` | Average CPU utilization percentage for the Consumer [HPA] |
| autoscaling.targetMemoryUtilizationPercentage | int | `50` | Average memory utilization percentage for the Consumer [HPA] |
| cache.address | string | `"cache:20100"` | Cache address |
| cache.enabled | bool | `true` | Should add cache arg |
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
| chainId | string | `"lava-testnet-2"` | Lava chain id |
| disableConflictTransactions | bool | `true` | Should disable conflict transactions |
| fullnameOverride | string | `""` | String to fully override `"consumer.fullname"` |
| geolocation | int | `2` | Provider geo-location can be one of the [geolocations](https://docs.lavanet.xyz/provider-setup#geolocations) |
| global.domain | string | `"my-consumer.local"` | Default domain used by all components # Used for ingresses, certificates, etc. |
| image.pullPolicy | string | `"IfNotPresent"` | Image pull policy for the consumer |
| image.repository | string | `"ghcr.io/lavanet/lava/lavap"` | Repository to use for the consumer |
| image.tag | string | `""` (defaults to Chart.appVersion) | Tag to use for the consumer |
| imagePullSecrets | list | `[]` | Secrets with credentials to pull images from a private registry |
| ingress.annotations | object | `{}` | Additional ingress annotations |
| ingress.className | string | `"nginx"` | Defines which ingress controller will implement the resource |
| ingress.enabled | bool | `false` | Enable an ingress resource for the consumers |
| ingress.path | string | `"/"` | The path to Consumer |
| ingress.pathType | string | `"Prefix"` | Ingress path type. One of `Exact`, `Prefix` or `ImplementationSpecific` |
| ingress.tls | bool | `true` | Enable TLS configuration for the domain defined at `global.domain` # TLS certificate will be retrieved from a TLS secret with name: `consumer-tls` |
| ingress.tlsSecretName | string | `nil` | Custom Ingress TLS secret |
| ingressGrpc.annotations | object | `{}` | Additional ingress annotations |
| ingressGrpc.className | string | `"nginx"` | Defines which ingress controller will implement the resource |
| ingressGrpc.enabled | bool | `false` | Enable a grpc ingress resource for the consumers |
| ingressGrpc.path | string | `"/"` | The path to Consumer |
| ingressGrpc.pathType | string | `"Prefix"` | Ingress path type. One of `Exact`, `Prefix` or `ImplementationSpecific` |
| ingressGrpc.tls | bool | `true` | Enable TLS configuration for the domain defined at `global.domain` # TLS certificate will be retrieved from a TLS secret with name: `consumer-grpc-tls` |
| ingressGrpc.tlsSecretName | string | `nil` | Custom GRPC Ingress TLS secret |
| key.passwordSecretKey | string | `"password"` | The key in the kubernetes secret that contains the password for the private key |
| key.passwordSecretName | string | `"wallet"` | The kubernetes secret that contains the password for the private key |
| key.secretKey | string | `"key"` | The key in the kubernetes secret to use |
| key.secretName | string | `"wallet"` | The kubernetes secret name containing the private key |
| keyringBackend | string | `"test"` | Consumer keyring backend |
| livenessProbe.failureThreshold | int | `3` | Minimum consecutive failures for the [probe] to be considered failed after having succeeded |
| livenessProbe.initialDelaySeconds | int | `10` | Number of seconds after the container has started before [probe] is initiated |
| livenessProbe.periodSeconds | int | `10` | How often (in seconds) to perform the [probe] |
| livenessProbe.successThreshold | int | `1` | Minimum consecutive successes for the [probe] to be considered successful after having failed |
| livenessProbe.timeoutSeconds | int | `1` | Number of seconds after which the [probe] times out |
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
| readinessProbe.failureThreshold | int | `3` | Minimum consecutive failures for the [probe] to be considered failed after having succeeded |
| readinessProbe.initialDelaySeconds | int | `10` | Number of seconds after the container has started before [probe] is initiated |
| readinessProbe.periodSeconds | int | `10` | How often (in seconds) to perform the [probe] |
| readinessProbe.successThreshold | int | `1` | Minimum consecutive successes for the [probe] to be considered successful after having failed |
| readinessProbe.timeoutSeconds | int | `1` | Number of seconds after which the [probe] times out |
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
