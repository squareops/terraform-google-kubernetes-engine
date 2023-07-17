# node-pool

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_container_node_pool.node_pool](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_node_pool) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_boot_disk_kms_key"></a> [boot\_disk\_kms\_key](#input\_boot\_disk\_kms\_key) | The Customer Managed Encryption Key used to encrypt the boot disk attached to each node in the node pool. This should be of the form projects/[KEY\_PROJECT\_ID]/locations/[LOCATION]/keyRings/[RING\_NAME]/cryptoKeys/[KEY\_NAME]. | `string` | `""` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name of the GKE cluster. | `string` | n/a | yes |
| <a name="input_disk_size_gb"></a> [disk\_size\_gb](#input\_disk\_size\_gb) | The size of the disks for the GKE node pool instances. | `number` | n/a | yes |
| <a name="input_disk_type"></a> [disk\_type](#input\_disk\_type) | The type of disks for the GKE node pool instances. e.g. pd-standard, pd-balanced or pd-ssd | `string` | `"pd-standard"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment in which the resources are being deployed. | `string` | n/a | yes |
| <a name="input_initial_node_count"></a> [initial\_node\_count](#input\_initial\_node\_count) | The initial number of nodes in the GKE node pool. | `number` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The machine type for the GKE node pool instances. | `string` | n/a | yes |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | The desired Kubernetes version for the GKE cluster and node pool. | `string` | n/a | yes |
| <a name="input_labels"></a> [labels](#input\_labels) | The labels to attach to the GKE node pool instances. | `map(string)` | `{}` | no |
| <a name="input_location"></a> [location](#input\_location) | The location/region of the GKE cluster and node pool. | `string` | n/a | yes |
| <a name="input_max_count"></a> [max\_count](#input\_max\_count) | The maximum number of nodes in the GKE node pool. | `number` | n/a | yes |
| <a name="input_max_surge"></a> [max\_surge](#input\_max\_surge) | The maximum number of nodes that can be created beyond the desired size during an upgrade. | `number` | `1` | no |
| <a name="input_max_unavailable"></a> [max\_unavailable](#input\_max\_unavailable) | The maximum number of nodes that can be simultaneously unavailable during an upgrade. | `number` | `0` | no |
| <a name="input_min_count"></a> [min\_count](#input\_min\_count) | The minimum number of nodes in the GKE node pool. | `number` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The prefix name of the node pool | `string` | `""` | no |
| <a name="input_node_locations"></a> [node\_locations](#input\_node\_locations) | The locations for the GKE node pool's nodes. | `list(string)` | n/a | yes |
| <a name="input_node_pools_taints"></a> [node\_pools\_taints](#input\_node\_pools\_taints) | Map of lists containing node taints by node-pool name | `map(list(object({ key = string, value = string, effect = string })))` | <pre>{<br>  "all": []<br>}</pre> | no |
| <a name="input_oauth_scopes"></a> [oauth\_scopes](#input\_oauth\_scopes) | Lists containing node oauth scopes by node-pool name | `list(string)` | <pre>[<br>  "https://www.googleapis.com/auth/devstorage.read_only",<br>  "https://www.googleapis.com/auth/ndev.clouddns.readwrite",<br>  "https://www.googleapis.com/auth/service.management.readonly",<br>  "https://www.googleapis.com/auth/logging.write",<br>  "https://www.googleapis.com/auth/monitoring",<br>  "https://www.googleapis.com/auth/servicecontrol",<br>  "https://www.googleapis.com/auth/trace.append",<br>  "https://www.googleapis.com/auth/devstorage.read_only",<br>  "https://www.googleapis.com/auth/cloud-platform"<br>]</pre> | no |
| <a name="input_preemptible"></a> [preemptible](#input\_preemptible) | Whether to create preemptible VM instances for the GKE node pool. | `bool` | `false` | no |
| <a name="input_project"></a> [project](#input\_project) | The ID or project number of the Google Cloud project. | `string` | n/a | yes |
| <a name="input_service_account"></a> [service\_account](#input\_service\_account) | Service account for the default node pool | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | The network tags to attach to the GKE node pool instances. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_node_pool"></a> [node\_pool](#output\_node\_pool) | Details of node pools |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
