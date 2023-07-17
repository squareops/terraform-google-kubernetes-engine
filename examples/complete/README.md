<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_gke"></a> [gke](#module\_gke) | squareops/kubernetes-engine/google | n/a |
| <a name="module_managed_node_pool"></a> [managed\_node\_pool](#module\_managed\_node\_pool) | squareops/kubernetes-engine/google//modules/node-pool | n/a |

## Resources

| Name | Type |
|------|------|
| [google_client_config.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | The name of the GKE cluster. |
| <a name="output_kubernetes_endpoint"></a> [kubernetes\_endpoint](#output\_kubernetes\_endpoint) | The cluster endpoint |
| <a name="output_node_pool"></a> [node\_pool](#output\_node\_pool) | Details of node pools |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
