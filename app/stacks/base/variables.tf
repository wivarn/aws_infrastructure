variable "ssm_parameter_prefix" {
  description = "The prefix to give to all SSM params in this stack"
}

variable "domain" {
  description = "the base domain"
}

variable "environment" {
  description = "Staging, production, dev, etc"
}

variable "public_assets_bucket" {
  description = "The name of the public assets bucket"
}
