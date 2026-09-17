output "bucket_name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.website.id
}

output "bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.website.arn
}

output "hosted_zone_id" {
  description = "The hosted zone ID of the S3 bucket"
  value       = aws_s3_bucket.website.hosted_zone_id
}
