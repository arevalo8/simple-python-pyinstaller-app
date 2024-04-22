# variables.tf
variable "docker_host" {
  description = "The Docker host URL"
  type        = string
  default     = "tcp://localhost:2375/"
}
