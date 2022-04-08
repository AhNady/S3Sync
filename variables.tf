#------------------------------------------------------------------------------
# S3 variables
#------------------------------------------------------------------------------

variable "dst_bucket" {
  type        = string
  default = "my-dst-denta-buacket"
}

variable "src_bucket" {
  type        = string
  default = "my-src-denta-buacket"
}

variable "dst_account_id" {
  type        = string
  default = "717220139840"
}

variable "aws_region" {
  type        = string
  default = "us-east-1"
}

variable "src_access_key" {
  type        = string
  default = "AKIAS4QFFBFV67JVVEFM"
}

variable "src_profile" {
  type        = string
  default = "src_profile"
}

variable "dst_profile" {
  type        = string
  default = "default"
}

variable "src_secret_key" {
  type        = string
  default = "g2yeFa4X13+xZ9iw6xJWhgzCO+RQlX5GMu+t3LLq"
}

variable "dst_access_key" {
  type        = string
  default = "AKIA2N7NG2NAIBCKFYAS"
}

variable "dst_secret_key" {
  type        = string
  default = "f3GMJcxYNohlWQ/L5z49E6erIj1bmV9zJ69rWA9F"
}