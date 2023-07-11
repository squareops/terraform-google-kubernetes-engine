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
    preemptible       = var.preemptible
    machine_type      = var.instance_type
    disk_size_gb      = var.disk_size_gb
    disk_type         = var.disk_type
    image_type        = "COS_CONTAINERD"
    boot_disk_kms_key = var.boot_disk_kms_key
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = var.service_account
    oauth_scopes    = var.oauth_scopes
    tags            = var.tags
    labels          = var.labels
    metadata = ({
      "disable-legacy-endpoints" = true
    })
    dynamic "taint" {
      for_each = concat(
        local.node_pools_taints["all"],
      )
      content {
        effect = taint.value.effect
        key    = taint.value.key
        value  = taint.value.value
      }
    }
    #   workload_metadata_config = {
    #   node_metadata = "${var.node_metadata}"
    # }

  }
}
