# GCP GKE Terraform module

![squareops_avatar]

[squareops_avatar]: https://squareops.com/wp-content/uploads/2022/12/squareops-logo.png

### [SquareOps Technologies](https://squareops.com/) Your DevOps Partner for Accelerating cloud journey.

<br>
This module simplifies the deployment of GKE clusters, allowing users to quickly create and manage a production-grade Kubernetes cluster on GCP. The module is highly configurable, allowing users to customize various aspects of the GKE cluster, such as the Kubernetes version, worker node instance type, and number of worker nodes. Additionally, the module provides a set of outputs that can be used to configure other resources, such as the Kubernetes config file.

This module is ideal for users who want to quickly deploy an GKE cluster on GCP without the need for manual setup and configuration. It is also suitable for users who want to adopt best practices for security and scalability in their GKE deployments.

## Usage Example

```hcl
module "gke" {
  source                     = "squareops/kubernetes-engine/google"
  project                    = project_name
  cluster_name               = "gke-cluster"
  region                     = "asia-south1"
  environment                = "dev"
  zones                      = ["asia-south1-a", "asia-south1-b", "asia-south1-c"]
  vpc_name                   = "dev-vpc"
  subnet                     = "dev-subnet-1"
  kubernetes_version         = "1.25"
  default_np_instance_type   = "e2-medium"
  default_np_locations       = "asia-south1-a,asia-south1-b"
  default_np_max_count       = 5
  default_np_preemptible     = true

}


module "node_pool" {
  source             = "squareops/kubernetes-engine/google//modules/node-pool"
  depends_on         = [module.gke]
  project            = project_name
  cluster_name       = module.gke.name
  name               = "app"
  environment        = "dev"
  location           = "asia-south1"
  kubernetes_version = "1.25"
  service_account    = module.gke.service_accounts_gke
  initial_node_count = 1
  min_count          = 1
  max_count          = 5
  node_locations     = ["asia-south1-a", "asia-south1-b", "asia-south1-c"]
  preemptible        = true
  instance_type      = "e2-medium"
  disk_size_gb       = 50
  labels = {
    "App-services" : true
  }
}

```
Refer [examples](https://github.com/sq-ia/terraform-google-kubernetes-engine/blob/main/examples/complete) for more details.

## Important Note
To prevent destruction interruptions, any resources that have been created outside of Terraform and attached to the resources provisioned by Terraform must be deleted before the module is destroyed.

### Configure a Service Account
1. Login to the GCP console. IAM > Service Account and Create a service account for authentication.

2. Provide the roles mentioned in [IAM.md](https://github.com/sq-ia/terraform-google-kubernetes-engine/blob/main/IAM.md).

3. Run command in terminal to configure google credentials:  

        gcloud auth activate-service-account SA-NAME --key-file=KEY.JSON (You need to export key file everytime you create resource)
        export GOOGLE_APPLICATION_CREDENTIALS="keypath"
        gcloud config set project <project-name>


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=0.13 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.51.0, < 5.0, !=4.65.0, !=4.65.1 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.10 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 2.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 4.51.0, < 5.0, !=4.65.0, !=4.65.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_gke"></a> [gke](#module\_gke) | terraform-google-modules/kubernetes-engine/google//modules/private-cluster | 27.0.0 |
| <a name="module_service_accounts_gke"></a> [service\_accounts\_gke](#module\_service\_accounts\_gke) | terraform-google-modules/service-accounts/google | ~> 3.0 |

## Resources

| Name | Type |
|------|------|
| [google_client_config.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name of the GKE cluster. | `string` | `""` | no |
| <a name="input_cluster_resource_labels"></a> [cluster\_resource\_labels](#input\_cluster\_resource\_labels) | The GCE resource labels (a map of key/value pairs) to be applied to the cluster | `map(string)` | `{}` | no |
| <a name="input_database_encryption"></a> [database\_encryption](#input\_database\_encryption) | Application-layer Secrets Encryption settings. The object format is {state = string, key\_name = string}. Valid values of state are: "ENCRYPTED"; "DECRYPTED". key\_name is the name of a CloudKMS key. | `list(object({ state = string, key_name = string }))` | <pre>[<br>  {<br>    "key_name": "",<br>    "state": "DECRYPTED"<br>  }<br>]</pre> | no |
| <a name="input_default_np_disk_size_gb"></a> [default\_np\_disk\_size\_gb](#input\_default\_np\_disk\_size\_gb) | Disk size (in GB) for the default node pool | `number` | `50` | no |
| <a name="input_default_np_initial_node_count"></a> [default\_np\_initial\_node\_count](#input\_default\_np\_initial\_node\_count) | Initial number of nodes for the default node pool | `number` | `1` | no |
| <a name="input_default_np_instance_type"></a> [default\_np\_instance\_type](#input\_default\_np\_instance\_type) | Machine type for the default node pool | `string` | `"e2-medium"` | no |
| <a name="input_default_np_locations"></a> [default\_np\_locations](#input\_default\_np\_locations) | Locations for the default node pool | `string` | `"asia-south1-a"` | no |
| <a name="input_default_np_max_count"></a> [default\_np\_max\_count](#input\_default\_np\_max\_count) | Maximum number of nodes for the default node pool | `number` | `3` | no |
| <a name="input_default_np_min_count"></a> [default\_np\_min\_count](#input\_default\_np\_min\_count) | Minimum number of nodes for the default node pool | `number` | `1` | no |
| <a name="input_default_np_name"></a> [default\_np\_name](#input\_default\_np\_name) | Name of the default node pool | `string` | `"default"` | no |
| <a name="input_default_np_preemptible"></a> [default\_np\_preemptible](#input\_default\_np\_preemptible) | Enable preemptible instances for the default node pool | `bool` | `true` | no |
| <a name="input_disk_type"></a> [disk\_type](#input\_disk\_type) | Disk type for the default node pool | `string` | `"pd-standard"` | no |
| <a name="input_enable_private_endpoint"></a> [enable\_private\_endpoint](#input\_enable\_private\_endpoint) | Whether to enable the private endpoint for the GKE cluster. | `bool` | `false` | no |
| <a name="input_enable_private_nodes"></a> [enable\_private\_nodes](#input\_enable\_private\_nodes) | Whether to enable private nodes for the GKE cluster. | `bool` | `true` | no |
| <a name="input_enable_secure_boot"></a> [enable\_secure\_boot](#input\_enable\_secure\_boot) | Enable secure boot for the default node pool | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment in which the resources are being deployed. | `string` | `""` | no |
| <a name="input_gke_backup_agent_config"></a> [gke\_backup\_agent\_config](#input\_gke\_backup\_agent\_config) | Whether Backup for GKE agent is enabled for this cluster. | `bool` | `false` | no |
| <a name="input_ip_range_pods_name"></a> [ip\_range\_pods\_name](#input\_ip\_range\_pods\_name) | The name of the IP range for pods in the GKE cluster. | `string` | `""` | no |
| <a name="input_ip_range_services_name"></a> [ip\_range\_services\_name](#input\_ip\_range\_services\_name) | The name of the IP range for services in the GKE cluster. | `string` | `""` | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | The desired Kubernetes version for the GKE cluster. | `string` | `"1.25"` | no |
| <a name="input_logging_enabled_components"></a> [logging\_enabled\_components](#input\_logging\_enabled\_components) | List of services to monitor: SYSTEM\_COMPONENTS, WORKLOADS. Empty list is default GKE configuration. | `list(string)` | `[]` | no |
| <a name="input_logging_service"></a> [logging\_service](#input\_logging\_service) | The logging service that the cluster should write logs to. Available options include logging.googleapis.com, logging.googleapis.com/kubernetes (beta), and none | `string` | `"logging.googleapis.com/kubernetes"` | no |
| <a name="input_master_authorized_networks"></a> [master\_authorized\_networks](#input\_master\_authorized\_networks) | Authorized networks for GKE master. | `string` | `""` | no |
| <a name="input_master_global_access_enabled"></a> [master\_global\_access\_enabled](#input\_master\_global\_access\_enabled) | Whether the cluster master is accessible globally (from any region) or only within the same region as the private endpoint. | `bool` | `true` | no |
| <a name="input_master_ipv4_cidr_block"></a> [master\_ipv4\_cidr\_block](#input\_master\_ipv4\_cidr\_block) | (Beta) The IP range in CIDR notation to use for the hosted master network | `string` | `"10.0.0.0/28"` | no |
| <a name="input_monitoring_enabled_components"></a> [monitoring\_enabled\_components](#input\_monitoring\_enabled\_components) | List of services to monitor: SYSTEM\_COMPONENTS, WORKLOADS (provider version >= 3.89.0). Empty list is default GKE configuration. | `list(string)` | `[]` | no |
| <a name="input_monitoring_service"></a> [monitoring\_service](#input\_monitoring\_service) | The monitoring service that the cluster should write metrics to. Automatically send metrics from pods in the cluster to the Google Cloud Monitoring API. VM metrics will be collected by Google Compute Engine regardless of this setting Available options include monitoring.googleapis.com, monitoring.googleapis.com/kubernetes (beta) and none | `string` | `"monitoring.googleapis.com/kubernetes"` | no |
| <a name="input_network_policy"></a> [network\_policy](#input\_network\_policy) | Enable network policy addon | `bool` | `false` | no |
| <a name="input_network_policy_provider"></a> [network\_policy\_provider](#input\_network\_policy\_provider) | The network policy provider. | `string` | `"CALICO"` | no |
| <a name="input_node_pools_oauth_scopes"></a> [node\_pools\_oauth\_scopes](#input\_node\_pools\_oauth\_scopes) | Map of lists containing node oauth scopes by node-pool name | `map(list(string))` | <pre>{<br>  "all": [<br>    "https://www.googleapis.com/auth/devstorage.read_only",<br>    "https://www.googleapis.com/auth/ndev.clouddns.readwrite",<br>    "https://www.googleapis.com/auth/service.management.readonly",<br>    "https://www.googleapis.com/auth/logging.write",<br>    "https://www.googleapis.com/auth/monitoring",<br>    "https://www.googleapis.com/auth/servicecontrol",<br>    "https://www.googleapis.com/auth/trace.append",<br>    "https://www.googleapis.com/auth/devstorage.read_only",<br>    "https://www.googleapis.com/auth/cloud-platform"<br>  ]<br>}</pre> | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | The ID or project number of the Google Cloud project. | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | The region to host the cluster in (optional if zonal cluster / required if regional) | `string` | `null` | no |
| <a name="input_regional"></a> [regional](#input\_regional) | Whether is a regional cluster (zonal cluster if set false. WARNING: changing this after cluster creation is destructive!) | `bool` | `true` | no |
| <a name="input_release_channel"></a> [release\_channel](#input\_release\_channel) | The release channel of the cluster. Accepted values are `UNSPECIFIED`, `RAPID`, `REGULAR` and `STABLE`. Defaults to `UNSPECIFIED`. | `string` | `"STABLE"` | no |
| <a name="input_remove_default_node_pool"></a> [remove\_default\_node\_pool](#input\_remove\_default\_node\_pool) | Remove default node pool | `bool` | `true` | no |
| <a name="input_subnet"></a> [subnet](#input\_subnet) | The name of the subnet within the VPC network for the GKE cluster. | `string` | `""` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | The name of the VPC network where the GKE cluster will be created. | `string` | `""` | no |
| <a name="input_zones"></a> [zones](#input\_zones) | The zones to host the cluster in (optional if regional cluster / required if zonal) | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ca_certificate"></a> [ca\_certificate](#output\_ca\_certificate) | The cluster ca certificate (base64 encoded) |
| <a name="output_client_token"></a> [client\_token](#output\_client\_token) | The bearer token for auth |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | Cluster name |
| <a name="output_cluster_region"></a> [cluster\_region](#output\_cluster\_region) | The region where the GKE cluster is located. |
| <a name="output_kubernetes_endpoint"></a> [kubernetes\_endpoint](#output\_kubernetes\_endpoint) | The cluster endpoint |
| <a name="output_peering_name"></a> [peering\_name](#output\_peering\_name) | The name of the peering between this cluster and the Google owned VPC. |
| <a name="output_service_account"></a> [service\_account](#output\_service\_account) | The default service account used for running nodes. |
| <a name="output_service_accounts_gke"></a> [service\_accounts\_gke](#output\_service\_accounts\_gke) | The service account to default running nodes. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->


## Contribute & Issue Report

To report an issue with a project:

  1. Check the repository's [issue tracker](https://github.com/sq-ia/terraform-google-kubernetes-engine/issues) on GitHub
  2. Search to check if the issue has already been reported
  3. If you can't find an answer to your question in the documentation or issue tracker, you can ask a question by creating a new issue. Make sure to provide enough context and details.

## License

Apache License, Version 2.0, January 2004 (https://www.apache.org/licenses/LICENSE-2.0)

## Support Us

To support our GitHub project by liking it, you can follow these steps:

  1. Visit the repository: Navigate to the [GitHub repository](https://github.com/sq-ia/terraform-google-kubernetes-engine)

  2. Click the "Star" button: On the repository page, you'll see a "Star" button in the upper right corner. Clicking on it will star the repository, indicating your support for the project.

  3. Optionally, you can also leave a comment on the repository or open an issue to give feedback or suggest changes.

Staring a repository on GitHub is a simple way to show your support and appreciation for the project. It also helps to increase the visibility of the project and make it more discoverable to others.

## Who we are

We believe that the key to success in the digital age is the ability to deliver value quickly and reliably. That’s why we offer a comprehensive range of DevOps & Cloud services designed to help your organization optimize its systems & Processes for speed and agility.

  1. We are an AWS Advanced consulting partner which reflects our deep expertise in AWS Cloud and helping 100+ clients over the last 5 years.
  2. Expertise in Kubernetes and overall container solution helps companies expedite their journey by 10X.
  3. Infrastructure Automation is a key component to the success of our Clients and our Expertise helps deliver the same in the shortest time.
  4. DevSecOps as a service to implement security within the overall DevOps process and helping companies deploy securely and at speed.
  5. Platform engineering which supports scalable,Cost efficient infrastructure that supports rapid development, testing, and deployment.
  6. 24*7 SRE service to help you Monitor the state of your infrastructure and eradicate any issue within the SLA.

We provide [support](https://squareops.com/contact-us/) on all of our projects, no matter how small or large they may be.

To find more information about our company, visit [squareops.com](https://squareops.com/), follow us on [Linkedin](https://www.linkedin.com/company/squareops-technologies-pvt-ltd/), or fill out a [job application](https://squareops.com/careers/). If you have any questions or would like assistance with your cloud strategy and implementation, please don't hesitate to [contact us](https://squareops.com/contact-us/).
