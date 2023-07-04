variable "region" {
  description = "The region where the resources will be created."
  type        = string
  default     = ""
}

variable "project" {
  description = "The ID or project number of the Google Cloud project."
  type        = string
  default = ""
}

variable "environment" {
  description = "The environment in which the resources are being deployed."
  type        = string
  default     = ""
}

variable "cluster_name" {
  description = "The name of the GKE cluster."
  type        = string
  default     = ""
}

variable "zones" {
  description = "The zones where the GKE cluster will be distributed across."
  type        = list(string)
  default = []
}

variable "vpc_name" {
  description = "The name of the VPC network where the GKE cluster will be created."
  type        = string
  default     = ""
}

variable "subnet" {
  description = "The name of the subnet within the VPC network for the GKE cluster."
  type        = string
  default     = ""
}

variable "ip_range_pods_name" {
  description = "The name of the IP range for pods in the GKE cluster."
  type        = string
  default = ""
}

variable "ip_range_services_name" {
  description = "The name of the IP range for services in the GKE cluster."
  type        = string
  default = ""
}

variable "release_channel" {
  description = "The release channel of the cluster. Accepted values are `UNSPECIFIED`, `RAPID`, `REGULAR` and `STABLE`. Defaults to `UNSPECIFIED`."
  type        = string
  default     = "STABLE"
}

variable "kubernetes_version" {
  description = "The desired Kubernetes version for the GKE cluster."
  type        = string
  default     = "1.25"
}

variable "enable_private_endpoint" {
  description = "Whether to enable the private endpoint for the GKE cluster."
  type        = bool
  default     = false
}

variable "enable_private_nodes" {
  description = "Whether to enable private nodes for the GKE cluster."
  type        = bool
  default     = true
}

variable "master_authorized_networks" {
  description = "The authorized networks for accessing the GKE cluster master."
  default     = ""
  type        = string
}

variable "logging_service" {
  description = "The logging service that the cluster should write logs to. Available options include logging.googleapis.com, logging.googleapis.com/kubernetes (beta), and none"
  type        = string
  default     = "logging.googleapis.com/kubernetes"
}

variable "monitoring_service" {
  description = "The monitoring service that the cluster should write metrics to. Automatically send metrics from pods in the cluster to the Google Cloud Monitoring API. VM metrics will be collected by Google Compute Engine regardless of this setting Available options include monitoring.googleapis.com, monitoring.googleapis.com/kubernetes (beta) and none"
  type        = string
  default     = "monitoring.googleapis.com/kubernetes"
}

variable "remove_default_node_pool" {
  default     = true
  type        = bool
  description = "Remove default node pool"
}

variable "default_np_name" {
  description = "Name of the default node pool"
  type        = string
  default     = "default"
}

variable "default_np_instance_type" {
  description = "Machine type for the default node pool"
  type        = string
  default     = "e2-medium"
}

variable "default_np_locations" {
  description = "Locations for the default node pool"
  type        = string
  default     = "asia-south1-a"
}

variable "default_np_min_count" {
  description = "Minimum number of nodes for the default node pool"
  type        = number
  default     = 1
}

variable "default_np_max_count" {
  description = "Maximum number of nodes for the default node pool"
  type        = number
  default     = 3
}

variable "default_np_disk_size_gb" {
  description = "Disk size (in GB) for the default node pool"
  type        = number
  default     = 50
}

variable "enable_secure_boot" {
  description = "Enable secure boot for the default node pool"
  type        = bool
  default     = false
}

variable "disk_type" {
  description = "Disk type for the default node pool"
  type        = string
  default     = "pd-standard"
}

variable "default_np_preemptible" {
  description = "Enable preemptible instances for the default node pool"
  type        = bool
  default     = true
}

variable "default_np_initial_node_count" {
  description = "Initial number of nodes for the default node pool"
  type        = number
  default     = 1
}
