variable "aws_region" {
  type        = string
  default     = "ap-southeast-2"
  description = "default region"
}

variable "project" {
  type    = string
  default = "devops_challenge"

  validation {
    condition     = var.project != ""
    error_message = "This variable cannot be empty."
  }
}

variable "name_prefix" {
  type    = string
  default = "web"

  validation {
    condition     = var.name_prefix != ""
    error_message = "This variable cannot be empty."
  }
}

variable "origin_id" {
  type        = string
  default     = "web-demo-EC2"
  description = "origin id for CDN"
}

variable "main_domain_name" {
  type        = string
  default     = "jiandevops.link" //can be passed in through tfvars file
  description = "your domain name"
}

variable "subdomain_web" {
  type        = string
  default     = "web.jiandevops.link"
  description = "subdomain for web demo"
}