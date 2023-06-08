output "cluster_name" {
  description = "The name of the GKE cluster."
  value       = format("%s-%s-gke-cluster", var.cluster_name, local.env)
}

output "cluster_region" {
  description = "The region where the GKE cluster is located."
  value       = var.region
}

output "cluster_id" {
  description = "The unique ID of the GKE cluster."
  value       = module.gke.cluster_id
}
