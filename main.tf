locals {
  region      = var.region
  project     = var.project
  environment = var.environment
}
provider "google" {
  region  = local.region
  project = local.project
}

provider "helm" {
  kubernetes {
    host                   = "https://${module.gke.endpoint}"
    token                  = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(module.gke.ca_certificate)
  }
}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

provider "kubectl" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
  load_config_file       = false
}


# google_client_config and kubernetes provider must be explicitly specified like the following.
data "google_client_config" "default" {}

module "service_accounts_gke" {
  source     = "terraform-google-modules/service-accounts/google"
  version    = "~> 3.0"
  project_id = local.project
  prefix     = var.cluster_name
  names      = [local.environment]
  project_roles = [
    "${local.project}=>roles/monitoring.viewer",
    "${local.project}=>roles/monitoring.metricWriter",
    "${local.project}=>roles/logging.logWriter",
    "${local.project}=>roles/stackdriver.resourceMetadata.writer",
    "${local.project}=>roles/storage.objectViewer",
  ]
  display_name = format("%s-%s-gke-cluster Nodes Service Account", var.cluster_name, local.environment)
}

module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  project_id                 = local.project
  name                       = format("%s-%s-gke-cluster", var.cluster_name, local.environment)
  region                     = local.region
  zones                      = var.zones
  network                    = var.vpc_name
  subnetwork                 = var.subnet
  ip_range_pods              = var.ip_range_pods_name
  ip_range_services          = var.ip_range_services_name
  release_channel            = var.release_channel
  kubernetes_version         = var.kubernetes_version
  http_load_balancing        = false
  horizontal_pod_autoscaling = true
  network_policy             = true
  enable_private_endpoint    = var.enable_private_endpoint
  enable_private_nodes       = var.enable_private_nodes
  # master_ipv4_cidr_block     = var.master_ipv4_cidr_block
  create_service_account     = false
  remove_default_node_pool   = var.remove_default_node_pool
  master_authorized_networks = var.enable_private_endpoint ? [{ cidr_block = var.master_authorized_networks, display_name = "VPN IP" }] : []
  logging_service            = var.logging_service
  monitoring_service         = var.monitoring_service
  node_pools = [
    {
      name               = format("%s-%s-node-pool", var.infra_np_name, local.environment)
      machine_type       = var.infra_np_instance_type
      node_locations     = var.infra_np_locations
      min_count          = var.infra_np_min_count
      max_count          = var.infra_np_max_count
      local_ssd_count    = 0
      disk_size_gb       = var.infra_np_disk_size_gb
      enable_secure_boot = var.enable_secure_boot
      disk_type          = var.disk_type
      image_type         = "COS_CONTAINERD"
      auto_repair        = true
      auto_upgrade       = true
      preemptible        = var.infra_np_preemptive
      initial_node_count = var.infra_np_initial_node_count
      service_account    = module.service_accounts_gke.email
    }
  ]

  node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/ndev.clouddns.readwrite",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/trace.append",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  node_pools_labels = {
    all = {}

    format("%s-%s-node-pool", var.infra_np_name, local.environment) = {
      "Infra-Services" = true
    }
  }

  # node_pools_metadata = {
  #   all = {}
  # }

  # node_pools_taints = {
  #   all = []
  # }

  # node_pools_tags = {
  #   all = []
  # }
}

# resource "google_container_node_pool" "application_nodes" {
#   count = var.create_application_nodes ? 1 : 0

#   name               = format("%s-%s-node-pool", var.application_np_name, local.environment)
#   location           = module.gke.region
#   cluster            = module.gke.name
#   max_pods_per_node  = 110
#   version            = var.kubernetes_version
#   initial_node_count = var.application_np_initial_node_count
#   node_locations     = var.application_np_locations
#   autoscaling {
#     min_node_count = var.application_np_min_count
#     max_node_count = var.application_np_max_count
#   }

#   management {
#     auto_repair  = true
#     auto_upgrade = true
#   }

#   node_config {
#     preemptible     = var.application_np_preemptive
#     machine_type    = var.application_np_instance_type
#     local_ssd_count = 0
#     disk_size_gb    = var.application_np_disk_size_gb
#     disk_type       = var.disk_type
#     image_type      = "COS_CONTAINERD"

#     # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
#     service_account = module.service_accounts_gke.email
#     oauth_scopes = [
#       "https://www.googleapis.com/auth/devstorage.read_only",
#       "https://www.googleapis.com/auth/ndev.clouddns.readwrite",
#       "https://www.googleapis.com/auth/service.management.readonly",
#       "https://www.googleapis.com/auth/logging.write",
#       "https://www.googleapis.com/auth/monitoring",
#       "https://www.googleapis.com/auth/servicecontrol",
#       "https://www.googleapis.com/auth/trace.append",
#       "https://www.googleapis.com/auth/devstorage.read_only",
#       "https://www.googleapis.com/auth/cloud-platform"
#     ]
#     # tags = [

#     # ]
#     labels = {
#       "App-Services" = true
#     }
#     # taint {
#     #   key = ""
#     #   value = ""
#     #   effect = ""
#     # }
#     #   workload_metadata_config = {
#     #   node_metadata = "${var.node_metadata}"
#     # }
#   }
# }

# resource "google_container_node_pool" "application_preemptible_nodes" {
#   count = var.create_application_preemtible ? 1 : 0

#   name               = format("%s-%s-node-pool-preemtible", var.application_np_preemtible_name, local.environment)
#   location           = module.gke.region
#   cluster            = module.gke.name
#   max_pods_per_node  = 110
#   version            = var.kubernetes_version
#   initial_node_count = var.application_np_preemtible_initial_node_count
#   node_locations     = var.application_np_preemtible_locations
#   autoscaling {
#     min_node_count = var.application_np_preemtible_min_count
#     max_node_count = var.application_np_preemtible_max_count
#   }

#   management {
#     auto_repair  = true
#     auto_upgrade = true
#   }

#   node_config {
#     preemptible     = var.application_np_preemtible_preemptive
#     machine_type    = var.application_np_preemtible_instance_type
#     local_ssd_count = 0
#     disk_size_gb    = var.application_np_preemtible_disk_size_gb
#     disk_type       = var.disk_type
#     image_type      = "COS_CONTAINERD"

#     # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
#     service_account = module.service_accounts_gke.email
#     oauth_scopes = [
#       "https://www.googleapis.com/auth/devstorage.read_only",
#       "https://www.googleapis.com/auth/ndev.clouddns.readwrite",
#       "https://www.googleapis.com/auth/service.management.readonly",
#       "https://www.googleapis.com/auth/logging.write",
#       "https://www.googleapis.com/auth/monitoring",
#       "https://www.googleapis.com/auth/servicecontrol",
#       "https://www.googleapis.com/auth/trace.append",
#       "https://www.googleapis.com/auth/devstorage.read_only",
#       "https://www.googleapis.com/auth/cloud-platform"
#     ]


#     labels = {
#       "App-Services"            = true,
#       "App-Services-Preemtible" = true
#     }
#     # taint {
#     #   key = ""
#     #   value = ""
#     #   effect = ""
#     # }
#     #   workload_metadata_config = {
#     #   node_metadata = "${var.node_metadata}"
#     # }
#   }
# }


# # Access the cluster
# resource "null_resource" "get_kubeconfig" {
#   depends_on = [module.gke]
#   count      = var.get_kubeconfig_enabled ? 1 : 0
#   provisioner "local-exec" {
#     command = "gcloud container clusters get-credentials ${module.gke.name} --region ${local.region} --project ${local.project}"
#   }
# }
