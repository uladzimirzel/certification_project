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

  metadata = {
    ssh-keys = <<EOF
    root: ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDfPznW66aLU39FXRzzAZQsZeCv0Fni3CY/LAijT7gbzieTPZBk+TOuLhNsU34Sv/6AfmDeSTzIxNGlyoGh6rELz2AOkNxTCZq3raTyzbt1i6085i3grx8lUVScWyjai+wHW/b0cLYEypAihNi16K73yOGmQPKxKWjEZ7CDlo4TkgXkjvkC9KWjQPSEboaupP/DO9yO9ZJ+SQGQmzoKFrMb7+B15LQ8d8E2H0H1t7XpM8lo6h6Npfboe/VSg5lHMC4jP9C3uRdRGEL1BO3NhB8bGDKFKHUGpKukrAasZpmZWQGzttu432E+KY1B3LUr2BNLGpe5QWaIejpE9hsw0emN5trY66TnNY6cvi0gJnA8yc7Mi5Pmjei0/u0br98dUSINsk1fmB3c1wa91TzGAnIZLr+UQF0FgzulbblSJ7jv4Tjoz91S2LR98Iof0a0/843RaPxJL7n2mppOojCRJnHeOsrZ+hId9M+/mgs3vgUMNAB6xRtHBZas9fO8aup1QI0= root@jenkins
    jenkins: ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDB4LY/pIZRp5eehRlMMISHV2szjwapbJGeyTB1ykp/BV9rC0u6QqB7xHVD+mzgPg2+9tPexEf7lCbOz6ONGwf4b8vZ1lXN0dH3ASJsjGmSpazLrOnowGig0m96Bs8hAl6ZreThU7YIgnNxaIHr6nNTCKegrtJ7fsj2+oqvYrXK4LBc/s6s08LC7FAT/JZfOD/PKtnF7ajZLpP2WAi3upKSZHbWAOpgTn6dhc33I5LBQ73lyobDVM0bPkZcFE/XzcRX4n/rfjYMFPwmkloQwh22ghqUAAl34z3Jl9hyQTrY8F9q02b28m6LNBKeacqg+m2pJMS+88vjfkxE0NW9Z8GfdTIflbDmwwiV2gVFGSV5T/yEd1Vzr8/uhTVJooybfjSUNgsgGfH4u/0aiLX+WbjhoTP8n3JsQXG5BIjsdQo7TLtPkHCtxiqpqrG0eVsX3JmFfmvvJE5Mny5O5tnjxAYSwIVeHBBrzh/hnKIRDyLXu8lget6AUrE2y4oDugfiQxs= jenkins@jenkins
        EOF
  }
}



resource "null_resource" "build_instance" {
    depends_on = [ google_compute_instance.build_instance ]

provisioner "remote-exec" {
    inline = [
      "apt update && apt install default-jdk -y",
      "apt install docker.io -y && apt install git -y",
      "apt install ansible -y && apt install python3-docker -y",
      "git clone https://github.com/uladzimirzel/certification_project.git /root/certification_project",
      "cd /root/certification_project",
      "ansible-playbook ansible-playbook.yml"
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

  metadata = {
    ssh-keys = <<EOF
    root: ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDfPznW66aLU39FXRzzAZQsZeCv0Fni3CY/LAijT7gbzieTPZBk+TOuLhNsU34Sv/6AfmDeSTzIxNGlyoGh6rELz2AOkNxTCZq3raTyzbt1i6085i3grx8lUVScWyjai+wHW/b0cLYEypAihNi16K73yOGmQPKxKWjEZ7CDlo4TkgXkjvkC9KWjQPSEboaupP/DO9yO9ZJ+SQGQmzoKFrMb7+B15LQ8d8E2H0H1t7XpM8lo6h6Npfboe/VSg5lHMC4jP9C3uRdRGEL1BO3NhB8bGDKFKHUGpKukrAasZpmZWQGzttu432E+KY1B3LUr2BNLGpe5QWaIejpE9hsw0emN5trY66TnNY6cvi0gJnA8yc7Mi5Pmjei0/u0br98dUSINsk1fmB3c1wa91TzGAnIZLr+UQF0FgzulbblSJ7jv4Tjoz91S2LR98Iof0a0/843RaPxJL7n2mppOojCRJnHeOsrZ+hId9M+/mgs3vgUMNAB6xRtHBZas9fO8aup1QI0= root@jenkins
    jenkins: ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDB4LY/pIZRp5eehRlMMISHV2szjwapbJGeyTB1ykp/BV9rC0u6QqB7xHVD+mzgPg2+9tPexEf7lCbOz6ONGwf4b8vZ1lXN0dH3ASJsjGmSpazLrOnowGig0m96Bs8hAl6ZreThU7YIgnNxaIHr6nNTCKegrtJ7fsj2+oqvYrXK4LBc/s6s08LC7FAT/JZfOD/PKtnF7ajZLpP2WAi3upKSZHbWAOpgTn6dhc33I5LBQ73lyobDVM0bPkZcFE/XzcRX4n/rfjYMFPwmkloQwh22ghqUAAl34z3Jl9hyQTrY8F9q02b28m6LNBKeacqg+m2pJMS+88vjfkxE0NW9Z8GfdTIflbDmwwiV2gVFGSV5T/yEd1Vzr8/uhTVJooybfjSUNgsgGfH4u/0aiLX+WbjhoTP8n3JsQXG5BIjsdQo7TLtPkHCtxiqpqrG0eVsX3JmFfmvvJE5Mny5O5tnjxAYSwIVeHBBrzh/hnKIRDyLXu8lget6AUrE2y4oDugfiQxs= jenkins@jenkins
        EOF
  }
}

resource "null_resource" "stage_instance" {
    depends_on = [ google_compute_instance.stage_instance ]

    provisioner "remote-exec" {
    inline = [
      "apt update && apt install default-jdk -y",
      "apt install docker.io -y",
      "echo '{\"insecure-registries\":[\"34.116.192.152:8123\"]}' > /etc/docker/daemon.json",
      "systemctl restart docker"
    ]

    connection {
      type        = "ssh"
      user        = "root"
      private_key = file("/root/.ssh/id_rsa")
      host        = google_compute_instance.stage_instance.network_interface[0].access_config[0].nat_ip
     }
   }
}