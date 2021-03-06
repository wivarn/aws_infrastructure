variable "ssm_parameter_prefix" {
  description = "The prefix to give to all SSM params in this module"
}

variable "domain" {
  description = "the base domain"
}

variable "environment" {
  description = "Staging, production, dev, etc"
}
