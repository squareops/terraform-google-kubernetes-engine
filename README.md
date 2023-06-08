# Terraform module for GKE

### Pre-requisites
### Install Below utilities
1. Terraform 1.0.0 :- https://www.terraform.io/docs/cli/install/apt.html
2. Kubectl 1.21.0 :- https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
3. Helm 3.0.0 :- https://helm.sh/docs/intro/install/
4. Cloud SDK :- https://cloud.google.com/sdk/docs/install

### Configure a Service Account
1. Login to the GCP console. IAM > Service Account and Create a service account for authentication, provide the bellow given permissions accordingly and generate a JSON service account key.
2. Add following permissions on the service account as required:
    - **Kubernetes Engine Admin** : For management of Kubernetes Clusters and their Kubernetes API objects.
    - **Service Account User** : For using service account in GKE cluster
    - **Service Account Admin & Project IAM Admin** : For creating and managing service accounts and assigning roles required in external-secrets. #Do not grant this role if not using external-secrets.
    - **Storage Admin** : For managing GCS resources.
    - **Logging Admin & Monitoring Admin** : If using logging and monitoring for CIS.
    - **Cloud KMS CryptoKey Encrypter/Decrypter** : If you are using CMEK for encryption.
    - **Secret Manager Secret Accessor** : For accessing secrets from secret manager.

3. Run command in terminal to configure google credentials:  

        gcloud auth activate-service-account SA-NAME --key-file=KEY.JSON (You need to export key file everytime you create resource)
        export GOOGLE_APPLICATION_CREDENTIALS="keypath"
        gcloud config set project <project-name>

# USAGE
- Used to create GKE cluster(Google Kubernetes Engine).
- Contains the following features:
  1. Creates a GKE cluster with different node pools consisting of "Preemtible" and "non-preemtible" nodes.
  2. It contain a Infra-services node pool, an Application node pool with preemtible VMs and an Application node pool with non preemtible VMs.
  3. Creating of firewall rules to allow different port required for bootstrap services or different infra-services.
  4. Bootstrap services :
        - Nginx Ingress Controller
        - Cert Manager
        - Kubernetes External Secret
        - Keda metric server
  5. Issues certificates with the help of Cluster Issuer.
  6. Created default storage class for infra-services.


For enablling bootstrap services, change the values in terraform.tfvars to true.

    cert_manager_enabled     = true
    ingress_nginx_enabled    = true
    external_secret_enabled  = true
    get_kubeconfig_enabled   = true // must be set true to get cluster credentials.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=0.13 |
