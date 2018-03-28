output "lb-fqdn" {
  value       = "${aws_route53_record.main.fqdn}"
  description = "the FQDN of the DNS record that points to the ALB"
}

output "lb-arn" {
  value       = "${aws_lb.main.arn}"
  description = "the FQDN of the DNS record that points to the ALB"
}

output "lb-arn-suffix" {
  value       = "${aws_lb.main.arn_suffix}"
  description = "the FQDN of the DNS record that points to the ALB"
}

output "tg-arn" {
  value       = "${aws_lb_target_group.default.arn}"
  description = "the arn of the default target group"
}

output "tg-arn-suffix" {
  value       = "${aws_lb_target_group.default.arn_suffix}"
  description = "the arn of the default target group"
}
