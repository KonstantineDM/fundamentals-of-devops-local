provider "aws" {
    region = "eu-central-1"
}

module "asg" {
    source          = "brikis98/devops/book//modules/asg"
    version         = "1.0.1"

    name            = "sample-app-asg"
    ami_name        = "sample-app-packer-${var.ami_version}"
    user_data       = filebase64("${path.module}/user-data.sh")
    app_http_port   = 8080

    instance_type   = "t3.micro"
    min_size        = 4
    max_size        = 10

    target_group_arns = [module.alb.target_group_arn]

    instance_refresh = {
        min_healthy_percentage = 100
        max_healthy_percentage = 200
        auto_rollback = true
    }
}

module "alb" {
    source = "brikis98/devops/book//modules/alb"
    version = "1.0.1"

    name = "sample-app-alb"
    alb_http_port = 80
    app_http_port = 8080
    app_health_check_path = "/"
}

resource "aws_route53_health_check" "example" {
    fqdn = module.alb.alb_dns_name
    type = "HTTP"
    request_interval = "10"
    resource_path = "/"
    port = 80
    failure_threshold = 1
    tags = {
        Name = "sample-app-health-check"
    }
}

module "cloudwatch_dashboard" {
    source = "brikis98/devops/book//modules/cloudwatch-dashboard"
    version = "1.0.1"

    name = "sample-app-dashboard"
    
    asg_name = module.asg.asg_name
    alb_name = module.alb.alb_name
    alb_arn_suffix = module.alb.alb_arn_suffix
    health_check_id = aws_route53_health_check.example.id
}