provider "aws" {
  region = "ap-southeast-1"
}

module "alb-single-listener" {
  source                   = "../.."
  lb_logs_s3_bucket_name   = "lb-logs-bucket"
  service_name             = "fprbc-app"
  environment              = "production"
  product_domain           = "fpr"
  description              = "Flight BC App's Application Load Balancer"
  listener_certificate_arn = "arn:aws:acm:ap-southeast-1:123456789012:certificate/certificate-arn-suffix"
  lb_security_groups       = ["sg-b0c9ed17"]
  lb_subnet_ids            = ["subnet-e099dc3f", "subnet-9eb519e8"]
  vpc_id                   = "vpc-a59be0ce"
}
