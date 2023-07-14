locals {
  region      = var.region
  project     = var.project_name
  environment = var.environment
}

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
    "${local.project}=>roles/artifactregistry.admin",
  ]
  display_name = format("%s-%s-gke-cluster Nodes Service Account", var.cluster_name, local.environment)
}

module "gke" {
  source                        = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  version                       = "27.0.0"
  project_id                    = local.project
  name                          = format("%s-%s-gke-cluster", var.cluster_name, local.environment)
  regional                      = var.regional
  region                        = local.region
  zones                         = var.zones
  network                       = var.vpc_name
  subnetwork                    = var.subnet
  master_global_access_enabled  = var.master_global_access_enabled
  ip_range_pods                 = var.ip_range_pods_name
  ip_range_services             = var.ip_range_services_name
  release_channel               = var.release_channel
  kubernetes_version            = var.kubernetes_version
  http_load_balancing           = false
  horizontal_pod_autoscaling    = true
  network_policy                = var.network_policy
  network_policy_provider       = var.network_policy_provider
  enable_private_endpoint       = var.enable_private_endpoint
  enable_private_nodes          = var.enable_private_nodes
  master_ipv4_cidr_block        = var.master_ipv4_cidr_block
  gke_backup_agent_config       = var.gke_backup_agent_config
  create_service_account        = false
  remove_default_node_pool      = var.remove_default_node_pool
  master_authorized_networks    = var.enable_private_endpoint ? [{ cidr_block = var.master_authorized_networks, display_name = "VPN IP" }] : []
  logging_service               = var.logging_service
  logging_enabled_components    = var.logging_enabled_components
  monitoring_service            = var.monitoring_service
  monitoring_enabled_components = var.monitoring_enabled_components
  cluster_resource_labels       = var.cluster_resource_labels
  node_pools = [
    {
      name               = format("%s-%s-node-pool", var.default_np_name, local.environment)
      machine_type       = var.default_np_instance_type
      node_locations     = var.default_np_locations
      min_count          = var.default_np_min_count
      max_count          = var.default_np_max_count
      local_ssd_count    = 0
      disk_size_gb       = var.default_np_disk_size_gb
      enable_secure_boot = var.enable_secure_boot
      disk_type          = var.disk_type
      image_type         = "COS_CONTAINERD"
      auto_repair        = true
      auto_upgrade       = true
      preemptible        = var.default_np_preemptible
      initial_node_count = var.default_np_initial_node_count
      service_account    = module.service_accounts_gke.email
    },
  ]

  node_pools_oauth_scopes = var.node_pools_oauth_scopes

  node_pools_labels = {
    all = {}

    format("%s-%s-node-pool", var.default_np_name, local.environment) = {
      "Infra-Services" = true
    }
  }

  node_pools_metadata = {
    all = {}
  }

  node_pools_taints = {
    all = []
  }

  node_pools_tags = {
    all = []
  }
}
