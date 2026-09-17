output "cloudfront_domain_name" {
    description = "The domain name of the CloudFront distribution"
    value = module.cloudfront.domain_name
}
