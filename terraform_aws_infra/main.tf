provider "aws" {
  region = var.aws_region
}

provider "aws" {
  region = "us-east-1"
  alias  = "us"
}

##################################################################################
# LOCALS
##################################################################################
locals {
  environment = terraform.workspace == "default" ? "dev" : terraform.workspace
  common_tags = merge({
    Environment = local.environment
    Project     = var.project
  }, {for v in [var.project] : "Project" => v if var.project != ""})
}

##################################################################################
# MODULE
##################################################################################

data "aws_vpc" "default" {
  default = true
} 

module "route53_dns" {
  source = "./modules/route53"

  main_domain_name     = var.main_domain_name
  subdomain_name       = var.subdomain_web
  create_alias_records = false
  tags                 = local.common_tags
}

module "cdn" {
  source = "./modules/cdn"

  origin_domain_name             = module.web_host.public_dns
  origin_id                      = var.origin_id
  zone_ids                       = [module.route53_dns.subdomain_zone_id]
  aliases                        = [var.subdomain_web]
  price_class                    = "PriceClass_100"
  restriction_type               = "whitelist"
  restriction_location           = ["US", "AU", "HK", "DE"]
  acm_certificate_arn            = module.acm_cert_for_cdn.acm_certificate_arn
  tags                           = local.common_tags

  depends_on = [module.acm_cert_for_cdn]
}

module "acm_cert_for_cdn" {
  source = "./modules/acm-cert"

  providers = {
    aws = aws.us
  }
  domain_name = var.subdomain_web
  zone_id     = module.route53_dns.subdomain_zone_id
  tags        = local.common_tags

  depends_on = [module.route53_dns]
}

module "web_host" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "web_host"

  ami                    = "ami-0b21dcff37a8cd8a4"
  instance_type          = "t2.micro"
  iam_instance_profile   = "EC2ECRFullAccess"
  key_name               = "EC2_test"
  monitoring             = false
  vpc_security_group_ids = [aws_security_group.web_host-sg.id]

  tags = local.common_tags
}

resource "aws_security_group" "web_host-sg" {
  name   = "${var.project}-sg"
  vpc_id = data.aws_vpc.default.id

  ingress {
    description = "Access from Internet allowed"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH connection allowed"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}