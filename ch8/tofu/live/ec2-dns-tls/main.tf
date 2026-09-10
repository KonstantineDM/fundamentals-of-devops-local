provider "aws" {
    region = "eu-central-1"
}

module "instances" {
    source = "brikis98/devops/book//modules/ec2-instances"
    version = "1.0.0"

    name = "ec2-dns-example"

    num_instances = 3
    instance_type = "t3.micro"
    ami_name = "sample-app-tls-packer-*"
    http_port = 443
    user_data = file("${path.module}/user-data.sh")
}

resource "aws_iam_role_policy" "tls_cert_access" {
    role = module.instances.iam_role_name
    policy = data.aws_iam_policy_document.tls_cert_access.json
}

data "aws_secretsmanager_secret" "certificate" {
    name = "certificate"
}

data "aws_iam_policy_document" "tls_cert_access" {
    statement {
        effect = "Allow"
        actions = ["secretsmanager:GetSecretValue"]
        resources = [data.aws_secretsmanager_secret.certificate.arn]
    }
}