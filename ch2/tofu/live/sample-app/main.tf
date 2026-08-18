provider "aws" {
 region = "eu-central-1"
}

# module "sample_app_1" {
#   source = "brikis98/devops/book//modules/ec2-instance"
#   name   = "sample-app-tofu-1"
# }

module "sample_app_2" {
  source = "../../modules/ec2-instance"
  name   = "sample-app-tofu-2"
  instance_type = var.instance_type
}
