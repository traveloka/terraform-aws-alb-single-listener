# terraform-aws-route53-alb_single_listener
A terraform module which provisions a DNS record that points to an Application LB that has a single listener


# Conventions
- specify 0 in `listener_target_group_idx` to select the default target group
