//ACM Cert and validation module
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.7.0"
      //configuration_aliases = [ aws.alternate ]
    }
  }
}

resource "aws_acm_certificate" "cert" {
  count = var.create_certificate ? 1 : 0

  domain_name               = var.domain_name
  subject_alternative_names = var.subject_alternative_names
  validation_method         = var.validation_method  
  tags                      = var.tags
  
  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_route53_record" "validation_record" {

  for_each = var.create_certificate && var.create_route53_records ? {
    for dvo in aws_acm_certificate.cert[0].domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }  
  } : {}

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = var.zone_id
}

resource "aws_acm_certificate_validation" "acm_validation" {
  count = var.create_certificate && var.create_route53_records && var.validate_certificate ? 1 : 0

  certificate_arn         = aws_acm_certificate.cert[0].arn
  validation_record_fqdns = [for record in aws_route53_record.validation_record : record.fqdn]
}
