provider "aws" {
  alias = "src"
  region = "us-east-1"
  # access_key = var.src_access_key
  # secret_key = var.src_secret_key
  profile = var.src_profile
}

provider "null" {
}

provider "aws" {
  # alias = "dst"
  region = "us-east-1"
  profile = var.dst_profile
  # access_key = var.dst_access_key
  # secret_key = var.dst_secret_key
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    null = {
      source = "hashicorp/null"
      version = "3.1.1"        
    }
  }
}

resource "aws_s3_bucket" "dst_bucket" {
  # provider = aws.dst
  bucket = var.dst_bucket
}

resource "aws_iam_user" "cross-account-copy" {
  # provider = aws.dst
  name = "cross-account-copy"
}

resource "aws_iam_policy" "s3-copy-policy" {
  # provider = aws.dst
  name        = "s3-copy-policy"
  description = "s3 copy policy"
  policy      = jsonencode({
    Version: "2012-10-17",
    Statement: [
        {
            Effect: "Allow",
            Action: [
                "s3:ListBucket",
                "s3:PutObject",
                "s3:GetObjectAcl",
                "s3:GetObject",
                "s3:PutObjectVersionAcl",
                "s3:GetObjectTagging",
                "s3:DeleteObject",
                "s3:GetBucketLocation",
                "s3:PutObjectAcl"
            ],
            Resource: [
                "arn:aws:s3:::${var.src_bucket}",
                "arn:aws:s3:::${var.src_bucket}/*"
            ]
        },
        {
            Effect: "Allow",
            Action: [
                "s3:ListBucket",
                "s3:PutObject",
                "s3:GetObjectAcl",
                "s3:GetObject",
                "s3:PutObjectVersionAcl",
                "s3:GetObjectTagging",
                "s3:DeleteObject",
                "s3:GetBucketLocation",
                "s3:PutObjectAcl"
            ],
            Resource: [
                "arn:aws:s3:::${var.dst_bucket}",
                "arn:aws:s3:::${var.dst_bucket}/*"
            ]
        }
    ]
})

}

resource "aws_iam_user_policy_attachment" "policy-attach" {
  # provider = aws.dst
  user       = aws_iam_user.cross-account-copy.name
  policy_arn = aws_iam_policy.s3-copy-policy.arn
}

resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  provider = aws.src
  bucket = var.src_bucket
  policy = data.aws_iam_policy_document.allow_access_from_another_account.json
}

data "aws_iam_policy_document" "allow_access_from_another_account" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.dst_account_id}:root"]
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
      "s3:GetObjectAcl"
    ]

    resources = [
        "arn:aws:s3:::${var.src_bucket}",
        "arn:aws:s3:::${var.src_bucket}/*"
    ]
  }
}


resource "null_resource" "create-endpoint" {
  provisioner "local-exec" {
  command = "D:/DevOps/awscli/Amazon/AWSCLIV2/aws s3 sync s3://${var.src_bucket} s3://${var.dst_bucket} --source-region ${var.aws_region} --region ${var.aws_region}"
  }
}
