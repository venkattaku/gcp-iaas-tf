data "google_compute_network" "existing_vpc" {
  name = "gke-vpc-network" # Replace with your VPC name
}

resource "google_compute_network" "vpc_network" {
  # Create a new VPC network if it doesn't exist
  count = data.google_compute_network.existing_vpc.id == "" ? 1 : 0

  name = "gke-vpc-network"
}

data "google_compute_subnetwork" "existing_subnetwork" {
  name = "gke-subnetwork" # Replace with your subnetwork
}

resource "google_compute_subnetwork" "subnetwork" {
  # Create a new VPC network if it doesn't exist
  count = data.google_compute_subnetwork.existing_subnetwork.id == "" ? 1 : 0

  name          = "gke-subnetwork"
  ip_cidr_range = "10.0.0.0/16"
  region        = var.region
  network       = coalesce(
    length(google_compute_network.vpc_network) > 0 ? google_compute_network.vpc_network[0].id : null,
    data.google_compute_network.existing_vpc.id
  )
}

output "network_name" {
  value = coalesce(
    length(google_compute_network.vpc_network) > 0 ? google_compute_network.vpc_network[0].name : null,
    data.google_compute_network.existing_vpc.name
  )
}

output "subnetwork_name" {
  value = coalesce(
    length(google_compute_subnetwork.subnetwork) > 0 ? google_compute_subnetwork.subnetwork[0].name : null,
    data.google_compute_subnetwork.existing_subnetwork.name
  )
}