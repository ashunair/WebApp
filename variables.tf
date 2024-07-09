variable "region" {
  description = "The region to deploy resources"
  default     = "us-central1-a"
}

variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "cluster_name" {
  description = "The name of the GKE cluster"
  default     = "ashu-cloud"
}
