# terraform {
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 3.0"
#     }
#   }
# }

# provider "aws" {
#   alias = "src"
#   region = "us-east-1"
#   access_key = var.src_access_key
#   secret_key = var.src_secret_key
# }

# provider "aws" {
#   alias = "dst"
#   region = "us-east-1"
#   access_key = var.dst_access_key
#   secret_key = var.dst_secret_key
# }