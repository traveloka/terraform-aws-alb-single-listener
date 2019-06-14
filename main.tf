# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

#     http://www.apache.org/licenses/LICENSE_2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
resource "aws_lb" "main" {
  name     = local.lb_name
  internal = var.lb_internal

  security_groups = var.lb_security_groups

  subnets         = var.lb_subnet_ids
  idle_timeout    = var.lb_idle_timeout
  ip_address_type = var.lb_ip_address_type

  access_logs {
    bucket  = var.lb_logs_s3_bucket_name
    prefix  = local.lb_name
    enabled = true
  }

  tags = merge(
    {
      "Name"          = local.lb_name
      "Service"       = var.service_name
      "Environment"   = var.environment
      "ProductDomain" = var.product_domain
      "Description"   = var.description
      "ManagedBy"     = "terraform"
    },
    var.lb_tags,
  )
}

resource "aws_lb_listener" "main" {
  load_balancer_arn = aws_lb.main.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = var.listener_ssl_policy
  certificate_arn   = var.listener_certificate_arn

  default_action {
    target_group_arn = aws_lb_target_group.default.arn
    type             = "forward"
  }
}

resource "aws_lb_target_group" "default" {
  name                 = local.tg_name
  port                 = var.tg_port
  protocol             = var.tg_protocol
  vpc_id               = var.vpc_id
  deregistration_delay = var.tg_deregistration_delay
  target_type          = var.tg_target_type

  health_check {
    enabled             = lookup(local.tg_health_check, "enabled", null)
    healthy_threshold   = lookup(local.tg_health_check, "healthy_threshold", null)
    interval            = lookup(local.tg_health_check, "interval", null)
    matcher             = lookup(local.tg_health_check, "matcher", null)
    path                = lookup(local.tg_health_check, "path", null)
    port                = lookup(local.tg_health_check, "port", null)
    protocol            = lookup(local.tg_health_check, "protocol", null)
    timeout             = lookup(local.tg_health_check, "timeout", null)
    unhealthy_threshold = lookup(local.tg_health_check, "unhealthy_threshold", null)
  }

  stickiness {
    cookie_duration = lookup(var.tg_stickiness, "cookie_duration", null)
    enabled         = lookup(var.tg_stickiness, "enabled", null)
    type            = stickiness.value.type
  }

  tags = merge(
    {
      "Name"          = local.tg_name
      "Service"       = var.service_name
      "Environment"   = var.environment
      "ProductDomain" = var.product_domain
      "Description"   = var.description
      "ManagedBy"     = "terraform"
    },
    var.tg_tags,
  )
}

resource "aws_lb_listener_rule" "main" {
  count        = length(var.listener_conditions)
  listener_arn = aws_lb_listener.main.arn

  priority = count.index + 1

  action {
    type             = "forward"
    target_group_arn = local.target_group_arns[var.listener_target_group_idx[count.index]]
  }
  dynamic "condition" {
    for_each = var.listener_conditions[count.index]
    content {

      field  = lookup(condition.value, "field", null)
      values = lookup(condition.value, "values", null)
    }
  }
}
