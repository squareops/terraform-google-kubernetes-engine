variable "project" {
  description = "The ID or project number of the Google Cloud project."
  type        = string
}

variable "cluster_name" {
  description = "The name of the GKE cluster."
  type        = string
}
variable "name" {
  default     = ""
  type        = string
  description = "The prefix name of the node pool"
}
variable "environment" {
  description = "The environment in which the resources are being deployed."
  type        = string
}

variable "location" {
  description = "The location/region of the GKE cluster and node pool."
  type        = string
}

variable "kubernetes_version" {
  description = "The desired Kubernetes version for the GKE cluster and node pool."
  type        = string
}

variable "initial_node_count" {
  description = "The initial number of nodes in the GKE node pool."
  type        = number
}

variable "node_locations" {
  description = "The locations for the GKE node pool's nodes."
  type        = list(string)
}

variable "min_count" {
  description = "The minimum number of nodes in the GKE node pool."
  type        = number
}

variable "max_count" {
  description = "The maximum number of nodes in the GKE node pool."
  type        = number
}

variable "max_surge" {
  description = "The maximum number of nodes that can be created beyond the desired size during an upgrade."
  type        = number
  default = 1
}

variable "max_unavailable" {
  description = "The maximum number of nodes that can be simultaneously unavailable during an upgrade."
  type        = number
  default = 0
}

variable "preemptible" {
  description = "Whether to create preemptible VM instances for the GKE node pool."
  type        = bool
  default = false
}

variable "instance_type" {
  description = "The machine type for the GKE node pool instances."
  type        = string
}

variable "disk_size_gb" {
  description = "The size of the disks for the GKE node pool instances."
  type        = number
}

variable "disk_type" {
  description = "The type of disks for the GKE node pool instances. e.g. pd-standard, pd-balanced or pd-ssd"
  type        = string
  default = "pd-standard"
}

variable "tags" {
  description = "The network tags to attach to the GKE node pool instances."
  type        = list(string)
  default = []
}

variable "labels" {
  description = "The labels to attach to the GKE node pool instances."
  type        = map(string)
  default = {}
}

variable "service_account" {
  description = "Service account for the default node pool"
  type        = string
}