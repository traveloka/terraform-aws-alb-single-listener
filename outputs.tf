output "lb-dns" {
  value       = "${aws_lb.main.dns_name}"
  description = "The DNS name of the load balancer"
}

output "lb-zone-id" {
  value       = "${aws_lb.main.zone_id}"
  description = "The canonical hosted zone ID of the load balancer (to be used in a Route 53 Alias record)"
}

output "lb-arn" {
  value       = "${aws_lb.main.arn}"
  description = "The ARN of the ALB"
}

output "lb-arn-suffix" {
  value       = "${aws_lb.main.arn_suffix}"
  description = "The ARN suffix of the ALB, useful with CloudWatch Metrics"
}

output "tg-arn" {
  value       = "${aws_lb_target_group.default.arn}"
  description = "The arn of the default target group"
}

output "tg-arn-suffix" {
  value       = "${aws_lb_target_group.default.arn_suffix}"
  description = "The arn suffix of the default target group, useful with CloudWatch Metrics"
}
