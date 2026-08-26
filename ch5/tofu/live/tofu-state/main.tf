provider "aws" {
  region = "eu-central-1"
}

module "state" {
  source  = "brikis98/devops/book//modules/state-bucket"
  version = "1.0.1"
  
  # TODO: fill in your own bucket name!
  name = "dke-fundamentals-of-devops-tofu-state"
}