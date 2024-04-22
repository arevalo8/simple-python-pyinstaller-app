terraform {
	required_providers {
		docker = {
			source = "kreuzwerker/docker"
			version = "~> 3.0.1"
		}
	}
}		

provider "docker" {}

resource "docker_image" "jenkins" {
  name = "your-custom-jenkins-image:latest"
  keep_locally = false
}

resource "docker_container" "jenkins" {
  name  = "jenkins_container"
  image = "jenkins"
  ports {
    internal = 8080
    external = 8080
  }
}

