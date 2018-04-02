output "lb-fqdn" {
  value       = "${aws_route53_record.main.fqdn}"
  description = "The FQDN of the DNS record that points to the ALB"
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
