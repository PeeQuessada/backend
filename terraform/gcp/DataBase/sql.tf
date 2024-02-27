# resource "google_compute_network" "private_network" {
#   provider = google-beta
#   name = "private-network"
# }

# resource "google_compute_global_address" "private_ip_address" {
#   provider = google-beta

#   name          = "private-ip-address"
#   purpose       = "VPC_PEERING"
#   address_type  = "INTERNAL"
#   prefix_length = 16
#   network       = google_compute_network.private_network.id
# }

# resource "google_service_networking_connection" "private_vpc_connection" {
#   provider = google-beta

#   network                 = google_compute_network.private_network.id
#   service                 = "servicenetworking.googleapis.com"
#   reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
# }

resource "google_sql_database_instance" "db-instance" {
  # provider = google-beta
  name                = "${var.prefix}-db-instance"
  region              = var.region
  project             = var.project_id
  database_version    = "POSTGRES_14"
  deletion_protection = false

  # depends_on = [google_service_networking_connection.private_vpc_connection]

  settings {
    tier = "db-f1-micro"
    # ip_configuration {
    #   ipv4_enabled                                  = false
    #   private_network                               = google_compute_network.private_network.id
    #   enable_private_path_for_google_cloud_services = true
    # }
    ip_configuration {
      ipv4_enabled = true # Ativado acesso público
      #   private_network = var.network_id
      
      authorized_networks {
        name = "local-ip"
        value = "179.94.178.144"
      }
      authorized_networks {
        name = "loadbalancer-ip"
        value = "34.27.206.29"
      }
      authorized_networks {
        name = "cluster-ip"
        value = "34.123.140.209"
      }

      authorized_networks {
        name = "public-ip"
        value = "0.0.0.0/0"
      }
    }
  }
}

resource "google_sql_database" "database" {
  name = "${var.prefix}-database"
  instance = google_sql_database_instance.db-instance.name
}

resource "google_sql_user" "db-user" {
  name = "${var.prefix}-db-user"
  instance = google_sql_database_instance.db-instance.name
  password = "admin"
}

output "host" {
  value = "${google_sql_database_instance.db-instance.public_ip_address}:///postgres?cloudSqlInstance=${google_sql_database_instance.db-instance.connection_name}"
  # value = "/cloudsql/${google_sql_database_instance.db-instance.connection_name}"
  # value = postgres://${google_sql_user.user.name}:${google_sql_user.user.password}@/${google_sql_database.database.name}?host=
}
output "database" {
  value = google_sql_database.database.name
}
output "username" {
  value = google_sql_user.db-user.name
}
output "port" {
  value = 5432
}

# Output para obter os valores de conexão
output "database_connection_info" {
  value = {
    host     = "/cloudsql/${google_sql_database_instance.db-instance.connection_name}"
    database = google_sql_database.database.name
    username = google_sql_user.db-user.name
    public_ip_address = google_sql_database_instance.db-instance.public_ip_address
  }
}