provider "aws" {
  region = "ap-southeast-1"
}

variable "frontend-condition" {
  default = [
    {
      "field"  = "host-header"
      "values" = ["flight.traveloka.com"]
    },
    {
      "field"  = "path-pattern"
      "values" = ["/*/g"]
    },
  ]
}

variable "black-panther-condition" {
  default = [
    {
      "field"  = "path-pattern"
      "values" = ["/*/wakanda/forever"]
    },
  ]
}

variable "thor-condition" {
  default = [
    {
      "field"  = "host-header"
      "values" = ["ragnarok.traveloka.com"]
    },
  ]
}

resource "aws_lb_target_group" "frontend" {
  name                 = "flight-frontend"
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
    "Name", "flight-frontend",
    "Service", "flight",
    "Environment", "production"
  )}"
}

resource "aws_lb_target_group" "thor" {
  name                 = "flight-thor"
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
    "Name", "flight-backend",
    "Service", "flight",
    "Environment", "production",
  )}"
}

module "alb-route53" {
  source                   = "../.."
  lb_logs_s3_bucket_name   = "gone-with-the-wind"
  tag_service_name         = "flight"
  tag_environment          = "production"
  tag_description          = "Flight backend Application Load Balancer"
  listener_certificate_arn = "arn:aws:acm:ap-southeast-1:123456789012:certificate/casablanca"
  lb_security_groups       = ["sg-b0c9ed17"]
  lb_subnet_ids            = ["subnet-e099dc3f", "subnet-9eb519e8"]

  listener_conditions = "${list(var.frontend-condition, var.black-panther-condition, var.thor-condition)}"

  target_group_arns = [
    "${aws_lb_target_group.frontend.arn}",
    "${aws_lb_target_group.thor.arn}",
  ]

  listener_target_group_idx = [1, 0, 2]
  r53_record_name           = "flight"
  r53_zone_id               = "SINGININTHERAIN"
  vpc_id                    = "vpc-a59be0ce"
}
