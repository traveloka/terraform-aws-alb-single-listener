# terraform-aws-alb-single-listener-and-route53-record
A terraform module which provisions a DNS record that points to an Application LB that has a single listener. Listener rules might be added along with a list of target group arns and a listener-target_group mapping.


## Conventions
- the listener use port `443` and `HTTPS` protocol
- taggable resources will have `Name`, `Service`, `Environment`, `ProductDomain`, and `Description` tags; their value can be overriden
- specify 0 in `listener_target_group_idx` to select the default target group

## License

See LICENSE for full details.
