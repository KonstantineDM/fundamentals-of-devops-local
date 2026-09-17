provider "aws" {
    region = "eu-central-1"
}

module "s3_bucket" {
    source = "../../modules/s3-website"

    name = "dke-fundamentals-of-devops-static-website"
    index_document = "index.html"
}

resource "aws_s3_object" "content" {
    for_each = {
        "index.html" = "text/html"
        "styles.css" = "text/css"
        "cover.png" = "image/png"
    }

    bucket = module.s3_bucket.bucket_name
    key = each.key
    source = "content/${each.key}"
    etag = filemd5("content/${each.key}")
    content_type = each.value
    cache_control = "public, max-age=300"
}

module "cloudfront" {
    source = "../../modules/cloudfront-s3"

    bucket_name = module.s3_bucket.bucket_name
    aws_region  = "eu-central-1"

    min_ttl = 0
    max_ttl = 300
    default_ttl = 0
    default_root_object = "index.html"
}
