//route53 module
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.7.0"
    }
  }
}

resource "aws_route53_zone" "main" {
  count = var.create_main_hosted_zone ? 1 : 0

  name = var.main_domain_name
}

data "aws_route53_zone" "main" {
  count = var.enable_data_source_main_zone ? 1 : 0

  name         = var.main_domain_name
  private_zone = false
}

resource "aws_route53_zone" "subdomain" {
  count = var.create_subdomain_hosted_zone ? 1 : 0

  name = var.subdomain_name

  tags = var.tags
}

resource "aws_route53_record" "ns" {
  count = var.create_subdomain_hosted_zone && var.create_ns_records ? 1 : 0

  zone_id = var.enable_data_source_main_zone ? data.aws_route53_zone.main[0].zone_id : aws_route53_zone.main[0].zone_id
  name    = var.subdomain_name
  type    = "NS"
  ttl     = "30"
  records = aws_route53_zone.subdomain[0].name_servers
}

resource "aws_route53_record" "alias" {
  count = var.create_subdomain_hosted_zone && var.create_alias_records ? 1 : 0

  zone_id = aws_route53_zone.subdomain[0].zone_id
  name    = var.subdomain_name
  type    = "A"
  alias {
    name                   = var.alias_name
    zone_id                = var.alias_zone_id
    evaluate_target_health = var.alias_evaluate_target_health
  }
}
