output "lb-fqdn" {
  value       = "${aws_route53_record.main.fqdn}"
  description = "the FQDN of the DNS record that points to the ALB"
}

output "default-target-group-arn" {
  value       = "${aws_lb_target_group.default.arn}"
  description = "the arn of the default target group"
}
