# Configuración del proveedor Docker
provider "docker" {
  host = "unix:///var/run/docker.sock"
}

resource "docker_image" "jenkins" {
  name   = "my-jenkins"
  build {
    context    = "./"
    dockerfile = "Dockerfile"
  }
}

resource "docker_container" "jenkins" {
  image = docker_image.jenkins.name  # Utiliza el atributo "name"
  name  = "jenkins-container"
  ports {
    internal = 8080
    external = 8080
  }
}
