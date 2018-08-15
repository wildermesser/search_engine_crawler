provider "google" {
  project = "${var.project}"
  region  = "${var.region}"
  version = "1.16"
}

resource "google_dns_managed_zone" "ocrawler" {
  name     = "ocrawler"
  dns_name = "ocrawler.tk."
}

module "production" {
  source        = "github.com/wildermesser/dockerinstance"
  instance_name = "${var.instance_name}"

  public_key_path   = "${var.public_key_path}"
  private_key_path  = "${var.private_key_path}"
  zone              = "${var.zone}"
  disk_image        = "${var.disk_image}"
  disk_size         = "10"
  machine_type      = "${var.machine_type}"
  dns_zone_name     = "ocrawler.tk."
  managed_zone_name = "ocrawler"
  tcp_ports         = ["22", "8000"]
  files_dir         = "../docker-compose.yml"

  remote_commands = [
    "cd ~",
    "sudo chgrp -R ubuntu /var/lib/docker/containers",
    "sudo chmod -R g+rx /var/lib/docker/containers",
    "sudo chown ubuntu filebeat.conf",
    "sudo docker-compose up -d",
  ]
}