terraform {
  backend "s3" {
    # TODO: fill in your own bucket name here!
    bucket  = "dke-fundamentals-of-devops-tofu-state"
    key     = "ch5/tofu/live/lambda-sample/terraform.tfstate"
    region  = "eu-central-1"
    encrypt = true
    # TODO: fill in your own DynamoDB table name here!
    dynamodb_table = "dke-fundamentals-of-devops-tofu-state"
  }
}
