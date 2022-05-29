# Input variable definitions
variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "create_main_hosted_zone" {
  description = "Whether to create main hosted zone"
  type        = bool
  default     = false
}

variable "enable_data_source_main_zone" {
  description = "Whether to data source main hosted zone"
  type        = bool
  default     = true
}

variable "create_subdomain_hosted_zone" {
  description = "Whether to create subdomain hosted zone"
  type        = bool
  default     = true
}

variable "create_ns_records" {
  description = "Whether to create subdomain NS record in main hosted zone"
  type        = bool
  default     = true
}

variable "create_alias_records" {
  description = "Whether to create alias record in subdomain hosted zone"
  type        = bool
  default     = true
}

variable "main_domain_name" {
  description = "This is the name of the resource"
  type        = string
  default     = ""
}

variable "subdomain_name" {
  description = "This is the name of the resource"
  type        = string
  default     = ""
}

variable "alias_name" {
  description = "DNS domain name for a CloudFront distribution, S3 bucket, ELB, or another resource record set in this hosted zone."
  type        = string
  default     = ""
}

variable "alias_zone_id" {
  description = "Hosted zone ID for a CloudFront distribution, S3 bucket, ELB, or Route 53 hosted zone."
  type        = string
  default     = ""
}

variable "alias_evaluate_target_health" {
  description = "whether to respond to DNS queries using this resource record set by checking the health of the resource record set."
  type        = bool
  default     = false
}
