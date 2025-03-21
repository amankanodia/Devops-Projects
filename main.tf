provider "google" {
  project = "your-project-id"
  region  = "asia-south1"
}

resource "google_compute_instance" "nse_app" {
  name         = "nse-data-app"
  machine_type = "e2-micro"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }
  network_interface {
    network = "default"
    access_config {}
  }
}