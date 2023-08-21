# このコードは、Terraform 4.25.0、および 4.25.0 と後方互換性があるバージョンと互換性があります。# この Terraform コードの検証については、https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/google-cloud-platform-build#format-and-validate-the-configuration をご覧ください
# 9$~11$

resource "google_compute_instance" "instance-beaver" {
  boot_disk {
    auto_delete = true
    device_name = "instance-beaver"

    initialize_params {
      image = "projects/debian-cloud/global/images/debian-11-bullseye-v20230814"
      size  = 30
      type  = "pd-balanced"
    }

    mode = "READ_WRITE"
  }

  can_ip_forward      = false
  deletion_protection = false
  enable_display      = false

  labels = {
    goog-ec-src = "vm_add-tf"
  }

  machine_type = "e2-micro"
  name         = "instance-beaver"

  network_interface {
    access_config {
      network_tier = "PREMIUM"
    }

    subnetwork = "projects/project-beaver-396601/regions/us-west1/subnetworks/default"
  }

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
    preemptible         = false
    provisioning_model  = "STANDARD"
  }

  service_account {
    email  = "148956278765-compute@developer.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring.write", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/trace.append"]
  }

  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_secure_boot          = false
    enable_vtpm                 = true
  }

  tags = ["http-server", "https-server"]
  zone = "us-west1-a"
}
