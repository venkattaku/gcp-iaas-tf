data "google_compute_networks" "existing_vpc" {
  name = "gke-vpc-network" # Replace with your VPC name
}

resource "google_compute_network" "vpc_network" {
  # Create a new VPC network if it doesn't exist
  count = data.google_compute_networks.existing_vpc.items.length == 0 ? 1 : 0

  name = "gke-vpc-network"
}

resource "google_compute_subnetwork" "subnetwork" {
  name          = "gke-subnetwork"
  ip_cidr_range = "10.0.0.0/16"
  region        = var.region
  network       = google_compute_network.vpc_network.id
}

output "network_name" {
  value = google_compute_network.vpc_network.name
}

output "subnetwork_name" {
  value = google_compute_subnetwork.subnetwork.name
}