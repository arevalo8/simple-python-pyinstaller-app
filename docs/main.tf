# Configuración del proveedor Docker
provider "docker" {
  host = "unix:///var/run/docker.sock"
}

# Recurso para construir la imagen de Docker
resource "docker_image" "jenkins" {
  name = "my-jenkins"

  build {
    context    = "./"
    dockerfile = "Dockerfile"
  }
}

# Recurso para crear el contenedor Docker a partir de la imagen
resource "docker_container" "jenkins" {
  image = docker_image.jenkins.name
  name  = "jenkins-container"

  ports {
    internal = 8080
    external = 8080
  }
}
