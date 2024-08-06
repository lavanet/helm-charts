# consumer

![Version: 0.2.9](https://img.shields.io/badge/Version-0.2.9-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v2.2.0](https://img.shields.io/badge/AppVersion-v2.2.0-informational?style=flat-square)

Lava consumer helm chart

**Homepage:** <https://lavanet.xyz>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| MagmaDevs |  | <https://lavanet.xyz> |

## Requirements

Kubernetes: `>=1.16.0-0`

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| chains.agr.default_interface | string | `"rest"` |  |
| chains.agr.interfaces[0].interface | string | `"rest"` |  |
| chains.agr.interfaces[0].port | int | `2002` |  |
| chains.agr.interfaces[1].interface | string | `"tendermintrpc"` |  |
| chains.agr.interfaces[1].port | int | `2003` |  |
| chains.agr.interfaces[2].interface | string | `"jsonrpc"` |  |
| chains.agr.interfaces[2].port | int | `2004` |  |
| chains.agr.interfaces[3].interface | string | `"grpc"` |  |
| chains.agr.interfaces[3].port | int | `2005` |  |
| chains.agr.metrics_port | int | `3002` |  |
| chains.arb1.default_interface | string | `"jsonrpc"` |  |
| chains.arb1.interfaces[0].interface | string | `"jsonrpc"` |  |
| chains.arb1.interfaces[0].port | int | `2000` |  |
| chains.arb1.metrics_port | int | `3000` |  |
| chains.arbn.default_interface | string | `"jsonrpc"` |  |
| chains.arbn.interfaces[0].interface | string | `"jsonrpc"` |  |
| chains.arbn.interfaces[0].port | int | `2001` |  |
| chains.arbn.metrics_port | int | `3001` |  |
| chains.axelar.default_interface | string | `"rest"` |  |
| chains.axelar.interfaces[0].interface | string | `"rest"` |  |
| chains.axelar.interfaces[0].port | int | `2006` |  |
| chains.axelar.interfaces[1].interface | string | `"tendermintrpc"` |  |
| chains.axelar.interfaces[1].port | int | `2007` |  |
| chains.axelar.interfaces[2].interface | string | `"grpc"` |  |
| chains.axelar.interfaces[2].port | int | `2008` |  |
| chains.axelar.legacy_url | bool | `true` |  |
| chains.axelar.metrics_port | int | `3003` |  |
| chains.axelart.default_interface | string | `"rest"` |  |
| chains.axelart.interfaces[0].interface | string | `"rest"` |  |
| chains.axelart.interfaces[0].port | int | `2009` |  |
| chains.axelart.interfaces[1].interface | string | `"tendermintrpc"` |  |
| chains.axelart.interfaces[1].port | int | `2010` |  |
| chains.axelart.interfaces[2].interface | string | `"grpc"` |  |
| chains.axelart.interfaces[2].port | int | `2011` |  |
| chains.axelart.legacy_url | bool | `true` |  |
| chains.axelart.metrics_port | int | `3004` |  |
| chains.axelart.testnet | bool | `true` |  |
| chains.berat.default_interface | string | `"jsonrpc"` |  |
| chains.berat.interfaces[0].interface | string | `"jsonrpc"` |  |
| chains.berat.interfaces[0].port | int | `2032` |  |
| chains.berat.metrics_port | int | `3013` |  |
| chains.blast.default_interface | string | `"jsonrpc"` |  |
| chains.blast.interfaces[0].interface | string | `"jsonrpc"` |  |
| chains.blast.interfaces[0].port | int | `2033` |  |
| chains.blast.metrics_port | int | `3014` |  |
| chains.celestia.default_interface | string | `"jsonrpc"` |  |
| chains.celestia.interfaces[0].interface | string | `"rest"` |  |
| chains.celestia.interfaces[0].port | int | `2046` |  |
| chains.celestia.interfaces[1].interface | string | `"tendermintrpc"` |  |
| chains.celestia.interfaces[1].port | int | `2047` |  |
| chains.celestia.interfaces[2].interface | string | `"jsonrpc"` |  |
| chains.celestia.interfaces[2].port | int | `2048` |  |
| chains.celestia.interfaces[3].interface | string | `"grpc"` |  |
| chains.celestia.interfaces[3].port | int | `2049` |  |
| chains.celestia.metrics_port | int | `3021` |  |
| chains.celestiatm.default_interface | string | `"jsonrpc"` |  |
| chains.celestiatm.interfaces[0].interface | string | `"rest"` |  |
| chains.celestiatm.interfaces[0].port | int | `2050` |  |
| chains.celestiatm.interfaces[1].interface | string | `"tendermintrpc"` |  |
| chains.celestiatm.interfaces[1].port | int | `2051` |  |
| chains.celestiatm.interfaces[2].interface | string | `"jsonrpc"` |  |
| chains.celestiatm.interfaces[2].port | int | `2052` |  |
| chains.celestiatm.interfaces[3].interface | string | `"grpc"` |  |
| chains.celestiatm.interfaces[3].port | int | `2053` |  |
| chains.celestiatm.metrics_port | int | `3022` |  |
| chains.eth1.default_interface | string | `"jsonrpc"` |  |
| chains.eth1.interfaces[0].interface | string | `"jsonrpc"` |  |
| chains.eth1.interfaces[0].port | int | `2034` |  |
| chains.eth1.metrics_port | int | `3015` |  |
| chains.evmos.default_interface | string | `"jsonrpc"` |  |
| chains.evmos.interfaces[0].interface | string | `"rest"` |  |
| chains.evmos.interfaces[0].port | int | `2012` |  |
| chains.evmos.interfaces[1].interface | string | `"tendermintrpc"` |  |
| chains.evmos.interfaces[1].port | int | `2013` |  |
| chains.evmos.interfaces[2].interface | string | `"jsonrpc"` |  |
| chains.evmos.interfaces[2].port | int | `2014` |  |
| chains.evmos.interfaces[3].interface | string | `"grpc"` |  |
| chains.evmos.interfaces[3].port | int | `2015` |  |
| chains.evmos.legacy_url | bool | `true` |  |
| chains.evmos.metrics_port | int | `3005` |  |
| chains.evmost.default_interface | string | `"jsonrpc"` |  |
| chains.evmost.interfaces[0].interface | string | `"rest"` |  |
| chains.evmost.interfaces[0].port | int | `2016` |  |
| chains.evmost.interfaces[1].interface | string | `"tendermintrpc"` |  |
| chains.evmost.interfaces[1].port | int | `2017` |  |
| chains.evmost.interfaces[2].interface | string | `"jsonrpc"` |  |
| chains.evmost.interfaces[2].port | int | `2018` |  |
| chains.evmost.interfaces[3].interface | string | `"grpc"` |  |
| chains.evmost.interfaces[3].port | int | `2019` |  |
| chains.evmost.legacy_url | bool | `true` |  |
| chains.evmost.metrics_port | int | `3006` |  |
| chains.evmost.testnet | bool | `true` |  |
| chains.koiit.default_interface | string | `"jsonrpc"` |  |
| chains.koiit.interfaces[0].interface | string | `"jsonrpc"` |  |
| chains.koiit.interfaces[0].port | int | `2025` |  |
| chains.koiit.metrics_port | int | `3010` |  |
| chains.lav1.default_interface | string | `"rest"` |  |
| chains.lav1.interfaces[0].interface | string | `"rest"` |  |
| chains.lav1.interfaces[0].port | int | `2020` |  |
| chains.lav1.interfaces[1].interface | string | `"tendermintrpc"` |  |
| chains.lav1.interfaces[1].port | int | `2021` |  |
| chains.lav1.interfaces[2].interface | string | `"grpc"` |  |
| chains.lav1.interfaces[2].port | int | `2022` |  |
| chains.lav1.metrics_port | int | `3007` |  |
| chains.near.default_interface | string | `"jsonrpc"` |  |
| chains.near.interfaces[0].interface | string | `"jsonrpc"` |  |
| chains.near.interfaces[0].port | int | `2023` |  |
| chains.near.metrics_port | int | `3008` |  |
| chains.neart.default_interface | string | `"jsonrpc"` |  |
| chains.neart.interfaces[0].interface | string | `"jsonrpc"` |  |
| chains.neart.interfaces[0].port | int | `2024` |  |
| chains.neart.legacy_url | bool | `true` |  |
| chains.neart.metrics_port | int | `3009` |  |
| chains.neart.testnet | bool | `true` |  |
| chains.secret.default_interface | string | `"rest"` |  |
| chains.secret.interfaces[0].interface | string | `"rest"` |  |
| chains.secret.interfaces[0].port | int | `2037` |  |
| chains.secret.interfaces[1].interface | string | `"tendermintrpc"` |  |
| chains.secret.interfaces[1].port | int | `2038` |  |
| chains.secret.interfaces[2].interface | string | `"grpc"` |  |
| chains.secret.interfaces[2].port | int | `2039` |  |
| chains.secret.metrics_port | int | `3018` |  |
| chains.secretp.default_interface | string | `"rest"` |  |
| chains.secretp.interfaces[0].interface | string | `"rest"` |  |
| chains.secretp.interfaces[0].port | int | `2040` |  |
| chains.secretp.interfaces[1].interface | string | `"tendermintrpc"` |  |
| chains.secretp.interfaces[1].port | int | `2041` |  |
| chains.secretp.interfaces[2].interface | string | `"grpc"` |  |
| chains.secretp.interfaces[2].port | int | `2042` |  |
| chains.secretp.metrics_port | int | `3019` |  |
| chains.strgz.default_interface | string | `"rest"` |  |
| chains.strgz.interfaces[0].interface | string | `"rest"` |  |
| chains.strgz.interfaces[0].port | int | `2026` |  |
| chains.strgz.interfaces[1].interface | string | `"tendermintrpc"` |  |
| chains.strgz.interfaces[1].port | int | `2027` |  |
| chains.strgz.interfaces[2].interface | string | `"grpc"` |  |
| chains.strgz.interfaces[2].port | int | `2028` |  |
| chains.strgz.metrics_port | int | `3011` |  |
| chains.strgzt.default_interface | string | `"rest"` |  |
| chains.strgzt.interfaces[0].interface | string | `"rest"` |  |
| chains.strgzt.interfaces[0].port | int | `2029` |  |
| chains.strgzt.interfaces[1].interface | string | `"tendermintrpc"` |  |
| chains.strgzt.interfaces[1].port | int | `2030` |  |
| chains.strgzt.interfaces[2].interface | string | `"grpc"` |  |
| chains.strgzt.interfaces[2].port | int | `2031` |  |
| chains.strgzt.metrics_port | int | `3012` |  |
| chains.strk.default_interface | string | `"jsonrpc"` |  |
| chains.strk.interfaces[0].interface | string | `"jsonrpc"` |  |
| chains.strk.interfaces[0].port | int | `2035` |  |
| chains.strk.legacy_url | bool | `true` |  |
| chains.strk.metrics_port | int | `3016` |  |
| chains.strkt.default_interface | string | `"jsonrpc"` |  |
| chains.strkt.interfaces[0].interface | string | `"jsonrpc"` |  |
| chains.strkt.interfaces[0].port | int | `2036` |  |
| chains.strkt.legacy_url | bool | `true` |  |
| chains.strkt.metrics_port | int | `3017` |  |
| chains.strkt.testnet | bool | `true` |  |
| chains.uniont.default_interface | string | `"rest"` |  |
| chains.uniont.interfaces[0].interface | string | `"rest"` |  |
| chains.uniont.interfaces[0].port | int | `2043` |  |
| chains.uniont.interfaces[1].interface | string | `"tendermintrpc"` |  |
| chains.uniont.interfaces[1].port | int | `2044` |  |
| chains.uniont.interfaces[2].interface | string | `"grpc"` |  |
| chains.uniont.interfaces[2].port | int | `2045` |  |
| chains.uniont.metrics_port | int | `3020` |  |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"ghcr.io/lavanet/lava/lavap"` |  |
| image.tag | string | `""` |  |
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
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| tolerations | list | `[]` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
