variable "env" {
  description = "Working environment."
  default     = "dev"
}

variable "artifacts_bucket_name" {
  description = "S3 Bucket for storing artifacts"
  default     = "cinema_microservices_bucket"
}

