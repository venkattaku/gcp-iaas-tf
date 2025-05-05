resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.region
  # Set to false to allow Terraform to delete the cluster
  deletion_protection = false 

  network    = var.network
  subnetwork = var.subnetwork

  node_config {
    machine_type = var.machine_type
  }

  initial_node_count = var.node_count
}

output "endpoint" {
  value = google_container_cluster.primary.endpoint
}

output "cluster_name" {
  value = google_container_cluster.primary.name
}