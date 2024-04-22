# Configuración del proveedor Docker
provider "docker" {}

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}


# Creación de la red Docker
resource "docker_network" "wordpress_network" {
  name = "wordpress_network"
}

# Creación del volumen para la base de datos
resource "docker_volume" "db_volume" {
  name = "db_volume"
}

# Creación del contenedor de la base de datos MariaDB
resource "docker_container" "mariadb" {
  image = "mariadb:latest"
  name  = "mariadb_container"
  #networks_advanced {
  #  name = docker_network.wordpress_network.name
  #}
  restart = "unless-stopped"
  env = [
    "MYSQL_ROOT_PASSWORD=${var.db_root_password}",
    "MYSQL_DATABASE=${var.wordpress_db_name}",
    "MYSQL_USER=${var.wordpress_db_user}",
    "MYSQL_PASSWORD=${var.wordpress_db_password}"
  ]
  volumes {
    volume_name    = docker_volume.db_volume.name
    container_path = "/var/lib/mysql"
  }
}



# Creación del contenedor de la aplicación Wordpress
resource "docker_container" "wordpress" {
  image = "wordpress:latest"
  name  = "wordpress_container"
  ports {
    internal = 80
    external = 8000
  }
  #networks_advanced {
  #  name = docker_network.wordpress_network.name
  #}
  restart = "unless-stopped"
  env = [
    "WORDPRESS_DB_USER=${var.wordpress_db_user}",
    "WORDPRESS_DB_PASSWORD=${var.wordpress_db_password}"
  ]
}
