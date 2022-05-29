# Terraform script for sigma infrastructure

## How to use

### Prerequisites
* AWS Credential
* AWS CLI
* Terraform
* AWS S3 bucket (optional, only required if you want to enable backend)

### Steps
1. configure environment variable
```bash
aws configure --profile terraform
export AWS_PROFILE=terraform
```

2. setup backend (optional, only required if you want to enable backend)
2.1 create S3 bucket
AWS console -> Services -> Storage -> S3 -> Create bucket

S3 Permissions: https://www.terraform.io/language/settings/backends/s3#s3-bucket-permissions

example:
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::809962484262:user/terraform-p3"
            },
            "Action": "s3:ListBucket",
            "Resource": "arn:aws:s3:::sigma-terraform-ryan"
        },
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::809962484262:user/terraform-p3"
            },
            "Action": [
                "s3:GetObject",
                "s3:PutObject",
                "s3:DeleteObject"
            ],
            "Resource": "arn:aws:s3:::sigma-terraform-ryan/*"
        }
    ]
}
```

DynamoDB Table Permissions: https://www.terraform.io/language/settings/backends/s3#dynamodb-table-permissions

2.2 create DynamoDB table

select a region

AWS console -> Services -> Database -> DynamoDB -> Create Table

```text
table_name = terraform-state
partition_key = LockID
```

2.3 create `backend.conf` under project root directory

exmpale:
```hcl
bucket         = "sigma-terraform-ryan"
key            = "dev/terraform.tfstate"
region         = "ap-southeast-2"
dynamodb_table = "terraform-state"
encrypt        = true
```


2.4 uncomment terraform block in `backend.tf`

3. initial terraform
```bash
terraform init # without backend
terraform init -backend-config=backend.conf # with backend
```

DynamoDB Table Permissions
DynamoDB Table Permissions: https://www.terraform.io/language/settings/backends/s3#dynamodb-table-permissions

4. run script
```bash
terraform apply # without variables override
terraform apply -var-file="terraform.tfvars" # without variables override
```


# TOBE delete blow
### 1. Put aws credential to the provider in variables.tf safely (No Plaintext)

### 2. Backend is commented so that you can just create tfstate locally, otherwise:
- Create a s3 bucket and dynamodb table, put the s3 bucket, path to tfstate and dynamodb_table name in backend.tf config, uncomment the code

### 3. Run commands
```bash
# Initialize terraform & install dependencies
terraform init

# Formated the code automatically
terraform fmt

terraform plan
terraform apply

terraform destroy
```


TODO:
use guide
variable
resources