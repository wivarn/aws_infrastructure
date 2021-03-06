resource "aws_acm_certificate" "api_domain_cert" {
  domain_name       = "api.${var.domain}"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "api_domain_cert" {
  for_each = {
    for dvo in aws_acm_certificate.api_domain_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.zone.zone_id
}

resource "aws_acm_certificate_validation" "api_domain_cert" {
  certificate_arn         = aws_acm_certificate.api_domain_cert.arn
  validation_record_fqdns = [for record in aws_route53_record.api_domain_cert : record.fqdn]
}

resource "aws_ssm_parameter" "api_domain_cert_arn" {
  name        = "${var.ssm_parameter_prefix}API_DOMAIN_CERT_ARN"
  description = "ARN of the api subdomain cert"
  type        = "String"
  value       = aws_acm_certificate.api_domain_cert.arn
}
