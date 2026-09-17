resource "aws_cloudfront_distribution" "website" {
  enabled = true

  default_root_object = var.default_root_object

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = var.bucket_name
    cache_policy_id        = aws_cloudfront_cache_policy.policy.id
    viewer_protocol_policy = "redirect-to-https"
    compress               = true
  }

  origin {
    domain_name = "${var.bucket_name}.s3.${var.aws_region}.amazonaws.com"
    origin_id   = var.bucket_name

    origin_access_control_id = aws_cloudfront_origin_access_control.website.id
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }
}

resource "aws_cloudfront_origin_access_control" "website" {
  name                              = "${var.bucket_name}-oac"
  description                       = "OAC for ${var.bucket_name}"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "s3_cloudfront_access" {
  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject"
    ]

    resources = [
      "arn:aws:s3:::${var.bucket_name}/*"
    ]

    principals {
      type = "Service"
      identifiers = [
        "cloudfront.amazonaws.com"
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"

      values = [
        "arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/${aws_cloudfront_distribution.website.id}"
      ]
    }
  }
}

resource "aws_s3_bucket_policy" "cloudfront_access" {
  bucket = var.bucket_name
  policy = data.aws_iam_policy_document.s3_cloudfront_access.json
}

resource "aws_cloudfront_cache_policy" "policy" {
  name = "${var.bucket_name}-policy"

  min_ttl     = var.min_ttl
  max_ttl     = var.max_ttl
  default_ttl = var.default_ttl

  parameters_in_cache_key_and_forwarded_to_origin {
    cookies_config {
      cookie_behavior = "none"
    }
    headers_config {
      header_behavior = "none"
    }
    query_strings_config {
      query_string_behavior = "all"
    }
  }
}