terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.13.0"
    }
  }
}

provider "google" {
  credentials = file("peppy-web-405812-a619da06f4f1.json")
  project     = "peppy-web-405812"
  region      = "europe-central2-a"
}

resource "google_compute_instance" "build_instance" {
  name         = "build"
  machine_type = "n1-standard-1"
  zone         = "europe-central2-a"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  network_interface {
    network = "default"
    access_config {

    }
  }

  metadata_startup_script = <<-EOF
    #!/bin/bash
    useradd -m -s /bin/bash bobzo
    usermod -aG sudo bobzo
    echo 'bobzo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
    mkdir -p /home/bobzo/.ssh
    echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC02+21UT4kT9XyzpWB9W06dGi63onnJ0+0zuGZl/acAqniZh+DEn5YOj8+a5TthedteRm2cOWz/lzm2SV6/L2g/I6XgF94fRnYnXA7ecGKZIgN1QOqGUL26mHeyL8QWzysMHKbL73313IttU6Vj4W0E90p+OA6WbzeucRKWhdanISqE4LRAGuY9NQAJj1xi3zo+zqRfvRTJvGqFwZ3fpcAcVa8OSJstdj21I33elm7DDehg2BMqgRI+rDlBUbs7rhSwWsBlHQxZRTyqS9Qg9hPKKo+fM5GjKxoliAiE5JSVTqHN6UriuCQYopYRQvycNMTWdd7HZFQ2NHsJxBkpwME62xdAwxfknnf0p0ehr1Uap6PilxEKkRKdHEcQf+2I45r470aTRrQpZ9XhMUtyeBsmY2lvsz93esaBtN8KZZaHOTu1Tfuzm9aq+0D9pJeY6+meIypQQD82S3R13R4eHrSpbOpjNvDy4Wuy0MVKfmn+sjZ3K3MyIF5WDqBHnoG5O0= bobzo@terraform" >> /home/bobzo/.ssh/authorized_keys
    chown -R bobzo: /home/bobzo/.ssh
    chmod 700 /home/bobzo/.ssh
    chmod 600 /home/bobzo/.ssh/authorized_keys
    gcloud auth configure-docker europe-central2-docker.pkg.dev -y
  EOF
}
