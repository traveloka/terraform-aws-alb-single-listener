output "lb-fqdn" {
  value = "${aws_route53_record.main.fqdn}"
}

output "default-target-group-arn" {
  value = "${aws_lb_target_group.default.arn}"
}
