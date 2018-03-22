variable "lb_name" {
  default     = ""
  description = ""
}

variable "lb_logs_s3_bucket_name" {
  description = ""
}

variable "lb_internal" {
  default     = true
  description = ""
}

variable "lb_security_groups" {
  type        = "list"
  description = ""
}

variable "lb_subnet_ids" {
  type        = "list"
  description = ""
}

variable "lb_ip_address_type" {
  default     = "ipv4"
  description = ""
}

variable "lb_idle_timeout" {
  default     = 60
  description = ""
}

variable "lb_tags" {
  default     = {}
  description = ""
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

  description = ""
}

variable "tg_stickiness" {
  default = {
    "type"            = "lb_cookie"
    "cookie_duration" = 1
    "enabled"         = true
  }

  description = ""
}

variable "tg_name" {
  default     = ""
  description = ""
}

variable "tg_port" {
  default     = 5000
  description = ""
}

variable "tg_protocol" {
  default     = "HTTP"
  description = ""
}

variable "tg_deregistration_delay" {
  default     = 300
  description = ""
}

variable "tg_tags" {
  default     = {}
  description = ""
}

variable "listener_certificate_arn" {
  type        = "string"
  description = ""
}

variable "listener_conditions" {
  default     = []
  description = ""
}

variable "listener_target_group_idx" {
  default     = []
  description = ""
}

variable "r53_record_name" {
  type        = "string"
  description = ""
}

variable "r53_zone_id" {
  type        = "string"
  description = ""
}

variable "tag_service_name" {
  type        = "string"
  description = ""
}

variable "tag_description" {
  default     = true
  description = ""
}

variable "tag_environment" {
  default     = true
  description = ""
}

variable "target_group_arns" {
  default     = []
  description = ""
}

variable "vpc_id" {
  type        = "string"
  description = ""
}
