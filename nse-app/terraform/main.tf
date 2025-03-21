provider "google" {
  project     = "your-gcp-project-id"
  region      = "asia-south1"
  credentials = file("credentials.json") # Path to your GCP service account key
}

resource "google_compute_instance" "nse_app" {
  name         = "nse-data-vm"
  machine_type = "e2-micro"
  zone         = "asia-south1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
    access_config {} # Assign public IP
  }

  metadata_startup_script = <<-EOF
    sudo apt-get update
    sudo apt-get install -y python3-pip
    pip3 install -r /home/nse-app/backend/requirements.txt
    python3 /home/nse-app/backend/app.py &
  EOF

  tags = ["http-server"]
}

resource "google_compute_firewall" "allow_http" {
  name    = "allow-http-8080"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }

  source_ranges = ["0.0.0.0/0"]
}