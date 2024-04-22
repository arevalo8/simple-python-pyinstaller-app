# variables.tf - Archivo de variables de Terraform

variable "jenkins_container_name" {
  description = "Nombre del contenedor de Jenkins"
  type        = string
  default     = "jenkins"
}

variable "dind_container_name" {
  description = "Nombre del contenedor de Docker in Docker"
  type        = string
  default     = "dind"
}

variable "jenkins_image" {
  description = "Imagen Docker para Jenkins"
  type        = string
  default     = "jenkins/jenkins:lts"
}

variable "dind_image" {
  description = "Imagen Docker para Docker in Docker"
  type        = string
  default     = "docker:dind"
}
