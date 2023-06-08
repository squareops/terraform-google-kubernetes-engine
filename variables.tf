## COMMON VARIABLES

variable "project" {
  default     = "fresh-sanctuary-389006"
  type        = string
  description = "The name of GCP project"
}

variable "region" {
  default     = "asia-south1"
  type        = string
  description = "The region to host the gke cluster"
}

variable "zones" {
  type        = list(string)
  default     = ["asia-south1-b", "asia-south1-c"]
  description = "The zone to host the cluster in (required if is a zonal cluster)"
}


variable "source_image" {
  description = "The source image to build the VM using. Specified by path reference or by {{project}}/{{image-family}}"
  type        = string
  default     = "ubuntu-os-cloud/ubuntu-1804-lts"
}

variable "startup_script" {
  description = "The script to be executed when the bastion host starts. It can be used to install additional software and/or configure the host."
  type        = string
  default     = ""
}

variable "tags" {
  default     = ""
  type        = string
  description = "Tags for naming convention"
}

## GKE VARIABLES
# variable "application_np_name" {
#   default = ""
#   type    = string
#   description = "The name of application node pool"
# }
# variable "application_np_preemtible_name" {
#   default = ""
#   type    = string
#   description = "The name of preemtible application node pool"

# }
# variable "application_np_min_count" {
#   default = 1
#   type    = number
#   description = "Minimum number of nodes in application node pool"
# }
# variable "application_np_preemtible_locations" {
#   type = list(string)
#   default = []
#   description = "The location(zone) for your preemptible node pool"
# }
# variable "application_np_locations" {
#   type = list(string)
#   default = []
#   description = "The location(zone) for your application node pool"
# }
# variable "application_np_max_count" {
#   default = 5
#   type    = number
#   description = "Maximum number of nodes in application node pool"
# }
# variable "application_np_preemtible_min_count" {
#   default = 1
#   type    = number
#   description = "Minimum number of nodes in preemptible application node pool"
# }

# variable "application_np_preemtible_max_count" {
#   default = 5
#   type    = number
#   description = "Maximum number of nodes for preemptible node pool"
# }

# variable "application_np_initial_node_count" {
#   default = 1
#   type    = number
#   description = "Initial node count for node pool"
# }

# variable "application_np_preemptive" {
#   default = false
#   type    = bool
#   description = "Create preemptible application  node pool"
# }
# variable "application_np_preemtible_initial_node_count" {
#   default = 1
#   type    = number
#   description = "Initial node count for preemptible application node pool"
# }
# variable "application_np_instance_type" {
#   default = ""
#   type    = string
#   description = "Instance type to be used for application node pool"
# }
# variable "application_np_preemtible_instance_type" {
#   default = ""
#   type    = string
#   description = "Instance type to be used for preemptible application node pool"
# }
# variable "application_np_preemtible_preemptive" {
#   default = true
#   type    = bool
#   description = "Create preemtible type application node pool"
# }
# variable "application_np_disk_size_gb" {
#   default = 20
#   type    = number
#   description = "Disk size of application nodes"
# }
# variable "application_np_preemtible_disk_size_gb" {
#   default = 20
#   type    = number
#   description = "Disk size of preemtible application nodes"
# }
variable "create_service_account" {
  default     = false
  type        = bool
  description = "Service account"
}
# variable "create_application_preemtible" {
#   default = false
#   type    = bool
#   description = "Create preemtible application node pool"
# }
# variable "create_application_nodes" {
#   default = false
#   type    = bool
#   description = "Create application node pool"
# }

variable "cluster_name" {
  default     = "test"
  type        = string
  description = "The name of the cluster"
}
variable "database_encryption" {
  description = "Application-layer Secrets Encryption settings. The object format is {state = string, key_name = string}. Valid values of state are: \"ENCRYPTED\"; \"DECRYPTED\". key_name is the name of a CloudKMS key."
  type        = list(object({ state = string, key_name = string }))

  default = [{
    state    = "DECRYPTED"
    key_name = ""
  }]
}
variable "disk_type" {
  default     = ""
  type        = string
  description = "Disk type for the cluster"
}
variable "enable_private_endpoint" {
  type        = bool
  default     = false
  description = "Create private cluster endpoint"
}
variable "enable_secure_boot" {
  type        = bool
  default     = true
  description = "Create a secure boot"
}
variable "environment" {
  default     = "dev"
  type        = string
  description = "The name of the environment"
}

