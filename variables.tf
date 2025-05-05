variable "project_id" {
  description = "The ID of the GCP project"
  type        = string
}

variable "region" {
  description = "The region to deploy resources"
  type        = string
  default     = "us-central1"
}

variable "cluster_name" {
  description = "The name of the GKE cluster"
  type        = string
  default     = "my-gke-cluster"
}

variable "node_count" {
  description = "The number of nodes in the cluster"
  type        = number
  default     = 3
}

variable "machine_type" {
  description = "The machine type for the cluster nodes"
  type        = string
  default     = "e2-medium"
}