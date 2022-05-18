variable "project_id" {
  description = "project id"
  default     = "pweb-idp"
}

variable "region" {
  description = "region"
  default     = "us-central1"
}

variable "location" {
  description = "location"
  default     = "us-central1-a"
}

provider "google" {
  project     = var.project_id
  region      = var.region
  credentials = var.gcp_credentials
}

# VPC
resource "google_compute_network" "vpc" {
  name                    = "${var.project_id}-vpc"
  auto_create_subnetworks = "false"
}

# Subnet
resource "google_compute_subnetwork" "subnet" {
  name          = "${var.project_id}-subnet"
  region        = var.region
  network       = google_compute_network.vpc.name
  ip_cidr_range = "10.10.0.0/24"
}

resource "google_compute_address" "public_lb_ip" {
  name   = "lb-ip"
  region = var.region
}