variable "get_kubeconfig_enabled" {
  default     = true
  type        = bool
  description = "Create kubeconfig"
}

variable "infra_np_name" {
  default     = "infra"
  type        = string
  description = "The name of the infra node pool"
}


variable "infra_np_instance_type" {
  default     = ""
  type        = string
  description = "Instance type for infra nodes"
}


variable "infra_np_min_count" {
  default     = 1
  type        = number
  description = "Minimum number of infra nodes"
}

variable "infra_np_max_count" {
  default     = 5
  type        = number
  description = "Maximum number of infra nodes"
}

variable "infra_np_disk_size_gb" {
  default     = 20
  type        = number
  description = "Disk size of infra nodes"
}

variable "infra_np_initial_node_count" {
  default     = 1
  type        = number
  description = "Initial count for infra nodes"
}
variable "ip_range_pods_name" {
  default     = ""
  type        = string
  description = "The _name_ of the secondary subnet ip range to use for pods"
}

variable "infra_np_preemptive" {
  default     = true
  type        = bool
  description = "Create preemptive type infra nodes"
}
variable "ip_range_services_name" {
  default     = ""
  type        = string
  description = "The _name_ of the secondary subnet range to use for services"
}
variable "cert_manager_email" {
  default     = ""
  type        = string
  description = "Enter cert manager email"
}
variable "ip_address" {
  type        = string
  description = "External Static Address for loadbalancer"
  default     = null
}

variable "kubernetes_version" {
  type        = string
  description = "Version of kubernetes"
  default     = "1.24"
}
variable "logging_service" {
  default     = "logging.googleapis.com/kubernetes"
  description = "The logging service that the cluster should write logs to. Available options include logging.googleapis.com, logging.googleapis.com/kubernetes (beta), and none"
  type        = string
}

variable "infra_np_locations" {
  type        = string
  description = "The lpcation(zone) of infra nodes"
  default     = "asia-south1-a"
}
variable "enable_private_nodes" {
  default     = true
  type        = bool
  description = "Enable private nodes"
}
variable "monitoring_service" {
  default     = "monitoring.googleapis.com/kubernetes"
  description = "The monitoring service that the cluster should write metrics to. Automatically send metrics from pods in the cluster to the Google Cloud Monitoring API. VM metrics will be collected by Google Compute Engine regardless of this setting Available options include monitoring.googleapis.com, monitoring.googleapis.com/kubernetes (beta) and none"
  type        = string
}
variable "master_authorized_networks" {
  default     = ""
  type        = string
  description = "Master authorized network for cluster"
}
variable "master_vpc_cidr" {
  default     = "10.0.0.0/28"
  type        = string
  description = "CIDR of master VPC"
}
variable "master_ipv4_cidr_block" {
  default     = ""
  type        = string
  description = "CIDR of master ipv4 block"
}
variable "network_policy" {
  default     = false
  type        = bool
  description = "Create network policy"
}
variable "network_name" {
  default     = "skaf-dev-vpc"
  type        = string
  description = "The name of network"
}
variable "public_subnet" {
  default     = "skaf-dev-public-subnet"
  type        = string
  description = "The name of public subnet"
}

variable "subnet" {
  default     = "skaf-dev-private-subnet"
  type        = string
  description = "The name of subnet"
}
variable "release_channel" {
  type        = string
  description = "The release channel of this cluster. Accepted values are `UNSPECIFIED`, `RAPID`, `REGULAR` and `STABLE`. Defaults to `UNSPECIFIED`."
  default     = null
}
variable "remove_default_node_pool" {
  default     = true
  type        = bool
  description = "Remove default node pool"
}
variable "service_account" {
  default     = ""
  type        = string
  description = "The name of service account"
}
variable "service_acc_names" {
  type        = list(string)
  description = "Names of the service accounts to create"
  default     = []
}
variable "vpc_name" {
  default     = "skaf-dev-vpc"
  type        = string
  description = "The name of the vpc"
}
