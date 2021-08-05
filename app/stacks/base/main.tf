<% if Terraspace.env != 'production' %>
module "vpc" {
  source = "../../modules/vpc"

  ssm_parameter_prefix = var.ssm_parameter_prefix
}

module "rds_instance" {
  source = "../../modules/rds_instance"

  db_subnet_group_name  = module.vpc.db_subnet_group_name
  rds_security_group_id = module.vpc.rds_security_group_id
  ssm_parameter_prefix  = var.ssm_parameter_prefix
}

module "s3" {
  source = "../../modules/s3"

  domain               = var.domain
  public_assets_bucket = var.public_assets_bucket
  ssm_parameter_prefix = var.ssm_parameter_prefix
}
<% end %>

module "route53" {
  source = "../../modules/route53"

  domain               = var.domain
  ssm_parameter_prefix = var.ssm_parameter_prefix
}

module "backend_parameters" {
  source = "../../modules/backend_parameters"

  domain               = var.domain
  ssm_parameter_prefix = var.ssm_parameter_prefix
}
