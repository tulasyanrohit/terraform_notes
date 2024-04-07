provider "aws" {
    region = "us-east-1"
}

data aws_secretsmanager_secret_version credentials {
    secret_id = "some-secret-name"
}