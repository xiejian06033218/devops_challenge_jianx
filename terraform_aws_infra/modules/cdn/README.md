# AWS Cloudfront CDN for S3 bucket hosting static website

This module provisions AWS cloudfront distribution for S3 bucket static website hosting.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aliases | Extra CNAMEs (alternate domain names), if any, for this distribution. | `list(string)` | n/a | yes |
| acm\_certificate\_arn | The ARN of the AWS Certificate Manager certificate that you wish to use with this distribution. The ACM certificate must be in US-EAST-1. | `string` | `null` | no |
| comment | Any comments you want to include about the distribution. | `string` | `null` | no |
| default\_root\_object | The object that you want CloudFront to return (for example, index.html) when an end user requests the root URL. | `string` | `"index.html"` | no |
| enabled | Whether the distribution is enabled to accept end user requests for content. | `bool` | `true` | no |
| is\_ipv6\_enabled | Whether the IPv6 is enabled for the distribution. | `bool` | `true` | no |
| logging\_config | The logging configuration that controls how logs are written to your distribution (maximum one). | `any` | `{}` | no |
| price\_class | The price class for this distribution. One of PriceClass_All, PriceClass_200, PriceClass_100 | `string` | `null` | no |
| restriction\_location | The ISO 3166-1-alpha-2 codes for which you want CloudFront either to distribute your content (whitelist) or not distribute your content (blacklist). | `list` | `[]` | no |
| restriction\_type | The restriction type of your CloudFront distribution geolocation restriction. Options include none, whitelist, blacklist. | `string` | `none` | no |
| retain\_on\_delete | Disables the distribution instead of deleting it when destroying the resource through Terraform. If this is set, the distribution needs to be deleted manually afterwards. | `bool` | `false` | no |
| s3\_bucket\_regional\_domain\_name | origin domain name for this distribution. | `string` | n/a | yes |
| s3\_origin\_id | origin id for this distribution. | `string` | n/a | yes |

| tags | Key and value pair that will be added as tag | `map(string)` | `{}` | no |
| wait\_for\_deployment | If enabled, the resource will wait for the distribution status to change from InProgress to Deployed. Setting this tofalse will skip the process. | `bool` | `true` | no |



## Outputs

| Name | Description |
|------|-------------|
| arn | The ARN (Amazon Resource Name) for the distribution. |
| domain\_name | The domain name corresponding to the distribution. |
| id | The identifier for the distribution. |
| last\_modified\_time | The date and time the distribution was last modified. |
| status | The current status of the distribution. Deployed if the distribution's information is fully propagated throughout the Amazon CloudFront system. |
| hosted\_zone\_id | The CloudFront Route 53 zone ID that can be used to route an Alias Resource Record Set to. |
