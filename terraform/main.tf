# Configuración del proveedor Docker
provider "docker" {}

# terraform {
#  required_providers {
#    docker = {
#      source  = "kreuzwerker/docker"
#      version = "~> 3.0.1"
#    }
#  }
#}

provider "docker" {
  host    = "tcp://localhost:2375/"
}

resource "docker_image" "jenkins" {
  name          = "my-jenkins"
  build         = "./"
  dockerfile    = "Dockerfile"
}

resource "docker_container" "jenkins" {
  image         = docker_image.jenkins.latest
  name          = "jenkins-container"
  restart_policy = "always"
  ports {
    internal = 8080
    external = 8080
  }
}
