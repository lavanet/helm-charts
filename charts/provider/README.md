# provider

Lava helm chart for the provider service

![Version: 0.3.2](https://img.shields.io/badge/Version-0.3.2-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v2.2.6](https://img.shields.io/badge/AppVersion-v2.2.6-informational?style=flat-square)

## Lavanet Provider Helm Chart

This Helm chart deploys a Lavanet provider service, which serves as a crucial component of the Lava network.

Lavanet providers are essential participants in the Lava ecosystem, responsible for:

* Servicing relay requests from consumers
* Staking on the Lava network
* Operating RPC nodes on various Relay Chains (e.g., Cosmos, Ethereum, Osmosis, Polygon)

Providers earn LAVA tokens as fees for fulfilling these requests, creating an incentive-driven decentralized infrastructure.

## Prerequisites

Before deploying the provider chart you'll need to do two imporatnt things:

* Create wallet and export it, or export an exisint one
* Create configuration for the provider

### Create wallet

In order to create a new wallet, make sure you have `lavap` CLI installed and run:

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

### Create configuration for provider

Most provider configurations point to secure nodes and should remain encrypted on the cluster

### Modify values file

The final step is to refrence the newly created secrets in the chart's values file:

```yaml
chains:
  lav1:
    existingSecret: "config"
    existingSecretKey: "config.yml"
    key:
      secretName: "wallet"
      secretKey: "key"
      passwordSecretName: "wallet"
      passwordSecretKey: "password"
```

## Installing the Chart

To install the chart with the release name `my-provider`:

```shell
helm repo add lavanet https://lavanet.github.io/helm-charts
helm repo update
helm install my-provider lavanet/provider
```

## Requirements

Kubernetes: `>=1.16.0-0`


## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| chains.lav1.cache.address | string | `"provider-cache:20100"` | cache address |
| chains.lav1.cache.enabled | bool | `true` | should add cache arg to provider |
| chains.lav1.chainId | string | `"lava-testnet-2"` | lava chain id |
| chains.lav1.existingSecret | string | `"config"` | existing configuration secret name |
| chains.lav1.existingSecretKey | string | `"config.yml"` | existing configuration secret key |
| chains.lav1.geolocation | string | `"2"` | provider geo-location can be one of the [geolocations](https://docs.lavanet.xyz/provider-setup#geolocations) |
| chains.lav1.key | object | `{"passwordSecretKey":"password","passwordSecretName":"wallet","secretKey":"passphrase","secretName":"wallet"}` | information about the private key to use for the node |
| chains.lav1.key.passwordSecretKey | string | `"password"` | the key in the kubernetes secret that contains the password for the private key |
| chains.lav1.key.passwordSecretName | string | `"wallet"` | the kubernetes secret that contains the password for the private key |
| chains.lav1.key.secretKey | string | `"passphrase"` | the key in the kubernetes secret to use |
| chains.lav1.key.secretName | string | `"wallet"` | the kubernetes secret name containing the private key |
| chains.lav1.keyringBackend | string | `"test"` | provider keyring backend |
| chains.lav1.log.format | string | `"json"` | log format, can be json or text |
| chains.lav1.log.level | string | `"info"` | log level |
| chains.lav1.metrics.enabled | bool | `true` | should enable prometheus metrics |
| chains.lav1.metrics.port | int | `3200` | prometheus metrics address |
| chains.lav1.metrics.serviceMonitor.enabled | bool | `false` |  |
| chains.lav1.node | string | `"https://testnet2-rpc.lavapro.xyz:443"` | lava node to connect to |
| chains.lav1.persistence.accessModes[0] | string | `"ReadWriteOnce"` |  |
| chains.lav1.persistence.enabled | bool | `true` | should create pvc for the provider data |
| chains.lav1.persistence.size | string | `"8Gi"` |  |
| chains.lav1.wallet | string | `"test"` | wallet name |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"ghcr.io/lavanet/lava/lavap"` |  |
| image.tag | string | `""` | overrides the image tag whose default is the chart appVersion. |
| imagePullSecrets | list | `[]` |  |
| ingress.annotations | object | `{}` |  |
| ingress.className | string | `""` |  |
| ingress.enabled | bool | `false` |  |
| ingress.hosts[0].host | string | `"chart-example.local"` |  |
| ingress.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.hosts[0].paths[0].pathType | string | `"ImplementationSpecific"` |  |
| ingress.tls | list | `[]` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| replicaCount | int | `1` |  |
| resources | object | `{}` |  |
| securityContext | object | `{}` |  |
| service.port | int | `2200` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` | annotations to add to the service account |
| serviceAccount.create | bool | `true` | specifies whether a service account should be created |
| serviceAccount.name | string | `""` | the name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| tolerations | list | `[]` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
