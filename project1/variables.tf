variable "access_key" {
  description = "The access key for the lab environment"
  type = string
}

variable "secret_key" {
  description = "Secret for the lab environment"
}

variable "server_port" {
  description = "The port server will use for HTTP requests"
  type = number
}