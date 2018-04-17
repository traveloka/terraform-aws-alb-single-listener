provider "aws" {
  region  = "ap-southeast-1"
  version = "1.14.1"
}

locals {
  product_domain = "fpr"
  service_name   = "${local.product_domain}ops"
  vpc_id         = "vpc-14b12345"

  frontend_condition = [
    {
      "field"  = "host-header"
      "values" = ["m.traveloka.com"]
    },
    {
      "field"  = "path-pattern"
      "values" = ["/frontend/"]
    },
  ]

  backend_canary_condition = [
    {
      "field"  = "path-pattern"
      "values" = ["/canary/"]
    },
  ]

  backend_default_condition = [
    {
      "field"  = "host-header"
      "values" = ["fpr.traveloka.com"]
    },
  ]
}

module "random_fe" {
  source = "github.com/traveloka/terraform-aws-resource-naming.git?ref=v0.4.0"

  name_prefix   = "${format("%s-%s", local.service_name, "fe")}"
  resource_type = "lb_target_group"
}

module "random_be" {
  source = "github.com/traveloka/terraform-aws-resource-naming.git?ref=v0.4.0"

  name_prefix   = "${format("%s-%s", local.service_name, "app")}"
  resource_type = "lb_target_group"
}

resource "aws_lb_target_group" "frontend" {
  name                 = "${module.random_fe.name}"
  port                 = 8080
  protocol             = "HTTP"
  vpc_id               = "${local.vpc_id}"
  deregistration_delay = 300

  health_check = {
    "interval"            = 30
    "path"                = "/frontend-healthcheck"
    "port"                = 8080
    "healthy_threshold"   = 3
    "unhealthy_threshold" = 3
    "timeout"             = 5
    "protocol"            = "HTTP"
    "matcher"             = "200"
  }

  stickiness = {
    "type"            = "lb_cookie"
    "cookie_duration" = 1
    "enabled"         = true
  }

  tags = {
    Name          = "${module.random_fe.name}"
    Service       = "${local.service_name}"
    ProductDomain = "${local.product_domain}"
    Environment   = "production"
    Description   = "Target group for ${local.service_name}-fe cluster"
    ManagedBy     = "Terraform"
  }
}

resource "aws_lb_target_group" "backend-canary" {
  name                 = "${module.random_be.name}"
  port                 = 5000
  protocol             = "HTTP"
  vpc_id               = "${local.vpc_id}"
  deregistration_delay = 300

  health_check = {
    "interval"            = 30
    "path"                = "/healthcheck"
    "port"                = 5000
    "healthy_threshold"   = 3
    "unhealthy_threshold" = 3
    "timeout"             = 5
    "protocol"            = "HTTP"
    "matcher"             = "200"
  }

  stickiness = {
    "type"            = "lb_cookie"
    "cookie_duration" = 1
    "enabled"         = true
  }

  tags = {
    Name          = "${module.random_be.name}"
    Service       = "${local.service_name}"
    ProductDomain = "${local.product_domain}"
    Environment   = "production"
    Description   = "Target group for ${local.service_name}-app cluster"
    ManagedBy     = "Terraform"
  }
}

module "alb-single-listener" {
  source                   = "../.."
  lb_logs_s3_bucket_name   = "elb-logs"
  service_name             = "${local.service_name}"
  cluster_role             = "app"
  environment              = "production"
  product_domain           = "${local.product_domain}"
  description              = "Internal load balancer for Flight Product operation service"
  listener_certificate_arn = "arn:aws:acm:ap-southeast-1:123456789012:certificate/7246d5f5-b4b3-417d-a8b8-123456789012"
  lb_security_groups       = ["sg-07eb717e"]
  lb_subnet_ids            = ["subnet-b1123456", "subnet-a0d12345", "subnet-e7607d12"]

  listener_conditions = "${list(local.frontend_condition, local.backend_canary_condition, local.backend_default_condition)}"

  target_group_arns = [
    "${aws_lb_target_group.frontend.arn}",
    "${aws_lb_target_group.backend-canary.arn}",
  ]

  listener_target_group_idx = [1, 2, 0]
  vpc_id                    = "${local.vpc_id}"
}
