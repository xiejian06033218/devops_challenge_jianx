# AWS ACM module

This module provisions AWS ACM Certificates, certificate validation and validation record creation in route53.
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create\_certificate | Whether to create ACM certificate | `bool` | `true` | no |
| create\_route53\_records | When validation is set to DNS, define whether to create the DNS records internally via Route53 or externally using any DNS provider | `bool` | `true` | no |
| domain\_name | A domain name for which the certificate should be issued | `string` | n/a | yes |
| subject\_alternative\_names | List of subject alternative names for the ACM certificate | `list(string)` | `[]` | no |
| tags | Key and value pair that will be added as tag | `map(string)` | `{}` | no |
| validate\_method | Which method to use for validation. DNS or EMAIL are valid, NONE can be used for certificates that were imported into ACM and then into Terraform. | `string` | `DNS` | no |
| zone\_id | The ID of the hosted zone to contain this record. Required when validating via Route53 | `string` | n/a | yes |


## Outputs

| Name | Description |
|------|-------------|
| certificate\_arn | The ARN of the certificate |
| certificate\_domain\_validation\_options | A list of attributes to feed into other resources to complete certificate validation |
| certificate\_domains | List of domain names covered by the certificate |
