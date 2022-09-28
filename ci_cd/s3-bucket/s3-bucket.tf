resource "aws_s3_bucket" "cinema-microservices-bucket" {
  bucket = var.artifacts_bucket_name

  tags = {
    Name        = "Cinema Microservices Bucket"
    Environment = var.env
  }
}

resource "aws_s3_bucket_acl" "cinema-microservices-bucket-acl" {
  bucket = aws_s3_bucket.cinema_microservices_bucket.id
  acl    = "private"
}
