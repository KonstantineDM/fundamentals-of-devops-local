# --------------------------------------------------------------------------------------------------------------------------------
# REQUIRED VARIABLES
# --------------------------------------------------------------------------------------------------------------------------------

variable "name" {
  description = "The base name for the IAM roles and all other resources"
  type        = string
}

variable "oidc_provider_arn" {
  description = "The ARN of the OIDC provider that will be allowed to assume the IAM roles"
  type = string
}

variable "github_repo" {
  description = "The GitHub repo that will be allowed to use OIDC to assume the IAM roles. Format must be USERNAME@USERID/REPO@REPOID: e.g., brikis98@11111111/fundamentals-of-devops@1111111111"
  type        = string
}

variable "eks_base_name" {
  description = "The base name used for the eks-sample app: especially its IAM roles. The IAM roles will have read or read & write access to this IAM role."
  type        = string
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# ---------------------------------------------------------------------------------------------------------------------

variable "enable_iam_role_for_plan" {
  description = "If set to true, create the IAM role for running 'plan' on the eks-sample module"
  type        = string
  default     = false
}

variable "enable_iam_role_for_apply" {
  description = "If set to true, create the IAM role for running 'apply' on the eks-sample module"
  type        = string
  default     = false
}

variable "tofu_state_bucket" {
  description = "The name of the S3 bucket that stores your OpenTofu state. The IAM roles will have read or read & write access to this bucket."
  type        = string
  default     = ""
}

variable "tofu_state_dynamodb_table" {
  description = "The name of the DynamoDB table that is used for OpenTofu state locking. The IAM roles will have read or read & write access to this bucket."
  type        = string
  default     = ""
}
