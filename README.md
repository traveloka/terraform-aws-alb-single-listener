# terraform-aws-alb-single-listener

[![Terraform Version](https://img.shields.io/badge/Terraform%20Version->=0.11.14,_<0.12.0-blue.svg)](https://releases.hashicorp.com/terraform/)
[![Release](https://img.shields.io/github/release/traveloka/terraform-aws-alb-single-listener.svg)](https://github.com/traveloka/terraform-aws-alb-single-listener/releases)
[![Last Commit](https://img.shields.io/github/last-commit/traveloka/terraform-aws-alb-single-listener.svg)](https://github.com/traveloka/terraform-aws-alb-single-listener/commits/master)
[![Issues](https://img.shields.io/github/issues/traveloka/terraform-aws-alb-single-listener.svg)](https://github.com/traveloka/terraform-aws-alb-single-listener/issues)
[![Pull Requests](https://img.shields.io/github/issues-pr/traveloka/terraform-aws-alb-single-listener.svg)](https://github.com/traveloka/terraform-aws-alb-single-listener/pulls)
[![License](https://img.shields.io/github/license/traveloka/terraform-aws-alb-single-listener.svg)](https://github.com/traveloka/terraform-aws-alb-single-listener/blob/master/LICENSE)
![Open Source Love](https://badges.frapsoft.com/os/v1/open-source.png?v=103)

## Table of Content

- [Prerequisites](#Prerequisites)
- [Quick Start](#Quick-Start)
- [Dependencies](#Dependencies)
- [Contributing](#Contributing)
- [Contributor](#Contributor)
- [License](#License)
- [Acknowledgments](#Acknowledgments)

## Prerequisites

- [Terraform](https://releases.hashicorp.com/terraform/). This module currently tested on `0.11.14`

## Quick Start
A terraform module which provisions a DNS record that points to an Application LB with a single listener

### Examples

* [Frontend, Backend, and Default Tags ](https://github.com/traveloka/terraform-aws-alb-single-listener/tree/master/examples/frontend-backend-and-default-tgs)
* [Simple ALB Single Listener](https://github.com/traveloka/terraform-aws-alb-single-listener/tree/master/examples/simple)

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| lb_name | The name of the LB, will override the default <service_name>-<lb_type>-<random_string> name. | `string` | n/a | no |
| lb_logs_s3_bucket_name | The S3 bucket that will be used to store LB access logs. | `string` | n/a | yes |
| lb_internal | Whether the LB will be public / private. | `string` | `true` | no |
| lb_security_groups | List of security group IDs for the LB. | `list` | n/a | yes |
| lb_subnet_ids | List of subnet IDs of the LB. | `list` | n/a | yes |
| lb_ip_address_type | The LB's ip address type. | `string` | `ipv4` | no |
| lb_idle_timeout | The LB's idle timeout. | `string` | `60` | no |
| lb_tags | The additional LB tags that will be merged over the default tags. | `map` | `{}` | no |
| tg_health_check | The default target group's health check configuration, will be merged over the default (see locals.tf). | `map` | `{}` | no |
| tg_target_type | The type of target that you must specify when registering targets with this target group. | `string` | `instance` | no |
| tg_stickiness | The default target group's stickiness configuration. | `map` | `default = { "type" = "lb_cookie" "cookie_duration" = 1 "enabled" = true }` | no |
| tg_name | The default target group's name, will override the default <service_name>-default name. | `string` | n/a | no |
| tg_port | The default target group's port. | `string` | `5000` | no |
| tg_protocol | The default target group's protocol. | `string` | `HTTP` | no |
| tg_deregistration_delay | The default target group's deregistration delay. | `string` | `300` | no |
| tg_tags | The additional Target Group tags that will be merged over the default tags. | `map` | `{}` | no |
| listener_port | The LB listener's port. | `string` | `443` | yes |
| listener_protocol | The LB listener's protocol. | `string` | `HTTPS` | yes |
| listener_certificate_arn | The LB listener's certificate ARN. | `string` | n/a | yes if `tg_protocol` is set to HTTPS |
| listener_ssl_policy | The LB listener's SSL policy. | `string` | `ELBSecurityPolicy-2016-08` | no |
| listener_conditions | List of conditions (https://www.terraform.io/docs/providers/aws/r/lb_listener_rule.html#condition) for the listener rules. A rule can have either 1 or 2 conditions. The rule's order will be its priority, i.e. the first is the highest. | `list` | `[]` | no |
| listener_target_group_idx | Indexes, starting from 0, of the `target_group_arns` variable that the listener rules will use when choosing target groups. '0' means the default target group. | `list` | `[]` | no |
| service_name | The service name that will be used in tags and resources default name. | `string` | n/a | yes |
| description | Will be used in resources' Description tag. | `string` | n/a | yes |
| environment | Will be used in resources' Environment tag. | `string` | n/a | yes |
| product_domain | Abbreviation of the product domain the created resources belong to. | `string` | n/a | yes |
| target_group_arns | A list of target group arns, will be used by listener rules using `listener_target_group_idx` variable. | `list` | `[]` | no |
| vpc_id | The default target group's VPC. | `string` | n/a | yes |
| cluster_role | Primary role/function of the cluster. Example value: 'app', 'fe', 'mongod', etc. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| lb_dns | The DNS name of the load balancer. |
| lb_zone_id | The canonical hosted zone ID of the load balancer (to be used in a Route 53 Alias record). |
| lb_arn | The ARN of the ALB. |
| lb_arn_suffix | The ARN suffix of the ALB, useful with CloudWatch Metrics. |
| tg_arn | The arn of the default target group. |
| tg_arn_suffix | The arn suffix of the default target group, useful with CloudWatch Metrics. |
| listener_arn | The ARN of the listener. |
| listener_id | The ID of the listener. |

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md)

## License

Apache 2 Licensed. See LICENSE for full details.
