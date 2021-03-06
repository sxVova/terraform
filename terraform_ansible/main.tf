provider "google" {
  credentials = file("account.json")
  project     = "devops-259416"
  region      = "europe-west1"
  zone        = "europe-west1-b"
}


data "google_compute_image" "start_image" {
  family  = "ubuntu-1804-lts"
  project = "ubuntu-os-cloud"
}

resource "google_compute_address" "static" {
  name = "ipv4-address"
}

resource "google_dns_record_set" "sxvova" {
  name         = "ansible.sxvova.opensource-ukraine.org."
  type         = "A"
  ttl          = 300
  managed_zone = "sxvova"

  rrdatas = [google_compute_address.static.address]
}

resource "google_compute_instance" "web-server" {
  name         = "ansible-master"
  machine_type = "n1-standard-2"
  zone         = "europe-west1-b"
  boot_disk {
    initialize_params {
      image = data.google_compute_image.start_image.self_link
    }
  }
  metadata = {
    ssh-keys = "rasavo99:${file("~/.ssh/id_rsa.pub")}"
  }
  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.static.address
    }
  }
  provisioner "file" {
    source      = "~/.ssh/id_rsa"
    destination = ".ssh/id_rsa"
    connection {
      type        = "ssh"
      user        = "rasavo99"
      host        = google_compute_address.static.address
      private_key = file("~/.ssh/id_rsa")
    }
  }
}
