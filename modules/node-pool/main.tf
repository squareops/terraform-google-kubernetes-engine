resource "google_container_node_pool" "node_pool" {
  name               = format("%s-%s-node-pool", var.name, var.environment)
  location           = var.location
  cluster            = var.cluster_name
  max_pods_per_node  = 110
  version            = var.kubernetes_version
  initial_node_count = var.initial_node_count
  node_locations     = var.node_locations
  autoscaling {
    min_node_count = var.min_count
    max_node_count = var.max_count
  }

  upgrade_settings {
    max_surge       = var.max_surge
    max_unavailable = var.max_unavailable
  }

  lifecycle {
    ignore_changes = [initial_node_count]
  }
  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    preemptible     = var.preemptible
    machine_type    = var.instance_type
    disk_size_gb    = var.disk_size_gb
    disk_type       = var.disk_type
    image_type      = "COS_CONTAINERD"

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = var.service_account
    oauth_scopes = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/ndev.clouddns.readwrite",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/trace.append",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/cloud-platform"
    ]
    tags = var.tags
    labels = var.labels
    metadata = ({
      # From GKE 1.12 onwards, disable-legacy-endpoints is set to true by the API;
      # if metadata is set but that default value is not included, Terraform will attempt to unset the value.
      # To avoid this, set the value in your config.
      "disable-legacy-endpoints" = true
    })
    # taint {
    #   key = ""
    #   value = ""
    #   effect = ""
    # }
    #   workload_metadata_config = {
    #   node_metadata = "${var.node_metadata}"
    # }

  }
}