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

  metadata = {
    ssh-keys = <<EOF
    root: ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDfPznW66aLU39FXRzzAZQsZeCv0Fni3CY/LAijT7gbzieTPZBk+TOuLhNsU34Sv/6AfmDeSTzIxNGlyoGh6rELz2AOkNxTCZq3raTyzbt1i6085i3grx8lUVScWyjai+wHW/b0cLYEypAihNi16K73yOGmQPKxKWjEZ7CDlo4TkgXkjvkC9KWjQPSEboaupP/DO9yO9ZJ+SQGQmzoKFrMb7+B15LQ8d8E2H0H1t7XpM8lo6h6Npfboe/VSg5lHMC4jP9C3uRdRGEL1BO3NhB8bGDKFKHUGpKukrAasZpmZWQGzttu432E+KY1B3LUr2BNLGpe5QWaIejpE9hsw0emN5trY66TnNY6cvi0gJnA8yc7Mi5Pmjei0/u0br98dUSINsk1fmB3c1wa91TzGAnIZLr+UQF0FgzulbblSJ7jv4Tjoz91S2LR98Iof0a0/843RaPxJL7n2mppOojCRJnHeOsrZ+hId9M+/mgs3vgUMNAB6xRtHBZas9fO8aup1QI0= root@jenkins
        EOF
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

  metadata = {
    ssh-keys = <<EOF
    root: ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDfPznW66aLU39FXRzzAZQsZeCv0Fni3CY/LAijT7gbzieTPZBk+TOuLhNsU34Sv/6AfmDeSTzIxNGlyoGh6rELz2AOkNxTCZq3raTyzbt1i6085i3grx8lUVScWyjai+wHW/b0cLYEypAihNi16K73yOGmQPKxKWjEZ7CDlo4TkgXkjvkC9KWjQPSEboaupP/DO9yO9ZJ+SQGQmzoKFrMb7+B15LQ8d8E2H0H1t7XpM8lo6h6Npfboe/VSg5lHMC4jP9C3uRdRGEL1BO3NhB8bGDKFKHUGpKukrAasZpmZWQGzttu432E+KY1B3LUr2BNLGpe5QWaIejpE9hsw0emN5trY66TnNY6cvi0gJnA8yc7Mi5Pmjei0/u0br98dUSINsk1fmB3c1wa91TzGAnIZLr+UQF0FgzulbblSJ7jv4Tjoz91S2LR98Iof0a0/843RaPxJL7n2mppOojCRJnHeOsrZ+hId9M+/mgs3vgUMNAB6xRtHBZas9fO8aup1QI0= root@jenkins
        EOF
  }
}