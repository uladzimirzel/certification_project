terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.13.0"
    }
  }
}

provider "google" {
  credentials = file("/var/lib/jenkins/peppy-web-405812-49c67ecba27f.json")
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
      size = "25"
      type = "pd-ssd"
    }
  }

  network_interface {
    network = "default"
    access_config {

    }
  }

  service_account {
    email = "jenkins@peppy-web-405812.iam.gserviceaccount.com"
    scopes = ["compute-ro", "storage-ro"]
  }
}

resource "null_resource" "build_instance" {
    depends_on = [ google_compute_instance.build_instance ]

provisioner "remote-exec" {
    inline = [
      "apt update && apt install docker.io -y",
      "apt install git -y",
      "apt install ansible -y && apt install python3-docker -y",
      "yes | gcloud auth configure-docker europe-central2-docker.pkg.dev",
      "docker login https://europe-central2-docker.pkg.dev/peppy-web-405812/my-docker"
    ]

    connection {
      type        = "ssh"
      user        = "root"
      private_key = file("/root/.ssh/id_rsa")
      host        = google_compute_instance.build_instance.network_interface[0].access_config[0].nat_ip
    }
  }
}

resource "google_compute_instance" "stage_instance" {
  name         = "stage"
  machine_type = "n1-standard-1"
  zone         = "europe-central2-a"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
      size = "25"
      type = "pd-ssd"
    }
  }

  network_interface {
    network = "default"
    access_config {

    }
  }

  service_account {
    email = "jenkins@peppy-web-405812.iam.gserviceaccount.com"
    scopes = ["compute-ro", "storage-ro"]
  }
}

resource "null_resource" "stage_instance" {
    depends_on = [ google_compute_instance.stage_instance ]

    provisioner "remote-exec" {
    inline = [
      "apt update && apt install docker.io -y",
      "apt install git -y",
      "apt install ansible -y && apt install python3-docker -y",
      "yes | gcloud auth configure-docker europe-central2-docker.pkg.dev",
      "docker login https://europe-central2-docker.pkg.dev/peppy-web-405812/my-docker"
    ]

    connection {
      type        = "ssh"
      user        = "root"
      private_key = file("/root/.ssh/id_rsa")
      host        = google_compute_instance.stage_instance.network_interface[0].access_config[0].nat_ip
     }
   }
}