variable "lb_name" {
  type        = string
  default     = ""
  description = "The name of the LB, will override the default <service_name>-<lb_type>-<random_string> name"
}

variable "lb_logs_s3_bucket_name" {
  type        = string
  description = "The S3 bucket that will be used to store LB access logs"
}

variable "lb_internal" {
  type        = string
  default     = "1"
  description = "Whether the LB will be public / private"
}

variable "lb_security_groups" {
  type        = list(string)
  description = "List of security group IDs for the LB"
}

variable "lb_subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs of the LB"
}

variable "lb_ip_address_type" {
  type        = string
  default     = "ipv4"
  description = "The LB's ip address type"
}

variable "lb_idle_timeout" {
  type        = string
  default     = 60
  description = "The LB's idle timeout"
}

variable "lb_tags" {
  type        = map(string)
  default     = {}
  description = "The additional LB tags that will be merged over the default tags"
}

variable "tg_health_check" {
  type        = map(string)
  default     = {}
  description = "The default target group's health check configuration, will be merged over the default (see locals.tf)"
}

variable "tg_target_type" {
  type        = string
  default     = "instance"
  description = "The type of target that you must specify when registering targets with this target group."
}

variable "tg_name" {
  type        = string
  default     = ""
  description = "The default target group's name, will override the default <service_name>-default name"
}

variable "tg_port" {
  type        = string
  default     = 5000
  description = "The default target group's port"
}

variable "tg_protocol" {
  type        = string
  default     = "HTTP"
  description = "The default target group's protocol"
}

variable "tg_protocol_version" {
  type        = string
  default     = "HTTP1"
  description = "The default target group's protocol version"
}

variable "tg_deregistration_delay" {
  type        = string
  default     = 180
  description = "The default target group's deregistration delay"
}

variable "tg_tags" {
  type        = map(string)
  default     = {}
  description = "The additional Target Group tags that will be merged over the default tags"
}

variable "listener_port" {
  type        = string
  default     = 443
  description = "The LB listener's port"
}

variable "listener_protocol" {
  type        = string
  default     = "HTTPS"
  description = "The LB listener's protocol"
}
variable "listener_certificate_arn" {
  type        = string
  description = "The LB listener's certificate ARN"
}

variable "listener_ssl_policy" {
  type        = string
  default     = "ELBSecurityPolicy-2016-08"
  description = "The LB listener's SSL policy"
}

variable "listener_rules_builtin" {
  type        = map
  default     = {}
  description = "A map of listener rules which target the built-in target group: priority --> conditions:[]"
}

variable "listener_rules_custom" {
  type        = map
  default     = {}
  description = "A map of listener rules which target the supplied target groups: priority --> {target_group_arn:'', conditions:[]}"
}

variable "service_name" {
  type        = string
  description = "The service name that will be used in tags and resources default name"
}

variable "description" {
  type        = string
  description = "Will be used in resources' Description tag"
}

variable "environment" {
  type        = string
  description = "Will be used in resources' Environment tag"
}

variable "product_domain" {
  type        = string
  description = "Abbreviation of the product domain the created resources belong to"
}

variable "vpc_id" {
  type        = string
  description = "The built-in target group's VPC"
}

variable "cluster_role" {
  type        = string
  description = "Primary role/function of the cluster. Example value: 'app', 'fe', 'mongod', etc"
}
