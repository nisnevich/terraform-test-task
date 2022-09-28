variable "env" {
  description = "Working environment."
  default     = "dev"
}

variable "aws_region" {
  type        = string
  description = "The availability zone name."
  default     = "ap-northeast-1"
}

variable "aws_account_id" {
  type        = string
  description = "Account ID."
  default     = "475753736115"
}

variable "artifacts_bucket_name" {
  description = "S3 Bucket for storing artifacts"
  default     = "artifacts-bucket"
}
