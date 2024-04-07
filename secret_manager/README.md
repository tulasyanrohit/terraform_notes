TASK:
Do not use secrets directly when creating resources.
Instead use AWS Secret Manager to access the credentials.

NOTE:
In this example terraform is using "local" backend but it is suggested to use some cloud backend like AWS s3

Step 01-A:
First Create a Secret Manager
<img width="1217" alt="image" src="https://github.com/tulasyanrohit/terraform_notes/assets/159639918/b836d721-79b8-476a-bef2-0c66e7f00eed">

Step 01-B:
Enter key-pair values
<img width="1142" alt="image" src="https://github.com/tulasyanrohit/terraform_notes/assets/159639918/f77c4c37-a71d-44b7-be9d-426f3b4ea3cb">

Step 01-C:
Give a name to your secret [Note this name will used in terraform to connect to this secret]
<img width="1050" alt="image" src="https://github.com/tulasyanrohit/terraform_notes/assets/159639918/1141a294-732e-43bd-a71c-b1d108c58f50">

Step 01-D:
Keep rest everthing as default

Step 02:
Add code to reference the secret created as part of Step 01
```terraform
data aws_secretsmanager_secret_version credentials {
    secret_id = "some-secret-name"
}
```

Step 03:
Code to referece key value secret
```terraform
locals {
    db_creds = jsondecode(data.aws_secretsmanager_secret_version.credentials.secret_string)
}

resource "aws_db_instance" "example" {
  identifier           = "database-identifier"
  instance_class       = "db.t3.micro"
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  username = local.db_creds.username
  password = local.db_creds.password
  skip_final_snapshot = true
}
```


Complete code can be found in file main.tf

Note:
AWS authentication is not disscused in this example but is prerequisite to this example

Some methods:
WAY 1:
Credentials can be provided by adding an access_key, secret_key, and optionally token, to the AWS provider block. Hard-coded credentials are not recommended.
provider "aws" {
  region     = "us-east-1"
  access_key = "my-access-key"
  secret_key = "my-secret-key"
}

WAY 2:
Use environment variables.

export AWS_ACCESS_KEY_ID="my-access-key"
export AWS_SECRET_ACCESS_KEY="my-secret-key"
export AWS_REGION="us-east-1"

unsetting ENV variable

unset AWS_ACCESS_KEY_ID
unset AWS_SECRET_ACCESS_KEY



WAY 3:

Terraform will automatically use credentials if it is set during "aws configure".
If you have the AWS Command Line Interface (CLI) installed, you can run aws configure and enter the access key ID, secret access key, and default region. 
