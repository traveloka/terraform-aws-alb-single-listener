module "random_lb" {
  source = "github.com/traveloka/terraform-aws-resource-naming.git?ref=v0.6.0"

  name_prefix   = "${format("%s-%s", var.service_name, var.lb_internal ? "lbint" : "lbext")}"
  resource_type = "lb"

  keepers = {
    lb_internal        = "${var.lb_internal}"
    lb_ip_address_type = "${var.lb_ip_address_type}"
    tg_port            = "${var.tg_port}"
    tg_protocol        = "${var.tg_protocol}"
    tg_vpc_id          = "${var.vpc_id}"
  }
}

module "random_tg" {
  source = "github.com/traveloka/terraform-aws-resource-naming.git?ref=v0.6.0"

  name_prefix   = "${format("%s-%s", var.service_name, var.cluster_role)}"
  resource_type = "lb_target_group"
}

locals {
  lb_name           = "${var.lb_name == "" ? module.random_lb.name : var.lb_name}"
  tg_name           = "${var.tg_name == "" ? module.random_tg.name : var.tg_name}"
  target_group_arns = "${concat(list(aws_lb_target_group.default.arn), var.target_group_arns)}"
}

locals {
  tg_default_health_check = {
    "interval"            = 30
    "path"                = "/healthcheck"
    "healthy_threshold"   = 3
    "unhealthy_threshold" = 3
    "timeout"             = 5
    "protocol"            = "HTTP"
    "matcher"             = "200"
  }

  tg_health_check = "${merge(local.tg_default_health_check, var.tg_health_check)}"
}
