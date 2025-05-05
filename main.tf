provider "google" {
  project = var.project_id
  region  = var.region
}

module "gke" {
  source            = "./modules/gke"
  project_id        = var.project_id
  region            = var.region
  cluster_name      = var.cluster_name
  node_count        = var.node_count
  machine_type      = var.machine_type
  network           = module.network.network_name
  subnetwork        = module.network.subnetwork_name
}

module "network" {
  source     = "./modules/network"
  project_id = var.project_id
  region     = var.region
}