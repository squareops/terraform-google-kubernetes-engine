output "cluster_name" {
  description = "The name of the GKE cluster."
  value       = module.gke.cluster_name
}

output "kubernetes_endpoint" {
  description = "The cluster endpoint"
  sensitive   = true
  value       = module.gke.kubernetes_endpoint
}

output "node_pool" {
  value       = module.managed_node_pool.node_pool
  description = "Details of node pools"
}
