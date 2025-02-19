# provider

Lava helm chart for the provider service

![Version: 1.1.1](https://img.shields.io/badge/Version-1.1.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v2.5.0](https://img.shields.io/badge/AppVersion-v2.5.0-informational?style=flat-square)

## Lavanet Provider Helm Chart

This Helm chart deploys a Lavanet provider service, which serves as a crucial component of the Lava network.

Lavanet providers are essential participants in the Lava ecosystem, responsible for:

* Servicing relay requests from consumers
* Staking on the Lava network
* Operating RPC nodes on various Relay Chains (e.g., Cosmos, Ethereum, Osmosis, Polygon)

Providers earn LAVA tokens as fees for fulfilling these requests, creating an incentive-driven decentralized infrastructure.

## Prerequisites

Before deploying the provider chart you'll need to do two imporatnt things:

* Create wallet and export it, or export an existing one
* Create configuration for the provider

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

kubectl apply -f exported-key.yaml -n my-namespace
```

### Create secert configuration for provider

Most provider configurations point to secure nodes and should remain encrypted on the cluster.
For this you'll have to create another secert containing the entire nodes' configuration, for example:

```yaml
base64 -w 0 <<EOF
metrics-listen-address: ":3200"
endpoints:
  - api-interface: rest
    chain-id: LAV1
    network-address:
      address: "0.0.0.0:2200"
      disable-tls: true
    node-urls:
      - url: "https://****/rest/"
      - url: "https://****/rest/"
        skip-verifications:
          - pruning
        addons:
          - archive
  - api-interface: tendermintrpc
    chain-id: LAV1
    network-address:
      address: "0.0.0.0:2200"
      disable-tls: true
    node-urls:
      - url: "https://****/rpc/"
      - url: "https://****/rpc/"
        skip-verifications:
          - pruning
        addons:
          - archive
  - api-interface: grpc
    chain-id: LAV1
    network-address:
      address: "0.0.0.0:2200"
      disable-tls: true
    node-urls:
      - url: "****:443"
      - url: "****:443"
        skip-verifications:
          - pruning
        addons:
          - archive
EOF
```

Like before, you need to apply the config as a secret:

```shell
cat > provider-config.yaml << EOF
apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: provider-config
data:
  config.yml: >-
    bWV0cmljcy1saXN0ZW4tYWRkcmVzczogIjozMjAwIgplbmRwb2ludHM6CiAgLSBhcGktaW50ZXJmYWNlOiByZXN0CiAgICBjaGFpbi1pZDogTEFWMQogICAgbmV0d29yay1hZGRyZXNzOgogICAgICBhZGRyZXNzOiAiMC4wLjAuMDoyMjAwIgogICAgICBkaXNhYmxlLXRsczogdHJ1ZQogICAgbm9kZS11cmxzOgogICAgICAtIHVybDogImh0dHBzOi8vKioqKi9yZXN0LyIKICAgICAgLSB1cmw6ICJodHRwczovLyoqKiovcmVzdC8iCiAgICAgICAgc2tpcC12ZXJpZmljYXRpb25zOgogICAgICAgICAgLSBwcnVuaW5nCiAgICAgICAgYWRkb25zOgogICAgICAgICAgLSBhcmNoaXZlCiAgLSBhcGktaW50ZXJmYWNlOiB0ZW5kZXJtaW50cnBjCiAgICBjaGFpbi1pZDogTEFWMQogICAgbmV0d29yay1hZGRyZXNzOgogICAgICBhZGRyZXNzOiAiMC4wLjAuMDoyMjAwIgogICAgICBkaXNhYmxlLXRsczogdHJ1ZQogICAgbm9kZS11cmxzOgogICAgICAtIHVybDogImh0dHBzOi8vKioqKi9ycGMvIgogICAgICAtIHVybDogImh0dHBzOi8vKioqKi9ycGMvIgogICAgICAgIHNraXAtdmVyaWZpY2F0aW9uczoKICAgICAgICAgIC0gcHJ1bmluZwogICAgICAgIGFkZG9uczoKICAgICAgICAgIC0gYXJjaGl2ZQogIC0gYXBpLWludGVyZmFjZTogZ3JwYwogICAgY2hhaW4taWQ6IExBVjEKICAgIG5ldHdvcmstYWRkcmVzczoKICAgICAgYWRkcmVzczogIjAuMC4wLjA6MjIwMCIKICAgICAgZGlzYWJsZS10bHM6IHRydWUKICAgIG5vZGUtdXJsczoKICAgICAgLSB1cmw6ICIqKioqOjQ0MyIKICAgICAgLSB1cmw6ICIqKioqOjQ0MyIKICAgICAgICBza2lwLXZlcmlmaWNhdGlvbnM6CiAgICAgICAgICAtIHBydW5pbmcKICAgICAgICBhZGRvbnM6CiAgICAgICAgICAtIGFyY2hpdmUK
EOF

kubectl apply -f provider-config.yaml -n my-namespace
```

### Modify values file

The final step is to refrence the newly created secrets in the chart's values file:

```yaml
# values.yaml
service:
  port: 2200

key:
  secretName: "wallet"
  secretKey: "key"
  passwordSecretName: "wallet"
  passwordSecretKey: "password"

chains:
  - name: my-lava-provider
    id: lav1
    existingConfigSecret: "provider-config"
    existingConfigSecretKey: "config.yml"
```

## Installing the Chart

To install the chart with the release name `my-provider`:

```shell
helm repo add lavanet https://lavanet.github.io/helm-charts
helm repo update
helm install my-provider lavanet/provider -n lava-system --create-namespace
```

## Requirements

Kubernetes: `>=1.25.0-0`

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| additionalArgs | list | `[]` | Lavap provider additional CLI arguments |
| affinity | object | `{}` | Assign custom [affinity] rules to the deployment |
| cache.address | string | `"provider-cache:20100"` | Provider cache address |
| cache.enabled | bool | `true` | Enable provider cache supports |
| certificate.additionalHosts | list | `[]` | Certificate Subject Alternate Names (SANs) |
| certificate.annotations | object | `{}` | Annotations to be applied to the Server Certificate |
| certificate.domain | string | `""` (defaults to global.domain) | Certificate primary domain (commonName) |
| certificate.duration | string | `""` (defaults to 2160h = 90d if not specified) | The requested 'duration' (i.e. lifetime) of the certificate. # Ref: <https://cert-manager.io/docs/usage/certificate/#renewal> |
| certificate.enabled | bool | `false` | Deploy a Certificate resource (requires cert-manager) |
| certificate.issuer.group | string | `""` | Certificate issuer group. Set if using an external issuer. Eg. `cert-manager.io` |
| certificate.issuer.kind | string | `"ClusterIssuer"` | Certificate issuer kind. Either `Issuer` or `ClusterIssuer` |
| certificate.issuer.name | string | `"selfsigned"` | Certificate issuer name. Eg. `letsencrypt` |
| certificate.privateKey.algorithm | string | `"RSA"` | Algorithm used to generate certificate private key. One of: `RSA`, `Ed25519` or `ECDSA` |
| certificate.privateKey.encoding | string | `"PKCS1"` | The private key cryptography standards (PKCS) encoding for private key. Either: `PCKS1` or `PKCS8` |
| certificate.privateKey.rotationPolicy | string | `"Never"` | Rotation policy of private key when certificate is re-issued. Either: `Never` or `Always` |
| certificate.privateKey.size | int | `2048` | Key bit size of the private key. If algorithm is set to `Ed25519`, size is ignored. |
| certificate.renewBefore | string | `""` (defaults to 360h = 15d if not specified) | How long before the expiry a certificate should be renewed. # Ref: <https://cert-manager.io/docs/usage/certificate/#renewal> |
| certificate.secretTemplateAnnotations | object | `{}` | Annotations that allow the certificate to be composed from data residing in existing Kubernetes Resources |
| certificate.usages | list | `[]` | Usages for the certificate ## Ref: <https://cert-manager.io/docs/reference/api-docs/#cert-manager.io/v1.KeyUsage> |
| chainId | string | `"lava-testnet-2"` | Lava chain id |
| deploymentUpdate.maxSurge | string | `"100%"` |  |
| deploymentUpdate.maxUnavailable | int | `0` |  |
| deploymentUpdate.type | string | `"RollingUpdate"` |  |
| fullnameOverride | string | `""` | String to fully override `"provider.fullname"` |
| geolocation | string | `"2"` | Provider geo-location can be one of the [geolocations](https://docs.lavanet.xyz/provider-setup#geolocations) |
| global.domain | string | `"my-provider.local"` | Default domain used by all components # Used for ingresses, certificates, etc. |
| image.pullPolicy | string | `"IfNotPresent"` | Image pull policy for the provider |
| image.repository | string | `"ghcr.io/lavanet/lava/lavap"` | Repository to use for the provider |
| image.tag | string | `""` (defaults to Chart.appVersion) | Tag to use for the provider |
| imagePullSecrets | list | `[]` | Secrets with credentials to pull images from a private registry |
| ingressGrpc.annotations | object | `{}` | Additional ingress annotations |
| ingressGrpc.className | string | `"nginx"` | Defines which ingress controller will implement the resource |
| ingressGrpc.enabled | bool | `false` | Enable an ingress resource for the provider |
| ingressGrpc.path | string | `"/"` | The path to Provider |
| ingressGrpc.pathType | string | `"Prefix"` | Ingress path type. One of `Exact`, `Prefix` or `ImplementationSpecific` |
| ingressGrpc.tls | bool | `true` | Enable TLS configuration for the domain defined at `global.domain` # TLS certificate will be retrieved from a TLS secret with name: `provider-grpc-tls` |
| ingressGrpc.tlsSecretName | string | `nil` | Custom Ingress TLS secret |
| key | object | `{"passwordSecretKey":"password","passwordSecretName":"wallet","secretKey":"key","secretName":"wallet"}` | Information about the private key to use for the node |
| key.passwordSecretKey | string | `"password"` | The key in the secret that contains the password for the private key |
| key.passwordSecretName | string | `"wallet"` | The secret that contains the password for the private key |
| key.secretKey | string | `"key"` | The key in the secret to use |
| key.secretName | string | `"wallet"` | The secret name containing the private key |
| keyringBackend | string | `"test"` | Provider keyring backend |
| livenessProbe.failureThreshold | int | `3` | Minimum consecutive failures for the [probe] to be considered failed after having succeeded |
| livenessProbe.initialDelaySeconds | int | `10` | Number of seconds after the container has started before [probe] is initiated |
| livenessProbe.periodSeconds | int | `10` | How often (in seconds) to perform the [probe] |
| livenessProbe.scheme | string | `"HTTPS"` | Schema of the [probe], can be HTTP or HTTPS |
| livenessProbe.successThreshold | int | `1` | Minimum consecutive successes for the [probe] to be considered successful after having failed |
| livenessProbe.timeoutSeconds | int | `1` | Number of seconds after which the [probe] times out |
| log.format | string | `"json"` | Provider log format, can be json or text |
| log.level | string | `"info"` | Provider log level |
| metrics.enabled | bool | `true` | Should enable prometheus metrics |
| metrics.port | int | `3200` | Metrics service port |
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
| node | string | `"https://testnet2-rpc.lavapro.xyz:443"` | Lava node to connect to |
| nodeSelector | object | `{}` | [Node selector] |
| podAnnotations | object | `{}` | Annotations for the all deployed pods |
| podSecurityContext | object | `{}` |  |
| readinessProbe.failureThreshold | int | `3` | Minimum consecutive failures for the [probe] to be considered failed after having succeeded |
| readinessProbe.initialDelaySeconds | int | `10` | Number of seconds after the container has started before [probe] is initiated |
| readinessProbe.periodSeconds | int | `10` | How often (in seconds) to perform the [probe] |
| readinessProbe.scheme | string | `"HTTPS"` | Schema of the [probe], can be HTTP or HTTPS |
| readinessProbe.successThreshold | int | `1` | Minimum consecutive successes for the [probe] to be considered successful after having failed |
| readinessProbe.timeoutSeconds | int | `1` | Number of seconds after which the [probe] times out |
| replicaCount | int | `1` | The number of provider pods to run. |
| resources | object | `{}` | Resource limits and requests for the provider pods |
| securityContext | object | `{}` |  |
| service.port | int | `2200` | Provider service port |
| service.type | string | `"ClusterIP"` | Provider service type |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| statefulSetUpdate.updateStrategy | string | `"RollingUpdate"` |  |
| tolerations | list | `[]` | [Tolerations] for use with node taints |
| wallet | string | `"test"` | Wallet name |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
