# Output variable definitions

output "main_domain_zone_id" {
  description = "Zone ID of main domain Route53 zone"
  value       = var.enable_data_source_main_zone ? data.aws_route53_zone.main[0].zone_id : aws_route53_zone.main[0].zone_id
}

output "main_domain_zone_name_servers" {
  description = "Name servers of main domain Route53 zone"
  value       = var.enable_data_source_main_zone ? data.aws_route53_zone.main[0].name_servers : aws_route53_zone.main[0].name_servers
}

output "main_domain_zone_arn" {
  description = "ARN of main domain Route53 zone"
  value       = var.enable_data_source_main_zone ? data.aws_route53_zone.main[0].arn : aws_route53_zone.main[0].arn
}

output "subdomain_zone_id" {
  description = "Zone ID of subdomain Route53 zone"
  value       = aws_route53_zone.subdomain[0].zone_id
}

output "subdomain_zone_name_servers" {
  description = "Name servers of subdomain Route53 zone"
  value       = aws_route53_zone.subdomain[0].name_servers
}

output "subdomain_zone_arn" {
  description = "ARN of subdomain Route53 zone"
  value       = aws_route53_zone.subdomain[0].arn
}