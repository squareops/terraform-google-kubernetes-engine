output "kubernetes_endpoint" {
  description = "The cluster endpoint"
  sensitive   = true
  value       = module.gke.endpoint
}

output "client_token" {
  description = "The bearer token for auth"
  sensitive   = true
  value       = base64encode(data.google_client_config.default.access_token)
}

output "ca_certificate" {
  description = "The cluster ca certificate (base64 encoded)"
  value       = module.gke.ca_certificate
}

output "cluster_name" {
  description = "Cluster name"
  value       = module.gke.name
}

output "peering_name" {
  description = "The name of the peering between this cluster and the Google owned VPC."
  value       = module.gke.peering_name
}

output "cluster_region" {
  description = "The region where the GKE cluster is located."
  value       = var.region
}

output "service_accounts_gke" {
  value       = module.service_accounts_gke.email
  description = "The service account to default running nodes."
}
