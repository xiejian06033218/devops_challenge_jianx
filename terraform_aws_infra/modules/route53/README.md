# AWS route53 module

This module provisions main domain and/or suddomain hosted zone via AWS route53 , subdomain `ns` record creation in main hosted zone and `alias` record creation for cloudfront or elastic load balancer in the subdomain hosted zone.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| alias\_evaluate\_target\_health | whether to respond to DNS queries using this resource record set by checking the health of the resource record set. | `bool` | `false` | no |
| alias\_name | DNS domain name for a CloudFront distribution, S3 bucket, ELB, or another resource record set in this hosted zone. | `string` | n/a | yes |
| alias\_zone\_id | Hosted zone ID for a CloudFront distribution, S3 bucket, ELB, or Route 53 hosted zone. | `string` | n/a | yes |
| create\_alias\_records | Whether to create alias record in subdomain hosted zone | `bool` | `true` | no |
| create\_main\_hosted\_zone | Whether to create main hosted zone | `bool` | `false` | no |
| create\_ns\_records | Whether to create subdomain NS record in main hosted zone | `bool` | `true` | no |
| create\_subdomain\_hosted\_zone | Whether to create subdomain hosted zone | `bool` | `true` | no |
| enable\_data\_source\_main\_zone | Whether to data source main hosted zone | `bool` | `true` | no |
| main\_domain\_name | This is the name of the resource | `string` | `""` | no |
| main\_zone\_id | Main hosted zone id needs to be provided only when main zone is neither created nor sourced via data block | `string` | `""` | no |
| subdomain\_name | This is the name of the resource | `string` | n/a | yes |
| tags | Key and value pair that will be added as tag | `map(string)` | `{}` | no |


## Outputs

| Name | Description |
|------|-------------|
| main\_domain\_zone\_arn | ARN of main domain Route53 zone |
| main\_domain\_zone\_id | Zone ID of main domain Route53 zone |
| main\_domain\_zone\_name\_servers | Name servers of main domain Route53 zone |
| subdomain\_zone\_arn | ARN of subdomain Route53 zone |
| subdomain\_zone\_id | Zone ID of subdomain Route53 zone |
| subdomain\_zone\_name\_servers | Name servers of subdomain Route53 zone |

