# Create a VPC network
resource "google_compute_network" "vpc" {
  name                    = "${var.project_id}-${var.zone}-vpc"
  auto_create_subnetworks = false
  description             = "Compute Network by Terraform"
  routing_mode            = "REGIONAL"
  project                 = var.project_id
}

resource "google_compute_subnetwork" "subnet" {
  name          = "${var.project_id}-${var.zone}-subnet"
  network       = google_compute_network.vpc.id
  ip_cidr_range = "10.0.0.0/16"
  region        = var.region
}

resource "google_compute_router" "router" {
  name    = "${var.prefix}-${var.zone}-router"
  region  = google_compute_subnetwork.subnet.region
  network = google_compute_network.vpc.id

  bgp {
    asn = 64514
  }
}

resource "google_compute_router_nat" "nat" {
  name                               = "${var.project_id}-${var.zone}-nat"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}

# resource "google_compute_health_check" "hc" {
#   name               = "proxy-health-check"
#   check_interval_sec = 1
#   timeout_sec        = 1

#   tcp_health_check {
#     port = "80"
#   }
# }

# resource "google_compute_network_peering" "peering1" {
#   provider     = google-beta
#   name         = "peering-producer-to-consumer"
#   network      = google_compute_network.vpc.id
#   peer_network = google_compute_network.vpc.id
# }

# resource "google_compute_region_backend_service" "backend" {
#   provider      = google-beta
#   name          = "compute-backend"
#   region        = var.region
#   health_checks = [google_compute_health_check.hc.id]
# }

# resource "google_compute_forwarding_rule" "default" {
#   provider = google-beta
#   name     = "compute-forwarding-rule"
#   region   = var.region

#   load_balancing_scheme = "INTERNAL"
#   backend_service       = google_compute_region_backend_service.backend.id
#   all_ports             = true
#   network               = google_compute_network.vpc.name
#   subnetwork            = google_compute_subnetwork.subnet.name
# }

# resource "google_compute_route" "route-ilb" {
#   provider     = google-beta
#   name         = "route-ilb"
#   dest_range   = "0.0.0.0/0"
#   network      = google_compute_network.vpc.name
#   next_hop_ilb = google_compute_forwarding_rule.default.ip_address
#   priority     = 2000
#   tags         = ["tag1", "tag2"]

#   depends_on = [
#     google_compute_network_peering.peering1
#   ]
# }