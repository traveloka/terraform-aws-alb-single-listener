variable "lb_name" {
  default     = ""
  description = "the name of the LB, will override the default <service_name>-<lb_type>-<random_string> name"
}

variable "lb_logs_s3_bucket_name" {
  type        = "string"
  description = "the S3 bucket that will be used to store LB access logs"
}

variable "lb_internal" {
  default     = true
  description = "whether the LB will be public / private"
}

variable "lb_security_groups" {
  type        = "list"
  description = "list of security group IDs for the LB"
}

variable "lb_subnet_ids" {
  type        = "list"
  description = "list of subnet IDs of the LB"
}

variable "lb_ip_address_type" {
  default     = "ipv4"
  description = "the LB's ip address type"
}

variable "lb_idle_timeout" {
  default     = 60
  description = "the LB's idle timeout"
}

variable "lb_tags" {
  default     = {}
  description = "the additional LB tags that will be merged over the default tags"
}

variable "tg_healthcheck" {
  default = {
    "interval"            = 30
    "path"                = "/healthcheck"
    "port"                = 5000
    "healthy_threshold"   = 3
    "unhealthy_threshold" = 3
    "timeout"             = 5
    "protocol"            = "HTTP"
    "matcher"             = "200"
  }

  description = "the default target group's health check configuration"
}

variable "tg_stickiness" {
  default = {
    "type"            = "lb_cookie"
    "cookie_duration" = 1
    "enabled"         = true
  }

  description = "the default target group's stickiness configuration"
}

variable "tg_name" {
  default     = ""
  description = "the default target group's name, will override the default <service_name>-default name"
}

variable "tg_port" {
  default     = 5000
  description = "the default target group's port"
}

variable "tg_protocol" {
  default     = "HTTP"
  description = "the default target group's protocol"
}

variable "tg_deregistration_delay" {
  default     = 300
  description = "the default target group's deregistration delay"
}

variable "tg_tags" {
  default     = {}
  description = "the additional Target Group tags that will be merged over the default tags"
}

variable "listener_certificate_arn" {
  type        = "string"
  description = "the LB listener's certificate ARN"
}

variable "listener_conditions" {
  default     = []
  description = "list of conditions (https://www.terraform.io/docs/providers/aws/r/lb_listener_rule.html#condition) for the listener rules. A rule can have either 1 or 2 conditions. The rule order represents its priority, starting from the higher priorities"
}

variable "listener_target_group_idx" {
  default     = []
  description = "indexes, starting from 0, of the `target_group_arns` variable that the listener rules will use when choosing target groups. '0' means the default target group"
}

variable "r53_record_name" {
  type        = "string"
  description = "the route 53's record name"
}

variable "r53_zone_id" {
  type        = "string"
  description = "the route 53's record zone id"
}

variable "tag_service_name" {
  type        = "string"
  description = "the service name that will be used in tags and resources default name"
}

variable "tag_description" {
  default     = true
  description = "will be used in resources' Description tag"
}

variable "tag_environment" {
  default     = true
  description = "will be used in resources' Environment tag"
}

variable "target_group_arns" {
  default     = []
  description = "A list of target group arns, will be used by listener rules using `listener_target_group_idx` variable"
}

variable "vpc_id" {
  type        = "string"
  description = "the default target group's VPC"
}
