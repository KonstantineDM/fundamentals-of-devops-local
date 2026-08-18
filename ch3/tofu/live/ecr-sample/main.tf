provider "aws" {
  region = "eu-central-1"
}

module "repo" {
  source = "brikis98/devops/book//modules/ecr-repo"
  version = "1.0.0"

  name = "sample-app"
}
