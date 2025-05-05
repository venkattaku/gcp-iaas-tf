output "cluster_endpoint" {
  description = "The endpoint of the GKE cluster"
  value       = module.gke.endpoint
}

output "cluster_name" {
  description = "The name of the GKE cluster"
  value       = module.gke.cluster_name
}