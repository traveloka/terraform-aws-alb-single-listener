variable "lb_name" {
  type        = "string"
  default     = ""
  description = "The name of the LB, will override the default <service_name>-<lb_type>-<random_string> name"
}

variable "lb_logs_s3_bucket_name" {
  type        = "string"
  description = "The S3 bucket that will be used to store LB access logs"
}

variable "lb_internal" {
  type        = "string"
  default     = true
  description = "Whether the LB will be public / private"
}

variable "lb_security_groups" {
  type        = "list"
  description = "List of security group IDs for the LB"
}

variable "lb_subnet_ids" {
  type        = "list"
  description = "List of subnet IDs of the LB"
}

variable "lb_ip_address_type" {
  type        = "string"
  default     = "ipv4"
  description = "The LB's ip address type"
}

variable "lb_idle_timeout" {
  type        = "string"
  default     = 60
  description = "The LB's idle timeout"
}

variable "lb_tags" {
  type        = "map"
  default     = {}
  description = "The additional LB tags that will be merged over the default tags"
}

variable "tg_health_check" {
  type        = "map"
  default     = {}
  description = "The default target group's health check configuration, will be merged over the default (see locals.tf)"
}

variable "tg_stickiness" {
  type = "map"

  default = {
    "type"            = "lb_cookie"
    "cookie_duration" = 1
    "enabled"         = true
  }

  description = "The default target group's stickiness configuration"
}

variable "tg_name" {
  type        = "string"
  default     = ""
  description = "The default target group's name, will override the default <service_name>-default name"
}

variable "tg_port" {
  type        = "string"
  default     = 5000
  description = "The default target group's port"
}

variable "tg_protocol" {
  type        = "string"
  default     = "HTTP"
  description = "The default target group's protocol"
}

variable "tg_deregistration_delay" {
  type        = "string"
  default     = 300
  description = "The default target group's deregistration delay"
}

variable "tg_tags" {
  type        = "map"
  default     = {}
  description = "The additional Target Group tags that will be merged over the default tags"
}

variable "listener_certificate_arn" {
  type        = "string"
  description = "The LB listener's certificate ARN"
}

variable "listener_ssl_policy" {
  type        = "string"
  default     = "ELBSecurityPolicy-2016-08"
  description = "The LB listener's SSL policy"
}

variable "listener_conditions" {
  type        = "list"
  default     = []
  description = "List of conditions (https://www.terraform.io/docs/providers/aws/r/lb_listener_rule.html#condition) for the listener rules. A rule can have either 1 or 2 conditions. The rule's order will be its priority, i.e. the first is the highest"
}

variable "listener_target_group_idx" {
  type        = "list"
  default     = []
  description = "Indexes, starting from 0, of the `target_group_arns` variable that the listener rules will use when choosing target groups. '0' means the default target group"
}

variable "service_name" {
  type        = "string"
  description = "The service name that will be used in tags and resources default name"
}

variable "description" {
  type        = "string"
  description = "Will be used in resources' Description tag"
}

variable "environment" {
  type        = "string"
  description = "Will be used in resources' Environment tag"
}

variable "product_domain" {
  type        = "string"
  description = "Abbreviation of the product domain the created resources belong to"
}

variable "target_group_arns" {
  type        = "list"
  default     = []
  description = "A list of target group arns, will be used by listener rules using `listener_target_group_idx` variable"
}

variable "vpc_id" {
  type        = "string"
  description = "The default target group's VPC"
}
