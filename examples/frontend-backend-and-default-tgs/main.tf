provider "aws" {
  region = "ap-southeast-1"
}

variable "frontend-condition" {
  default = [
    {
      "field"  = "host-header"
      "values" = ["m.traveloka.com"]
    },
    {
      "field"  = "path-pattern"
      "values" = ["/frontend/"]
    },
  ]
}

variable "backend-canary-condition" {
  default = [
    {
      "field"  = "path-pattern"
      "values" = ["/canary/"]
    },
  ]
}

variable "backend-default-condition" {
  default = [
    {
      "field"  = "host-header"
      "values" = ["fpr.traveloka.com"]
    },
  ]
}

resource "aws_lb_target_group" "frontend" {
  name                 = "fpr-frontend"
  port                 = 8080
  protocol             = "HTTP"
  vpc_id               = "vpc-a59be0ce"
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

  tags = "${map(
    "Name", "fpr-frontend",
    "Service", "fprfe",
    "Environment", "production"
  )}"
}

resource "aws_lb_target_group" "backend-canary" {
  name                 = "fpr-backend-canary"
  port                 = 5000
  protocol             = "HTTP"
  vpc_id               = "vpc-a59be0ce"
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

  tags = "${map(
    "Name", "fpr-backend-canary",
    "Service", "fprbe",
    "Environment", "production",
  )}"
}

module "alb-single-listener" {
  source                   = "../.."
  lb_logs_s3_bucket_name   = "gone-with-the-wind"
  service_name             = "fprab-app"
  environment              = "production"
  product_domain           = "fpr"
  description              = "Flight AB App's Application Load Balancer"
  listener_certificate_arn = "arn:aws:acm:ap-southeast-1:123456789012:certificate/casablanca"
  lb_security_groups       = ["sg-b0c9ed17"]
  lb_subnet_ids            = ["subnet-e099dc3f", "subnet-9eb519e8"]

  listener_conditions = "${list(var.frontend-condition, var.backend-canary-condition, var.backend-default-condition)}"

  target_group_arns = [
    "${aws_lb_target_group.frontend.arn}",
    "${aws_lb_target_group.backend-canary.arn}",
  ]

  listener_target_group_idx = [1, 2, 0]
  vpc_id                    = "vpc-a59be0ce"
}
