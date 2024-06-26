provider "aws" {
    region = "us-east-1"
}

data aws_secretsmanager_secret_version credentials {
    secret_id = "some-secret-name"
}

#Using JsonDecode function to map "secret_string" to json object and assiging to local var
locals {
    db_creds = jsondecode(data.aws_secretsmanager_secret_version.credentials.secret_string)
}

resource "aws_db_instance" "example" {
  identifier           = "database-identifier"
  instance_class       = "db.t3.micro"
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  #Insted of using 
  #username = admin
  #password = assword

  #Using aws secret manager to access the secret data
  username = local.db_creds.username
  password = local.db_creds.password
  skip_final_snapshot = true
}