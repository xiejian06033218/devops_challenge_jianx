# Output variable definitions

output "acm_certificate_arn" {
  description = "The ARN of the certificate"
  value       = aws_acm_certificate.cert[0].arn
}

output "certificate_domain_validation_options" {
  description = "A list of attributes to feed into other resources to complete certificate validation. Can have more than one element, e.g. if SANs are defined. Only set if DNS-validation was used."
  value       = aws_acm_certificate.cert[0].domain_validation_options
}

output "certificate_domains" {
  description = "List of domain names covered by the certificate"
  value       = concat([aws_acm_certificate.cert[0].domain_name], tolist(aws_acm_certificate.cert[0].subject_alternative_names))
}