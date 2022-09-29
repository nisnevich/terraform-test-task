variable "project_name" {
  type        = string
  description = "The name of the project."
  default     = "eswap-test-task"
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

variable "image_id" {
  type        = string
  description = "The id of the machine image (AMI) to use for the server."
  default     = "ami-03f4fa076d2981b45"
}

variable "docdb_instance_class" {
  type        = string
  description = "Which DB instance to run on."
  default     = "db.r4.large"
}

variable "docdb_password" {
  type        = string
  description = "Password to connect to DocumentDB."
  default     = "test"
}

