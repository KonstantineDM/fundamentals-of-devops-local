provider "aws" {
    region = "eu-central-1"
}

module "vpc" {
    source = "brikis98/devops/book//modules/vpc"
    version = "1.0.1"

    name = "example-vpc"
    cidr_block = "10.0.0.0/16"
}

module "public_instance" {
    key_name = "ch7-aws-ec2"

    source = "brikis98/devops/book//modules/ec2-instances"
    version = "1.0.1"

    name = "public-instance"

    num_instances = 1
    instance_type = "t3.micro"
    ami_name = "sample-app-packer-*"
    http_port = 8080
    user_data = file("${path.module}/user-data.sh")
    vpc_id = module.vpc.vpc.id
    subnet_id = module.vpc.public_subnet.id
}

module "private_instance" {
    key_name = "ch7-aws-ec2"

    source = "brikis98/devops/book//modules/ec2-instances"
    version = "1.0.1"

    name = "private-instance"

    num_instances = 1
    instance_type = "t3.micro"
    ami_name = "sample-app-packer-*"
    http_port = 8080
    user_data = file("${path.module}/user-data.sh")
    vpc_id = module.vpc.vpc.id
    subnet_id = module.vpc.private_subnet.id
}
