provider "google" {
  credentials = file("account.json")
  project     = "devops-259416"
  region      = "europe-west3"
  zone        = "europe-west3-c"
}


resource "google_compute_address" "static" {
  name = "ipv4-address"
}

resource "google_dns_record_set" "sxvova" {
  name         = "sentry.sxvova.opensource-ukraine.org."
  type         = "A"
  ttl          = 300
  managed_zone = "sxvova"

  rrdatas = [google_compute_address.static.address]
}


data "google_compute_image" "start_image" {
  family  = "ubuntu-1804-lts"
  project = "ubuntu-os-cloud"
}


resource "google_compute_instance" "web-server" {
  name                    = "sentry"
  machine_type            = "n1-standard-2"
  zone                    = "europe-west3-c"
  tags                    = ["http-server", "https-server"]
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
}
