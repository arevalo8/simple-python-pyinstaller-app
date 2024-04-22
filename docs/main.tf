provider "docker" {
  host = "tcp://localhost:2375/"
}

resource "docker_image" "jenkins" {
  name = "your-custom-jenkins-image:latest"
  keep_locally = false
}

resource "docker_container" "jenkins" {
  name = "jenkins-container"
  image = docker_image.jenkins.latest
  ports {
    internal = 8080
    external = 8080
  }
  restart = "always"
}
