provider "aws" {
  region = "eu-central-1"
}

module "oidc_provider" {
  source       = "brikis98/devops/book//modules/github-aws-oidc"
  version      = "1.0.0"
  provider_url = "https://token.actions.githubusercontent.com"
}

module "iam_roles" {
  source            = "brikis98/devops/book//modules/gh-actions-iam-roles"
  version           = "1.0.0"
  name              = "lambda-sample"
  oidc_provider_arn = module.oidc_provider.oidc_provider_arn

  enable_iam_role_for_testing = true

  # TODO: fill in your own repo name with user and repo IDs here!
  github_repo      = "KonstantineDM@71542112/fundamentals-of-devops-local@1338389819"
  lambda_base_name = "lambda-sample"

  enable_iam_role_for_plan = true
  enable_iam_role_for_apply = true
  # TODO: fill in your own bucket and table name here!
  tofu_state_bucket = "dke-fundamentals-of-devops-tofu-state"
  tofu_state_dynamodb_table = "dke-fundamentals-of-devops-tofu-state"
}

module "iam_roles_eks" {
  source            = "../../modules/gh-actions-iam-roles-eks"
  
  name              = "eks-sample"
  github_repo       = "KonstantineDM@71542112/fundamentals-of-devops-local@1338389819"
  oidc_provider_arn = module.oidc_provider.oidc_provider_arn

  eks_base_name     = "eks-sample"

  enable_iam_role_for_plan = true
  enable_iam_role_for_apply = true

  tofu_state_bucket = "dke-fundamentals-of-devops-tofu-state"
  tofu_state_dynamodb_table = "dke-fundamentals-of-devops-tofu-state"
}
