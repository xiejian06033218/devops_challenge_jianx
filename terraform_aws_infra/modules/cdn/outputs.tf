# Output variable definitions

output "id" {
  description = "The identifier for the distribution."
  value       = aws_cloudfront_distribution.cdn_distribution.id
}

output "arn" {
  description = "The ARN (Amazon Resource Name) for the distribution."
  value       = aws_cloudfront_distribution.cdn_distribution.arn
}

output "status" {
  description = "The current status of the distribution. Deployed if the distribution's information is fully propagated throughout the Amazon CloudFront system."
  value       = aws_cloudfront_distribution.cdn_distribution.status
}

output "domain_name" {
  description = "The domain name corresponding to the distribution."
  value       = aws_cloudfront_distribution.cdn_distribution.domain_name
}

output "last_modified_time" {
  description = "The date and time the distribution was last modified."
  value       = aws_cloudfront_distribution.cdn_distribution.last_modified_time
}

output "hosted_zone_id" {
  description = "The CloudFront Route 53 zone ID that can be used to route an Alias Resource Record Set to."
  value       = aws_cloudfront_distribution.cdn_distribution.hosted_zone_id
}