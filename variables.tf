
variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
  default = "us-central1"
}

variable "zone" {
  description = "The GCP zone"
  type        = string
  default = "us-central1-a"
}

variable "instance_type" {
  description = "The instance type"
  type        = string
  default = "n2d-standard-2"
}

variable "image" {
  description = "The image to boot the instance"
  type        = string
  default = "rocky-linux-9"
}

variable "disk_size" {
  description = "The disk size in GB"
  type        = number
  default = 100
}

variable "ssh_public_key" {
  description = "The SSH public key to access the instances"
  type        = string
}