output "eks_deploy_plan_role_arn" {
  description = "The ARN of the IAM role for plan"
  value = length(aws_iam_role.eks_deploy_plan) > 0 ? aws_iam_role.eks_deploy_plan[0].arn : null
}

output "eks_deploy_apply_role_arn" {
  description = "The ARN of the IAM role for apply"
  value = length(aws_iam_role.eks_deploy_apply) > 0 ? aws_iam_role.eks_deploy_apply[0].arn : null
}
