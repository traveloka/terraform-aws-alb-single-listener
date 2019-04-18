output "lb_dns" {
  value       = "${aws_lb.main.dns_name}"
  description = "The DNS name of the load balancer"
}

output "lb_zone_id" {
  value       = "${aws_lb.main.zone_id}"
  description = "The canonical hosted zone ID of the load balancer (to be used in a Route 53 Alias record)"
}

output "lb_arn" {
  value       = "${aws_lb.main.arn}"
  description = "The ARN of the ALB"
}

output "lb_arn_suffix" {
  value       = "${aws_lb.main.arn_suffix}"
  description = "The ARN suffix of the ALB, useful with CloudWatch Metrics"
}

output "tg_arn" {
  value       = "${aws_lb_target_group.default.arn}"
  description = "The arn of the default target group"
}

output "tg_arn_suffix" {
  value       = "${aws_lb_target_group.default.arn_suffix}"
  description = "The arn suffix of the default target group, useful with CloudWatch Metrics"
}

output "listener_arn" {
  value       = "The ARN of the listener"
  description = "${aws_lb_listener.main.arn}"
}

output "listener_id" {
  value       = "The ID of the listener"
  description = "${aws_lb_listener.main.id}"
}
