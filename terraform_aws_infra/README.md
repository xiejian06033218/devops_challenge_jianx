# Terraform script for creations of static Website infrastructure on AWS

Resources to be created using the configuration in this directory include:

- AWS EC2
- AWS CloudFront Distribution
- AWS ACM TLS Certificate
- AWS Route53 Hosted zone, subdomain domain name and records

## How to use

### Prerequisites

* AWS Credential
* AWS CLI
* Terraform
* AWS S3 bucket (optional, only required if you want to enable backend)

### Steps

To create the resources, you need to execute:

```bash
terraform init
terraform plan
terraform apply
```

Run `terraform destroy` when you don't need these resources.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.72 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.72 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| route53\_dns | ./modules/route53 | n/a |
| cdn | ./modules/cdn | n/a |
| acm\_cert\_for\_cdn | ./modules/acm-cert | n/a |
| web\_host | terraform-aws-modules/ec2-instance/aws | ~> 3.0 |

## Resources

| Name | Type |
|------|------|
| aws\_security\_group.web\_host-sg | resource |
| aws\_vpc.default | data |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_region | default region | `string` | `ap-southeast-2` | no |
| project | name of the project | `string` | `devops_challenge` | no |
| main\_domain\_name | main domain name | `string` | n/a | yes |
| subdomain\_web | subdomain for web demo | `string` | n/a | yes |
