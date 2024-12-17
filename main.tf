resource "google_compute_address" "k8_master_ip" {
  name   = "k8-master-ip"
  region = var.region
}

resource "google_compute_instance" "k8_master" {
  name         = "k8-master"
  machine_type = var.instance_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.image
      size  = var.disk_size
    }
  }

  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.k8_master_ip.address
    }
  }

  metadata = {
    ssh-keys = join("\n", [for key in var.ssh_public_keys : "${var.ssh_user}:${key}"])
  }
  tags = ["k8s"] 
}

# VM for Kubernetes Worker Node 1
resource "google_compute_instance" "k8_worker1" {
  name         = "k8-worker1"
  machine_type = var.instance_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.image
      size  = var.disk_size
    }
  }

  network_interface {
    network = "default"
    access_config {
      // Dynamic IP
    }
  }

  metadata = {
    ssh-keys = join("\n", [for key in var.ssh_public_keys : "${var.ssh_user}:${key}"])
  }
  tags = ["k8s"] 
}

# VM for Kubernetes Worker Node 2
resource "google_compute_instance" "k8_worker2" {
  name         = "k8-worker2"
  machine_type = var.instance_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.image
      size  = var.disk_size
    }
  }

  network_interface {
    network = "default"
    access_config {
      // Dynamic IP
    }
  }

  metadata = {
    ssh-keys = join("\n", [for key in var.ssh_public_keys : "${var.ssh_user}:${key}"])
  }
  tags = ["k8s"] 
}

output "k8_master_ip" {
  value = google_compute_address.k8_master_ip.address
}

output "k8_worker_ips" {
  value = [
    google_compute_instance.k8_worker1.network_interface[0].access_config[0].nat_ip,
    google_compute_instance.k8_worker2.network_interface[0].access_config[0].nat_ip
  ]
}

output "ssh_user" {
  value = var.ssh_user
  
}