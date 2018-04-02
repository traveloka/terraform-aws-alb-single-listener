resource "random_id" "lb_suffix" {
  length  = 8
  upper   = false
  special = false
}

locals {
  lb_name           = "${var.lb_name == "" ? format("%s-%s-%s", var.tag_service_name, var.lb_internal ? "lbint" : "lbext", random_string.lb_suffix.result) : var.lb_name}"
  tg_name           = "${var.tg_name == "" ? format("%s-%s", local.lb_name, "default") : var.tg_name}"
  target_group_arns = "${concat(list(aws_lb_target_group.default.arn), var.target_group_arns)}"
}

locals {
  tg_health_check = {
    "interval"            = 30
    "path"                = "/healthcheck"
    "port"                = 5000
    "healthy_threshold"   = 3
    "unhealthy_threshold" = 3
    "timeout"             = 5
    "protocol"            = "HTTP"
    "matcher"             = "200"
  }

  r53_record_name = "${var.r53_record_name == "" ? format("%s-%s", var.tag_service_name, var.tag_environment) : var.r53_record_name}"
}
