# module "vpc" {
#   source = "terraform-aws-modules/vpc/aws"
#
#   name = var.project_name
#   cidr = "10.0.0.0/16"
#
#   azs             = ["${var.aws_region}c"]
#   private_subnets = ["10.0.1.0/24"]
#   public_subnets  = ["10.0.101.0/24"]
#
#   enable_dns_hostnames = true
#   enable_dns_support = true
#   enable_nat_gateway = true
#   enable_vpn_gateway = true
#   single_nat_gateway = false
# }
#
# resource "aws_security_group" "service" {
#   name        = var.project_name
#   vpc_id      = module.vpc.vpc_id
#
#   ingress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#
#   egress {
#     from_port       = 0
#     to_port         = 0
#     protocol        = "-1"
#     cidr_blocks     = ["0.0.0.0/0"]
#   }
# }
