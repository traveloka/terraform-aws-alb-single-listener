resource "random_id" "lb_suffix" {
  keepers = {
    lb_internal        = "${var.lb_internal}"
    lb_ip_address_type = "${var.lb_ip_address_type}"
    tg_port            = "${var.tg_port}"
    tg_protocol        = "${var.tg_protocol}"
    tg_vpc_id          = "${var.vpc_id}"
  }

  byte_length = 8
}

locals {
  lb_name           = "${var.lb_name == "" ? format("%s-%s-%s", var.service_name, var.lb_internal ? "lbint" : "lbext", random_id.lb_suffix.b64_url) : var.lb_name}"
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
}