| <a name="requirement_google"></a> [google](#requirement\_google) | < 5.0, >= 2.12 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.7.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | < 5.0, >= 2.12 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_gke"></a> [gke](#module\_gke) | terraform-google-modules/kubernetes-engine/google//modules/private-cluster | n/a |
| <a name="module_service_accounts_gke"></a> [service\_accounts\_gke](#module\_service\_accounts\_gke) | terraform-google-modules/service-accounts/google | ~> 3.0 |

## Resources

| Name | Type |
|------|------|
| [google_client_config.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cert_manager_email"></a> [cert\_manager\_email](#input\_cert\_manager\_email) | Enter cert manager email | `string` | `""` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name of the cluster | `string` | `"test"` | no |
| <a name="input_create_service_account"></a> [create\_service\_account](#input\_create\_service\_account) | Service account | `bool` | `false` | no |
| <a name="input_database_encryption"></a> [database\_encryption](#input\_database\_encryption) | Application-layer Secrets Encryption settings. The object format is {state = string, key\_name = string}. Valid values of state are: "ENCRYPTED"; "DECRYPTED". key\_name is the name of a CloudKMS key. | `list(object({ state = string, key_name = string }))` | <pre>[<br>  {<br>    "key_name": "",<br>    "state": "DECRYPTED"<br>  }<br>]</pre> | no |
| <a name="input_disk_type"></a> [disk\_type](#input\_disk\_type) | Disk type for the cluster | `string` | `""` | no |
| <a name="input_enable_private_endpoint"></a> [enable\_private\_endpoint](#input\_enable\_private\_endpoint) | Create private cluster endpoint | `bool` | `false` | no |
| <a name="input_enable_private_nodes"></a> [enable\_private\_nodes](#input\_enable\_private\_nodes) | Enable private nodes | `bool` | `true` | no |
| <a name="input_enable_secure_boot"></a> [enable\_secure\_boot](#input\_enable\_secure\_boot) | Create a secure boot | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The name of the environment | `string` | `"dev"` | no |
| <a name="input_get_kubeconfig_enabled"></a> [get\_kubeconfig\_enabled](#input\_get\_kubeconfig\_enabled) | Create kubeconfig | `bool` | `true` | no |
| <a name="input_infra_np_disk_size_gb"></a> [infra\_np\_disk\_size\_gb](#input\_infra\_np\_disk\_size\_gb) | Disk size of infra nodes | `number` | `20` | no |
| <a name="input_infra_np_initial_node_count"></a> [infra\_np\_initial\_node\_count](#input\_infra\_np\_initial\_node\_count) | Initial count for infra nodes | `number` | `1` | no |
| <a name="input_infra_np_instance_type"></a> [infra\_np\_instance\_type](#input\_infra\_np\_instance\_type) | Instance type for infra nodes | `string` | `""` | no |
| <a name="input_infra_np_locations"></a> [infra\_np\_locations](#input\_infra\_np\_locations) | The lpcation(zone) of infra nodes | `string` | `"asia-south1-a"` | no |
| <a name="input_infra_np_max_count"></a> [infra\_np\_max\_count](#input\_infra\_np\_max\_count) | Maximum number of infra nodes | `number` | `5` | no |
| <a name="input_infra_np_min_count"></a> [infra\_np\_min\_count](#input\_infra\_np\_min\_count) | Minimum number of infra nodes | `number` | `1` | no |
| <a name="input_infra_np_name"></a> [infra\_np\_name](#input\_infra\_np\_name) | The name of the infra node pool | `string` | `"infra"` | no |
| <a name="input_infra_np_preemptive"></a> [infra\_np\_preemptive](#input\_infra\_np\_preemptive) | Create preemptive type infra nodes | `bool` | `true` | no |
| <a name="input_ip_address"></a> [ip\_address](#input\_ip\_address) | External Static Address for loadbalancer | `string` | `null` | no |
| <a name="input_ip_range_pods_name"></a> [ip\_range\_pods\_name](#input\_ip\_range\_pods\_name) | The _name_ of the secondary subnet ip range to use for pods | `string` | `""` | no |
| <a name="input_ip_range_services_name"></a> [ip\_range\_services\_name](#input\_ip\_range\_services\_name) | The _name_ of the secondary subnet range to use for services | `string` | `""` | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | Version of kubernetes | `string` | `"1.24"` | no |
| <a name="input_logging_service"></a> [logging\_service](#input\_logging\_service) | The logging service that the cluster should write logs to. Available options include logging.googleapis.com, logging.googleapis.com/kubernetes (beta), and none | `string` | `"logging.googleapis.com/kubernetes"` | no |
| <a name="input_master_authorized_networks"></a> [master\_authorized\_networks](#input\_master\_authorized\_networks) | Master authorized network for cluster | `string` | `""` | no |
| <a name="input_master_ipv4_cidr_block"></a> [master\_ipv4\_cidr\_block](#input\_master\_ipv4\_cidr\_block) | CIDR of master ipv4 block | `string` | `""` | no |
| <a name="input_master_vpc_cidr"></a> [master\_vpc\_cidr](#input\_master\_vpc\_cidr) | CIDR of master VPC | `string` | `"10.0.0.0/28"` | no |
| <a name="input_monitoring_service"></a> [monitoring\_service](#input\_monitoring\_service) | The monitoring service that the cluster should write metrics to. Automatically send metrics from pods in the cluster to the Google Cloud Monitoring API. VM metrics will be collected by Google Compute Engine regardless of this setting Available options include monitoring.googleapis.com, monitoring.googleapis.com/kubernetes (beta) and none | `string` | `"monitoring.googleapis.com/kubernetes"` | no |
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | The name of network | `string` | `"skaf-dev-vpc"` | no |
| <a name="input_network_policy"></a> [network\_policy](#input\_network\_policy) | Create network policy | `bool` | `false` | no |
| <a name="input_project"></a> [project](#input\_project) | The name of GCP project | `string` | `"fresh-sanctuary-389006"` | no |
| <a name="input_public_subnet"></a> [public\_subnet](#input\_public\_subnet) | The name of public subnet | `string` | `"skaf-dev-public-subnet"` | no |
| <a name="input_region"></a> [region](#input\_region) | The region to host the gke cluster | `string` | `"asia-south1"` | no |
| <a name="input_release_channel"></a> [release\_channel](#input\_release\_channel) | The release channel of this cluster. Accepted values are `UNSPECIFIED`, `RAPID`, `REGULAR` and `STABLE`. Defaults to `UNSPECIFIED`. | `string` | `null` | no |
| <a name="input_remove_default_node_pool"></a> [remove\_default\_node\_pool](#input\_remove\_default\_node\_pool) | Remove default node pool | `bool` | `true` | no |
| <a name="input_service_acc_names"></a> [service\_acc\_names](#input\_service\_acc\_names) | Names of the service accounts to create | `list(string)` | `[]` | no |
| <a name="input_service_account"></a> [service\_account](#input\_service\_account) | The name of service account | `string` | `""` | no |
| <a name="input_source_image"></a> [source\_image](#input\_source\_image) | The source image to build the VM using. Specified by path reference or by {{project}}/{{image-family}} | `string` | `"ubuntu-os-cloud/ubuntu-1804-lts"` | no |
| <a name="input_startup_script"></a> [startup\_script](#input\_startup\_script) | The script to be executed when the bastion host starts. It can be used to install additional software and/or configure the host. | `string` | `""` | no |
| <a name="input_subnet"></a> [subnet](#input\_subnet) | The name of subnet | `string` | `"skaf-dev-private-subnet"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for naming convention | `string` | `""` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | The name of the vpc | `string` | `"skaf-dev-vpc"` | no |
| <a name="input_zones"></a> [zones](#input\_zones) | The zone to host the cluster in (required if is a zonal cluster) | `list(string)` | <pre>[<br>  "asia-south1-b",<br>  "asia-south1-c"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | The unique ID of the GKE cluster. |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | The name of the GKE cluster. |
| <a name="output_cluster_region"></a> [cluster\_region](#output\_cluster\_region) | The region where the GKE cluster is located. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
