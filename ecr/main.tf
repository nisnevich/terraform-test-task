resource "aws_ecr_repository" "eswap_ecr" {
  name                 = "eswap"
  image_tag_mutability = "MUTABLE"
}

